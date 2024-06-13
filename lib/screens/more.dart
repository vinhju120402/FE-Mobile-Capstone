import 'package:flutter/material.dart';

class Officer {
  final String name;
  final String imageUrl;
  final String position;

  Officer({required this.name, required this.imageUrl, required this.position});
}

// ignore: use_key_in_widget_constructors
class OfficersScreen extends StatelessWidget {
  final List<Officer> officers = [
    Officer(
        name: 'Quang Vinh', imageUrl: 'images/pho1.jpg', position: 'Sao Đỏ'),
    Officer(
        name: 'Thành Nguyễn',
        imageUrl: 'images/pho2.jpg',
        position: 'Hiệu Trưởng'),
    Officer(
        name: 'Thành Trương',
        imageUrl: 'images/pho3.jpg',
        position: 'Phó Hiệu Trưởng'),
    Officer(name: 'Tấn Phước', imageUrl: 'images/pho4.jpg', position: ''),
    Officer(name: 'Quang Vinh', imageUrl: 'images/pho1.jpg', position: ''),
    Officer(name: 'Thành Nguyễn', imageUrl: 'images/pho2.jpg', position: ''),
    Officer(name: 'Thành Trương', imageUrl: 'images/pho3.jpg', position: ''),
    Officer(name: 'Tấn Phước', imageUrl: 'images/pho4.jpg', position: ''),
    Officer(name: 'Quang Vinh', imageUrl: 'images/pho1.jpg', position: ''),
    Officer(name: 'Thành Nguyễn', imageUrl: 'images/pho2.jpg', position: ''),
    Officer(name: 'Thành Trương', imageUrl: 'images/pho3.jpg', position: ''),
    Officer(name: 'Tấn Phước', imageUrl: 'images/pho4.jpg', position: ''),
    Officer(name: 'Quang Vinh', imageUrl: 'images/pho1.jpg', position: ''),
    Officer(name: 'Thành Nguyễn', imageUrl: 'images/pho2.jpg', position: ''),
    Officer(name: 'Thành Trương', imageUrl: 'images/pho3.jpg', position: ''),
    Officer(name: 'Tấn Phước', imageUrl: 'images/pho4.jpg', position: ''),
    Officer(name: 'Quang Vinh', imageUrl: 'images/pho1.jpg', position: ''),
    Officer(name: 'Thành Nguyễn', imageUrl: 'images/pho2.jpg', position: ''),
    Officer(name: 'Thành Trương', imageUrl: 'images/pho3.jpg', position: ''),
    Officer(name: 'Tấn Phước', imageUrl: 'images/pho4.jpg', position: ''),
    Officer(name: 'Quang Vinh', imageUrl: 'images/pho1.jpg', position: ''),
    Officer(name: 'Thành Nguyễn', imageUrl: 'images/pho2.jpg', position: ''),
    Officer(name: 'Thành Trương', imageUrl: 'images/pho3.jpg', position: ''),
    Officer(name: 'Tấn Phước', imageUrl: 'images/pho4.jpg', position: ''),
    // Thêm các cán bộ khác vào đây
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Officers'),
        backgroundColor: Color.fromARGB(189, 7, 206, 43),
      ),
      body: Container(
        color: Color.fromARGB(226, 134, 253, 237),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                3, // Decrease the number of columns to make each card larger
            childAspectRatio: 0.7, // Adjust the aspect ratio for larger height
          ),
          itemCount: officers.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.green[200],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(officers[index].imageUrl),
                    radius: 40, // Increase the radius for a larger image
                  ),
                  SizedBox(height: 8),
                  Text(
                    officers[index].name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14), // Increase font size
                  ),
                  SizedBox(height: 4),
                  Text(
                    officers[index].position,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14, // Increase font size
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
