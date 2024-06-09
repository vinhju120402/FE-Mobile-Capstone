import 'package:eduappui/screens/home_screen.dart';
import 'package:eduappui/screens/main_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text('Profile', style: TextStyle(color: Colors.black))),
        backgroundColor: const Color.fromARGB(189, 7, 206, 43),
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage("images/book.jpg"),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Icon(Icons.person, color: Colors.grey[600]),
                SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Full Name',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'John Smith',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              height: 30,
              thickness: 2,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Icon(Icons.email, color: Colors.grey[600]),
                SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email: ',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'johnsmith@gmail.com',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              height: 30,
              thickness: 2,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Icon(Icons.phone, color: Colors.grey[600]),
                SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mobile number',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '698698966',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              height: 30,
              thickness: 2,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}
