import 'dart:io';
import 'package:eduappui/remote/constant/constants.dart';
import 'package:eduappui/remote/local/local_client.dart';
import 'package:eduappui/remote/model/request/violation_request.dart';
import 'package:eduappui/remote/model/response/class_reponse.dart';
import 'package:eduappui/remote/model/response/schedule_response.dart';
import 'package:eduappui/remote/model/response/school_year_response.dart';
import 'package:eduappui/remote/model/response/student_in_class_response.dart';
import 'package:eduappui/remote/model/response/violation_group_response.dart';
import 'package:eduappui/remote/model/response/violation_type_response.dart';
import 'package:eduappui/remote/service/repository/class_repository.dart';
import 'package:eduappui/remote/service/repository/schedule_repository.dart';
import 'package:eduappui/remote/service/repository/school_year_repository.dart';
import 'package:eduappui/remote/service/repository/student_in_class_repository.dart';
import 'package:eduappui/remote/service/repository/violation_repository.dart';
import 'package:eduappui/routers/screen_route.dart';
import 'package:eduappui/widget/TextField/common_text_field.dart';
import 'package:eduappui/widget/app_bar.dart';
import 'package:eduappui/widget/base_main_content.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class CreateViolationScreen extends StatefulWidget {
  const CreateViolationScreen({super.key});

  @override
  CreateViolationScreenState createState() => CreateViolationScreenState();
}

class CreateViolationScreenState extends State<CreateViolationScreen> {
  final ViolationRepositoryImpl violationRepository = ViolationRepositoryImpl();
  final ClassRepositoryImpl classRepository = ClassRepositoryImpl();
  final StudentInClassRepositoryImpl studentInClassRepository = StudentInClassRepositoryImpl();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController violateGroupController = TextEditingController();
  final TextEditingController violateTypeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  List<ViolationGroupResponse> violationGroup = [];
  List<ViolationTypeResponse> violationType = [];
  List<StudentInClassResponse> studentInClass = [];
  ClassResponse classResponse = ClassResponse();
  List<ClassResponse> classList = [];
  bool isSelectedViolationGroup = false;
  int? classId;
  int? studentInClassId;
  int? violationTypeId;
  ProgressDialog? _progressDialog;
  SchoolYearRepositoryImpl schoolYearRepository = SchoolYearRepositoryImpl();
  LocalClientImpl localClientImpl = LocalClientImpl();
  List<SchoolYearResponse> schoolYear = [];
  final TextEditingController schoolYearController = TextEditingController();
  int? schoolYearId;
  DateTime? pickerStartDate;
  DateTime? pickerEndDate;
  bool isAdmin = false;
  ScheduleRepositoryImpl scheduleRepository = ScheduleRepositoryImpl();
  List<ScheduleResponse> scheduleList = [];
  final TextEditingController scheduleController = TextEditingController();
  int? scheduleId;

  @override
  void initState() {
    super.initState();
    isAdmin = localClientImpl.readData("isAdmin");
    getSchoolYear();
    getViolationGroup();
    getSchedule();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String selectedViolation = '';
  List<File> imageFiles = [];

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      if (imageFiles.length < 2) {
        setState(() {
          imageFiles.add(File(pickedImage.path));
        });
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Bạn chỉ có thể chọn tối đa 2 ảnh.')),
          );
        }
      }
    }
  }

  Future<void> _selectPicture() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();

    if (imageFiles.length + pickedImages.length <= 2) {
      setState(() {
        imageFiles.addAll(pickedImages.map((pickedImage) => File(pickedImage.path)).toList());
      });
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bạn chỉ có thể chọn tối đa 2 ảnh.')),
        );
      }
    }
  }

  Future<void> _selectDateTime() async {
    if (schoolYearController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bạn chưa chọn niên khóa')),
      );
      return;
    }

    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: pickerStartDate,
      firstDate: pickerStartDate ?? DateTime.now(),
      lastDate: pickerEndDate ?? DateTime.now().add(Duration(days: 365)),
    );

    if (selectedDate != null) {
      if (mounted) {
        TimeOfDay? selectedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (selectedTime != null) {
          setState(() {
            DateTime fullDateTime = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              selectedTime.hour,
              selectedTime.minute,
            );
            String formattedDateTime =
                "${fullDateTime.year}-${fullDateTime.month.toString().padLeft(2, '0')}-${fullDateTime.day.toString().padLeft(2, '0')} ${fullDateTime.hour.toString().padLeft(2, '0')}:${fullDateTime.minute.toString().padLeft(2, '0')}:${fullDateTime.second.toString().padLeft(2, '0')}";
            timeController.text = formattedDateTime;
          });
        }
      }
    }
  }

  void createViolation() async {
    List<File>? listImage = [];
    listImage = imageFiles;
    int schoolId = int.parse(await localClientImpl.readData(Constants.school_id));
    ViolationRequest violationRequest = ViolationRequest(
      schoolId: schoolId,
      userId: int.parse(await localClientImpl.readData(Constants.user_id)),
      schoolYear: schoolYearController.text.isNotEmpty ? int.parse(schoolYearController.text) : 0,
      studentInClassId: studentInClassId ?? 0,
      scheduleId: scheduleId ?? 0,
      classId: classId ?? 0,
      date: DateTime.parse(timeController.text),
      violationTypeId: violationTypeId ?? 0,
      violationName: violateTypeController.text,
      description: descriptionController.text,
      images: listImage,
    );
    if (kDebugMode) {
      print(violationRequest.toJson());
    }
    var res = await violationRepository.createViolation(violationRequest);

    if (res is String) {
      if (kDebugMode) {
        print(res);
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
      }
    } else {
      if (mounted) {
        showProgress();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tạo vi phạm thành công.')));
        GoRouter.of(context).go(ScreenRoute.homeScreen);
      }
    }
  }

  void getViolationGroup() async {
    int schoolId = int.parse(await localClientImpl.readData(Constants.school_id));
    var response = await violationRepository.getViolationGroup(schoolId);
    violationGroup = response;
  }

  void getViolationTypeByGroup(int groupId) async {
    var response = await violationRepository.getListViolationTypeByGroup(groupId);
    violationType = response;
  }

  void getClassBySchedule(int scheduleId) async {
    var response = await classRepository.getClassBySchedule(scheduleId);
    classResponse = response;
    classController.text = classResponse.name ?? '';
    classId = classResponse.classId;
    getSutdentInClass(classId);
  }

  void getClassList() async {
    int schoolId = int.parse(await localClientImpl.readData(Constants.school_id));
    var response = await classRepository.getListClass(schoolId);
    classList = response;
    classList.removeWhere((x) => x.schoolYearId != schoolYearId);
  }

  void getSutdentInClass(int? classId) async {
    var response = await studentInClassRepository.getListStudent(classId: classId);
    studentInClass = response;
  }

  void showProgress() {
    _progressDialog = ProgressDialog(context: context);
    _progressDialog!.show(
      max: 100,
      msg: 'Vui lòng chờ giây lát ..',
      progressBgColor: Colors.red,
    );
  }

  void getSchoolYear() async {
    int schoolId = int.parse(await localClientImpl.readData(Constants.school_id));
    var response = await schoolYearRepository.getListSchoolYear(schoolId);
    if (response.isNotEmpty) {
      schoolYear = response;
    }
  }

  void getSchedule() async {
    int userId = int.parse(await localClientImpl.readData(Constants.user_id));
    var schedule = await scheduleRepository.getDutyScheduleBySupervisorId(userId);
    scheduleList = schedule;
    // filter schedule by status ongoing
    scheduleList = scheduleList.where((element) => element.status == 'ONGOING').toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        onBack: () => context.pop(),
        title: 'Tạo vi phạm',
      ),
      body: BaseMainContent(
        children: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Niên khóa',
                  style: TextStyle(fontSize: 14, color: Color(0xfff8a8bb3)),
                ),
                CommonTextField(
                  maxLines: 1,
                  isReadOnly: true,
                  inputController: schoolYearController,
                  onTap: () => _buildSchoolYearList(context),
                ),
                if (!isAdmin) SizedBox(height: 20.0),
                if (!isAdmin)
                  const Text(
                    'Ca trực',
                    style: TextStyle(fontSize: 14, color: Color(0xfff8a8bb3)),
                  ),
                if (!isAdmin)
                  CommonTextField(
                    maxLines: 1,
                    isReadOnly: true,
                    inputController: scheduleController,
                    onTap: () {
                      if (schoolYearController.text.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('Vui lòng chọn niên khóa trước.')));
                      } else {
                        _buildScheduleList(context);
                      }
                    },
                  ),
                SizedBox(height: 20.0),
                const Text(
                  'Lớp',
                  style: TextStyle(fontSize: 14, color: Color(0xfff8a8bb3)),
                ),
                CommonTextField(
                  maxLines: 1,
                  inputController: classController,
                  isReadOnly: true,
                  onTap: () {
                    if (isAdmin) {
                      if (schoolYearController.text.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('Vui lòng chọn niên khóa trước.')));
                      } else {
                        _buildClassBottomSheet(context);
                      }
                    } else {
                      if (scheduleController.text.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('Vui lòng chọn ca trực trước.')));
                      } else {
                        _buildClassBottomSheet(context);
                      }
                    }
                  },
                ),
                SizedBox(height: 20.0),
                const Text(
                  'Tên học sinh',
                  style: TextStyle(fontSize: 14, color: Color(0xfff8a8bb3)),
                ),
                CommonTextField(
                  maxLines: 1,
                  inputController: nameController,
                  isReadOnly: true,
                  onTap: () {
                    if (classController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Vui lòng chọn lớp trước.')));
                    } else {
                      _buildStudentInClassList(context);
                    }
                  },
                ),
                SizedBox(height: 20.0),
                const Text(
                  'Thời gian',
                  style: TextStyle(fontSize: 14, color: Color(0xfff8a8bb3)),
                ),
                CommonTextField(
                  maxLines: 1,
                  inputController: timeController,
                  isReadOnly: true,
                  onTap: () => _selectDateTime(),
                ),
                SizedBox(height: 20.0),
                const Text(
                  'Nhóm vi phạm',
                  style: TextStyle(fontSize: 14, color: Color(0xfff8a8bb3)),
                ),
                CommonTextField(
                  maxLines: 1,
                  inputController: violateGroupController,
                  isReadOnly: true,
                  onTap: () {
                    if (schoolYearController.text.isEmpty) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('Vui lòng chọn niên khóa trước.')));
                    } else {
                      _buildViolationGroupBottomSheet(context);
                    }
                  },
                ),
                SizedBox(height: 20.0),
                const Text(
                  'Loại vi phạm',
                  style: TextStyle(fontSize: 14, color: Color(0xfff8a8bb3)),
                ),
                CommonTextField(
                  maxLines: 1,
                  inputController: violateTypeController,
                  isReadOnly: true,
                  onTap: () {
                    if (!isSelectedViolationGroup || violateGroupController.text.isEmpty) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('Vui lòng chọn nhóm vi phạm trước.')));
                    } else {
                      _buildViolationTypeBottomSheet(context);
                    }
                  },
                ),
                SizedBox(height: 20.0),
                SizedBox(height: 20.0),
                const Text(
                  'Mô tả',
                  style: TextStyle(fontSize: 14, color: Color(0xfff8a8bb3)),
                ),
                CommonTextField(
                  maxLines: 3,
                  inputController: descriptionController,
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _takePicture,
                      icon: const Icon(Icons.camera_alt, color: Colors.white),
                      label: const Text('Chụp ảnh', style: TextStyle(fontSize: 14, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 20.0,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _selectPicture,
                      icon: const Icon(Icons.photo_library, color: Colors.white),
                      label: const Text('Chọn ảnh', style: TextStyle(fontSize: 14, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isAdmin ? Colors.blue : Color(0xFFB74848),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                if (imageFiles.isNotEmpty)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: imageFiles.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: 120.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26, // Shadow color
                              blurRadius: 10.0, // Shadow blur radius
                              offset: Offset(0, 5), // Shadow offset
                            ),
                          ],
                          border: Border.all(
                            color: Colors.white, // Border color
                            width: 2.0, // Border width
                          ),
                          image: DecorationImage(
                            image: FileImage(imageFiles[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8.0), // Padding inside the container
                        margin: const EdgeInsets.all(8.0), // Margin outside the container
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(Icons.close, color: Colors.red, size: 20.0),
                          ],
                        ),
                      );
                    },
                  ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    createViolation();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isAdmin ? Colors.blue : Color(0xFFB74848),
                    textStyle: TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                  ),
                  child: const Text('Gửi', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _buildViolationGroupBottomSheet(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    List filteredViolationGroup = List.from(violationGroup);

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Tìm kiếm',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {
                        filteredViolationGroup = violationGroup.where((group) {
                          return group.vioGroupName?.toLowerCase().contains(value.toLowerCase()) ?? false;
                        }).toList();
                      });
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredViolationGroup.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(filteredViolationGroup[index].vioGroupName ?? ''),
                        onTap: () {
                          violateTypeController.clear();
                          violateGroupController.text = filteredViolationGroup[index].vioGroupName ?? '';
                          if (kDebugMode) {
                            print('ID nhóm vi phạm: ${filteredViolationGroup[index].violationGroupId}');
                          }
                          isSelectedViolationGroup = true;
                          getViolationTypeByGroup(filteredViolationGroup[index].violationGroupId ?? 0);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {});
      }
    });
  }

  void _buildViolationTypeBottomSheet(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    List filteredViolationType = List.from(violationType);

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Tìm kiếm',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {
                        filteredViolationType = violationType.where((type) {
                          return type.vioTypeName?.toLowerCase().contains(value.toLowerCase()) ?? false;
                        }).toList();
                      });
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredViolationType.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(filteredViolationType[index].vioTypeName ?? ''),
                        onTap: () {
                          violateTypeController.text = filteredViolationType[index].vioTypeName ?? '';
                          if (kDebugMode) {
                            print('ID loại vi phạm: ${filteredViolationType[index].violationTypeId}');
                          }
                          violationTypeId = filteredViolationType[index].violationTypeId;
                          Navigator.pop(context);
                          setState(() {});
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {});
      }
    });
  }

  void _buildClassBottomSheet(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    List filteredClassList = List.from(classList);

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Tìm kiếm',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {
                        filteredClassList = classList.where((classItem) {
                          return classItem.name?.toLowerCase().contains(value.toLowerCase()) ?? false;
                        }).toList();
                      });
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredClassList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(filteredClassList[index].name ?? ''),
                        onTap: () {
                          nameController.clear();
                          classController.text = filteredClassList[index].name ?? '';
                          if (kDebugMode) {
                            print('ID lớp: ${filteredClassList[index].classId}');
                          }
                          classId = filteredClassList[index].classId;
                          getSutdentInClass(filteredClassList[index].classId);
                          Navigator.pop(context);
                          setState(() {});
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {});
      }
    });
  }

  void _buildStudentInClassList(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    List filteredStudentInClass = List.from(studentInClass);

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Tìm kiếm',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {
                        filteredStudentInClass = studentInClass.where((student) {
                          return student.studentName?.contains(value.toLowerCase()) ?? false;
                        }).toList();
                      });
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredStudentInClass.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(filteredStudentInClass[index].studentName.toString()),
                        onTap: () {
                          nameController.text = filteredStudentInClass[index].studentName.toString();
                          if (kDebugMode) {
                            print('ID học sinh: ${filteredStudentInClass[index].studentId}');
                          }
                          studentInClassId = filteredStudentInClass[index].studentInClassId;
                          Navigator.pop(context);
                          setState(() {});
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {});
      }
    });
  }

  void _buildSchoolYearList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: schoolYear.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(schoolYear[index].year.toString()),
                        onTap: () {
                          schoolYearController.text = schoolYear[index].year.toString();
                          schoolYearId = schoolYear[index].schoolYearId;
                          pickerStartDate = DateTime.parse(schoolYear[index].startDate ?? '');
                          pickerEndDate = DateTime.parse(schoolYear[index].endDate ?? '');
                          if (kDebugMode) {
                            print('Niên khóa: ${schoolYear[index].year}');
                          }
                          timeController.text = pickerStartDate.toString();
                          if (isAdmin) {
                            getClassList();
                          }
                          Navigator.pop(context);
                          setState(() {});
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {});
      }
    });
  }

  void _buildScheduleList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: scheduleList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title:
                            Text('${DateFormat('yyyy-MM-dd').format(DateTime.parse(scheduleList[index].from ?? ''))} - '
                                '${DateFormat('yyyy-MM-dd').format(DateTime.parse(scheduleList[index].to ?? ''))}'),
                        onTap: () {
                          scheduleController.text =
                              '${DateFormat('yyyy-MM-dd').format(DateTime.parse(scheduleList[index].from ?? ''))} - '
                              '${DateFormat('yyyy-MM-dd').format(DateTime.parse(scheduleList[index].to ?? ''))}';
                          if (kDebugMode) {
                            print('Ca trực: id: ${scheduleList[index].scheduleId} - '
                                '${DateFormat('yyyy-MM-dd').format(DateTime.parse(scheduleList[index].from ?? ''))} - '
                                '${DateFormat('yyyy-MM-dd').format(DateTime.parse(scheduleList[index].to ?? ''))}');
                          }
                          scheduleId = scheduleList[index].scheduleId;
                          getClassBySchedule(scheduleId!);
                          Navigator.pop(context);
                          setState(() {});
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {});
      }
    });
  }
}
