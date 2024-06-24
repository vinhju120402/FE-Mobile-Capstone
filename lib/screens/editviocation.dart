import 'dart:io';
import 'package:eduappui/remote/model/response/class_reponse.dart';
import 'package:eduappui/remote/model/response/student_in_class_response.dart';
import 'package:eduappui/remote/model/response/violation_group_response.dart';
import 'package:eduappui/remote/model/response/violation_type_response.dart';
import 'package:eduappui/remote/service/repository/class_repository.dart';
import 'package:eduappui/remote/service/repository/student_in_class_repository.dart';
import 'package:eduappui/remote/service/repository/violation_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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
  final TextEditingController codeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool isLoading = true;
  List<ViolationGroupResponse> violationGroup = [];
  List<ClassResponse> classList = [];
  List<ViolationTypeResponse> violationType = [];
  List<StudentInClassResponse> studentInClass = [];

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print('ID: ${widget.id}');
    }
    getViolationGroup();
    getClassList();
    getViolationById(widget.id);
  }

  String selectedViolation = '';
  File? imageFile;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  Future<void> _selectPicture() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
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
              "${fullDateTime.year}-${fullDateTime.month.toString().padLeft(2, '0')}-${fullDateTime.day.toString().padLeft(2, '0')} ${fullDateTime.hour.toString().padLeft(2, '0')}:${fullDateTime.minute.toString().padLeft(2, '0')}:${fullDateTime.second.toString().padLeft(2, '0')}";
          timeController.text = formattedDateTime;
        });
      }
    }
  }

  void getViolationById(int id) async {
    try {
      final violation = await violationRepository.getViolationById(id);
      if (kDebugMode) {
        print('Violation: $violation');
      }
      if (violation.violationId != null) {
        nameController.text = violation.studentName ?? '';
        classController.text = violation.classId.toString();
        timeController.text = DateFormat.yMd().format(DateTime.parse(violation.date ?? ''));
        violateGroupController.text = violation.violationTypeId.toString();
        violateTypeController.text = violation.violationTypeId.toString();
        codeController.text = violation.code ?? '';
        descriptionController.text = violation.description ?? '';
      } else {
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Get Violation Failed'),
              content: Text('Violation not found. Please try again.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
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
        print('Error: ${e.message}');
      }
    }
  }

  void getViolationGroup() async {
    var response = await violationRepository.getViolationGroup();
    violationGroup = response;
    setState(() {});
  }

  void getClassList() async {
    var response = await classRepository.getListClass();
    classList = response;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(226, 134, 253, 237),
      appBar: AppBar(
        title: Text('Edit Violation'),
        backgroundColor: Color.fromARGB(189, 7, 206, 43),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: classController,
                      onTap: () {
                        _buildClassBottomSheet(context);
                      },
                      readOnly: true, // Prevent keyboard from appearing on tap
                      decoration: InputDecoration(
                        labelText: 'Class',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: nameController,
                      onTap: () {
                        _buildStudentInClassList(context);
                      },
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Student name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: timeController,
                      readOnly: true,
                      onTap: _selectDateTime,
                      decoration: InputDecoration(
                        labelText: 'Time',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: violateGroupController,
                      onTap: () {
                        _buildViolationGroupBottomSheet(context);
                      },
                      readOnly: true, // Prevent keyboard from appearing on tap
                      decoration: InputDecoration(
                        labelText: 'Violation group',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: violateTypeController,
                      onTap: () {
                        _buildViolationTypeBottomSheet(context);
                      },
                      readOnly: true, // Prevent keyboard from appearing on tap
                      decoration: InputDecoration(
                        labelText: 'Violation type',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: codeController,
                      decoration: InputDecoration(
                        labelText: 'Code',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: descriptionController,
                      maxLines: null,
                      maxLength: 300,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        labelText: 'Description',
                        counterText: '${descriptionController.text.length}/300',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _takePicture,
                          icon: Icon(Icons.camera_alt),
                          label: Text('Chụp ảnh'),
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
                          icon: Icon(Icons.photo_library),
                          label: Text('Chọn ảnh'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
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
                    if (imageFile != null)
                      Container(
                        width: 120.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: FileImage(imageFile!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        final name = nameController.text;
                        final className = classController.text;
                        final time = timeController.text;
                        final violateGroup = violateGroupController.text;
                        final violateType = violateTypeController.text;
                        final code = codeController.text;
                        final description = descriptionController.text;
                        final image = imageFile;

                        print('Tên học sinh: $name');
                        print('Lớp học: $className');
                        print('Thời gian: $time');
                        print('Nhóm vi phạm: $violateGroup');
                        print('Loại vi phạm: $violateType');
                        print('Mã vi phạm: $code');
                        print('Mô tả: $description');
                        print('Ảnh: $image');

                        // Reset text controllers and image file state
                        nameController.clear();
                        classController.clear();
                        timeController.clear();
                        violateGroupController.clear();
                        violateTypeController.clear();
                        codeController.clear();
                        descriptionController.clear();
                        setState(() {
                          imageFile = null;
                        });
                      },
                      child: Text('Gửi'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        textStyle: TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                      ),
                    ),
                    SizedBox(height: 20.0),
                  ],
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
                          // getSutdentInClass(filteredClassList[index].classId);
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
                        // filteredStudentInClass = studentInClass.where((student) {
                        //   return student.studentId?.(value.toLowerCase()) ?? false;
                        // }).toList();
                      });
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredStudentInClass.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(filteredStudentInClass[index].studentId.toString()),
                        onTap: () {
                          nameController.text = filteredStudentInClass[index].studentId.toString();
                          if (kDebugMode) {
                            print('ID học sinh: ${filteredStudentInClass[index].studentId}');
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
}
