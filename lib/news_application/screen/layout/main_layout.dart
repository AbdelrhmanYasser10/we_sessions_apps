import 'package:flutter/material.dart';
import 'package:we_session1/news_application/screen/category_screen.dart';
import 'package:we_session1/news_application/screen/home_screen.dart';
import 'package:we_session1/news_application/screen/search_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int index = 0;
  List<Widget> screens = [
    HomeScreen(),
    CategoryScreen(),
    SearchScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
            index = value;
            setState(() {

            });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home
              ),
            label: "Home",

          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.category
              ),
            label: "Category"
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search
              ),
            label: "Search"
          ),
        ],
      ),
      body: screens[index],
    );
  }
}
