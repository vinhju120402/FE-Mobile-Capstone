import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class DataEntryForm extends StatefulWidget {
  const DataEntryForm({Key? key}) : super(key: key);

  @override
  _DataEntryFormState createState() => _DataEntryFormState();
}

class _DataEntryFormState extends State<DataEntryForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController violateGroupController = TextEditingController();
  final TextEditingController violateTypeController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final List<String> predefinedViolations = [
    'Nghỉ học không phép',
    'Quấy rối trong lớp học',
    'Vi phạm nội quy trường học',
    'Vô lễ với giáo viên',
    'Không tham gia hoạt động giáo dục',
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentTime();
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

  void _getCurrentTime() {
    DateTime now = DateTime.now();
    String formattedTime =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
    timeController.text = formattedTime;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Violation'),
        backgroundColor:
            Color.fromARGB(189, 7, 206, 43), // Thay đổi màu nền của app bar
      ),
      body: Container(
        color: Color.fromARGB(226, 134, 253, 237),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: nameController,
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
                  controller: classController,
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
                    _showPredefinedViolations(context, 'violationGroup');
                  },
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
                    _showPredefinedViolations(context, 'violationType');
                  },
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
                  maxLines: null, // Cho phép nhiều dòng khi cần thiết
                  maxLength: 300, // Giới hạn tối đa 300 ký tự
                  maxLengthEnforcement:
                      MaxLengthEnforcement.enforced, // Bắt buộc giới hạn ký tự
                  onChanged: (value) {
                    setState(
                        () {}); // Đảm bảo cập nhật giao diện khi thay đổi nội dung
                  },
                  decoration: InputDecoration(
                    labelText: 'Description',
                    counterText:
                        '${descriptionController.text.length}/300', // Hiển thị số lượng ký tự đã nhập
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
                SizedBox(height: 1.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 10.0),
                    if (imageFile != null)
                      Container(
                        width: 120.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: FileImage(imageFile!),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    SizedBox(height: 20.0),
                  ],
                ),
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

                    // Xóa nội dung của các trường và tệp ảnh
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
                SizedBox(
                  height: 300,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showPredefinedViolations(BuildContext context, String field) {
    List<String> filteredViolations = List.from(predefinedViolations);
    TextEditingController searchController = TextEditingController();

    TextEditingController selectedController;
    String dialogTitle;

    if (field == 'violationGroup') {
      selectedController = violateGroupController;
      dialogTitle = 'Nhóm vi phạm';
    } else if (field == 'violationType') {
      selectedController = violateTypeController;
      dialogTitle = 'Loại vi phạm';
    } else {
      return; // Xử lý giá trị trường không mong muốn
    }

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
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
                    filteredViolations = predefinedViolations
                        .where((violation) => violation
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredViolations.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredViolations[index]),
                    onTap: () {
                      Navigator.pop(context, filteredViolations[index]);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          selectedController.text = value;
        });
      }
    });
  }
}
