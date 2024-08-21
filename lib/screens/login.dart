import 'package:eduappui/remote/constant/constants.dart';
import 'package:eduappui/remote/local/local_client.dart';
import 'package:eduappui/remote/local/secure_storage.dart';
import 'package:eduappui/remote/model/request/login_request.dart';
import 'package:eduappui/remote/model/response/login_response.dart';
import 'package:eduappui/remote/service/repository/login_repository.dart';
import 'package:eduappui/routers/screen_route.dart';
import 'package:eduappui/widget/TextField/common_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ProgressDialog? _progressDialog;
  LoginRepositoryImpl loginRepository = LoginRepositoryImpl();
  SecureStorageImpl secureStorageImpl = SecureStorageImpl();
  LocalClientImpl localClientImpl = LocalClientImpl();

  void showProgress() {
    _progressDialog = ProgressDialog(context: context);
    _progressDialog!.show(
      max: 100,
      msg: 'vui lòng chờ giây lát ..',
      barrierColor: Colors.transparent,
    );
  }

  Future<void> storageToCache(LoginResponse response, Map<String, dynamic> decodedToken) async {
    secureStorageImpl.saveAccessToken(response.token);
    await localClientImpl.saveData(Constants.expired_at, decodedToken['exp'].toString());
    await localClientImpl.saveData(Constants.user_id, decodedToken['UserId']);
    await localClientImpl.saveData(Constants.school_id, decodedToken['SchoolId']);
  }

  Future<void> _signIn() async {
    // Lấy dữ liệu từ ô nhập liệu
    String phoneNumber = phoneNumberController.text;
    String password = passwordController.text;
    try {
      if (phoneNumber.isEmpty || password.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text(' Vui lòng nhập số điện thoại và mật khẩu của bạn!')));
          return;
        }
      }
      var response = await loginRepository.login(LoginRequest(phoneNumber: phoneNumber, password: password));
      showProgress();
      if (response.token != null) {
        Map<String, dynamic> decodedToken = JwtDecoder.decode(response.token!);
        if (decodedToken['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'] == 'STUDENT_SUPERVISOR') {
          storageToCache(response, decodedToken);
          if (kDebugMode) {
            print(decodedToken['UserId']);
            print(
                'is admin -- false , Role:  ${decodedToken['http://schemas.microsoft.com/ws/2008/06/identity/claims/role']}');
          }
          await localClientImpl.saveData('isAdmin', false);
          await Future.delayed(const Duration(seconds: 2), () {
            context.pushReplacement(ScreenRoute.homeScreen, extra: {'isAdmin': false});
          });
        } else if (decodedToken['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'] == 'SUPERVISOR') {
          storageToCache(response, decodedToken);
          if (kDebugMode) {
            print(decodedToken['UserId']);
            print(
                'is admin -- true , Role: ${decodedToken['http://schemas.microsoft.com/ws/2008/06/identity/claims/role']}');
          }
          await localClientImpl.saveData('isAdmin', true);
          await Future.delayed(const Duration(seconds: 2), () {
            context.pushReplacement(ScreenRoute.homeScreen, extra: {'isAdmin': true});
          });
        } else {
          if (mounted) {
            _progressDialog!.close();
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Tài khoản của bạn không có quyền truy cập')));
            return;
          }
        }
      }else{
         if (mounted) {
        _progressDialog!.close();
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Đăng nhập thất bai'),
            content: const Text('Vui lòng kiểm tra số điện thoại và mật khẩu của bạn'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
      }
    } catch (e) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Đăng nhập thất bai'),
            content: const Text('Vui lòng kiểm tra số điện thoại và mật khẩu của bạn'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLogoContent(screenHeight, screenWidth),
          const Text('Đăng nhập', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CommonTextField(
              maxLines: 1,
              inputController: phoneNumberController,
              hintText: 'Số Điện Thoại',
            ),
          ),
          const SizedBox(height: 20), // Khoảng cách giữa dòng chữ và ô nhập liệu
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CommonTextField(
              maxLines: 1,
              inputController: passwordController,
              hintText: 'Mật Khẩu',
              isPassword: true,
            ),
          ),
          const SizedBox(height: 20), // Khoảng cách giữa ô nhập liệu và nút đăng nhập
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _signIn,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Màu nền xanh cho nút Sign In
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Bo góc tròn
                ),
              ),
              child: Container(
                width: double.infinity, // Tự động mở rộng chiều dài
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: const Center(
                  child: Text(
                    'Đăng Nhập',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Spacer(),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: ClipPath(
              clipper: WaveClip(),
              child: Container(
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildLogoContent(double screenHeight, double screenWidth) {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.white,
    ),
    width: double.infinity,
    height: screenHeight * 0.38,
    child: Stack(
      children: [
        Image.asset(
          "images/school.jpg",
          fit: BoxFit.cover,
        ),
        Positioned(
          top: screenHeight * 0.25,
          left: screenWidth * 0.4,
          child: Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF032E66),
            ),
            child: Padding(
              padding: const EdgeInsets.all(0.5),
              child: ClipOval(
                child: Image.asset(
                  "images/logo.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

class WaveClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Điểm thấp và điểm cao của sóng
    const lowPoint = 20.0;
    const highPoint = 80.0;

    // Điểm bắt đầu của đường sóng
    path.lineTo(0, highPoint);

    // Đường sóng thứ nhất
    path.quadraticBezierTo(size.width / 4, lowPoint, size.width / 2, highPoint);

    // Đường sóng thứ hai
    path.quadraticBezierTo(3 / 4 * size.width, highPoint + 40.0, size.width, highPoint);

    // Đường dưới của container
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
