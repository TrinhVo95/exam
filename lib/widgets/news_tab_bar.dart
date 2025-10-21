import 'package:exam/page/new.dart';
import 'package:flutter/material.dart';

class NewsTabBar extends StatelessWidget {
  const NewsTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,

          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TabBar(
                isScrollable: false,
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),

                dividerColor: Colors.transparent,
                indicatorPadding: const EdgeInsets.symmetric(
                  horizontal: -8,
                  vertical: 8,
                ),

                labelColor: Colors.orange,
                unselectedLabelColor: Colors.white,
                tabs: const [
                  Tab(text: 'Feeds'),
                  Tab(text: 'Popular'),
                  Tab(text: 'Following'),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: NewsPage()),
            Center(child: NewsPage()),
            Center(child: NewsPage()),
          ],
        ),
      ),
    );
  }
}
