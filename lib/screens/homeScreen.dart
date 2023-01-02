import 'package:flutter/material.dart';
import 'package:livestreamingapp/providers/user_provider.dart';
import 'package:livestreamingapp/screens/feed_screen.dart';
import 'package:livestreamingapp/screens/live_screen.dart';
import 'package:livestreamingapp/utils/colors.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  List<Widget> pages = [
    const FeedScreen(),
    const LiveScreen(),
    const Center(
      child: Text("Browser"),
    )
  ];
  onPageChange(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: btnColor,
          unselectedItemColor: primaryColor,
          unselectedFontSize: 12,
          backgroundColor: backgroundColor,
          onTap: onPageChange,
          currentIndex: _page,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite_border_outlined,
                ),
                label: "Following"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.live_tv_sharp,
                ),
                label: "Go Live"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.browse_gallery_outlined,
                ),
                label: "Browse"),
          ]),
      body: pages[_page],
    );
  }
}
