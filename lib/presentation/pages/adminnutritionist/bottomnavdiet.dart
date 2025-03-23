
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:tiziappp2/presentation/pages/adminnutritionist/admin_dietecianhomepage.dart';
import 'package:tiziappp2/presentation/pages/adminnutritionist/dietaddpage.dart';
import 'package:tiziappp2/presentation/pages/adminnutritionist/dietclientspage.dart';
import 'package:tiziappp2/presentation/pages/adminnutritionist/dietmessage.dart';
import 'package:tiziappp2/presentation/pages/adminnutritionist/dietnotification.dart';
// Import your page files here
// import 'package:your_app/pages/diet_home_page.dart';
// etc.

class Bottomnavdiet extends StatefulWidget {
  const Bottomnavdiet({super.key});

  @override
  State<Bottomnavdiet> createState() => _BottomnavdietState();
}

class _BottomnavdietState extends State<Bottomnavdiet> {
  int currentTabIndex = 0;

  // Define pages
  late List<Widget> pages;
  late AdminDietecianhomepage homePage;
  late Dietclientspage clientsPage;
  late Dietaddpage addPage;
  late Dietmessage messagesPage;
  late Dietnotification notificationsPage;

  @override
  void initState() {
    // Initialize your pages here
    homePage = const AdminDietecianhomepage();
    clientsPage = const Dietclientspage();
    addPage = const Dietaddpage();
    messagesPage = const Dietmessage();
    notificationsPage = const Dietnotification();
    
    pages = [homePage, clientsPage, addPage, messagesPage, notificationsPage];
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.white,
        color: Colors.green[700] ?? Colors.green, // Changed to green for diet theme
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
            Icons.add_circle_outline, // Add icon
            color: Colors.white,
          ),
          Icon(
            Icons.message, // Messages icon
            color: Colors.white,
          ),
          Icon(
            Icons.notifications,
            color: Colors.white,
          ),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}

