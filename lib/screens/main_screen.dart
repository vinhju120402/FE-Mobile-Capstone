import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eduappui/remote/local/local_client.dart';
import 'package:eduappui/routers/screen_route.dart';
import 'package:eduappui/screens/contact.dart';
import 'package:eduappui/screens/create_violation_screen.dart';
import 'package:eduappui/screens/duty.dart';
import 'package:eduappui/screens/historyviolation.dart';
import 'package:eduappui/screens/profile.dart';
import 'package:eduappui/screens/rule.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int _activeIndex = 0;
  Map<String, Map<String, dynamic>>? categories;
  List<IconData>? iconList;
  List<Widget>? _pages;
  LocalClientImpl localClientImpl = LocalClientImpl();
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();

    categories = {
      "Rule": {
        "color": const Color(0xff1d74f6),
        "icon": const Icon(Icons.rule, color: Colors.white, size: 30),
      },
      "Contact": {
        "color": const Color(0xff1d74f6),
        "icon": const Icon(Icons.contact_emergency, color: Colors.white, size: 30),
      },
      "HistoryViolation": {
        "color": const Color(0xff1d74f6),
        "icon": const Icon(Icons.history_edu, color: Colors.white, size: 30),
      },
      "Duty schedule": {
        "color": const Color(0xff1d74f6),
        "icon": const Icon(Icons.schedule_outlined, color: Colors.white, size: 30),
      },
    };

    iconList = [
      Icons.home,
      Icons.class_,
      Icons.person,
    ];

    _pages = [
      MainScreenContent(categories: categories),
      const CreateViolationScreen(),
      ProfileScreen(),
    ];
    isAdmin = localClientImpl.readData('isAdmin');
    if (isAdmin == false) {
      categories!.remove("Duty schedule");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('Main Screen is Admin: $isAdmin');
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _activeIndex,
        children: _pages!,
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        inactiveColor: Colors.white,
        backgroundColor: Colors.blue,
        activeColor: const Color(0xFF032E66),
        height: 75,
        gapLocation: GapLocation.none,
        icons: iconList!,
        activeIndex: _activeIndex,
        leftCornerRadius: 40,
        rightCornerRadius: 40,
        onTap: (index) => setState(() => _activeIndex = index),
      ),
    );
  }
}

class MainScreenContent extends StatelessWidget {
  final Map<String, Map<String, dynamic>>? categories;
  const MainScreenContent({super.key, this.categories});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeaderContent(context),
          _buildUpcomingSchedule(),
          _buildOther(categories),
        ],
      ),
    );
  }
}

Widget _buildUpcomingSchedule() {
  return Padding(
    padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
    child: Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(1.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Upcoming Schedule',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Card(
          color: Colors.grey[200],
          elevation: 3,
          child: SizedBox(
            width: double.infinity,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        '1/2/2024',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    height: 130,
                    width: 1,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Thời gian: 7h-8h', style: TextStyle(fontSize: 12)),
                        SizedBox(height: 10),
                        Text('Lớp: 12A1', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget _buildHeaderContent(BuildContext context) {
  return Container(
    color: Colors.blue,
    height: 80,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello ',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              Text(
                'Leonel Messi',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Container(
            width: 105,
            height: 30,
            decoration: ShapeDecoration(
              color: const Color(0xFF032E66),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                customButton: Stack(
                  children: [
                    const Positioned(
                      left: 10,
                      top: 8,
                      child: Text(
                        'Lenoel Messi',
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 32.61,
                        height: 31,
                        decoration: const ShapeDecoration(
                          shape: OvalBorder(
                            side: BorderSide(width: 1, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 4,
                      top: 4,
                      child: Container(
                        width: 24.46,
                        height: 21.14,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('images/pho1.jpg'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                items: [
                  ...MenuItems.item.map(
                    (item) => DropdownMenuItem<MenuItem>(
                      value: item,
                      child: MenuItems.buildItem(item),
                    ),
                  ),
                ],
                onChanged: (value) {
                  MenuItems.onChanged(context, value!);
                },
                dropdownStyleData: DropdownStyleData(
                  width: 110,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xFF032E66),
                  ),
                  offset: const Offset(0, -3),
                ),
                menuItemStyleData: MenuItemStyleData(
                  customHeights: [
                    ...List<double>.filled(MenuItems.item.length, 25),
                  ],
                  padding: const EdgeInsets.only(left: 16, right: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildOther(Map<String, Map<String, dynamic>>? categories) {
  return Padding(
    padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
    child: Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(1.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Category',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        GridView.builder(
          itemCount: categories!.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.1,
          ),
          itemBuilder: (context, index) {
            String categoryName = categories.keys.elementAt(index);
            Map<String, dynamic> categoryData = categories[categoryName]!;
            Color categoryColor = categoryData["color"];
            Icon categoryIcon = categoryData["icon"];

            return GestureDetector(
              onTap: () {
                // Navigate to the respective screen based on the tapped category
                if (categoryName == "Rule") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RuleScreen()),
                  );
                } else if (categoryName == "Violation") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CreateViolationScreen()),
                  );
                } else if (categoryName == "Contact") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ContactScreen()),
                  );
                } else if (categoryName == "Profile") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                } else if (categoryName == "HistoryViolation") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HistoryScreen()),
                  );
                } else if (categoryName == "Duty schedule") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DutyScheduleScreen()),
                  );
                }
              },
              child: Column(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: categoryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: categoryIcon,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    categoryName,
                    style: TextStyle(
                      fontSize: 12,
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
  );
}

class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
}

abstract class MenuItems {
  static const List<MenuItem> item = [notifications, settings, logout];

  static const settings = MenuItem(text: 'Settings', icon: Icons.settings);
  static const notifications = MenuItem(text: 'Notifications', icon: Icons.notifications);
  static const logout = MenuItem(text: 'Log Out', icon: Icons.logout);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 9),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(
              fontSize: 9,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  static void onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.notifications:
        context.push(ScreenRoute.notificationPage);
        break;
      case MenuItems.settings:
        context.push(ScreenRoute.settingsScreen);
        break;
      case MenuItems.logout:
        context.push(ScreenRoute.loginScreen);
        break;
    }
  }
}
