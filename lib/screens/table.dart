import 'dart:io';
import 'package:flutter/material.dart';
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
  final TextEditingController violateController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  final List<String> predefinedViolations = [
    'Nghỉ học không phép',
    'Quấy rối trong lớp học',
    'Vi phạm nội quy trường học',
    'Vô lễ với giáo viên',
    'Không tham gia hoạt động giáo dục',
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appearence'),
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
                  onTap: () {
                    _showPredefinedViolations(context);
                  },
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
                        backgroundColor: Colors.orange, // Thay đổi màu nút
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Thay đổi hình dạng nút
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 20.0), // Thay đổi padding của nút
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _selectPicture,
                      icon: Icon(Icons.photo_library),
                      label: Text('Chọn ảnh'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Thay đổi màu nút
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Thay đổi hình dạng nút
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 20.0), // Thay đổi padding của nút
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                // Trong phần build() của lớp _DataEntryFormState
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Các TextFormField đã có
                    SizedBox(height: 10.0),
                    // Hiển thị ảnh nếu đã chọn hoặc chụp
                    if (imageFile != null)
                      Container(
                        width: 120.0, // Đặt chiều rộng của container thành 90
                        height: 120.0, // Đặt chiều cao của container thành 90
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: FileImage(
                                imageFile!), // Sử dụng FileImage để hiển thị ảnh từ File
                            fit: BoxFit
                                .contain, // Thay đổi fit thành BoxFit.contain
                          ),
                        ),
                      ),
                    SizedBox(height: 20.0),
                    // Các nút và ElevatedButton đã có
                  ],
                ),

                ElevatedButton(
                  onPressed: () {
                    // Xử lý dữ liệu ở đây (ví dụ: lưu vào cơ sở dữ liệu, thực hiện hành động khác)
                    // Ví dụ:
                    final name = nameController.text;
                    final className = classController.text;
                    final time = timeController.text;
                    final violate = violateController.text;
                    final image = imageFile;
                    final note = noteController;

                    // In thông tin vừa nhập
                    print('Họ và Tên: $name');
                    print('Lớp: $className');
                    print('Thời Gian: $time');
                    print('Vi Phạm: $violate');
                    print('Ảnh: $image');

                    // Xóa dữ liệu sau khi đã nhập
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
                    backgroundColor: Colors.blue, // Thay đổi màu nút
                    textStyle: TextStyle(
                        fontSize: 18), // Thay đổi font size của văn bản nút
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // Thay đổi hình dạng nút
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 15.0), // Thay đổi padding của nút
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

  void _showPredefinedViolations(BuildContext context) {
    List<String> filteredViolations = List.from(predefinedViolations);
    TextEditingController searchController = TextEditingController();

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
                  hintText: 'Search',
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
                      setState(() {
                        selectedViolation = filteredViolations[index];
                        violateController.text = selectedViolation;
                      });
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
  }
}
