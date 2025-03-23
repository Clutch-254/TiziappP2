import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:tiziappp2/presentation/pages/adminfitnessinstitution/addinspage.dart';
import 'package:tiziappp2/presentation/pages/adminfitnessinstitution/adminfitnessinstitution.dart';
import 'package:tiziappp2/presentation/pages/adminfitnessinstitution/clientsinspage.dart';
import 'package:tiziappp2/presentation/pages/adminfitnessinstitution/notificationsinspage.dart';
import 'package:tiziappp2/presentation/pages/adminfitnessinstitution/staffinspage.dart';

class Borromnavins extends StatefulWidget {
  const Borromnavins({super.key});

  @override
  State<Borromnavins> createState() => _BorromnavinsState();
}

class _BorromnavinsState extends State<Borromnavins> {
  int currentTabIndex = 0;

  // Define page placeholders - replace these with your actual pages
  late List<Widget> pages;
  late Widget currentPage;
  late Adminfitnessinstitution profilePage;
  late Clientsinspage clientsPage;
  late Addinspage addPage;
  late Staffinspage staffPage;
  late Notificationsinspage notificationsPage;

  @override
  void initState() {
    // Initialize your pages here
    profilePage = const Adminfitnessinstitution();
    clientsPage = const Clientsinspage();
    addPage = const Addinspage();
    staffPage = const Staffinspage();
    notificationsPage = const Notificationsinspage();
    
    pages = [profilePage, clientsPage, addPage, staffPage, notificationsPage];
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.white,
        color: Colors.grey,
        animationDuration: const Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: const [
          Icon(
            Icons.person_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.people_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.add_circle_outline,
            color: Colors.white,
          ),
          Icon(
            Icons.badge_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.notifications_outlined,
            color: Colors.white,
          ),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}

