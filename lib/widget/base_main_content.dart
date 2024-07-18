import 'package:flutter/material.dart';

class BaseMainContent extends StatelessWidget {
  final List<Widget>? children;

  const BaseMainContent({super.key, this.children});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 50,
          color: Colors.blue,
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
            ),
          ),
          width: double.infinity,
          child: Column(
            children: children ?? [],
          ),
        ),
      ],
    );
  }
}
