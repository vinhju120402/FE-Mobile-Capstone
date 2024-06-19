import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class OrtherViolation extends StatefulWidget {
  const OrtherViolation({Key? key}) : super(key: key);

  @override
  _OrtherViolationState createState() => _OrtherViolationState();
}

class _OrtherViolationState extends State<OrtherViolation> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController violateController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  String selectedViolation = '';
  File? imageFile;

  @override
  void initState() {
    super.initState();
    // Gọi hàm để đặt thời gian hiện tại vào ô nhập liệu
    _getCurrentTime();
  }

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

  // Hàm để lấy thời gian hiện tại và đặt vào timeController
  void _getCurrentTime() {
    DateTime now = DateTime.now();
    String formattedTime =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
    timeController.text = formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Other Violation'),
        backgroundColor: Color.fromARGB(189, 7, 206, 43),
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
                    labelText: 'Họ và Tên',
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
                    labelText: 'Lớp',
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
                  readOnly:
                      true, // Đặt readOnly để ngăn người dùng chỉnh sửa trực tiếp
                  decoration: InputDecoration(
                    labelText: 'Thời Gian',
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
                  controller: violateController,
                  decoration: InputDecoration(
                    labelText: 'Vi Phạm',
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
                            vertical: 15.0, horizontal: 20.0),
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
                            vertical: 15.0, horizontal: 20.0),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
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
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    final name = nameController.text;
                    final className = classController.text;
                    final time = timeController.text;
                    final violate = violateController.text;
                    final image = imageFile;
                    final note = noteController.text;

                    print('Họ và Tên: $name');
                    print('Lớp: $className');
                    print('Thời Gian: $time');
                    print('Vi Phạm: $violate');
                    print('Ảnh: $image');

                    nameController.clear();
                    classController.clear();
                    timeController.clear();
                    violateController.clear();
                    noteController.clear();
                    setState(() {
                      imageFile = null;
                    });
                  },
                  child: Text('Submit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    textStyle: TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                  ),
                ),
                SizedBox(height: 300),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
