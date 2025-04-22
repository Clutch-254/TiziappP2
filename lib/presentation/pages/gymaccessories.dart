import 'package:flutter/material.dart';

import '../../technicals/widgets/database.dart';
import '../../technicals/widgets/supportwidget.dart';
import '../productdetails.dart';

class Gymaccessories extends StatefulWidget {
  const Gymaccessories({super.key});

  @override
  State<Gymaccessories> createState() => _GymaccessoriesState();
}

class _GymaccessoriesState extends State<Gymaccessories> {
  // Initialize equipment as true by default so it's selected on page load
  bool equipment = true, gymoutfits = false;

  // ScrollController for implementing scroll functionality
  ScrollController _scrollController = ScrollController();

  Stream? fitItemStream;
  onTheLoad() async {
    fitItemStream = await DatabaseMethods().getFitItem("Equipment");
  }

  @override
  void initState() {
    super.initState();
    // This ensures the equipment button is selected by default
    equipment = true;
    gymoutfits = false;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
          top: 50.0,
          left: 20.0,
        ),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40, // Same width as the cart icon container
                  ),
                  Text(
                    equipment ? "Equipment" : "Gymfits",
                    style: AppWidget.boldTextFieledStyle(),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.only(right: 20.0),
                child: showToolItem(),
              ),
              SizedBox(
                height: 30.0,
              ),

              // Show content based on selection
              equipment ? showEquipmentItems() : showGymOutfitItems(),
            ],
          ),
        ),
      ),
      // Optional: Add a floating action button for quick scrolling to bottom
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: Colors.black,
        onPressed: () {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        child: Icon(Icons.arrow_downward, color: Colors.white),
      ),
    );
  }

  Widget showToolItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            equipment = true;
            gymoutfits = false;

            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                color: equipment ? Colors.grey : Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(10),
              child: Image.asset(
                "Images/equipment.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: equipment ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            equipment = false;
            gymoutfits = true;
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            color: gymoutfits ? Colors.grey : Colors.white,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Image.asset(
                "Images/gymoutfit.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: gymoutfits ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Function to show equipment items
  Widget showEquipmentItems() {
    return Column(
      children: [
        // Horizontal scrolling items
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Productdetails(
                        product: Product(
                          id: 1,
                          name: "5 kilogram dumbbells",
                          description:
                              "A pair of solid 5kg dumbbells, built from durable cast iron with a fixed-weight design that cannot be dismantled. \n\n"
                              "Each dumbbell features a compact, balanced structure with a textured grip handle for secure and comfortable use during workouts. \n\n"
                              "Ideal for strength training, toning, and home fitness routines—perfect for exercises like curls, presses, rows, and shoulder raises. \n\n"
                              "Low-maintenance and sturdy, these fixed-weight dumbbells offer simplicity, safety, and consistency in every session.",
                          nutritionalValue: "N/A",
                          price: 2500.0,
                          imageAsset: "Images/5kgdumb.png",
                          deliveryTime: 0,
                          qualifications: '',
                          location: '',
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "Images/5kgdumb.png",
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            "5 kilogram dumbbells",
                            style: AppWidget.smallBoldTextFieledStyle(),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "\Ksh2500",
                            style: AppWidget.smallBoldTextFieledStyle(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Productdetails(
                        product: Product(
                          id: 1,
                          name: "Smith Machine",
                          description:
                              "A heavy-duty Smith Machine designed for safe and controlled weight training, featuring a fixed barbell guided by vertical steel rails. \n\n"
                              "Built with a sturdy steel frame, it includes safety catches and adjustable hooks, allowing for secure racking at various heights—ideal for squats, bench presses, shoulder presses, and more. \n\n"
                              "Perfect for home or commercial gyms, the Smith Machine offers added stability and reduced injury risk, making it great for beginners and advanced lifters alike. \n\n"
                              "Compatible with Olympic weight plates and often includes a pull-up bar, plate storage, and additional cable or pulley attachments depending on the model.",
                          nutritionalValue: "N/A",
                          price: 120000.0,
                          imageAsset: "Images/smith.png",
                          deliveryTime: 0,
                          qualifications: '',
                          location: '',
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(4),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "Images/smith.png",
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            "Smith Machine",
                            style: AppWidget.smallBoldTextFieledStyle(),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "\Ksh120,000",
                            style: AppWidget.smallBoldTextFieledStyle(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30.0,
        ),

        // List items below
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Productdetails(
                  product: Product(
                    id: 1,
                    name: "Excalibur Punching Bag",
                    description:
                        "The Excalibur Punching Bag is a high-quality, heavy-duty training bag designed for boxing, kickboxing, and martial arts workouts. \n\n"
                        "Made from durable synthetic leather with reinforced stitching, it can withstand intense strikes, kicks, and combinations. \n\n"
                        "Typically weighing between 30–50kg and measuring around 100–120cm in height, it provides a realistic training experience for power, speed, and endurance. \n\n"
                        "Includes strong hanging straps or chains for secure mounting and shock absorption. Ideal for home gyms, boxing clubs, or combat sports training setups.",
                    nutritionalValue: "N/A",
                    price: 20000.0,
                    imageAsset: "Images/punchb.png",
                    deliveryTime: 0,
                    qualifications: '',
                    location: '',
                  ),
                ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(right: 20.0),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        "Images/punchb.png",
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            "Excalibur Punching Bag",
                            style: AppWidget.smallBoldTextFieledStyle(),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            "\Ksh20,000",
                            style: AppWidget.smallBoldTextFieledStyle(),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        SizedBox(
          height: 30.0,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Productdetails(
                  product: Product(
                    id: 1,
                    name: "Premium Kettlebell Set",
                    description:
                        "The Premium Kettlebell Set includes a range of high-quality kettlebells, typically from 4kg to 24kg, crafted for durability, balance, and performance. \n\n"
                        "Each kettlebell features a smooth, powder-coated cast iron body for enhanced grip and comfort, with color-coded weights for easy identification. \n\n"
                        "Ideal for functional training, strength building, and cardio workouts—perfect for swings, goblet squats, Turkish get-ups, and presses. \n\n"
                        "The flat base ensures stability for floor exercises and storage, making this set a versatile and space-efficient addition to any home or professional gym.",
                    nutritionalValue: "N/A",
                    price: 15000.0,
                    imageAsset: "Images/kettle.png",
                    deliveryTime: 0,
                    qualifications: '',
                    location: '',
                  ),
                ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(right: 20.0),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        "Images/kettle.png",
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            "Premium Kettlebell Set",
                            style: AppWidget.smallBoldTextFieledStyle(),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            "\Ksh15,000",
                            style: AppWidget.smallBoldTextFieledStyle(),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        SizedBox(
          height: 30.0,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Productdetails(
                  product: Product(
                    id: 1,
                    name: "Resistance band",
                    description:
                        "A versatile and durable resistance band designed for strength training, mobility work, rehabilitation, and stretching. \n\n"
                        "Made from high-quality latex or rubber, it offers consistent tension and elasticity—available in varying resistance levels from light to heavy. \n\n"
                        "Perfect for full-body workouts, targeting muscles through controlled resistance during exercises like squats, rows, presses, and stretches. \n\n"
                        "Lightweight, portable, and easy to store, making it ideal for home workouts, travel, or gym use.",
                    nutritionalValue: "N/A",
                    price: 3500.0,
                    imageAsset: "Images/resist.png",
                    deliveryTime: 0,
                    qualifications: '',
                    location: '',
                  ),
                ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(right: 20.0, bottom: 30.0),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        "Images/resist.png",
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            "Resistance band",
                            style: AppWidget.smallBoldTextFieledStyle(),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            "\Ksh3,500",
                            style: AppWidget.smallBoldTextFieledStyle(),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Updated function to show gym outfit items with proper placeholders
  Widget showGymOutfitItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title for first horizontal scroll section
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Text(
            "Men's Workout Gear",
            style: AppWidget.boldTextFieledStyle(),
          ),
        ),
        SizedBox(height: 15.0),

        // First horizontal scrolling section
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Productdetails(
                        product: Product(
                          id: 1,
                          name: "Heren Men's  Shirt and Short",
                          description:
                              "A stylish and performance-ready men's workout wear set featuring a black and aqua blue color scheme. \n\n"
                              "The moisture-wicking t-shirt offers a slim athletic fit with breathable mesh panels, keeping you cool and dry during intense training. \n\n"
                              "Paired with lightweight, quick-dry shorts that offer a full range of motion, an elastic waistband with drawstring, and side pockets for convenience. \n\n"
                              "Designed for gym sessions, running, or outdoor workouts—combining comfort, durability, and a bold, sporty look.",
                          nutritionalValue: "N/A",
                          price: 1800.0,
                          imageAsset: "Images/heren.png",
                          deliveryTime: 0,
                          qualifications: '',
                          location: '',
                        ),
                      ),
                    ),
                  );
                },
                child: _buildHorizontalCard("Heren Men's  Shirt and Short",
                    "Ksh1,800", "Images/heren.png"),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Productdetails(
                        product: Product(
                          id: 1,
                          name: "Men's Maxwear Fullstack",
                          description:
                              "The Max Wear Men's All-Black Performance Set is a complete workout outfit designed for serious training and all-day athletic comfort. \n\n"
                              "This 5-piece set includes a lightweight hoodie, a long-sleeved compression shirt, a breathable short-sleeved t-shirt, durable workout shorts, and compression pants—all in sleek, versatile black. \n\n"
                              "Each piece is made from sweat-wicking, stretchable fabric that offers maximum mobility, muscle support, and temperature control. \n\n"
                              "Perfect for gym workouts, running, or outdoor training in any weather, this set combines style, functionality, and performance in one unified look.",
                          nutritionalValue: "N/A",
                          price: 1000.0,
                          imageAsset: "Images/maxwear.png",
                          deliveryTime: 0,
                          qualifications: '',
                          location: '',
                        ),
                      ),
                    ),
                  );
                },
                child: _buildHorizontalCard("Men's Maxwear Fullstack",
                    "Ksh2,200", "Images/maxwear.png"),
              ),
            ],
          ),
        ),

        SizedBox(height: 30.0),

        // Title for second horizontal scroll section
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Text(
            "Women's Activewear",
            style: AppWidget.boldTextFieledStyle(),
          ),
        ),
        SizedBox(height: 15.0),

        // Second horizontal scrolling section
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Productdetails(
                        product: Product(
                          id: 1,
                          name: "Women's Seamless Fullstack",
                          description:
                              "A sleek and stylish women’s activewear set in black and aqua green, designed for performance, comfort, and confidence. \n\n"
                              "This 3-piece set includes high-waisted workout pants, a supportive sports bra, and a lightweight zip-up hoodie—perfectly coordinated for gym sessions, yoga, or outdoor runs. \n\n"
                              "The breathable, stretchable fabric offers sweat-wicking properties, muscle support, and a flattering fit that moves with you. \n\n"
                              "Combining bold color accents with athletic functionality, this set keeps you looking sharp and feeling strong through every rep and stride.",
                          nutritionalValue: "N/A",
                          price: 1900.0,
                          imageAsset: "Images/seamlessw.png",
                          deliveryTime: 0,
                          qualifications: '',
                          location: '',
                        ),
                      ),
                    ),
                  );
                },
                child: _buildHorizontalCard("Women's Seamless Fullstack",
                    "Ksh1,900", "Images/seamlessw.png"),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Productdetails(
                        product: Product(
                          id: 1,
                          name: "Women's Shelift's Fullstack",
                          description:
                              "The SheLifts Women's Performance Set in black and aqua green is built for strength, style, and self-confidence. \n\n"
                              "This 3-piece set includes sculpting high-rise workout pants, a supportive and breathable sports bra, and a lightweight zip-up hoodie—crafted to empower every lift, sprint, and stretch. \n\n"
                              "Made from premium moisture-wicking, four-way stretch fabric that hugs your body and moves with you, delivering comfort and freedom through every session. \n\n"
                              "The bold aqua green accents reflect power and energy, while the sleek black base keeps it fierce and focused—designed for women who lift, push limits, and show up strong.",
                          nutritionalValue: "N/A",
                          price: 2500.0,
                          imageAsset: "Images/shelift.png",
                          deliveryTime: 0,
                          qualifications: '',
                          location: '',
                        ),
                      ),
                    ),
                  );
                },
                child: _buildHorizontalCard("Women's Shelift's Fullstack",
                    "Ksh2,500", "Images/shelift.png"),
              ),
            ],
          ),
        ),

        SizedBox(height: 30.0),

        // Title for vertical list
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Text(
            "Featured Gym Wear",
            style: AppWidget.boldTextFieledStyle(),
          ),
        ),
        SizedBox(height: 15.0),

        // First vertical item
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Productdetails(
                  product: Product(
                    id: 1,
                    name: "Premium Workout Gloves",
                    description:
                        "X Brand Gym Gloves are built for comfort, grip, and protection—perfect for lifting, cross-training, or functional workouts. \n\n"
                        "Designed with a breathable mesh upper and padded palms for anti-slip support, they reduce pressure on the hands and prevent calluses during intense sessions. \n\n"
                        "The adjustable wrist strap ensures a secure fit, while the fingerless design offers full range of motion and ventilation. \n\n"
                        "Durable, lightweight, and stylish, these gloves are a reliable training companion for anyone looking to lift smarter and train harder.",
                    nutritionalValue: "N/A",
                    price: 200.0,
                    imageAsset: "Images/xglove.png",
                    deliveryTime: 0,
                    qualifications: '',
                    location: '',
                  ),
                ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(right: 20.0),
            child: _buildVerticalCard(
                "Premium Workout Gloves", "Ksh1,200", "Images/xglove.png"),
          ),
        ),

        SizedBox(height: 30.0),

        // Second vertical item
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Productdetails(
                  product: Product(
                    id: 1,
                    name: "Adidas Gloves",
                    description:
                        "Adidas Gym Gloves are engineered for performance, protection, and style—ideal for weightlifting, strength training, and functional fitness. \n\n"
                        "Crafted with breathable mesh fabric and padded suede-like palms, they offer enhanced grip, hand comfort, and durability during heavy lifts. \n\n"
                        "Featuring a snug, ergonomic fit with an adjustable Velcro strap for wrist support, and a fingerless design for improved flexibility and ventilation. \n\n"
                        "With the iconic Adidas branding and quality construction, these gloves are the perfect addition to any serious athlete’s gear.",
                    nutritionalValue: "N/A",
                    price: 3800.0,
                    imageAsset: "Images/adidas.png",
                    deliveryTime: 0,
                    qualifications: '',
                    location: '',
                  ),
                ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(right: 20.0),
            child: _buildVerticalCard(
                "Adidas Gloves", "Ksh3,800", "Images/adidas.png"),
          ),
        ),

        SizedBox(height: 30.0),
      ],
    );
  }

  // Updated helper method to build horizontal cards with image placeholders
  Widget _buildHorizontalCard(String title, String price, String imagePath) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image placeholder that can be replaced with actual images
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  imagePath,
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                  // This onError handler displays a placeholder if the image is not found
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.fitness_center,
                          size: 50,
                          color: Colors.grey[600],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                title,
                style: AppWidget.smallBoldTextFieledStyle(),
              ),
              SizedBox(height: 5.0),
              Text(
                price,
                style: AppWidget.smallBoldTextFieledStyle(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Updated helper method to build vertical cards with image placeholders
  Widget _buildVerticalCard(String title, String price, String imagePath) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.all(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder that can be replaced with actual images
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                imagePath,
                height: 120,
                width: 120,
                fit: BoxFit.cover,
                // This onError handler displays a placeholder if the image is not found
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.sports_gymnastics,
                        size: 40,
                        color: Colors.grey[600],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(width: 20.0),
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    title,
                    style: AppWidget.smallBoldTextFieledStyle(),
                  ),
                ),
                SizedBox(height: 5.0),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    price,
                    style: AppWidget.smallBoldTextFieledStyle(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
