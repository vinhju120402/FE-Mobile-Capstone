import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eduappui/remote/constant/constants.dart';
import 'package:eduappui/remote/local/local_client.dart';
import 'package:eduappui/remote/local/secure_storage.dart';
import 'package:eduappui/remote/model/response/schedule_response.dart';
import 'package:eduappui/remote/service/repository/schedule_repository.dart';
import 'package:eduappui/remote/service/repository/user_repository.dart';
import 'package:eduappui/routers/screen_route.dart';
import 'package:eduappui/widget/base_main_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

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
  UserRepositoryImpl userRepositoryImpl = UserRepositoryImpl();
  bool? isAdmin;
  int? userId;
  String? userName;
  bool isLoading = true;
  ScheduleRepositoryImpl scheduleRepository = ScheduleRepositoryImpl();
  List<ScheduleResponse> scheduleList = [];
  ScheduleResponse? firstOngoing;

  @override
  void initState() {
    super.initState();
    categories = {
      "Tạo Vi Phạm": {
        "icon": const Icon(Icons.add),
      },
      "Quy Định": {
        "icon": const Icon(Icons.rule),
      },
      "Lịch Sử Vi Phạm": {
        "icon": const Icon(Icons.history_edu),
      },
      "Tài Khoản": {
        "icon": const Icon(Icons.person),
      },
      "Liên Lạc": {
        "icon": const Icon(Icons.contact_emergency),
      },
    };

    iconList = [
      Icons.home,
      Icons.class_,
      Icons.person,
    ];
    getCurrentUser();
    getSchedule();
  }

  getCurrentUser() async {
    isAdmin = await localClientImpl.readData('isAdmin');
    userId = int.parse(await localClientImpl.readData(Constants.user_id));
    var response = await userRepositoryImpl.getUserbyId(userId ?? 0);

    userName = response.userName;
    setState(() {
      isLoading = false;
    });
  }

  getSchedule() async {
    var schedule = await scheduleRepository.getDutySchedule();
    scheduleList = schedule;
    firstOngoing = getFirstOngoingSchedule(scheduleList);
    setState(() {});
  }

  ScheduleResponse? getFirstOngoingSchedule(List<ScheduleResponse> schedules) {
    for (var schedule in schedules) {
      if (schedule.status == 'ONGOING') {
        return schedule;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                  color: isAdmin ?? false ? Colors.blue : Color(0xFFB74848),
                ))
              : MainScreenContent(
                  userName: userName ?? '',
                  isAdmin: isAdmin ?? false,
                  categories: categories,
                  localClientImpl: localClientImpl,
                  secureStorageImpl: secureStorageImpl,
                  firstOngoing: firstOngoing,
                )
        ],
      ),
    );
  }
}

class MainScreenContent extends StatelessWidget {
  final bool isAdmin;
  final String userName;
  final Map<String, Map<String, dynamic>>? categories;
  final LocalClientImpl localClientImpl;
  final SecureStorageImpl secureStorageImpl;
  final ScheduleResponse? firstOngoing;
  const MainScreenContent(
      {super.key,
      this.categories,
      required this.localClientImpl,
      required this.secureStorageImpl,
      required this.isAdmin,
      required this.userName,
      this.firstOngoing});

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
                    Expanded(child: Container(color: isAdmin ? Colors.blue : Color(0xFFB74848))),
                  ],
                ),
              ),
              _buildHeaderContent(context, localClientImpl, secureStorageImpl, isAdmin, userName),
            ],
          ),
          BaseMainContent(
              children: Column(
            children: [
              Visibility(
                visible: isAdmin == false,
                child: _buildUpcomingSchedule(context, firstOngoing, isAdmin),
              ),
              _buildOther(categories, isAdmin),
            ],
          )),
          const SizedBox(height: 50)
        ],
      ),
    );
  }
}

Widget _buildUpcomingSchedule(BuildContext context, ScheduleResponse? firstOngoing, bool isAdmin) {
  return Padding(
    padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
    child: Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Lịch trực sắp tới',
            style: TextStyle(
              fontSize: 18,
              color: isAdmin ? Color(0xFF55B5F3) : Color(0xFFAF1116),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Card(
          color: Colors.white,
          elevation: 3,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (firstOngoing != null)
                        Text(
                          DateFormat('dd/MM/yyyy').format(DateTime.parse(firstOngoing.from ?? '')),
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      Text('đến', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      if (firstOngoing != null)
                        Text(
                          DateFormat('dd/MM/yyyy').format(DateTime.parse(firstOngoing.to ?? '')),
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                    ],
                  ),
                ),
                Container(
                  height: 130,
                  width: 1,
                  color: Colors.black,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sao Đỏ:', style: TextStyle(fontSize: 12)),
                      Text(firstOngoing?.supervisorName ?? '',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text('Giám Thị:', style: TextStyle(fontSize: 12)),
                      Text(firstOngoing?.teacherName ?? '',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Lớp: ',
                              style: TextStyle(fontSize: 12),
                            ),
                            TextSpan(
                              text: firstOngoing?.classId.toString() ?? '',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: InkWell(
                  onTap: () => context.push(ScreenRoute.dutyScheduleScreen),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Xem chi tiết',
                        style: TextStyle(fontSize: 12, color: isAdmin ? Color(0xFF55B5F3) : Color(0xFFAF1116)),
                      ),
                      Icon(
                        Icons.navigate_next_outlined,
                        size: 20,
                        color: isAdmin ? Color(0xFF55B5F3) : Color(0xFFAF1116),
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

Widget _buildHeaderContent(BuildContext context, LocalClientImpl localClient, SecureStorageImpl secureStorageImpl,
    bool isAdmin, String userName) {
  return Container(
    height: 80,
    decoration: BoxDecoration(
      color: isAdmin ? Colors.blue : Color(0xFFB74848),
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
                    userName,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    isAdmin ? 'Giám Thị' : 'Học sinh',
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
                  width: 120,
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

Widget _buildOther(Map<String, Map<String, dynamic>>? categories, bool isAdmin) {
  return Padding(
    padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(1.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Chức năng khác',
              style: TextStyle(
                fontSize: 18,
                color: isAdmin ? Color(0xFF55B5F3) : Color(0xFFAF1116),
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
            return _buildCardCategoryItem(categoryIcon, categoryName, context, isAdmin);
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
  static const List<MenuItem> item = [settings, logoutIcon];
  static const settings = MenuItem(text: 'Cài Đặt', icon: Icons.settings);
  static const logoutIcon = MenuItem(text: 'Đăng Xuất', icon: Icons.logout);

  static Widget buildItem(MenuItem item) {
    bool isAdmin = false;
    LocalClientImpl localClientImpl = LocalClientImpl();
    isAdmin = localClientImpl.readData("isAdmin");
    return Row(
      children: [
        Icon(item.icon, color: isAdmin ? Color(0xFF55B5F3) : Color(0xFFAF1116), size: 12),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(
              fontSize: 10,
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
  bool isAdmin,
) {
  return GestureDetector(
    onTap: () {
      // Navigate to the respective screen based on the tapped category
      if (categoryName == "Quy Định") {
        context.push(ScreenRoute.ruleScreen);
      } else if (categoryName == "Tạo Vi Phạm") {
        context.push(ScreenRoute.createViolationScreen);
      } else if (categoryName == "Liên Lạc") {
        context.push(ScreenRoute.contactScreen);
      } else if (categoryName == "Tài Khoản") {
        context.push(ScreenRoute.profileScreen);
      } else if (categoryName == "Lịch Sử Vi Phạm") {
        context.push(ScreenRoute.violationHistoryScreen);
      } else if (categoryName == "Lịch Trực") {
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
            color: isAdmin ? Color(0xFF55B5F3) : Color(0xFFAF1116),
            size: 35,
          ),
          Text(
            categoryName,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    ),
  );
}
