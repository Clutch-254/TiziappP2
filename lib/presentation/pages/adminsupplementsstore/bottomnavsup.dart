import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:tiziappp2/presentation/pages/adminsupplementsstore/adminsupplementsstoreprofile.dart';
import 'package:tiziappp2/presentation/pages/adminsupplementsstore/messagesup.dart';
import 'package:tiziappp2/presentation/pages/adminsupplementsstore/notificationssup.dart';
import 'package:tiziappp2/presentation/pages/adminsupplementsstore/ordersup.dart';

class Bottomnavsup extends StatefulWidget {
  const Bottomnavsup({super.key});

  @override
  State<Bottomnavsup> createState() => _BottomnavsupState();
}

class _BottomnavsupState extends State<Bottomnavsup> {
  int currentTabIndex = 0;

  // Define pages
  late List<Widget> pages;
  late Adminsupplementsstoreprofile homePage;
  late Ordersup ordersPage;
  late Messagesup messagesPage;
  late Notificationssup notificationsPage;

  @override
  void initState() {
    // Initialize your pages here
    homePage = const Adminsupplementsstoreprofile();
    ordersPage = const Ordersup();
    messagesPage = const Messagesup();
    notificationsPage = const Notificationssup();
    
    pages = [homePage, ordersPage, messagesPage, notificationsPage];
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.white,
        color: const Color.fromARGB(255, 47, 47, 49) ?? Color.fromARGB(255, 36, 37, 37), // Blue theme for supplements
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
            Icons.shopping_cart, // Orders icon
            color: Colors.white,
          ),
          Icon(
            Icons.message, // Messages icon
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

