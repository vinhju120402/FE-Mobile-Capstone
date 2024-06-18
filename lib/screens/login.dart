import 'package:eduappui/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  ProgressDialog? _progressDialog;

  void showProgress() {
    _progressDialog = ProgressDialog(context: context);
    _progressDialog!.show(
      max: 100,
      msg: 'please wait ..',
      progressBgColor: Colors.red,
    );
  }

  void _signIn() {
    // Lấy dữ liệu từ ô nhập liệu
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Kiểm tra thông tin đăng nhập
    if (email == 'admin@gmail.com' && password == '123456') {
      // Nếu thông tin đúng, hiển thị tiến trình
      showProgress();
      // Sau đó chuyển hướng đến màn hình HomeScreen
      Future.delayed(Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      });
    } else {
      // Nếu thông tin không đúng, hiển thị thông báo lỗi
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Failed'),
          content: Text('Incorrect email or password. Please try again.'),
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
            const SizedBox(
                height: 20), // Khoảng cách giữa dòng chữ và ô nhập liệu
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true, // Đặt filled thành true
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        const BorderSide(color: Colors.white), // Bo góc tròn
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10), // Khoảng cách giữa ô nhập liệu
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _passwordController,
                obscureText: _obscureText, // Ẩn/mở mật khẩu
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true, // Đặt filled thành true
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        const BorderSide(color: Colors.white), // Bo góc tròn
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
