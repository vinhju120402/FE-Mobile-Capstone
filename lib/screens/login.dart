import 'package:eduappui/remote/model/request/login_request.dart';
import 'package:eduappui/remote/service/repository/login_repository.dart';
import 'package:eduappui/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ProgressDialog? _progressDialog;
  LoginRepositoryImpl loginRepository = LoginRepositoryImpl();

  void showProgress() {
    _progressDialog = ProgressDialog(context: context);
    _progressDialog!.show(
      max: 100,
      msg: 'please wait ..',
      progressBgColor: Colors.red,
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
              .showSnackBar(SnackBar(content: Text(' Please enter your phone number and password!')));
          return;
        }
      }
      var response = await loginRepository.login(LoginRequest(phoneNumber: phoneNumber, password: password));
      showProgress();
      if (response.token != null) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
        });
      }
    } catch (e) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Login Failed'),
            content: Text('Please check your phone number and password'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(190, 6, 231, 231),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 70), // Khoảng cách từ đỉnh màn hình đến logo
            Center(
              child: ClipOval(
                child: Image.asset(
                  "images/logo.jpg", // Đường dẫn hình ảnh logo của bạn
                  width: 150, // Kích thước của logo
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20), // Khoảng cách giữa logo và dòng chữ
            const Text(
              'Sign in now',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20), // Khoảng cách giữa dòng chữ và ô nhập liệu
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  filled: true, // Đặt filled thành true
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.white), // Bo góc tròn
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10), // Khoảng cách giữa ô nhập liệu
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: passwordController,
                obscureText: _obscureText, // Ẩn/mở mật khẩu
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true, // Đặt filled thành true
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.white), // Bo góc tròn
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ), // Khoảng cách giữa ô nhập liệu và nút đăng nhập
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
          ],
        ),
      ),
    );
  }
}
