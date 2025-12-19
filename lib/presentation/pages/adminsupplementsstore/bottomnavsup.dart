import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:tiziappp2/presentation/pages/adminsupplementsstore/adminsupplementsstoreprofile.dart';
import 'package:tiziappp2/presentation/pages/adminsupplementsstore/messagesup.dart';
import 'package:tiziappp2/presentation/pages/adminsupplementsstore/notificationssup.dart';
import 'package:tiziappp2/presentation/pages/adminsupplementsstore/ordersup.dart';

import 'package:tiziappp2/presentation/pages/adminsupplementsstore/addsupplementsup.dart';

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
  late Addsupplementsup addPage;
  late Messagesup messagesPage;
  late Notificationssup notificationsPage;

  @override
  void initState() {
    // Initialize your pages here
    homePage = const Adminsupplementsstoreprofile();
    ordersPage = const Ordersup();
    addPage = const Addsupplementsup();
    messagesPage = const Messagesup();
    notificationsPage = const Notificationssup();
    
    pages = [homePage, ordersPage, addPage, messagesPage, notificationsPage];
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.white,
        color: const Color.fromARGB(255, 47, 47, 49),
        buttonBackgroundColor: const Color.fromARGB(255, 47, 47, 49),
        animationDuration: const Duration(milliseconds: 500),
        index: currentTabIndex,
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: const [
          Icon(
            Icons.home,
            color: Colors.white,
            size: 26,
          ),
          Icon(
            Icons.shopping_cart,
            color: Colors.white,
            size: 26,
          ),
          Icon(
            Icons.add_circle,
            color: Colors.white,
            size: 28,
          ),
          Icon(
            Icons.message,
            color: Colors.white,
            size: 26,
          ),
          Icon(
            Icons.notifications,
            color: Colors.white,
            size: 26,
          ),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}

