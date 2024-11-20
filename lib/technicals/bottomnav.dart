import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tiziappp2/presentation/pages/foodnsupplements.dart';
import 'package:tiziappp2/presentation/pages/gymaccessories.dart';
import 'package:tiziappp2/presentation/pages/homepage.dart';
import 'package:tiziappp2/presentation/pages/orderhireapply.dart';
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
  late Orderhireapply orderhireapply;

  @override
  void initState() {
    homepage = Homepage();
    foodnsupplements = Foodnsupplements();
    gymaccessories = Gymaccessories();
    orderhireapply = Orderhireapply();
    profile = Profile();
    pages = [
      homepage,
      foodnsupplements,
      gymaccessories,
      orderhireapply,
      profile
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.white,
        color: Colors.grey,
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
            Icons.shopping_bag_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.wallet_outlined,
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
