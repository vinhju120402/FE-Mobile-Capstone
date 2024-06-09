import 'package:flutter/material.dart';

class RatingReviewScreen extends StatefulWidget {
  @override
  _RatingReviewScreenState createState() => _RatingReviewScreenState();
}

class _RatingReviewScreenState extends State<RatingReviewScreen> {
  int? selectedRating;
  final TextEditingController reviewController = TextEditingController();
  bool isButtonEnabled = false; // Biến để theo dõi trạng thái của nút

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Give rating & Review'),
        backgroundColor: Color.fromARGB(189, 7, 206, 43),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromARGB(226, 134, 253, 237),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('images/1.png'),
                      radius: 30, // Đường kính là 36 nên bán kính là 18
                    ),
                    SizedBox(width: 8), // Khoảng cách giữa các CircleAvatar
                    CircleAvatar(
                      backgroundImage: AssetImage('images/2.png'),
                      radius: 30,
                    ),
                    SizedBox(width: 8),
                    CircleAvatar(
                      backgroundImage: AssetImage('images/3.png'),
                      radius: 30,
                    ),
                    SizedBox(width: 8),
                    CircleAvatar(
                      backgroundImage: AssetImage('images/4.png'),
                      radius: 30,
                    ),
                    SizedBox(width: 8),
                    CircleAvatar(
                      backgroundImage: AssetImage('images/5.png'),
                      radius: 30,
                    ),
                  ],
                ),

                SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(188, 85, 239, 126),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: reviewController,
                      maxLines: 8,
                      decoration: InputDecoration(
                        hintText: 'Write your review',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () {
                    // Thực hiện hành động khi nút được nhấn
                    if (isButtonEnabled) {
                      // Thực hiện hành động khi nút được kích hoạt
                      // Ví dụ: gửi đánh giá
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 48.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isButtonEnabled
                            ? [
                                Color.fromARGB(255, 189, 211, 137),
                                Colors.green.shade600
                              ]
                            : [
                                Color.fromRGBO(255, 228, 196, 1),
                                Color.fromARGB(255, 19, 176, 22)
                              ],
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 1000.0), // Thêm một khoảng trống
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRatingIcon(int index, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRating = index;
        });
      },
      child: Icon(
        icon,
        color: selectedRating == index ? Colors.amber : Colors.grey,
        size: 32.0,
      ),
    );
  }
}
