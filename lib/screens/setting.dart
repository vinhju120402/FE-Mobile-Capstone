import 'package:eduappui/screens/faq.dart';
import 'package:eduappui/screens/home_screen.dart';
import 'package:eduappui/screens/login.dart';
import 'package:eduappui/screens/main_screen.dart';
import 'package:eduappui/screens/privacy.dart';
import 'package:eduappui/screens/review.dart';
import 'package:eduappui/screens/term.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text('Setting', style: TextStyle(color: Colors.black))),
        backgroundColor: Color.fromARGB(189, 7, 206, 43),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
            );
          },
        ),
      ),
      body: Container(
        color: Color.fromARGB(226, 134, 253, 237),
        child: ListView(
          children: <Widget>[
            Card(
              margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Color.fromARGB(188, 85, 239, 126),
              child: ListTile(
                leading: Icon(Icons.language, color: Colors.grey[600]),
                title: Text('Language', style: TextStyle(color: Colors.black)),
                trailing: Icon(Icons.arrow_drop_down, color: Colors.black54),
              ),
            ),
            SizedBox(height: 35),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: Color.fromARGB(188, 85, 239, 126),
              child: SwitchListTile(
                secondary:
                    Icon(Icons.notifications_none, color: Colors.grey[600]),
                title: Text('Notifications',
                    style: TextStyle(color: Colors.black)),
                value: notificationsEnabled,
                activeColor: Colors.green,
                onChanged: (value) {
                  setState(() {
                    notificationsEnabled = value;
                  });
                },
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Color.fromARGB(188, 85, 239, 126),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TermsScreen()),
                  );
                },
                child: ListTile(
                  leading: Icon(Icons.description, color: Colors.grey[600]),
                  title: Text('Term & Conditions',
                      style: TextStyle(color: Colors.black)),
                  trailing: Icon(Icons.arrow_drop_down, color: Colors.black54),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Color.fromARGB(188, 85, 239, 126),
              child: ListTile(
                leading: Icon(Icons.info, color: Colors.grey[600]),
                title: Text('About app', style: TextStyle(color: Colors.black)),
                trailing: Icon(Icons.arrow_drop_down, color: Colors.black54),
              ),
            ),
            SizedBox(height: 35),
            Card(
              margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Color.fromARGB(188, 85, 239, 126),
              child: ListTile(
                leading: Icon(Icons.help, color: Colors.grey[600]),
                title: Text('Help & Support',
                    style: TextStyle(color: Colors.black)),
                trailing: Icon(Icons.arrow_drop_down, color: Colors.black54),
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Color.fromARGB(188, 85, 239, 126),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RatingReviewScreen()),
                  );
                },
                child: ListTile(
                  leading: Icon(Icons.rate_review, color: Colors.grey[600]),
                  title: Text('Rate the Mypass app',
                      style: TextStyle(color: Colors.black)),
                  trailing: Icon(Icons.arrow_drop_down, color: Colors.black54),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Color.fromARGB(188, 85, 239, 126),
              child: ListTile(
                leading: Icon(Icons.logout, color: Colors.grey[600]),
                title: Text('Logout', style: TextStyle(color: Colors.black)),
                trailing: Icon(Icons.arrow_drop_down, color: Colors.black54),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Color.fromARGB(189, 7, 206, 43),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19.0),
                        ),
                        content: Text(
                          'Are you sure you want to logout',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        contentPadding:
                            EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'NO',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            },
                            child: Text(
                              'YES',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Color.fromARGB(188, 85, 239, 126),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FaqScreen()),
                  );
                },
                child: ListTile(
                  leading: Icon(Icons.question_answer, color: Colors.grey[600]),
                  title: Text('Faq?', style: TextStyle(color: Colors.black)),
                  trailing: Icon(Icons.arrow_drop_down, color: Colors.black54),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Color.fromARGB(188, 85, 239, 126),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PrivacyPolicyScreen()),
                  );
                },
                child: ListTile(
                  leading: Icon(Icons.privacy_tip, color: Colors.grey[600]),
                  title: Text('Privacy Policy',
                      style: TextStyle(color: Colors.black)),
                  trailing: Icon(Icons.arrow_drop_down, color: Colors.black54),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
