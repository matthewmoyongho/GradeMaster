import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  void Function(int index) onTap;
  int currentIndex;
  BottomNavBar(this.onTap, this.currentIndex);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'GP',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notification',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: currentIndex,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue[900],
      unselectedItemColor: Colors.grey,
      //showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: onTap,
    );
  }
}
