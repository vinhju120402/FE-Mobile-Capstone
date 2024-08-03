import 'package:eduappui/remote/constant/constants.dart';
import 'package:eduappui/remote/local/local_client.dart';
import 'package:eduappui/remote/model/request/user_request.dart';
import 'package:eduappui/remote/service/repository/user_repository.dart';
import 'package:eduappui/widget/TextField/common_text_field.dart';
import 'package:eduappui/widget/app_bar.dart';
import 'package:eduappui/widget/base_main_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int? userId;
  LocalClientImpl localClientImpl = LocalClientImpl();
  UserRepositoryImpl userRepositoryImpl = UserRepositoryImpl();
  TextEditingController nameController = TextEditingController();
  TextEditingController addrressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController schoolController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  String? password;
  int? schoolId;

  getCurrentUser() async {
    userId = int.parse(await localClientImpl.readData(Constants.user_id));
    var response = await userRepositoryImpl.getUserbyId(userId ?? 0);
    nameController.text = response.userName ?? '';
    addrressController.text = response.address ?? '';
    phoneController.text = response.phone ?? '';
    schoolController.text = response.schoolName ?? '';
    codeController.text = response.code ?? '';
    password = response.password;
    schoolId = response.schoolId;
    setState(() {});
  }

  void editProfile() async {
    UserResquest userRequest = UserResquest(
      name: nameController.text,
      address: addrressController.text,
      phone: phoneController.text,
      schoolId: schoolId,
      code: codeController.text,
      password: password,
    );
    var response = await userRepositoryImpl.updateUser(userId ?? 0, userRequest);
    if (response == 200) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Chỉnh sửa thông tin thành công')),
        );
        context.pop();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Tài khoản',
        onBack: () => context.pop(),
      ),
      body: BaseMainContent(
        children: Column(
          children: [
            const SizedBox(height: 16.0),
            _buildAvatarSection('https://letsenhance.io/static/73136da51c245e80edc6ccfe44888a99/1015f/MainBefore.jpg'),
            _buildPersonalInfoSection(
                nameController, addrressController, phoneController, schoolController, codeController, editProfile),
          ],
        ),
      ),
    );
  }
}

Widget _buildAvatarSection(String image) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: () async {
          // try {
          //   String newImage = await PickImageUtil.pickImage();
          // } catch (e) {
          //   return;
          // }
        },
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              alignment: Alignment.center,
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: const Color(0xfff10275a)),
                color: image.isEmpty ? Colors.grey : null,
                image: image.isNotEmpty && image.startsWith('http')
                    ? DecorationImage(
                        image: NetworkImage(image),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: image.isEmpty
                  ? const Icon(Icons.person, color: Colors.white)
                  : image.isEmpty || image.startsWith('http')
                      ? null
                      : const Center(
                          child: Text(
                            'Local Image',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 15, bottom: 5),
              child: Icon(
                Icons.camera_alt,
                color: Color(0xfff10275a),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildPersonalInfoSection(
  TextEditingController nameController,
  TextEditingController addrressController,
  TextEditingController phoneNumberController,
  TextEditingController schoolController,
  TextEditingController codeController,
  Function()? ontap,
) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tên',
          style: TextStyle(fontSize: 14, color: Color(0xfff8a8bb3)),
        ),
        CommonTextField(
          maxLines: 1,
          inputController: nameController,
        ),
        SizedBox(height: 20),
        Text(
          'Mã',
          style: TextStyle(fontSize: 14, color: Color(0xfff8a8bb3)),
        ),
        CommonTextField(
          maxLines: 1,
          inputController: codeController,
          isDisable: true,
        ),
        SizedBox(height: 20),
        Text(
          'Tên Trường',
          style: TextStyle(fontSize: 14, color: Color(0xfff8a8bb3)),
        ),
        CommonTextField(
          maxLines: 1,
          inputController: schoolController,
          isDisable: true,
        ),
        SizedBox(height: 20),
        Text(
          'Địa chỉ',
          style: TextStyle(fontSize: 14, color: Color(0xfff8a8bb3)),
        ),
        CommonTextField(
          maxLines: 1,
          inputController: addrressController,
        ),
        SizedBox(height: 20),
        Text(
          'Số điện thoại',
          style: TextStyle(fontSize: 14, color: Color(0xfff8a8bb3)),
        ),
        CommonTextField(
          maxLines: 1,
          inputController: phoneNumberController,
        ),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: ontap,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Màu nền xanh cho nút Sign In
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // Bo góc tròn
              ),
            ),
            child: Container(
              width: double.infinity, // Tự động mở rộng chiều dài
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: const Center(
                child: Text(
                  'Chỉnh sửa thông tin',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
