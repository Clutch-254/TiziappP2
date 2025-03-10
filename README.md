Tizi app, your fitness and well app

import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Sample cart items data
  final List<CartItem> cartItems = [
    CartItem(
      id: 1,
      name: "Dumbbell",
      price: 5000,
      quantity: 4,
      image: "Images/5kgdumbbe.png",
      status: PurchaseStatus.toPurchase,
    ),
    CartItem(
      id: 2,
      name: "Excalibur Punching bag",
      price: 2500,
      quantity: 1,
      image: "Images/punchb.png",
      status: PurchaseStatus.bought,
    ),
    CartItem(
      id: 3,
      name: "Kettlebell",
      price: 6000,
      quantity: 2,
      image: "Images/kettle.png",
      status: PurchaseStatus.underDelivery,
    ),
    CartItem(
      id: 4,
      name: "Smith Machine",
      price: 30000,
      quantity: 1,
      image: "Images/smith.png",
      status: PurchaseStatus.toPurchase,
    ),
    CartItem(
      id: 5,
      name: "Resistance Band",
      price: 1500,
      quantity: 3,
      image: "Images/resist.png",
      status: PurchaseStatus.bought,
    ),
    CartItem(
      id: 6,
      name: "Shelift Full body outfit",
      price: 800,
      quantity: 2,
      image: "Images/shelift.png",
      status: PurchaseStatus.underDelivery,
    ),
    CartItem(
      id: 7,
      name: "nitrotech Protein Powder",
      price: 3000,
      quantity: 1,
      image: "Images/nitrotech.png",
      status: PurchaseStatus.toPurchase,
    ),
    CartItem(
      id: 8,
      name: "Under Labz Creatine",
      price: 1200,
      quantity: 2,
      image: "Images/labzcreatine.png",
      status: PurchaseStatus.bought,
    ),
    CartItem(
      id: 9,
      name: "BioTech Creatine",
      price: 2800,
      quantity: 1,
      image: "Images/biocreatine.png",
      status: PurchaseStatus.underDelivery,
    ),
    CartItem(
      id: 10,
      name: "O.N. Whey",
      price: 4500,
      quantity: 1,
      image: "Images/opwhey.png",
      status: PurchaseStatus.toPurchase,
    ),
    CartItem(
      id: 11,
      name: "O.N. Creatine",
      price: 1800,
      quantity: 1,
      image: "Images/opcreatine.png",
      status: PurchaseStatus.bought,
    ),
    CartItem(
      id: 12,
      name: "X Glove",
      price: 3500,
      quantity: 1,
      image: "Images/xglove.png",
      status: PurchaseStatus.underDelivery,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Reduced from 3 to 2 for larger items
                  childAspectRatio: 0.65, // Adjusted for taller items
                  crossAxisSpacing: 20, // Increased spacing between columns
                  mainAxisSpacing: 20, // Increased spacing between rows
                ),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return buildCartItem(cartItems[index]);
                },
              ),
            ),
            SizedBox(height: 15), // Increased space before checkout button
            buildCheckoutButton(),
          ],
        ),
      ),
    );
  }

  Widget buildCartItem(CartItem item) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(12), // Increased border radius
      color: Colors.white,
      child: InkWell(
        onTap: () {
          // Handle item tap
        },
        borderRadius: BorderRadius.circular(12), // Increased border radius
        child: Container(
          padding: EdgeInsets.all(12), // Increased padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Item ID display
              Text(
                "ID: ${item.id}",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 8),

              // Image section
              Expanded(
                flex: 4, // Increased flex for larger image
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      item.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12), // Increased spacing

              // Item details section
              Expanded(
                flex: 3, // Increased flex for more text content
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16, // Increased font size
                      ),
                      maxLines: 2, // Allow for 2 lines of text
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Ksh ${item.price}",
                      style: TextStyle(
                        fontSize: 15, // Increased font size
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Qty: ${item.quantity} (Ksh ${item.price * item.quantity})",
                      style: TextStyle(
                        fontSize: 14, // Increased font size
                      ),
                    ),
                    SizedBox(height: 10), // Increased spacing

                    // Status button - made larger
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle button action
                        },
                        child: Text(
                          getStatusText(item.status),
                          style: TextStyle(
                            fontSize: 13, // Increased font size
                            fontWeight: FontWeight.bold,
                            color: item.status == PurchaseStatus.toPurchase
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: getStatusColor(item.status),
                          padding: EdgeInsets.symmetric(
                              vertical: 10), // Increased padding
                          minimumSize: Size(
                              double.infinity, 38), // Increased button height
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCheckoutButton() {
    return Container(
      width: double.infinity,
      height: 60, // Increased height
      child: ElevatedButton(
        onPressed: () {
          // Handle checkout
        },
        child: Text(
          "CHECKOUT",
          style: TextStyle(
            fontSize: 18, // Increased font size
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Increased border radius
          ),
          padding: EdgeInsets.symmetric(vertical: 15), // Increased padding
        ),
      ),
    );
  }

  String getStatusText(PurchaseStatus status) {
    switch (status) {
      case PurchaseStatus.toPurchase:
        return "Yet to Purchase";
      case PurchaseStatus.bought:
        return "Bought";
      case PurchaseStatus.underDelivery:
        return "Bought - Under Delivery";
    }
  }

  Color getStatusColor(PurchaseStatus status) {
    switch (status) {
      case PurchaseStatus.toPurchase:
        return Colors.grey;
      case PurchaseStatus.bought:
        return Colors.grey[600]!;
      case PurchaseStatus.underDelivery:
        return Colors.grey[700]!;
    }
  }
}

// Model for cart items
class CartItem {
  final int id;
  final String name;
  final int price;
  int quantity;
  final String image;
  final PurchaseStatus status;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
    required this.status,
  });
}

// Enum for purchase status
enum PurchaseStatus {
  toPurchase,
  bought,
  underDelivery,
}
