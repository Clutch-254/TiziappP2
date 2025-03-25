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
                      builder: (context) => Productdetails(),
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
        builder: (context) => Productdetails(),
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
        builder: (context) => Productdetails(),
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
        builder: (context) => Productdetails(),
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
        builder: (context) => Productdetails(),
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
        builder: (context) => Productdetails(),
      ),
    );
  },
                child: _buildHorizontalCard("Heren Men's  Shirt and Short", "Ksh1,800",
                    "Images/heren.png"),
              ),
              SizedBox(width: 10),
              GestureDetector(
                 onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Productdetails(),
      ),
    );
  },
                child: _buildHorizontalCard(
                    "Men's Maxwear Fullstack", "Ksh2,200", "Images/maxwear.png"),
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
        builder: (context) => Productdetails(),
      ),
    );
  },
                child: _buildHorizontalCard("Women's Seamless Fullstack", "Ksh1,900",
                    "Images/seamlessw.png"),
              ),
              SizedBox(width: 10),
              GestureDetector(
                 onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Productdetails(),
      ),
    );
  },
                child: _buildHorizontalCard("Women's Shelift's Fullstack", "Ksh2,500",
                    "Images/shelift.png"),
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
        builder: (context) => Productdetails(),
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
        builder: (context) => Productdetails(),
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
