import 'package:flutter/material.dart';

import '../../technicals/widgets/database.dart';
import '../../technicals/widgets/supportwidget.dart';
import '../productdetails.dart';

class Foodnsupplements extends StatefulWidget {
  const Foodnsupplements({super.key});

  @override
  State<Foodnsupplements> createState() => _FoodnsupplementsState();
}

class _FoodnsupplementsState extends State<Foodnsupplements> {
  // Set foods to true by default to auto-select it when page opens
  bool foods = true, supplements = false;

  Stream? gymItemStream;
  onFitLoad() async {
    gymItemStream = await DatabaseMethods().getGymItem("Foods");
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
    return Column(
      children: [
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
                          name: "Grilled steak and fried potatoes",
                          description:
                              "A hearty 300-gram portion of juicy, medium-rare steak—tender, flavorful,\n and seared to perfection—rests beside 200 grams of golden, crispy fried potatoes.\n The steak boasts a smoky char and rich marbling, while the potatoes are crunchy on the outside,\n fluffy inside, and lightly seasoned with salt and herbs for a savory finish.",
                          nutritionalValue:
                              "A hearty 300-gram portion of juicy, medium-rare steak—tender, flavorful, and seared to perfection—rests beside 200 grams of golden, crispy fried potatoes. \n\n"
                              "Macronutrients:\n"
                              "Steak: ~660 kcal, 62g protein, 45g fat, 0g carbs\n"
                              "Fried Potatoes: ~480 kcal, 5g protein, 25g fat, 55g carbs\n\n"
                              "Micronutrients:\n"
                              "Steak: Rich in iron, zinc, vitamin B12, and niacin\n"
                              "Fried Potatoes: Contains potassium, vitamin C, vitamin B6, and magnesium\n\n"
                              "Total: ~1140 kcal, 67g protein, 70g fat, 55g carbs",
                          price: 750.0,
                          imageAsset: "Images/steak_potato.png",
                          deliveryTime: 45,
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
                              "Images/steak_potato.png",
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            "Grilled steak and\n fried potatoes",
                            style: AppWidget.smallBoldTextFieledStyle(),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "\Ksh750",
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
                          name: "Fruit Salad",
                          description:
                              "A refreshing fruit salad made with 100g of grapes, 100g of pineapple chunks, 100g of sliced strawberries, and 100g of kiwi fruit. \n"
                              "Each fruit brings its own vibrant color, juicy texture, and natural sweetness—grapes add a burst of crispness, pineapples provide a tangy kick, strawberries offer a mellow sweetness, and kiwi brings a tropical zest. \n\n",
                          nutritionalValue: "Macronutrients:\n"
                              "Total (approx.): ~240 kcal, 2g protein, 0.8g fat, 60g carbs (mostly natural sugars and fiber) \n\n"
                              "Micronutrients:\n"
                              "Grapes: High in antioxidants (resveratrol), vitamin K, and vitamin C\n"
                              "Pineapple: Rich in vitamin C, manganese, and bromelain (a digestive enzyme)\n"
                              "Strawberries: Packed with vitamin C, folate, and antioxidants\n"
                              "Kiwi: Excellent source of vitamin C, vitamin K, and potassium",
                          price: 400.0,
                          imageAsset: "Images/fruitsalad.png",
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
                              "Images/fruitsalad.png",
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            "Fruit Salad",
                            style: AppWidget.smallBoldTextFieledStyle(),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "\Ksh400",
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
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Productdetails(
                  product: Product(
                    id: 1,
                    name: "Rice and beef stew",
                    description:
                        "A warm, hearty meal featuring 200g of steamed white rice paired with 250g of savory beef stew. \n"
                        "The rice is fluffy and mild, serving as the perfect base for the rich, slow-cooked beef stew—tender chunks of beef simmered with tomatoes, onions, garlic, and a blend of aromatic spices for deep flavor. \n\n",
                    nutritionalValue: "Macronutrients:\n"
                        "White Rice (200g): ~260 kcal, 5g protein, 0.5g fat, 57g carbs\n"
                        "Beef Stew (250g): ~400 kcal, 35g protein, 25g fat, 10g carbs\n\n"
                        "Micronutrients:\n"
                        "Rice: Contains small amounts of B vitamins (especially B1 and B3), iron, and magnesium\n"
                        "Beef Stew: Rich in iron, zinc, vitamin B12, and selenium from beef; vitamin C and lycopene from tomatoes; antioxidants and anti-inflammatory compounds from garlic and onions",
                    price: 550.0,
                    imageAsset: "Images/beefrice.png",
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
                        "Images/beefrice.png",
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
                            "Rice and beef stew",
                            style: AppWidget.smallBoldTextFieledStyle(),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            "\Ksh550",
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

        // First additional food placeholder
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
                    name: "Fish n Chips",
                    description:
                        "A classic dish featuring 200g of battered and deep-fried white fish served with 200g of crispy golden potato fries. \n"
                        "The fish is flaky and tender on the inside with a crunchy, seasoned outer crust, while the fries are perfectly crisp on the outside and soft within, lightly salted for a satisfying finish. \n",
                    nutritionalValue: "Macronutrients:\n"
                        "Fried Fish (200g): ~400 kcal, 30g protein, 25g fat, 15g carbs\n"
                        "Potato Fries (200g): ~480 kcal, 5g protein, 25g fat, 55g carbs\n\n"
                        "Micronutrients:\n"
                        "Fried Fish: Good source of omega-3 fatty acids (if using oily fish like cod or haddock), vitamin D, B12, and selenium\n"
                        "Potato Fries: Provide potassium, vitamin C, vitamin B6, and some fiber depending on preparation",
                    price: 600.0,
                    imageAsset: "Images/fishchip.png",
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
                        "Images/fishchip.png",
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
                            "Fish n Chips",
                            style: AppWidget.smallBoldTextFieledStyle(),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            "\Ksh600",
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

        // Second additional food placeholder
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
                    name: "Steak and Potatoes",
                    description:
                        "A hearty meal featuring 300g of seared, medium-rare steak served with 200g of crispy fried potatoes. \n\n"
                        "The steak is juicy and tender with a rich, smoky char, while the potatoes are golden, crunchy on the outside, and fluffy inside—seasoned with salt and herbs for extra flavor. \n",
                    nutritionalValue: "Macronutrients:\n"
                        "Steak (300g): ~660 kcal, 62g protein, 45g fat, 0g carbs\n"
                        "Fried Potatoes (200g): ~480 kcal, 5g protein, 25g fat, 55g carbs\n\n"
                        "Micronutrients:\n"
                        "Steak: Excellent source of iron, zinc, vitamin B12, and niacin\n"
                        "Fried Potatoes: Provide potassium, vitamin C, vitamin B6, and magnesium",
                    price: 450.0,
                    imageAsset: "Images/steak_potato.png",
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
                        "Images/steak_potato.png",
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
                            "Steak and Potatoes",
                            style: AppWidget.smallBoldTextFieledStyle(),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            "\Ksh450",
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
