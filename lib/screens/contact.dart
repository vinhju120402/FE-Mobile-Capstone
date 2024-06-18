import 'package:eduappui/screens/main_screen.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(226, 134, 253, 237),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(189, 7, 206, 43),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
            );
          },
        ),
        title: Center(
          child: Text(
            'Contact',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 16.0),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width *
                  0.8, // Chiều rộng container
              decoration: BoxDecoration(
                color: Color.fromARGB(188, 85, 239, 126),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Căn giữa nội dung
                children: [
                  Text(
                    'School Services',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Divider(
                    height: 30,
                    thickness: 2,
                    color: Colors.black,
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Căn giữa nội dung
                    children: [
                      Icon(
                        Icons.call,
                        color: Colors.black,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        '01234567890',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Căn giữa nội dung
                    children: [
                      Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        '123456@gmail.com',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
