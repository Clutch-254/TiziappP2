
import 'package:flutter/material.dart';

import 'package:tiziappp2/presentation/pages/adminfoodstore/addfoodpage.dart';
import 'package:tiziappp2/presentation/pages/adminfoodstore/adminvirtualfoodstore.dart';
import 'package:tiziappp2/presentation/pages/adminfoodstore/inventoryfoodpage.dart';
import 'package:tiziappp2/presentation/pages/adminfoodstore/notificationsfood.dart';
import 'package:tiziappp2/presentation/pages/adminfoodstore/ordersfoodpage.dart';

class Bottomnavfood extends StatefulWidget {
  const Bottomnavfood({super.key});

  @override
  State<Bottomnavfood> createState() => _BottomnavfoodState();
}

class _BottomnavfoodState extends State<Bottomnavfood> {
  int _selectedIndex = 0;

  // Placeholder widgets for the different pages
  final List<Widget> _pages = [
    const Adminvirtualfoodstore(),
    const Ordersfoodpage(),
    const Addfoodpage(),
    const Inventoryfoodpage(),
    const Notificationsfood(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[700],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[300],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Inventory',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
      ),
    );
  }
}

