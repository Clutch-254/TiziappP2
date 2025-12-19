import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:tiziappp2/presentation/pages/admintrainer/admin_virtualtrainerhomepage.dart';
import 'package:tiziappp2/presentation/pages/admintrainer/clientstrainer.dart';
import 'package:tiziappp2/presentation/pages/admintrainer/institutiontrainer.dart';
import 'package:tiziappp2/presentation/pages/admintrainer/messagetrainer.dart';
import 'package:tiziappp2/presentation/pages/admintrainer/notificationstrainer.dart';

class Bottomnavtrainer extends StatefulWidget {
  const Bottomnavtrainer({super.key});

  @override
  State<Bottomnavtrainer> createState() => _BottomnavtrainerState();
}

class _BottomnavtrainerState extends State<Bottomnavtrainer> {
  int currentTabIndex = 0;

  // Define pages
  late List<Widget> pages;
  late AdminVirtualhomepage homePage;
  late Clientstrainer clientsPage;
  late Messagetrainer messagesPage;
  late Institutiontrainer gymPage;
  late Notificationstrainer notificationsPage;

  @override
  void initState() {
    // Initialize your pages here
    homePage = const AdminVirtualhomepage();
    clientsPage = const Clientstrainer();
    messagesPage = const Messagetrainer();
    gymPage = const Institutiontrainer();
    notificationsPage = const Notificationstrainer();

    pages = [homePage, clientsPage, messagesPage, gymPage, notificationsPage];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Bottomnavtrainer build called');
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.white,
        color: const Color.fromARGB(255, 48, 45, 45) ??
            const Color.fromARGB(255, 54, 50, 50), // Red theme for trainer app
        animationDuration: const Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: const [
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.people, // Clients icon
            color: Colors.white,
          ),
          Icon(
            Icons.message, // Messages icon
            color: Colors.white,
          ),
          Icon(
            Icons.fitness_center, // Gym/Institution icon
            color: Colors.white,
          ),
          Icon(
            Icons.notifications, // Notifications icon
            color: Colors.white,
          ),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
