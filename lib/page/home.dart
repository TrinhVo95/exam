import 'package:exam/page/detail.dart';
import 'package:exam/widgets/bottom_nav_bar.dart';
import 'package:exam/widgets/news_card.dart';
import 'package:exam/widgets/news_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<List<News>> fetchNewsList() async {
  final response = await http.get(Uri.parse('https://dummyjson.com/posts'));

  if (response.statusCode == 200) {
    // Giải mã JSON
    final Map<String, dynamic> jsonData = jsonDecode(response.body);

    // API trả về {"posts": [...], "total": ..., ...}
    final List<dynamic> jsonList = jsonData['posts'];

    // Map từng phần tử JSON thành đối tượng News
    return jsonList.map((json) => News.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load news');
  }
}

class News {
  final int id;
  final String title;
  final String body;

  const News({required this.id, required this.title, required this.body});

  factory News.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': int id, 'title': String title, 'body': String body} => News(
        id: id,
        title: title,
        body: body,
      ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<News>> futureNews;

  @override
  void initState() {
    super.initState();
    futureNews = fetchNewsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/image/avatar.png',
                      width: 60,
                      height: 60,
                    ),
                  ),
                  Text('Hello, Mia Luna'),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Breaking News',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BottomNavBar(
                            initialIndex: 2,
                          ), // ✅ Mở tab News
                        ),
                      );
                    },
                    child: Text(
                      'See more',
                      style: TextStyle(fontSize: 12, color: Color(0xFF0866FF)),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: FutureBuilder(
                  future: futureNews,
                  builder: (context, result) {
                    if (result.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (result.hasError) {
                      return Center(child: Text('Error: ${result.error}'));
                    } else if (result.hasData) {
                      final newsList = result.data!;
                      return SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: newsList.length,
                          itemBuilder: (context, index) {
                            final news = newsList[index];

                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: NewsCard(
                                title: news.title,
                                body: news.body,
                                onTap: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Detail(news: news),
                                    ),
                                  ),
                                },
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const Center(child: Text('No data'));
                    }
                  },
                ),
              ),
              Expanded(child: NewsTabBar()),
            ],
          ),
        ),
      ),
    );
  }
}
