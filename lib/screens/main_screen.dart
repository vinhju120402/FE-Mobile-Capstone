import 'dart:async';
import 'package:eduappui/screens/contact.dart';
import 'package:eduappui/screens/duty.dart';
import 'package:eduappui/screens/historyviolation.dart';
import 'package:eduappui/screens/more.dart';
import 'package:eduappui/screens/notifications.dart';
import 'package:eduappui/screens/profile.dart';
import 'package:eduappui/screens/rule.dart';
import 'package:eduappui/screens/setting.dart';
import 'package:eduappui/screens/table.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> catNames = [
    "Rule",
    "Violation",
    "Contact",
    "HistoryViolation",
    "Duty schedule",
    "Profile",
  ];
  final List<Officer> officers = [
    Officer(name: 'Quang Vinh', profilePicture: 'images/pho1.jpg'),
    Officer(name: 'Thanh Nguyen', profilePicture: 'images/pho2.jpg'),
    Officer(name: 'Thinh Truong', profilePicture: 'images/pho3.jpg'),
    Officer(name: 'Tan Phuoc', profilePicture: 'images/pho4.jpg'),
  ];
  List<Color> catColors = [
    Color(0xff1d74f6),
    Color(0xff1d74f6),
    Color(0xff1d74f6),
    Color(0xff1d74f6),
    Color(0xff1d74f6),
    Color(0xff1d74f6),
  ];
  List<Icon> catIcons = [
    Icon(Icons.rule, color: Colors.white, size: 30),
    Icon(Icons.class_outlined, color: Colors.white, size: 30),
    Icon(Icons.contact_emergency, color: Colors.white, size: 30),
    Icon(Icons.history_edu, color: Colors.white, size: 30),
    Icon(Icons.schedule_outlined, color: Colors.white, size: 30),
    Icon(Icons.person_2_outlined, color: Colors.white, size: 30),
  ];
  int _selectedIndex = 0;
  final List<String> imageList = [
    'images/pho1.jpg',
    'images/pho2.jpg',
    'images/pho3.jpg',
    'images/pho4.jpg',
  ];
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_currentPage < imageList.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        color: Color.fromARGB(
            226, 134, 253, 237), // Change background color to blue
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding:
                    EdgeInsets.only(top: 35, right: 15, left: 15, bottom: 10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(189, 7, 206, 43),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            CircleAvatar(
                              radius: 25, // Adjust the radius as needed
                              backgroundImage: AssetImage("images/logo.jpg"),
                            ),
                            SizedBox(
                                width:
                                    5), // Reduced space between the avatar and the text
                            Text(
                              'Hello Student',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                wordSpacing: 2,
                                // Adjust text style as needed
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NotificationScreen()),
                                );
                              },
                              child: Icon(
                                Icons.notifications,
                                size: 30,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SettingsScreen()),
                                );
                              },
                              child: Icon(
                                Icons.settings,
                                size: 30,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 180, // Height for the PageView
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: imageList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                imageList[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10), // Adjusted spacing for indicator
                    Center(
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: imageList.length,
                        effect: ExpandingDotsEffect(
                          activeDotColor: Colors.blue,
                          dotColor: Colors.grey,
                          dotHeight: 8,
                          dotWidth: 8,
                          spacing: 4,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Application',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    GridView.builder(
                      itemCount: catNames.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.1,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Navigate to the respective screen based on the tapped category
                            if (catNames[index] == "Rule") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RuleScreen()),
                              );
                            } else if (catNames[index] == "Violation") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DataEntryForm()),
                              );
                            } else if (catNames[index] == "Contact") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ContactScreen()),
                              );
                            } else if (catNames[index] == "Profile") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileScreen()),
                              );
                            } else if (catNames[index] == "HistoryViolation") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HistoryScreen()),
                              );
                            } else if (catNames[index] == "Duty schedule") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DutyScheduleScreen()),
                              );
                            }
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: catColors[index],
                                    // shape: BoxShape.circle,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: catIcons[index],
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                catNames[index],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '   List of officers',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OfficersScreen()),
                        );
                      },
                      child: Text(
                        'More',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black, // Customize the color as needed
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: officers.map((officer) {
                  return Column(
                    children: [
                      Container(
                        width: 60, // Width of the rectangular frame
                        height: 80, // Height of the rectangular frame
                        padding: EdgeInsets.all(
                            5), // Space between frame and circular image
                        decoration: BoxDecoration(
                          color: Color.fromARGB(240, 0, 247,
                              255), // Background color of the frame
                          border: Border.all(
                              color: Colors.grey), // Border color of the frame
                          borderRadius: BorderRadius.circular(
                              8), // Rounded corners for the frame
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            officer.profilePicture,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        officer.name,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 50),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Officer {
  final String name;
  final String profilePicture;

  Officer({required this.name, required this.profilePicture});
}
