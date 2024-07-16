import 'package:eduappui/remote/local/local_client.dart';
import 'package:eduappui/remote/local/secure_storage.dart';
import 'package:eduappui/remote/model/request/login_request.dart';
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
      msg: 'please wait ..',
      barrierColor: Colors.transparent,
    );
  }

  Future<void> _signIn() async {
    // Lấy dữ liệu từ ô nhập liệu
    String phoneNumber = phoneNumberController.text;
    String password = passwordController.text;
    try {
      if (phoneNumber.isEmpty || password.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text(' Please enter your phone number and password!')));
          return;
        }
      }
      var response = await loginRepository.login(LoginRequest(phoneNumber: phoneNumber, password: password));
      showProgress();
      if (response.token != null) {
        secureStorageImpl.saveAccessToken(response.token);
        Map<String, dynamic> decodedToken = JwtDecoder.decode(response.token!);
        if (decodedToken['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'] == 'STUDENT_SUPERVISOR') {
          if (kDebugMode) {
            print(
                'is admin -- false , Role:  ${decodedToken['http://schemas.microsoft.com/ws/2008/06/identity/claims/role']}');
          }
          localClientImpl.saveData('isAdmin', false);
          Future.delayed(const Duration(seconds: 2), () {
            context.pushReplacement(ScreenRoute.homeScreen, extra: {'isAdmin': false});
          });
        } else {
          if (kDebugMode) {
            print(
                'is admin -- true , Role: ${decodedToken['http://schemas.microsoft.com/ws/2008/06/identity/claims/role']}');
          }
          localClientImpl.saveData('isAdmin', true);
          Future.delayed(const Duration(seconds: 2), () {
            context.pushReplacement(ScreenRoute.homeScreen, extra: {'isAdmin': true});
          });
        }
      }
    } catch (e) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Login Failed'),
            content: const Text('Please check your phone number and password'),
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
          const Text('Login', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CommonTextField(
              maxLines: 1,
              inputController: phoneNumberController,
              hintText: 'Phone Number',
            ),
          ),
          const SizedBox(height: 20), // Khoảng cách giữa dòng chữ và ô nhập liệu
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CommonTextField(
              maxLines: 1,
              inputController: passwordController,
              hintText: 'Password',
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
                    'Sign In',
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
