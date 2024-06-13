import 'package:eduappui/screens/table.dart';
import 'package:flutter/material.dart';

class ViolationScreen extends StatefulWidget {
  const ViolationScreen({super.key});

  @override
  State<ViolationScreen> createState() => _ViolationScreenState();
}

class _ViolationScreenState extends State<ViolationScreen> {
  List<String> catNames = [
    "Appearence",
    "Footwear",
    "Orther",
    "Clothing",
  ];
  List<Color> catColors = [
    Color(0xff1d74f6),
    Color(0xff1d74f6),
    Color(0xff1d74f6),
    Color(0xff1d74f6),
  ];
  List<Icon> catIcons = [
    Icon(Icons.rule, color: Colors.white, size: 30),
    Icon(Icons.video_library, color: Colors.white, size: 30),
    Icon(Icons.assessment, color: Colors.white, size: 30),
    Icon(Icons.class_outlined, color: Colors.white, size: 30),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Violation"),
        backgroundColor: Color.fromARGB(189, 7, 206, 43),
      ),
      body: Container(
        color: Color.fromARGB(226, 134, 253, 237),
        child: ListView(
          children: [
            //
            Padding(
              padding: EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Column(
                children: [
                  GridView.builder(
                    itemCount: catNames.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.1,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigate to the respective screen based on the tapped category
                          if (catNames[index] == "Appearence") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DataEntryForm()),
                            );
                          } else if (catNames[index] == "Note") {
                            // Add your navigation code here
                          }
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: catColors[index],
                                  // shape: BoxShape.circle,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: catIcons[index],
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              catNames[index],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.7),
                                
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

