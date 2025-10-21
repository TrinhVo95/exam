import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  NewsPage({super.key});
  final List<Map<String, dynamic>> newsList = [
    {
      'image': 'assets/image/travel.png',
      'title':
          'The beautiful African paradise islands that most tourists don\'t know about',
      'type': 'Travel',
    },
    {
      'image': 'assets/image/food.png',
      'title': 'World\'s best spicy foods: 20 dishes to try',
      'type': 'Food & Drink',
    },
    {
      'image': 'assets/image/travel.png',
      'title':
          'The beautiful African paradise islands that most tourists don\'t know about',
      'type': 'Travel',
    },
    {
      'image': 'assets/image/food.png',
      'title': 'World\'s best spicy foods: 20 dishes to try',
      'type': 'Food & Drink',
    },
    {
      'image': 'assets/image/travel.png',
      'title':
          'The beautiful African paradise islands that most tourists don\'t know about',
      'type': 'Travel',
    },
    {
      'image': 'assets/image/food.png',
      'title': 'World\'s best spicy foods: 20 dishes to try',
      'type': 'Food & Drink',
    },
    {
      'image': 'assets/image/travel.png',
      'title':
          'The beautiful African paradise islands that most tourists don\'t know about',
      'type': 'Travel',
    },
    {
      'image': 'assets/image/food.png',
      'title': 'World\'s best spicy foods: 20 dishes to try',
      'type': 'Food & Drink',
    },
    {
      'image': 'assets/image/travel.png',
      'title':
          'The beautiful African paradise islands that most tourists don\'t know about',
      'type': 'Travel',
    },
    {
      'image': 'assets/image/food.png',
      'title': 'World\'s best spicy foods: 20 dishes to try',
      'type': 'Food & Drink',
    },
    {
      'image': 'assets/image/travel.png',
      'title':
          'The beautiful African paradise islands that most tourists don\'t know about',
      'type': 'Travel',
    },
    {
      'image': 'assets/image/food.png',
      'title': 'World\'s best spicy foods: 20 dishes to try',
      'type': 'Food & Drink',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: newsList.length,
                  itemBuilder: (context, index) {
                    final news = newsList[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              news['image'],
                              width: 144,
                              height: 116,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 144,
                                  height: 116,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey[200],
                                  ),
                                  child: Icon(
                                    Icons.image,
                                    color: Colors.grey[400],
                                    size: 40,
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  news['type'],
                                  style: TextStyle(
                                    color: Color(0xFF969696),
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  news['title'],
                                  style: TextStyle(fontSize: 14),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
