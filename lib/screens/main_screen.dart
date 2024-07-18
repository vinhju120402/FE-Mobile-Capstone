import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eduappui/remote/local/local_client.dart';
import 'package:eduappui/remote/local/secure_storage.dart';
import 'package:eduappui/routers/screen_route.dart';
import 'package:eduappui/widget/base_main_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Map<String, Map<String, dynamic>>? categories;
  List<IconData>? iconList;
  LocalClientImpl localClientImpl = LocalClientImpl();
  SecureStorageImpl secureStorageImpl = SecureStorageImpl();
  bool? isAdmin;

  @override
  void initState() {
    super.initState();
    isAdmin = localClientImpl.readData('isAdmin');
    categories = {
      "Create Violation": {
        "icon": const Icon(Icons.add, color: Colors.white, size: 30),
      },
      "Rule": {
        "icon": const Icon(Icons.rule, color: Colors.white, size: 30),
      },
      "History Violation": {
        "icon": const Icon(Icons.history_edu, color: Colors.white, size: 30),
      },
      "Profile": {
        "icon": const Icon(Icons.person, color: Colors.white, size: 30),
      },
      "Contact": {
        "icon": const Icon(Icons.contact_emergency, color: Colors.white, size: 30),
      },
    };

    iconList = [
      Icons.home,
      Icons.class_,
      Icons.person,
    ];

    if (isAdmin == true) {
      categories!.remove("Duty schedule");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainScreenContent(
        isAdmin: isAdmin ?? false,
        categories: categories,
        localClientImpl: localClientImpl,
        secureStorageImpl: secureStorageImpl,
      ),
    );
  }
}

class MainScreenContent extends StatelessWidget {
  final bool isAdmin;
  final Map<String, Map<String, dynamic>>? categories;
  final LocalClientImpl localClientImpl;
  final SecureStorageImpl secureStorageImpl;
  const MainScreenContent(
      {super.key,
      this.categories,
      required this.localClientImpl,
      required this.secureStorageImpl,
      required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 80,
                child: Row(
                  children: [
                    Expanded(child: Container(color: Colors.white)),
                    Expanded(child: Container(color: Colors.blue)),
                  ],
                ),
              ),
              _buildHeaderContent(context, localClientImpl, secureStorageImpl, isAdmin),
            ],
          ),
          BaseMainContent(
            children: [
              Visibility(
                visible: isAdmin == false,
                child: _buildUpcomingSchedule(context),
              ),
              _buildOther(categories),
            ],
          ),
          const SizedBox(height: 50)
        ],
      ),
    );
  }
}

Widget _buildUpcomingSchedule(BuildContext context) {
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
                color: Color(0xFF55B5F3),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Card(
          color: Colors.white,
          elevation: 3,
          child: SizedBox(
            width: double.infinity,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
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
                Expanded(
                    child: InkWell(
                  onTap: () => context.push(ScreenRoute.dutyScheduleScreen),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Go to details',
                        style: TextStyle(fontSize: 9, color: Colors.lightBlue),
                      ),
                      Icon(
                        Icons.navigate_next_outlined,
                        size: 20,
                        color: Colors.lightBlue,
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget _buildHeaderContent(
    BuildContext context, LocalClientImpl localClient, SecureStorageImpl secureStorageImpl, bool isAdmin) {
  return Container(
    height: 80,
    decoration: const BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('images/pho1.jpg'),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Leonel Messi',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    isAdmin ? 'Teacher' : 'Student',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                customButton: const Icon(
                  Icons.density_medium_sharp,
                  color: Colors.white,
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
                  onChanged(context, value!, localClient, secureStorageImpl);
                },
                dropdownStyleData: DropdownStyleData(
                  width: 110,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
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
                color: Color(0xFF55B5F3),
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
            crossAxisCount: 2,
            childAspectRatio: 1.1,
          ),
          itemBuilder: (context, index) {
            String categoryName = categories.keys.elementAt(index);
            Map<String, dynamic> categoryData = categories[categoryName]!;
            Icon categoryIcon = categoryData["icon"];
            return _buildCardCategoryItem(categoryIcon, categoryName, context);
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

class MenuItems {
  static const List<MenuItem> item = [notifications, settings, logoutIcon];
  static const settings = MenuItem(text: 'Settings', icon: Icons.settings);
  static const notifications = MenuItem(text: 'Notifications', icon: Icons.notifications);
  static const logoutIcon = MenuItem(text: 'Log Out', icon: Icons.logout);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Color(0xFF55B5F3), size: 9),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(
              fontSize: 9,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

Future<void> onChanged(
    BuildContext context, MenuItem item, LocalClientImpl localClientImpl, SecureStorageImpl secureStorage) async {
  switch (item) {
    case MenuItems.notifications:
      context.push(ScreenRoute.notificationPage);
      break;
    case MenuItems.settings:
      context.push(ScreenRoute.settingsScreen);
      break;
    case MenuItems.logoutIcon:
      logout(localClientImpl, context, secureStorage);
      break;
  }
}

logout(LocalClientImpl localClientImpl, BuildContext context, SecureStorageImpl secureStorageImpl) {
  localClientImpl.removeAll();
  secureStorageImpl.removeAll();
  context.pushReplacement(ScreenRoute.loginScreen);
}

Widget _buildCardCategoryItem(
  Icon categoryIcon,
  String categoryName,
  BuildContext context,
) {
  return GestureDetector(
    onTap: () {
      // Navigate to the respective screen based on the tapped category
      if (categoryName == "Rule") {
        context.push(ScreenRoute.ruleScreen);
      } else if (categoryName == "Create Violation") {
        context.push(ScreenRoute.createViolationScreen);
      } else if (categoryName == "Contact") {
        context.push(ScreenRoute.contactScreen);
      } else if (categoryName == "Profile") {
        context.push(ScreenRoute.profileScreen);
      } else if (categoryName == "History Violation") {
        context.push(ScreenRoute.violationHistoryScreen);
      } else if (categoryName == "Duty schedule") {
        context.push(ScreenRoute.dutyScheduleScreen);
      }
    },
    child: Card(
      elevation: 3,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            categoryIcon.icon,
            color: const Color(0XFF55B5F3),
            size: 30,
          ),
          Text(
            categoryName,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    ),
  );
}
