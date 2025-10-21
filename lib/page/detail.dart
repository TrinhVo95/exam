import 'package:flutter/material.dart';
import 'package:exam/page/home.dart';

class Detail extends StatelessWidget {
  final News news;

  const Detail({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: Colors.orange,
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                Text(
                  'Travel',
                  style: TextStyle(color: Color(0xFF969696), fontSize: 12),
                ),
                Text(
                  news.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    'assets/image/travel.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Text(news.body),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
