import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tiziappp2/presentation/pages/cart.dart';
import 'package:tiziappp2/presentation/pages/contentscroll.dart';
import 'package:tiziappp2/presentation/pages/foodnsupplements.dart';
import 'package:tiziappp2/presentation/pages/gymaccessories.dart';
import 'package:tiziappp2/presentation/pages/homepage.dart';

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:tiziappp2/presentation/pages/profile.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget currentPage;
  late Homepage homepage;
  late Foodnsupplements foodnsupplements;
  late Profile profile;
  late Gymaccessories gymaccessories;
  late CartPage cart;
  late Contentscroll contentscroll; // Added content scroll page

  @override
  void initState() {
    homepage = Homepage();
    foodnsupplements = Foodnsupplements();
    gymaccessories = Gymaccessories();
    cart = CartPage();
    profile = Profile();
    contentscroll = Contentscroll(); // Initialize the content scroll page
    
    // Added contentscroll to pages array at index 3 (before cart)
    pages = [homepage, foodnsupplements, gymaccessories, contentscroll, cart, profile];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.white,
        color: Colors.black, // Changed from grey to black for darker appearance
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: [
          Icon(
            Icons.home_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.food_bank_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.fitness_center_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.video_collection_outlined, // Added content/video icon
            color: Colors.white,
          ),
          Icon(
            Icons.shopping_bag_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.person_outlined,
            color: Colors.white,
          ),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}