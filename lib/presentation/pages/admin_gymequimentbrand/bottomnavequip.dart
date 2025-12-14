import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:tiziappp2/presentation/pages/admin_gymequimentbrand/admin_gymequipmentprofile.dart';
import 'package:tiziappp2/presentation/pages/admin_gymequimentbrand/eventsequippage.dart';
import 'package:tiziappp2/presentation/pages/admin_gymequimentbrand/inventoryequippage.dart';
import 'package:tiziappp2/presentation/pages/admin_gymequimentbrand/orderequipspage.dart';
import 'package:tiziappp2/presentation/pages/admin_gymequimentbrand/shopequippage.dart';


class Bottomnavequip extends StatefulWidget {
  const Bottomnavequip({super.key});

  @override
  State<Bottomnavequip> createState() => _BottomnavequipState();
}

class _BottomnavequipState extends State<Bottomnavequip> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late AdminGymequipmentprofile profile;
  late Inventoryequippage inventory;
  late Eventsequippage events;
  late Shopequippage shop;
  late Orderequipspage orders;

  @override
  void initState() {
    profile = AdminGymequipmentprofile();
    inventory = Inventoryequippage();
    events = Eventsequippage();
    shop = Shopequippage();
    orders = Orderequipspage();
    
    pages = [profile, inventory, events, shop, orders];
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.white,
        color: Colors.black, // Changed from grey to black to match bottomnav
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: [
          Icon(
            Icons.person,
            color: Colors.white,
          ),
          Icon(
            Icons.inventory,
            color: Colors.white,
          ),
          Icon(
            Icons.event,
            color: Colors.white,
          ),
          Icon(
            Icons.shopping_bag,
            color: Colors.white,
          ),
          Icon(
            Icons.receipt_long,
            color: Colors.white,
          ),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}