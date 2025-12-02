
import 'package:flutter/material.dart';
import 'package:tiziappp2/technicals/widgets/supportwidget.dart';
import 'package:tiziappp2/technicals/services/nutrition_service.dart';

// Product Model - Shared between files
class Product {
  final int id;
  final String name;
  final String description;
  final String nutritionalValue;
  final String qualifications;
  final String location;
  final double price;
  final String imageAsset;
  final int deliveryTime;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.nutritionalValue,
    required this.qualifications,
    required this.location,
    required this.price,
    required this.imageAsset,
    required this.deliveryTime,
  });
}

// Products List - Displays all 36 products in a grid
class Productslist extends StatefulWidget {
  const Productslist({super.key});

  @override
  State<Productslist> createState() => _ProductslistState();
}

class _ProductslistState extends State<Productslist> {
  // List of 36 products with nutritional values
  final List<Product> products = [
    // Product 1
    Product(
      id: 1,
      name: "Grilled Steak and Potatoes",
      description: "This dish comprises of fried beef escorted with fried potato chops. Some of its constituent nutrients include: protein, fats, omega 3 and 6 fatty acids, Vitamins B12, B6, B3, B2, B1 and minerals such as zinc, selenium, phosphorous, L-arginine, potassium and magnesium, all within the beef. As for the fried potatoes, they contain: Complex carbohydrates and simple sugars, fibres, fats, vitamins B6, C, B3, B2, B1 and minerals such as potassium, magnesium, phosphrous, iron, zinc, calcium and selenium.",
      nutritionalValue: "Protein: 35g, Fats: 22g, Carbs: 45g, Calories: 520",
      price: 750.0,
      imageAsset: "Images/steak_potato.png",
      deliveryTime: 15, qualifications: '', location: '',
    ),
    // Rest of your products list...
    // Product 2
    Product(
      id: 2,
      name: "Chicken Curry",
      description: "Delicious chicken curry with rice and vegetables.",
      nutritionalValue: "Protein: 28g, Fats: 15g, Carbs: 40g, Calories: 430",
      price: 600.0,
      imageAsset: "Images/chicken_curry.png",
      deliveryTime: 20, qualifications: '', location: '',
    ),
    // Product 3
    Product(
      id: 3,
      name: "Vegetable Pasta",
      description: "Fresh pasta with seasonal vegetables and homemade sauce.",
      nutritionalValue: "Protein: 12g, Fats: 8g, Carbs: 65g, Calories: 380",
      price: 450.0,
      imageAsset: "Images/veg_pasta.png",
      deliveryTime: 15, qualifications: '', location: '',
    ),
    // Product 4
    Product(
      id: 4,
      name: "Fish and Chips",
      description: "Traditional fish and chips with tartar sauce.",
      nutritionalValue: "Protein: 22g, Fats: 25g, Carbs: 55g, Calories: 550",
      price: 550.0,
      imageAsset: "Images/fish_chips.png",
      deliveryTime: 18, qualifications: '', location: '',
    ),
    // Product 5
    Product(
      id: 5,
      name: "Caesar Salad",
      description: "Fresh romaine lettuce with Caesar dressing and croutons.",
      nutritionalValue: "Protein: 15g, Fats: 18g, Carbs: 12g, Calories: 280",
      price: 350.0,
      imageAsset: "Images/caesar_salad.png",
      deliveryTime: 12, qualifications: '', location: '',
    ),
    // Product 6
    Product(
      id: 6,
      name: "Beef Burger",
      description: "Juicy beef patty with lettuce, tomato, and special sauce.",
      nutritionalValue: "Protein: 28g, Fats: 32g, Carbs: 45g, Calories: 650",
      price: 500.0,
      imageAsset: "Images/beef_burger.png",
      deliveryTime: 15, qualifications: '', location: '',
    ),
    // Product 7
    Product(
      id: 7,
      name: "Vegetable Pizza",
      description: "Thin crust pizza with assorted vegetables and cheese.",
      nutritionalValue: "Protein: 18g, Fats: 22g, Carbs: 58g, Calories: 520",
      price: 650.0,
      imageAsset: "Images/veg_pizza.png",
      deliveryTime: 25, qualifications: '', location: '',
    ),
    // Product 8
    Product(
      id: 8,
      name: "Mushroom Risotto",
      description: "Creamy risotto with mushrooms and parmesan.",
      nutritionalValue: "Protein: 10g, Fats: 15g, Carbs: 48g, Calories: 380",
      price: 480.0,
      imageAsset: "Images/mushroom_risotto.png",
      deliveryTime: 22, qualifications: '', location: '',
    ),
    // Product 9
    Product(
      id: 9,
      name: "Seafood Paella",
      description: "Traditional Spanish rice dish with seafood.",
      nutritionalValue: "Protein: 25g, Fats: 14g, Carbs: 60g, Calories: 480",
      price: 750.0,
      imageAsset: "Images/seafood_paella.png",
      deliveryTime: 30, qualifications: '', location: '',
    ),
    // Product 10
    Product(
      id: 10,
      name: "Lamb Curry",
      description: "Spicy lamb curry with basmati rice.",
      nutritionalValue: "Protein: 30g, Fats: 25g, Carbs: 40g, Calories: 550",
      price: 700.0,
      imageAsset: "Images/lamb_curry.png",
      deliveryTime: 25, qualifications: '', location: '',
    ),
    // Product 11
    Product(
      id: 11,
      name: "Chocolate Cake",
      description: "Rich chocolate cake with ganache.",
      nutritionalValue: "Protein: 5g, Fats: 22g, Carbs: 65g, Calories: 450",
      price: 300.0,
      imageAsset: "Images/chocolate_cake.png",
      deliveryTime: 10, qualifications: '', location: '',
    ),
    // Product 12
    Product(
      id: 12,
      name: "Fruit Salad",
      description: "Assorted fresh fruits with honey.",
      nutritionalValue: "Protein: 2g, Fats: 1g, Carbs: 30g, Calories: 120",
      price: 250.0,
      imageAsset: "Images/fruit_salad.png",
      deliveryTime: 8, qualifications: '', location: '',
    ),
    // Product 13
    Product(
      id: 13,
      name: "Pancakes",
      description: "Fluffy pancakes with maple syrup and berries.",
      nutritionalValue: "Protein: 8g, Fats: 12g, Carbs: 55g, Calories: 380",
      price: 350.0,
      imageAsset: "Images/pancakes.png",
      deliveryTime: 15, qualifications: '', location: '',
    ),
    // Product 14
    Product(
      id: 14,
      name: "Chicken Wings",
      description: "Spicy chicken wings with dipping sauce.",
      nutritionalValue: "Protein: 25g, Fats: 28g, Carbs: 10g, Calories: 420",
      price: 450.0,
      imageAsset: "Images/chicken_wings.png",
      deliveryTime: 18, qualifications: '', location: '',
    ),
    // Product 15
    Product(
      id: 15,
      name: "Greek Salad",
      description: "Fresh vegetables with feta cheese and olives.",
      nutritionalValue: "Protein: 8g, Fats: 15g, Carbs: 10g, Calories: 220",
      price: 380.0,
      imageAsset: "Images/greek_salad.png",
      deliveryTime: 10, qualifications: '', location: '',
    ),
    // Product 16
    Product(
      id: 16,
      name: "Beef Lasagna",
      description: "Layered pasta with beef and cheese.",
      nutritionalValue: "Protein: 22g, Fats: 28g, Carbs: 50g, Calories: 580",
      price: 550.0,
      imageAsset: "Images/beef_lasagna.png",
      deliveryTime: 20, qualifications: '', location: '',
    ),
    // Product 17
    Product(
      id: 17,
      name: "Vegetable Soup",
      description: "Hearty soup with seasonal vegetables.",
      nutritionalValue: "Protein: 8g, Fats: 5g, Carbs: 25g, Calories: 180",
      price: 300.0,
      imageAsset: "Images/vegetable_soup.png",
      deliveryTime: 15, qualifications: '', location: '',
    ),
    // Product 18
    Product(
      id: 18,
      name: "Chicken Sandwich",
      description: "Grilled chicken sandwich with lettuce and mayo.",
      nutritionalValue: "Protein: 25g, Fats: 18g, Carbs: 35g, Calories: 420",
      price: 400.0,
      imageAsset: "Images/chicken_sandwich.png",
      deliveryTime: 12, qualifications: '', location: '',
    ),
    // Continue with products 19-36...
    // Product 19
    Product(
      id: 19,
      name: "Shrimp Pasta",
      description: "Pasta with shrimp in cream sauce.",
      nutritionalValue: "Protein: 22g, Fats: 20g, Carbs: 65g, Calories: 520",
      price: 650.0,
      imageAsset: "Images/shrimp_pasta.png",
      deliveryTime: 18, qualifications: '', location: '',
    ),
    // Product 20
    Product(
      id: 20,
      name: "Beef Stir Fry",
      description: "Beef stir fry with vegetables and rice.",
      nutritionalValue: "Protein: 28g, Fats: 15g, Carbs: 45g, Calories: 450",
      price: 580.0,
      imageAsset: "Images/beef_stirfry.png",
      deliveryTime: 20, qualifications: '', location: '',
    ),
    // Product 21
    Product(
      id: 21,
      name: "Vegetable Curry",
      description: "Mixed vegetable curry with coconut milk.",
      nutritionalValue: "Protein: 10g, Fats: 18g, Carbs: 35g, Calories: 350",
      price: 420.0,
      imageAsset: "Images/veg_curry.png",
      deliveryTime: 18, qualifications: '', location: '',
    ),
    // Product 22
    Product(
      id: 22,
      name: "Chicken Biryani",
      description: "Flavorful rice dish with chicken and spices.",
      nutritionalValue: "Protein: 25g, Fats: 18g, Carbs: 60g, Calories: 520",
      price: 600.0,
      imageAsset: "Images/chicken_biryani.png",
      deliveryTime: 25, qualifications: '', location: '',
    ),
    // Product 23
    Product(
      id: 23,
      name: "Beef Tacos",
      description: "Corn tortillas with seasoned beef and toppings.",
      nutritionalValue: "Protein: 20g, Fats: 22g, Carbs: 30g, Calories: 420",
      price: 450.0,
      imageAsset: "Images/beef_tacos.png",
      deliveryTime: 15, qualifications: '', location: '',
    ),
    // Product 24
    Product(
      id: 24,
      name: "Cheese Pizza",
      description: "Classic pizza with tomato sauce and cheese.",
      nutritionalValue: "Protein: 22g, Fats: 25g, Carbs: 65g, Calories: 580",
      price: 550.0,
      imageAsset: "Images/cheese_pizza.png",
      deliveryTime: 20, qualifications: '', location: '',
    ),
    // Product 25
    Product(
      id: 25,
      name: "Fish Curry",
      description: "Flavorful fish curry with coconut milk.",
      nutritionalValue: "Protein: 25g, Fats: 15g, Carbs: 25g, Calories: 380",
      price: 550.0,
      imageAsset: "Images/fish_curry.png",
      deliveryTime: 22, qualifications: '', location: '',
    ),
    // Product 26
    Product(
      id: 26,
      name: "Chicken Salad",
      description: "Fresh salad with grilled chicken and dressing.",
      nutritionalValue: "Protein: 28g, Fats: 12g, Carbs: 15g, Calories: 320",
      price: 420.0,
      imageAsset: "Images/chicken_salad.png",
      deliveryTime: 12, qualifications: '', location: '',
    ),
    // Product 27
    Product(
      id: 27,
      name: "Vegetable Burger",
      description: "Plant-based patty with fresh toppings.",
      nutritionalValue: "Protein: 15g, Fats: 18g, Carbs: 45g, Calories: 420",
      price: 380.0,
      imageAsset: "Images/veg_burger.png",
      deliveryTime: 15, qualifications: '', location: '',
    ),
    // Product 28
    Product(
      id: 28,
      name: "Beef Noodles",
      description: "Stir-fried noodles with beef and vegetables.",
      nutritionalValue: "Protein: 22g, Fats: 15g, Carbs: 65g, Calories: 520",
      price: 480.0,
      imageAsset: "Images/beef_noodles.png",
      deliveryTime: 18, qualifications: '', location: '',
    ),
    // Product 29
    Product(
      id: 29,
      name: "Margherita Pizza",
      description: "Classic pizza with tomato, mozzarella, and basil.",
      nutritionalValue: "Protein: 18g, Fats: 22g, Carbs: 55g, Calories: 480",
      price: 550.0,
      imageAsset: "Images/margherita_pizza.png",
      deliveryTime: 20, qualifications: '', location: '',
    ),
    // Product 30
    Product(
      id: 30,
      name: "Lemon Cake",
      description: "Light and zesty lemon cake with icing.",
      nutritionalValue: "Protein: 5g, Fats: 18g, Carbs: 60g, Calories: 420",
      price: 320.0,
      imageAsset: "Images/lemon_cake.png",
      deliveryTime: 10, qualifications: '', location: '',
    ),
    // Product 31
    Product(
      id: 31,
      name: "Shrimp Fried Rice",
      description: "Stir-fried rice with shrimp and vegetables.",
      nutritionalValue: "Protein: 20g, Fats: 12g, Carbs: 60g, Calories: 450",
      price: 520.0,
      imageAsset: "Images/shrimp_fried_rice.png",
      deliveryTime: 18, qualifications: '', location: '',
    ),
    // Product 32
    Product(
      id: 32,
      name: "Vegetable Samosas",
      description: "Crispy pastry filled with spiced vegetables.",
      nutritionalValue: "Protein: 6g, Fats: 15g, Carbs: 30g, Calories: 280",
      price: 280.0,
      imageAsset: "Images/veg_samosas.png",
      deliveryTime: 15, qualifications: '', location: '',
    ),
    // Product 33
    Product(
      id: 33,
      name: "Chicken Tikka",
      description: "Marinated chicken pieces cooked in tandoor.",
      nutritionalValue: "Protein: 32g, Fats: 12g, Carbs: 8g, Calories: 320",
      price: 480.0,
      imageAsset: "Images/chicken_tikka.png",
      deliveryTime: 20, qualifications: '', location: '',
    ),
    // Product 34
    Product(
      id: 34,
      name: "Beef Sausages",
      description: "Grilled beef sausages with mustard.",
      nutritionalValue: "Protein: 18g, Fats: 28g, Carbs: 5g, Calories: 380",
      price: 350.0,
      imageAsset: "Images/beef_sausages.png",
      deliveryTime: 15, qualifications: '', location: '',
    ),
    // Product 35
    Product(
      id: 35,
      name: "Vegetable Spring Rolls",
      description: "Crispy rolls filled with vegetables.",
      nutritionalValue: "Protein: 5g, Fats: 12g, Carbs: 25g, Calories: 220",
      price: 280.0,
      imageAsset: "Images/spring_rolls.png",
      deliveryTime: 12, qualifications: '', location: '',
    ),
    // Product 36
    Product(
      id: 36,
      name: "Chocolate Milkshake",
      description: "Creamy chocolate milkshake with whipped cream.",
      nutritionalValue: "Protein: 8g, Fats: 18g, Carbs: 45g, Calories: 380",
      price: 250.0,
      imageAsset: "Images/choc_milkshake.png",
      deliveryTime: 8, qualifications: '', location: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Our Menu",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to product details page with the selected product
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Productdetails(product: products[index]),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                      child: Image.asset(
                        products[index].imageAsset,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: Center(
                              child: Text(
                                "${products[index].id}",
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          products[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          "Ksh${products[index].price.toStringAsFixed(0)}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Product Details - Shows a single product with all details
class Productdetails extends StatefulWidget {
  final Product product;

  const Productdetails({
    super.key, 
    required this.product,
  });

  @override
  State<Productdetails> createState() => _ProductdetailsState();
}

class _ProductdetailsState extends State<Productdetails> {
  int x = 1;
  final NutritionService _nutritionService = NutritionService();
  bool isSubscribed = false;
  bool isService = false;

  @override
  void initState() {
    super.initState();
    _checkIfService();
    _checkSubscriptionStatus();
  }
  
  void _checkIfService() {
    // Determine if this is a service (Trainer, Nutritionist, Gym) based on name or description
    // This is a heuristic since we don't have a type field yet
    final name = widget.product.name.toLowerCase();
    if (name.contains('trainer') || 
        name.contains('nutrition') || 
        name.contains('gym') || 
        name.contains('coach') ||
        name.contains('instructor')) {
      setState(() {
        isService = true;
      });
    }
  }

  Future<void> _checkSubscriptionStatus() async {
    if (!isService) return;
    final subscribed = await _nutritionService.isSubscribed(widget.product.name);
    if (mounted) {
      setState(() {
        isSubscribed = subscribed;
      });
    }
  }

  Future<void> _handleSubscription() async {
    if (isSubscribed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You are already subscribed to this service.")),
      );
      return;
    }

    String type = 'Trainer';
    final name = widget.product.name.toLowerCase();
    if (name.contains('nutrition')) {
      type = 'Nutritionist';
    } else if (name.contains('gym')) {
      type = 'Gym';
    }

    await _nutritionService.addSubscription(
      type: type,
      name: widget.product.name,
      imagePath: widget.product.imageAsset,
      price: widget.product.price,
      description: widget.product.description,
    );

    setState(() {
      isSubscribed = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Subscribed successfully!")),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50.0, right: 20.0, left: 20.0, bottom: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.black,
              ),
            ),
            Image.asset(
              widget.product.imageAsset,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.5,
                  color: Colors.grey[300],
                  child: Center(
                    child: Text(
                      "${widget.product.id}",
                      style: TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: AppWidget.boldTextFieledStyle(),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                if (!isService) ...[
                  GestureDetector(
                    onTap: () {
                      if (x > 1) {
                        --x;
                      }
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    x.toString(),
                    style: AppWidget.smallBoldTextFieledStyle(),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      ++x;
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              widget.product.description,
              style: AppWidget.smallBoldTextFieledStyle(),
            ),
            SizedBox(
              height: 15.0,
            ),
            
            // Conditional display based on whether it's a service or product
            if (isService) ...[
              // Qualifications section for services
              if (widget.product.qualifications.isNotEmpty) ...[
                Row(
                  children: [
                    Icon(
                      Icons.verified,
                      color: Colors.grey[800],
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Qualifications:",
                      style: AppWidget.boldTextFieledStyle(),
                    ),
                  ],
                ),
                SizedBox(height: 5.0),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Text(
                    widget.product.qualifications,
                    style: AppWidget.smallBoldTextFieledStyle(),
                  ),
                ),
                SizedBox(height: 15.0),
              ],
              
              // Location section for services
              if (widget.product.location.isNotEmpty) ...[
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.red[400],
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Location:",
                      style: AppWidget.boldTextFieledStyle(),
                    ),
                  ],
                ),
                SizedBox(height: 5.0),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Text(
                    widget.product.location,
                    style: AppWidget.smallBoldTextFieledStyle(),
                  ),
                ),
                SizedBox(height: 15.0),
              ],
              
              // Services/Pricing info
              Row(
                children: [
                  Icon(
                    Icons.attach_money,
                    color: Colors.green[700],
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Service Fee:",
                    style: AppWidget.boldTextFieledStyle(),
                  ),
                ],
              ),
              SizedBox(height: 5.0),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Text(
                  "Ksh${widget.product.price.toStringAsFixed(0)} ${widget.product.price >= 10000 ? 'per month' : 'per session'}",
                  style: AppWidget.smallBoldTextFieledStyle(),
                ),
              ),
            ] else ...[
              // Nutritional Value for food products
              Text(
                "Nutritional Value:",
                style: AppWidget.boldTextFieledStyle(),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                widget.product.nutritionalValue,
                style: AppWidget.smallBoldTextFieledStyle(),
              ),
              SizedBox(
                height: 15.0,
              ),
              
              // Delivery Time for food products
              Row(
                children: [
                  Text(
                    "Delivery Time:",
                    style: AppWidget.smallBoldTextFieledStyle(),
                  ),
                  Icon(
                    Icons.alarm,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${widget.product.deliveryTime} minutes",
                    style: AppWidget.smallBoldTextFieledStyle(),
                  ),
                ],
              ),
            ],
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isService ? "Price:" : "Total Price:",
                        style: AppWidget.smallBoldTextFieledStyle(),
                      ),
                      Text(
                        "Ksh${(widget.product.price * x).toStringAsFixed(0)}",
                        style: AppWidget.boldTextFieledStyle(),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      if (isService) {
                        _handleSubscription();
                      } else {
                        // Existing Add to Cart logic (placeholder)
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Added to Cart")),
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: isSubscribed ? Colors.grey : Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Text(
                            isService 
                              ? (isSubscribed ? "Subscribed" : "Subscribe") 
                              : "Add to cart",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: isSubscribed ? Colors.grey : Colors.black,
                            ),
                            child: Icon(
                              isService ? Icons.check_circle : Icons.shopping_cart_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ],
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
}

// Example of displaying a featured product on another page
class FeaturedProductPage extends StatelessWidget {
  // This can be any page in your app where you want to feature a product
  final List<Product> products = _ProductslistState().products;
  
  @override
  Widget build(BuildContext context) {
    // Choose any product to feature (example: product with ID 6)
    final featuredProduct = products.firstWhere(
      (product) => product.id == 6, 
      orElse: () => products.first
    );
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Featured Product"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Today's Special",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Navigate to the product details page with the featured product
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Productdetails(product: featuredProduct),
                  ),
                );
              },
              child: Container(
                width: 250,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Image.asset(
                      featuredProduct.imageAsset,
                      height: 150,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 150,
                          color: Colors.grey[300],
                          child: Center(
                            child: Text(
                              "${featuredProduct.id}",
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    Text(
                      featuredProduct.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Ksh${featuredProduct.price.toStringAsFixed(0)}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "View Details",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

