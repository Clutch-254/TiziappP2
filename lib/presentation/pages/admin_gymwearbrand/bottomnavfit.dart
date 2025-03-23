import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:tiziappp2/presentation/pages/admin_gymwearbrand/addfitpage.dart';
import 'package:tiziappp2/presentation/pages/admin_gymwearbrand/admingymwearbrandprofile.dart';
import 'package:tiziappp2/presentation/pages/admin_gymwearbrand/clientsfitpage.dart';
import 'package:tiziappp2/presentation/pages/admin_gymwearbrand/notificationsfit.dart';
import 'package:tiziappp2/presentation/pages/admin_gymwearbrand/stafffitpage.dart';

// Import your page classes here
// For example:
// import 'package:yourapp/presentation/pages/homepage.dart';
// import 'package:yourapp/presentation/pages/clientspage.dart';
// etc.

class Bottomnavfit extends StatefulWidget {
  const Bottomnavfit({super.key});

  @override
  State<Bottomnavfit> createState() => _BottomnavfitState();
}

class _BottomnavfitState extends State<Bottomnavfit> {
  int currentTabIndex = 0;
  late List<Widget> pages;
  
  // Declare your page variables
  late Widget profile;
  late Widget clientsPage;
  late Widget addPage;
  late Widget staffPage;
  late Widget notificationsPage;
  
  @override
  void initState() {
    // Initialize your page objects
    // Replace these placeholders with your actual page classes
    profile = Admingymwearbrandprofile();
    clientsPage = Clientsfitpage();
    addPage = Addfitpage();
    staffPage = Stafffitpage();
    notificationsPage = Notificationsfit();
    
    // Add pages to the list in the order they should appear
    pages = [profile, clientsPage, addPage, staffPage, notificationsPage];
    
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.white,
        color: Colors.blue[800] ?? Colors.blue,
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
            Icons.people,
            color: Colors.white,
          ),
          Icon(
            Icons.add_circle_outline,
            color: Colors.white,
          ),
          Icon(
            Icons.person_pin_circle,
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