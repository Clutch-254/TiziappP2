import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../technicals/widgets/database.dart';
import '../../technicals/widgets/supportwidget.dart';
import '../productdetails.dart';
import '../widgets/display_image.dart';

class Foodnsupplements extends StatefulWidget {
  const Foodnsupplements({super.key});

  @override
  State<Foodnsupplements> createState() => _FoodnsupplementsState();
}

class _FoodnsupplementsState extends State<Foodnsupplements> {
  // Set foods to true by default to auto-select it when page opens
  bool foods = true, supplements = false;

  Future? gymItemStream; // Changed to Future
  
  onFitLoad() async {
    gymItemStream = DatabaseMethods().getLocalItems("Foods");
    setState(() {});
  }

  @override
  void initState() {
    onFitLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: 50.0,
            left: 20.0,
          ),
          child: Column(
            children: [
              // Dynamic title section using conditional rendering
              if (foods) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Foods",
                          style: AppWidget.boldTextFieledStyle(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              if (supplements) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Supplements",
                          style: AppWidget.boldTextFieledStyle(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.only(right: 20.0),
                child: showFoodItem(),
              ),
              SizedBox(
                height: 30.0,
              ),
              // Conditionally show either food content or supplements content
              foods ? showFoodContent() : showSupplementsContent(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to display food content
  Widget showFoodContent() {
    return FutureBuilder(
      future: gymItemStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        
        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Icon(Icons.error_outline, size: 60, color: Colors.red),
                  SizedBox(height: 10),
                  Text(
                    'Error loading foods',
                    style: AppWidget.boldTextFieledStyle(),
                  ),
                  SizedBox(height: 5),
                  Text(
                    snapshot.error.toString(),
                    style: AppWidget.smallSemiBoldTextFieledStyle(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }
        
        if (!snapshot.hasData || snapshot.data.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Icon(Icons.restaurant_menu, size: 60, color: Colors.grey),
                  SizedBox(height: 10),
                  Text(
                    'No food items available',
                    style: AppWidget.boldTextFieledStyle(),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Please add food items from the admin panel',
                    style: AppWidget.smallSemiBoldTextFieledStyle(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }
        
        return Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(snapshot.data.length, (index) {
                  var ds = snapshot.data[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Productdetails(
                            product: Product(
                              id: 1, // You might want to use ds['id'] or a field from DB
                              name: ds["Name"],
                              description: ds["Detail"],
                              nutritionalValue: "N/A",
                              price: double.parse(ds["Price"]),
                              imageAsset: ds["Image"],
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
                                child: DisplayImage(
                                  imagePath: ds["Image"],
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                ds["Name"],
                                style: AppWidget.smallBoldTextFieledStyle(),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "\\Ksh" + ds["Price"],
                                style: AppWidget.smallBoldTextFieledStyle(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
          ],
        );
      },
    );
  }

  // Widget to display supplements content
  Widget showSupplementsContent() {
    return Column(
      children: [
        // Horizontal scrollable supplements at the top
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // First supplement item
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Productdetails(
                        product: Product(
                          id: 1,
                          name: "NitroTech Protein Powder",
                          description:
                              "A single serving (1 scoop, ~44g) of NitroTech Chocolate Protein Powder—a rich, creamy chocolate-flavored shake designed to support muscle growth and recovery. \n\n"
                              "Made with high-quality whey peptides and isolate, it mixes smoothly and delivers fast-absorbing protein post-workout. \n",
                          nutritionalValue: "Macronutrients:\n"
                              "Per serving (44g): ~160 kcal, 30g protein, 2.5g fat, 4g carbs\n\n"
                              "Micronutrients:\n"
                              "Contains calcium, iron, and sodium\n"
                              "Also enriched with creatine monohydrate (3g), which supports strength and performance\n"
                              "Includes small amounts of vitamin C and magnesium depending on the variant\n\n"
                              "Note: Exact values may vary slightly by flavor or batch.",
                          price: 2500.0,
                          imageAsset: "Images/nitrotech.png",
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
                              "Images/nitrotech.png",
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            "NitroTech Protein Powder",
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

              // Second supplement item (new placeholder)
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
                          name: "Optimum Nutrition Whey",
                          description:
                              "A single serving (1 scoop, ~32g) of Optimum Nutrition Gold Standard 100% Whey Protein in rich chocolate flavor—ideal for muscle recovery and daily protein support. \n"
                              "Made with a blend of whey protein isolate, concentrate, and peptides, it mixes easily and delivers a smooth, delicious taste with minimal fat and carbs. \n",
                          nutritionalValue: "Macronutrients:\n"
                              "Per serving (32g): ~120 kcal, 24g protein, 1g fat, 3g carbs (1g sugar)\n\n"
                              "Micronutrients:\n"
                              "Contains calcium (~130mg), iron (~0.7mg), and sodium (~130mg)\n"
                              "Also includes small amounts of potassium and magnesium\n"
                              "Low in lactose and cholesterol, making it suitable for most fitness goals\n\n"
                              "Note: Nutrient values may vary slightly depending on the flavor variant.",
                          price: 1800.0,
                          imageAsset: "Images/opwhey.png",
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
                              "Images/opwhey.png",
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            "Optimum Nutrition Whey",
                            style: AppWidget.smallBoldTextFieledStyle(),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "\Ksh1800",
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

        // Vertical list of supplements
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Productdetails(
                  product: Product(
                    id: 1,
                    name: "Optimum NutritionCreatine",
                    description:
                        "A single serving (1 scoop, ~5g) of Optimum Nutrition Creatine Monohydrate—unflavored and micronized for easy mixing and rapid absorption. \n"
                        "Designed to support increased strength, muscle power, and high-intensity performance, it's ideal for athletes and gym-goers looking to boost training results. \n",
                    nutritionalValue: "Macronutrients:\n"
                        "Per serving (5g): 0 kcal, 0g protein, 0g fat, 0g carbs\n\n"
                        "Micronutrients:\n"
                        "Contains 5g of pure creatine monohydrate\n"
                        "Free from sugars, artificial additives, and calories\n"
                        "Helps replenish ATP stores, aiding in short bursts of explosive energy during workouts\n\n"
                        "Note: Best taken daily, with or without food. Can be mixed with water, juice, or protein shakes.",
                    price: 1500.0,
                    imageAsset: "Images/opcreatine.png",
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
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "Images/opcreatine.png",
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
                            "Optimum NutritionCreatine",
                            style: AppWidget.smallBoldTextFieledStyle(),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            "\Ksh1500",
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
          height: 20.0,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Productdetails(
                  product: Product(
                    id: 1,
                    name: "C4 Pre-Workout",
                    description:
                        "A single serving (1 scoop, ~6.5g) of C4 Original Pre-Workout—a high-energy, explosive blend designed to boost focus, endurance, and performance during training. \n"
                        "Known for its iconic flavor and tingly beta-alanine kick, C4 helps power your workouts with a quick and sustained energy surge. \n",
                    nutritionalValue: "Macronutrients:\n"
                        "Per serving (6.5g): ~5 kcal, 0g protein, 0g fat, 1g carbs\n\n"
                        "Key Active Ingredients:\n"
                        "Beta-Alanine (1.6g): Enhances muscular endurance and reduces fatigue\n"
                        "Creatine Nitrate (1g): Supports strength and blood flow\n"
                        "Caffeine Anhydrous (150mg): Boosts energy and mental focus\n"
                        "Arginine Alpha-Ketoglutarate (1g): Promotes nitric oxide production for better pumps\n\n"
                        "Micronutrients:\n"
                        "Includes vitamin C, niacin (B3), vitamin B6, folic acid, and vitamin B12 to support energy metabolism\n\n"
                        "Note: Effects vary by tolerance. Start with half a scoop to assess sensitivity.",
                    price: 2200.0,
                    imageAsset: "Images/c4.png",
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
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "Images/c4.png",
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
                            "C4 Pre-Workout",
                            style: AppWidget.smallBoldTextFieledStyle(),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            "\Ksh2200",
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

        // Second additional supplement placeholder
        SizedBox(
          height: 20.0,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Productdetails(
                  product: Product(
                    id: 1,
                    name: "Bio Creatine Monohydrate",
                    description:
                        "A single serving (1 scoop, ~5g) of BioTechUSA Creatine Monohydrate—pure, unflavored creatine designed to support explosive strength, endurance, and muscle volume. \n"
                        "Micronized for better absorption and mixability, it's ideal for athletes seeking improved performance in high-intensity training. \n",
                    nutritionalValue: "Macronutrients:\n"
                        "Per serving (5g): 0 kcal, 0g protein, 0g fat, 0g carbs\n\n"
                        "Micronutrients:\n"
                        "Contains 5g of 100% pure creatine monohydrate\n"
                        "Supports ATP regeneration, helping to sustain power during short, intense bursts\n"
                        "Free from sugars, fillers, and artificial additives\n\n"
                        "Note: Suitable for both loading (20g/day for 5–7 days) and maintenance (3–5g/day) phases. Can be mixed with water, juice, or a post-workout shake.",
                    price: 1000.0,
                    imageAsset: "Images/biocreatine.png",
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
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "Images/biocreatine.png",
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
                            "Bio Creatine Monohydrate",
                            style: AppWidget.smallBoldTextFieledStyle(),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            "\Ksh3200",
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

  Widget showFoodItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            foods = true;
            supplements = false;
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                color: foods ? Colors.grey : Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(10),
              child: Image.asset(
                "Images/food.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: foods ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            foods = false;
            supplements = true;
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            color: supplements ? Colors.grey : Colors.white,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Image.asset(
                "Images/supplements.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: supplements ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
