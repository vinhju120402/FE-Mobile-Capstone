import 'package:eduappui/remote/local/local_client.dart';
import 'package:flutter/material.dart';

class BaseMainContent extends StatelessWidget {
  final Widget? children;

  const BaseMainContent({super.key, this.children});
  @override
  Widget build(BuildContext context) {
    LocalClientImpl localClientImpl = LocalClientImpl();
    bool isAdmin = localClientImpl.readData('isAdmin');
    return Stack(
      children: [
        Container(
          height: 50,
          color: isAdmin ? Colors.blue : Color(0xFFB74848),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF8F9FD),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
            ),
          ),
          width: double.infinity,
          child: SingleChildScrollView(child: children),
        ),
      ],
    );
  }
}
