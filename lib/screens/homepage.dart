import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'profile_screen.dart';
import 'saved_books_screen.dart';
import 'explore_screen.dart';

class Homepage extends StatefulWidget {
  final String userIdentifier; // Accept username or email

  const Homepage({super.key, required this.userIdentifier});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const ExploreScreen(),
    const SavedBooksScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _showWelcomeToast(); // Show welcome toast when the homepage is loaded
  }

  void _showWelcomeToast() {
    Fluttertoast.showToast(
      msg: "Hello ${widget.userIdentifier}, Welcome to SmartLibrary",
      toastLength: Toast.LENGTH_LONG, 
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.deepPurple,
      textColor: Colors.white,
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SmartLibrary'),
        backgroundColor: Colors.deepPurple,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Saved Books',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }
}
