import 'package:eduappui/screens/editviocation.dart';
import 'package:flutter/material.dart'; // Import the DataEntryForm screen

class HistoryScreen extends StatelessWidget {
  final List<Map<String, String>> violations = [
    {'name': 'Nguyen Van A', 'type': 'Lỗi vi phạm 1', 'date': '6/5/2024'},
    {'name': 'Tran Thi B', 'type': 'Lỗi vi phạm 2', 'date': '6/5/2024'},
    {'name': 'Le Van C', 'type': 'Lỗi vi phạm 3', 'date': '6/5/2024'},
    {'name': 'Pham Thi D', 'type': 'Lỗi vi phạm 4', 'date': '6/5/2024'},
    {'name': 'Hoang Van E', 'type': 'Lỗi vi phạm 5', 'date': '6/5/2024'},
    {'name': 'Ngo Thi F', 'type': 'Lỗi vi phạm 6', 'date': '6/5/2024'},
    {'name': 'Bui Van G', 'type': 'Lỗi vi phạm 7', 'date': '6/5/2024'},
    {'name': 'Doan Thi H', 'type': 'Lỗi vi phạm 8', 'date': '6/5/2024'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(226, 134, 253, 237),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(189, 7, 206, 43),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            'History Viocation',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  'Showing ${violations.length} results',
                  style: TextStyle(
                    color: Colors.brown[600],
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: violations.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Editviocation(
                          violationData: violations[index],
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Container(
                      color: Color.fromARGB(188, 85, 239, 126),
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Họ và Tên: ${violations[index]['name']}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Loại Vi Phạm: ${violations[index]['type']}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Date: ${violations[index]['date']}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
