import 'package:eduappui/remote/local/local_client.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Function()? onBack;
  const CustomAppbar({super.key, this.title, this.onBack});

  @override
  Widget build(BuildContext context) {
    LocalClientImpl localClientImpl = LocalClientImpl();
    bool isAdmin = localClientImpl.readData('isAdmin');
    return Stack(
      children: [
        SizedBox(
          height: 90,
          width: double.infinity,
          child: Row(
            children: [
              Expanded(child: Container(color: Colors.white)),
              Expanded(child: Container(color: isAdmin ? Colors.blue : Color(0xFFB74848))),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: isAdmin ? Colors.blue : Color(0xFFB74848),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                      onPressed: onBack,
                    ),
                  ],
                ),
              ),
              Center(
                child: Text(
                  title ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80);
}
