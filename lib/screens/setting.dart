import 'dart:io';
import 'package:eduappui/remote/local/local_client.dart';
import 'package:eduappui/remote/local/secure_storage.dart';
import 'package:eduappui/routers/screen_route.dart';
import 'package:eduappui/widget/app_bar.dart';
import 'package:eduappui/widget/base_main_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rate_my_app/rate_my_app.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;
  LocalClientImpl localClientImpl = LocalClientImpl();
  SecureStorageImpl secureStorageImpl = SecureStorageImpl();
  bool isAdmin = false;

  logout(LocalClientImpl localClientImpl, SecureStorageImpl secureStorageImpl) {
    localClientImpl.removeAll();
    secureStorageImpl.removeAll();
    context.pushReplacement(ScreenRoute.loginScreen);
  }

  _languageOntap() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Chọn ngôn ngữ'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('TIêng Việt'),
                onTap: () {
                  context.pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  _rateReviewOntap() {
    RateMyApp rateMyApp = RateMyApp(
      preferencesPrefix: 'Đánh giá ứng dụng',
      minDays: 7,
      minLaunches: 10,
      remindDays: 7,
      remindLaunches: 10,
    );
    rateMyApp.showStarRateDialog(
      context,
      title: 'Đánh giá ứng dụng',
      message: 'Bạn thích ứng dụng này? Sau đó hãy dành chút thời gian của bạn để để lại đánh giá :',
      actionsBuilder: (context, stars) {
        return [
          TextButton(
            child: Text('Chấp nhận'),
            onPressed: () async {
              context.pop();
            },
          ),
        ];
      },
      ignoreNativeDialog: Platform.isAndroid,
      dialogStyle: const DialogStyle(
        // Custom dialog styles.
        titleAlign: TextAlign.center,
        messageAlign: TextAlign.center,
        messagePadding: EdgeInsets.only(bottom: 20),
      ),
      starRatingOptions: const StarRatingOptions(), // Custom star bar rating options.
      onDismissed: () => rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
    );
  }

  @override
  void initState() {
    super.initState();
    isAdmin = localClientImpl.readData("isAdmin");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Cài Đặt',
        onBack: () => context.pop(),
      ),
      body: BaseMainContent(
        children: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            SizedBox(height: 10),
            Card(
              margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 3,
              color: Colors.white,
              child: GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildSettingItem(
                        iconColor: isAdmin ? Colors.blue : Color(0xFFB74848),
                        Icons.language,
                        'Ngôn ngữ',
                        onTap: _languageOntap,
                      ),
                      SizedBox(height: 20),
                      _buildSettingItem(
                        iconColor: isAdmin ? Colors.blue : Color(0xFFB74848),
                        Icons.description,
                        'Terms & Conditions',
                        onTap: () => context.push(ScreenRoute.termScreen),
                      ),
                      SizedBox(height: 20),
                      _buildSettingItem(
                        iconColor: isAdmin ? Colors.blue : Color(0xFFB74848),
                        Icons.privacy_tip,
                        'Privacy Policy',
                        onTap: () => context.push(ScreenRoute.privacyScreen),
                      ),
                      SizedBox(height: 20),
                      _buildSettingItem(
                        iconColor: isAdmin ? Colors.blue : Color(0xFFB74848),
                        Icons.rate_review,
                        'Đánh giá ứng dụng',
                        onTap: _rateReviewOntap,
                      ),
                      SizedBox(height: 20),
                      _buildSettingItem(
                        iconColor: isAdmin ? Colors.blue : Color(0xFFB74848),
                        Icons.question_answer,
                        'FAQ?',
                        onTap: () => context.push(ScreenRoute.faqScreen),
                      ),
                      SizedBox(height: 20),
                      _buildSettingItem(
                        Icons.info,
                        'Thông tin ứng dụng',
                        iconColor: isAdmin ? Colors.blue : Color(0xFFB74848),
                      ),
                      SizedBox(height: 20),
                      _buildSettingItem(
                        Icons.logout,
                        'Đăng xuất',
                        iconColor: Colors.red,
                        textColor: Colors.red,
                        onTap: () => logout(localClientImpl, secureStorageImpl),
                      ),
                    ],
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

Widget _buildSettingItem(IconData icon, String title, {Color? iconColor, Color? textColor, Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Icon(icon, color: iconColor ?? Colors.blue),
            ),
            SizedBox(width: 10),
            Text(title, style: TextStyle(color: textColor ?? Colors.black)),
          ],
        ),
        Icon(Icons.arrow_forward_ios, color: iconColor ?? Colors.grey[400]),
      ],
    ),
  );
}
