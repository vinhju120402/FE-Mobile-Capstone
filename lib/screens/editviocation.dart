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
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class Editviocation extends StatefulWidget {
  const Editviocation({super.key, required this.id});
  final int id;

  @override
  EditviocationState createState() => EditviocationState();
}

class EditviocationState extends State<Editviocation> {
  ViolationRepositoryImpl violationRepository = ViolationRepositoryImpl();
  final ClassRepositoryImpl classRepository = ClassRepositoryImpl();
  final StudentInClassRepositoryImpl studentInClassRepository = StudentInClassRepositoryImpl();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController violateGroupController = TextEditingController();
  final TextEditingController violateTypeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool isLoading = true;
  List<ViolationGroupResponse> violationGroup = [];
  List<ClassResponse> classList = [];
  List<ViolationTypeResponse> violationType = [];
  List<StudentInClassResponse> studentInClass = [];
  int? classId;
  int? studentInClassId;
  int? violationTypeId;
  String violationName = '';
  List<String> violationImagesList = [];
  List<File> imageFiles = [];
  LocalClientImpl localClientImpl = LocalClientImpl();
  bool isAdmin = false;
  List<SchoolYearResponse> schoolYear = [];
  final TextEditingController schoolYearController = TextEditingController();
  List<ScheduleResponse> scheduleList = [];
  final TextEditingController scheduleController = TextEditingController();
  int? scheduleId;
  int? schoolYearId;
  DateTime? pickerStartDate;
  DateTime? pickerEndDate;
  ClassResponse classResponse = ClassResponse();
  SchoolYearRepositoryImpl schoolYearRepository = SchoolYearRepositoryImpl();
  ScheduleRepositoryImpl scheduleRepository = ScheduleRepositoryImpl();
  ProgressDialog? _progressDialog;

  @override
  void initState() {
    super.initState();
    isAdmin = localClientImpl.readData("isAdmin");
    if (kDebugMode) {
      print('ID: ${widget.id}');
    }
    initializeData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String selectedViolation = '';

  void showProgress() {
    _progressDialog = ProgressDialog(context: context);
    _progressDialog!.show(
      max: 100,
      msg: 'Vui lòng chờ giây lát ..',
      progressBgColor: Colors.red,
    );
  }

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
            SnackBar(content: Text('Bạn chỉ có thể chọn tối đa 2 hình ảnh.')),
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
          const SnackBar(content: Text('Bạn chỉ có thể chọn tối đa 2 hình ảnh.')),
        );
      }
    }
  }

  Future<void> _selectDateTime() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
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
              "${fullDateTime.year}/${fullDateTime.month.toString().padLeft(2, '0')}/${fullDateTime.day.toString().padLeft(2, '0')} ${fullDateTime.hour.toString().padLeft(2, '0')}:${fullDateTime.minute.toString().padLeft(2, '0')}:${fullDateTime.second.toString().padLeft(2, '0')}";
          timeController.text = formattedDateTime;
        });
      }
    }
  }

  Future<void> getViolationById(int id) async {
    try {
      final violation = await violationRepository.getViolationById(id);
      if (kDebugMode) {
        print('Violation: $violation');
      }
      if (violation.violationId != null) {
        schoolYearController.text = violation.year.toString();
        classController.text = violation.className ?? '';
        classId = violation.classId;
        String scheduleText = '';
        var schedule = scheduleList.firstWhere((element) => element.name == violation.scheduleName);
        scheduleId = schedule.scheduleId;
        String from = DateFormat('yyyy/MM/dd').format(DateTime.parse(schedule.from ?? ''));
        String to = DateFormat('yyyy/MM/dd').format(DateTime.parse(schedule.to ?? ''));
        scheduleText = '$from - $to';

        scheduleController.text = scheduleText;

        await getSutdentInClass(violation.classId);
        nameController.text = violation.studentName ?? '';
        studentInClassId = violation.studentInClassId;
        timeController.text = DateFormat('yyyy/MM/dd').format(DateTime.parse(violation.date ?? ''));
        violateGroupController.text = violationGroup
                .firstWhere((element) => element.violationGroupId == violation.violationGroupId)
                .vioGroupName ??
            '';
        await getViolationTypeByGroup(violation.violationGroupId ?? 0);
        violateTypeController.text =
            violationType.firstWhere((element) => element.violationTypeId == violation.violationTypeId).vioTypeName ??
                '';
        violationTypeId = violation.violationTypeId;
        violationName = violation.violationName ?? '';
        descriptionController.text = violation.description ?? '';
        violationImagesList = violation.imageUrls ?? [];
        loadImages(violationImagesList);
      } else {
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Lấy thông tin vi phạm thất bại'),
              content: const Text('Không thể lấy thông tin vi phạm.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Chấp nhận'),
                ),
              ],
            ),
          );
        }
      }
      isLoading = false;
      setState(() {});
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Lỗi: ${e.message}');
      }
    }
  }

  Future<void> getViolationGroup() async {
    int schoolId = int.parse(await localClientImpl.readData(Constants.school_id));
    var response = await violationRepository.getViolationGroup(schoolId);
    violationGroup = response;
  }

  Future<void> getClassList() async {
    int schoolId = int.parse(await localClientImpl.readData(Constants.school_id));
    var response = await classRepository.getListClass(schoolId);
    classList = response;
  }

  Future<void> initializeData() async {
    await getSchoolYear();
    await getViolationGroup();
    await getSchedule();
    await getViolationById(widget.id);
  }

  Future<void> getViolationTypeByGroup(int groupId) async {
    var response = await violationRepository.getListViolationTypeByGroup(groupId);
    violationType = response;
  }

  Future<void> editViolation(int id) async {
    ViolationRequest violationRequest = ViolationRequest(
      schoolId: int.parse(await localClientImpl.readData(Constants.school_id)),
      userId: int.parse(await localClientImpl.readData(Constants.user_id)),
      schoolYear: schoolYearController.text.isNotEmpty ? int.parse(schoolYearController.text) : 0,
      scheduleId: scheduleId ?? 0,
      classId: classId ?? 0,
      studentInClassId: studentInClassId ?? 0,
      violationTypeId: violationTypeId ?? 0,
      teacherId: null,
      violationName: violateTypeController.text,
      description: descriptionController.text,
      date: DateFormat('yyyy/MM/dd').parse(timeController.text),
      images: imageFiles,
    );

    var response = await violationRepository.editViolation(id, violationRequest);
    if (response is String) {
      if (kDebugMode) {
        print(response);
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response)));
      }
    } else {
      if (mounted) {
        showProgress();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Chỉnh sửa vi phạm thành công.')));
        GoRouter.of(context).go(ScreenRoute.homeScreen);
      }
    }
  }

  Future<void> getSutdentInClass(int? classId) async {
    var response = await studentInClassRepository.getListStudent(classId: classId);
    studentInClass = response;
  }

  Future<void> loadImages(List<String> imageFromAPIList) async {
    final cacheManager = DefaultCacheManager();

    final List<File> files = [];
    for (String url in imageFromAPIList) {
      final file = await cacheManager.getSingleFile(url);
      files.add(file);
    }
    setState(() {
      imageFiles = files;
    });
  }

  void getClassBySchedule(int scheduleId) async {
    var response = await classRepository.getClassBySchedule(scheduleId);
    classResponse = response;
    classController.text = classResponse.name ?? '';
    classId = classResponse.classId;
    getSutdentInClass(classId);
  }

  Future<void> getSchoolYear() async {
    int schoolId = int.parse(await localClientImpl.readData(Constants.school_id));
    var response = await schoolYearRepository.getListSchoolYear(schoolId);
    if (response.isNotEmpty) {
      schoolYear = response;
    }
  }

  Future<void> getSchedule() async {
    int userId = int.parse(await localClientImpl.readData(Constants.user_id));
    var schedule = await scheduleRepository.getDutyScheduleBySupervisorId(userId);
    scheduleList = schedule;
    // filter schedule by status ongoing
    scheduleList = scheduleList.where((element) => element.status == 'ONGOING').toList();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isLoading,
      child: Scaffold(
        appBar: CustomAppbar(
          onBack: () => context.pop(),
          title: 'Chỉnh sửa vi phạm',
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : BaseMainContent(
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
                        const Text(
                          'Lớp',
                          style: TextStyle(fontSize: 14, color: Color(0xfff8a8bb3)),
                        ),
                        CommonTextField(
                          maxLines: 1,
                          inputController: classController,
                          isReadOnly: true,
                          onTap: () => _buildClassBottomSheet(context),
                        ),
                        const SizedBox(height: 20.0),
                        const Text(
                          'Tên học sinh',
                          style: TextStyle(fontSize: 14, color: Color(0xfff8a8bb3)),
                        ),
                        CommonTextField(
                          maxLines: 1,
                          inputController: nameController,
                          isReadOnly: true,
                          onTap: () => _buildStudentInClassList(context),
                        ),
                        const SizedBox(height: 20.0),
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
                        const SizedBox(height: 20.0),
                        const Text(
                          'Nhóm vi phạm',
                          style: TextStyle(fontSize: 14, color: Color(0xfff8a8bb3)),
                        ),
                        CommonTextField(
                          maxLines: 1,
                          inputController: violateGroupController,
                          isReadOnly: true,
                          onTap: () => _buildViolationGroupBottomSheet(context),
                        ),
                        const SizedBox(height: 20.0),
                        const Text(
                          'Loại vi phạm',
                          style: TextStyle(fontSize: 14, color: Color(0xfff8a8bb3)),
                        ),
                        CommonTextField(
                          maxLines: 1,
                          inputController: violateTypeController,
                          isReadOnly: true,
                          onTap: () => _buildViolationTypeBottomSheet(context),
                        ),
                        const SizedBox(height: 20.0),
                        const Text(
                          'Mô tả',
                          style: TextStyle(fontSize: 14, color: Color(0xfff8a8bb3)),
                        ),
                        CommonTextField(
                          maxLines: 3,
                          inputController: descriptionController,
                        ),
                        const SizedBox(height: 20.0),
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
                                padding: const EdgeInsets.symmetric(
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
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15.0,
                                  horizontal: 20.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        if (imageFiles.isNotEmpty)
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: imageFiles.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
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
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      imageFiles.removeAt(index);
                                    });
                                  },
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Icon(Icons.close, color: Colors.red, size: 20.0),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            editViolation(widget.id);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isAdmin ? Colors.blue : Color(0xFFB74848),
                            textStyle: const TextStyle(fontSize: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                          ),
                          child: const Text('Gửi', style: TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(height: 20.0),
                      ],
                    ),
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
                    decoration: const InputDecoration(
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
                          // isSelectedViolationGroup = true;
                          // getViolationTypeByGroup(filteredViolationGroup[index].violationGroupId ?? 0);
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
                            Text('${DateFormat('yyyy/MM/dd').format(DateTime.parse(scheduleList[index].from ?? ''))} - '
                                '${DateFormat('yyyy/MM/dd').format(DateTime.parse(scheduleList[index].to ?? ''))}'),
                        onTap: () {
                          scheduleController.text =
                              '${DateFormat('yyyy/MM/dd').format(DateTime.parse(scheduleList[index].from ?? ''))} - '
                              '${DateFormat('yyyy/MM/dd').format(DateTime.parse(scheduleList[index].to ?? ''))}';
                          if (kDebugMode) {
                            print('Ca trực: id: ${scheduleList[index].scheduleId} - '
                                '${DateFormat('yyyy/MM/dd').format(DateTime.parse(scheduleList[index].from ?? ''))} - '
                                '${DateFormat('yyyy/MM/dd').format(DateTime.parse(scheduleList[index].to ?? ''))}');
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
                    decoration: const InputDecoration(
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
                    decoration: const InputDecoration(
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
                        onTap: () async {
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
                    decoration: const InputDecoration(
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
}
