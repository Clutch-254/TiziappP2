import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
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

  void removeItem(int id) {
    setState(() {
      cartItems.removeWhere((item) => item.id == id);
    });
  }

  int get totalCartValue {
    return cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cart",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: cartItems.isEmpty
                  ? const Center(
                      child: Text(
                        "Your cart is empty",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
            const SizedBox(height: 20),
            if (cartItems.isNotEmpty)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Ksh ${totalCartValue}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  buildCheckoutButton(),
                ],
              ),
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
          // Handle item tap - show details or edit quantity
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
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
              const SizedBox(height: 10),

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
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.image_not_supported, size: 50),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Item details section
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Ksh ${item.price}",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),

                    // Quantity controls
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (item.quantity > 1) {
                                item.quantity--;
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Icon(Icons.remove, size: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "${item.quantity}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              item.quantity++;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Icon(Icons.add, size: 16),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "Ksh ${item.price * item.quantity}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Remove button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => removeItem(item.id),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[700],
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Remove",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          // Handle checkout
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Proceed to Checkout"),
              content: Text("Total amount: Ksh $totalCartValue"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigate to checkout page or process payment
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Processing your order..."),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: const Text("Confirm"),
                ),
              ],
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          "CHECKOUT",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
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
