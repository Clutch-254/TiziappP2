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
      image: "Images/5kgdumb.png",
    ),
    CartItem(
      id: 2,
      name: "Excalibur Punching bag",
      price: 2500,
      quantity: 1,
      image: "Images/punchb.png",
    ),
    CartItem(
      id: 3,
      name: "Kettlebell",
      price: 6000,
      quantity: 2,
      image: "Images/kettle.png",
    ),
    CartItem(
      id: 4,
      name: "Smith Machine",
      price: 30000,
      quantity: 1,
      image: "Images/smith.png",
    ),
    CartItem(
      id: 5,
      name: "Resistance Band",
      price: 1500,
      quantity: 3,
      image: "Images/resist.png",
    ),
    CartItem(
      id: 6,
      name: "Shelift Full body outfit",
      price: 800,
      quantity: 2,
      image: "Images/shelift.png",
    ),
    CartItem(
      id: 7,
      name: "nitrotech Protein Powder",
      price: 3000,
      quantity: 1,
      image: "Images/nitrotech.png",
    ),
    CartItem(
      id: 8,
      name: "Under Labz Creatine",
      price: 1200,
      quantity: 2,
      image: "Images/labzcreatine.png",
    ),
    CartItem(
      id: 9,
      name: "BioTech Creatine",
      price: 2800,
      quantity: 1,
      image: "Images/biocreatine.png",
    ),
    CartItem(
      id: 10,
      name: "O.N. Whey",
      price: 4500,
      quantity: 1,
      image: "Images/opwhey.png",
    ),
    CartItem(
      id: 11,
      name: "O.N. Creatine",
      price: 1800,
      quantity: 1,
      image: "Images/opcreatine.png",
    ),
    CartItem(
      id: 12,
      name: "X Glove",
      price: 3500,
      quantity: 1,
      image: "Images/xglove.png",
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
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 25,
                ),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return buildCartItem(cartItems[index]);
                },
              ),
            ),
            SizedBox(height: 20),
            buildCheckoutButton(),
          ],
        ),
      ),
    );
  }

  Widget buildCartItem(CartItem item) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
      child: InkWell(
        onTap: () {
          // Handle item tap
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(12),
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
              SizedBox(height: 13),

              // Image section
              Expanded(
                flex: 4,
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
              SizedBox(height: 17),

              // Item details section
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 11),
                    Text(
                      "Ksh ${item.price}",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 9),
                    Text(
                      "Qty: ${item.quantity} (Ksh ${item.price * item.quantity})",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 15),

                    // Add to cart or Remove button
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle button action
                          },
                          child: Text(
                            "Remove",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[700],
                            padding: EdgeInsets.symmetric(vertical: 12),
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
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
      height: 65,
      child: ElevatedButton(
        onPressed: () {
          // Handle checkout
        },
        child: Text(
          "CHECKOUT",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }
}

// Model for cart items
class CartItem {
  final int id;
  final String name;
  final int price;
  int quantity;
  final String image;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
  });
}
