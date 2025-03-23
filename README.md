Tizi app, your fitness and well app
Homepage
import 'package:flutter/material.dart';
import 'package:tiziappp2/presentation/productdetails.dart';
import 'package:tiziappp2/technicals/widgets/database.dart';
import 'package:tiziappp2/technicals/widgets/supportwidget.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // Sets trainer2o to true by default
  bool trainer2o = true, nutritionist = false, gyms = false;

  // We no longer need the dynamic title getter as we're using conditional widgets

  Stream? subItemStream;
  onLoad() async {
    subItemStream = await DatabaseMethods().getSubItem("Trainer");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
            top: 50.0,
            left: 20.0,
          ),
          child: Column(
            children: [
              // Title row is only shown for the selected category
              if (trainer2o) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Trainers",
                          style: AppWidget.boldTextFieledStyle(),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 20.0),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
              if (nutritionist) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Nutritionist",
                          style: AppWidget.boldTextFieledStyle(),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 20.0),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
              if (gyms) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Fitness Institution",
                          style: AppWidget.boldTextFieledStyle(),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 20.0),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(
                height: 20.0,
              ),
              Container(
                margin: const EdgeInsets.only(right: 20.0),
                child: showItem(),
              ),
              const SizedBox(
                height: 30.0,
              ),

              // Only show trainer content when trainer2o is true
              if (trainer2o) ...[
                // Trainers section with horizontal scroll
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Productdetails(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.asset(
                                      "Images/Jina_Trainer.png",
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    "Jina - Personal Trainer",
                                    style: AppWidget.smallBoldTextFieledStyle(),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "Personal Trainer",
                                    style: AppWidget
                                        .smallSemiBoldTextFieledStyle(),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "\Ksh1,000 per session",
                                    style: AppWidget.smallBoldTextFieledStyle(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.all(4),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    "Images/PnM.png",
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  "Poly n Mike - Couple's \nPersonal Trainers",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "Fitness Coaches",
                                  style:
                                      AppWidget.smallSemiBoldTextFieledStyle(),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "\Ksh14,000 per month",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),

                // Jin - Muay Thai Coach
                Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "Images/jin_woo.png",
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Jin - Muay Thai Coach",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Muay Thai athlete",
                                  style:
                                      AppWidget.smallSemiBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "\Ksh2,000 per session",
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

                const SizedBox(
                  height: 20.0,
                ),

                // Sarah - Yoga Instructor
                Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "Images/miley.png",
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Sarah - Yoga Instructor",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Certified Yoga Expert",
                                  style:
                                      AppWidget.smallSemiBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "\Ksh1,500 per session",
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

                const SizedBox(
                  height: 20.0,
                ),

                // David - Nutritionist
                Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "Images/Juma.png",
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "David - Nutritionist",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Sports Nutrition Expert",
                                  style:
                                      AppWidget.smallSemiBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "\Ksh3,000 per consultation",
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

                const SizedBox(
                  height: 20.0,
                ),

                // Fitness Zone Gym
                Container(
                  margin: const EdgeInsets.only(right: 20.0, bottom: 30.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "Images/Juma.png",
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Fitness Zone Gym",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Full Service Gym Facility",
                                  style:
                                      AppWidget.smallSemiBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "\Ksh5,000 per month",
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
              ],

              // Nutritionist content section
              if (nutritionist) ...[
                // Horizontal scroll section with two nutritionist items
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // First horizontal nutritionist placeholder
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    "Images/kisha.png",
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  "Kisha Wanjiku - Nutrition Expert",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "Sports Nutritionist",
                                  style:
                                      AppWidget.smallSemiBoldTextFieledStyle(),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "\Ksh2,500 per session",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),

                      Container(
                        margin: const EdgeInsets.all(4),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    "Images/malon.png",
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  "Malon Rivers - Diet Specialist",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "Clinical Nutritionist",
                                  style:
                                      AppWidget.smallSemiBoldTextFieledStyle(),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "\Ksh3,500 per consultation",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),

                Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "Images/Juma.png",
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Juma Waweru - Weight Management",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Weight Loss Specialist",
                                  style:
                                      AppWidget.smallSemiBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "\Ksh2,800 per session",
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

                const SizedBox(
                  height: 20.0,
                ),

                Container(
                  margin: const EdgeInsets.only(right: 20.0, bottom: 30.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "Images/Jina_Trainer.png",
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Jina Wickets - Performance Nutrition",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Athletic Performance Specialist",
                                  style:
                                      AppWidget.smallSemiBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "\Ksh4,000 per consultation",
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
              ],

              // Gym content section
              if (gyms) ...[
                // Horizontal scroll section with two gym items
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // First horizontal gym placeholder
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    "Images/gordon.png",
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  "Gordon's Gym",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "Modern Fitness Center",
                                  style:
                                      AppWidget.smallSemiBoldTextFieledStyle(),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "\Ksh4,500 per month",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),

                      Container(
                        margin: const EdgeInsets.all(4),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    "Images/Zumba.png",
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  "Fitness Hub",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "Premium Gym Facility",
                                  style:
                                      AppWidget.smallSemiBoldTextFieledStyle(),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "\Ksh6,000 per month",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),

                // First vertical gym placeholder
                Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "Images/Tizilogin.png",
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Tizi CrossFit Zone",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "CrossFit & Functional Training",
                                  style:
                                      AppWidget.smallSemiBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "\Ksh7,000 per month",
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

                const SizedBox(
                  height: 20.0,
                ),

                // Second vertical gym placeholder
                Container(
                  margin: const EdgeInsets.only(right: 20.0, bottom: 30.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "Images/FC.png",
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Flex Fitness",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Boutique Gym & Studio Classes",
                                  style:
                                      AppWidget.smallSemiBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "\Ksh5,500 per month",
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
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            trainer2o = true;
            nutritionist = false;
            gyms = false;

            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                color: trainer2o ? Colors.grey : Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                "Images/trainer2o.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: trainer2o ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            trainer2o = false;
            nutritionist = true;
            gyms = false;
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            color: nutritionist ? Colors.grey : Colors.white,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                "Images/nutritionist.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: nutritionist ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            trainer2o = false;
            nutritionist = false;
            gyms = true;
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            color: gyms ? Colors.grey : Colors.white,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                "Images/gyms.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: gyms ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Food and supplements
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
                    Container(
                      margin: EdgeInsets.only(right: 20.0),
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
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
                    Container(
                      margin: EdgeInsets.only(right: 20.0),
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
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
              Container(
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
            ],
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Container(
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

        // First additional food placeholder
        SizedBox(
          height: 20.0,
        ),
        Container(
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

        // Second additional food placeholder
        SizedBox(
          height: 20.0,
        ),
        Container(
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
              Container(
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

              // Second supplement item (new placeholder)
              SizedBox(
                width: 10,
              ),
              Container(
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
            ],
          ),
        ),

        SizedBox(
          height: 30.0,
        ),

        // Vertical list of supplements
        Container(
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

        // First additional supplement placeholder
        SizedBox(
          height: 20.0,
        ),
        Container(
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

        // Second additional supplement placeholder
        SizedBox(
          height: 20.0,
        ),
        Container(
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


gym accessories
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
                  Container(
                    margin: EdgeInsets.only(right: 20.0),
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
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
              Container(
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
            ],
          ),
        ),
        SizedBox(
          height: 30.0,
        ),

        // List items below
        Container(
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

        SizedBox(
          height: 30.0,
        ),
        Container(
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

        SizedBox(
          height: 30.0,
        ),
        Container(
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
              _buildHorizontalCard("Heren Men's  Shirt and Short", "Ksh1,800",
                  "Images/heren.png"),
              SizedBox(width: 10),
              _buildHorizontalCard(
                  "Men's Maxwear Fullstack", "Ksh2,200", "Images/maxwear.png"),
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
              _buildHorizontalCard("Women's Seamless Fullstack", "Ksh1,900",
                  "Images/seamlessw.png"),
              SizedBox(width: 10),
              _buildHorizontalCard("Women's Shelift's Fullstack", "Ksh2,500",
                  "Images/shelift.png"),
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
        Container(
          margin: EdgeInsets.only(right: 20.0),
          child: _buildVerticalCard(
              "Premium Workout Gloves", "Ksh1,200", "Images/xglove.png"),
        ),

        SizedBox(height: 30.0),

        // Second vertical item
        Container(
          margin: EdgeInsets.only(right: 20.0),
          child: _buildVerticalCard(
              "Adidas Gloves", "Ksh3,800", "Images/adidas.png"),
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



import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math' show pi;

class Profile extends StatefulWidget {
  final Function(DateTime)? onDateSelected;
  final Color backgroundColor;

  const Profile({
    Key? key,
    this.onDateSelected,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late DateTime _selectedDate;
  late List<DateTime> _weekDays;
  late PageController _pageController;
  int _selectedIconIndex = 0; // Set the food icon as the default selected icon

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _pageController = PageController(initialPage: 0);
    _generateWeekDays(DateTime.now());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _generateWeekDays(DateTime date) {
    // Find the start of the week (Monday)
    DateTime startOfWeek = date.subtract(Duration(days: date.weekday - 1));

    _weekDays = List.generate(7, (index) {
      return startOfWeek.add(Duration(days: index));
    });
  }

  void _navigateToWeek(int direction) {
    setState(() {
      DateTime newDate = _selectedDate.add(Duration(days: 7 * direction));
      _selectedDate = newDate;
      _generateWeekDays(newDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3),
                    child: Material(
                      elevation: 10.0,
                      borderRadius: BorderRadius.circular(60),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.asset(
                          "Images/Juma.png",
                          height: 90,
                          width: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3 - 40),
                    child: Text(
                      "Max Achebi",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3 + 100),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildIconButton(0, Icons.fastfood), // Food icon
                            SizedBox(width: 40),
                            _buildIconButton(
                                1, Icons.access_time), // Clock icon
                            SizedBox(width: 40),
                            _buildIconButton(
                                2, Icons.contacts), // Phonebook icon
                            SizedBox(width: 40),
                            _buildIconButton(
                                3, Icons.bar_chart), // Bar graph icon
                          ],
                        ),
                        // Add the nutrition donut chart if the food icon is selected
                        if (_selectedIconIndex == 0)
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Column(
                              children: [
                                NutritionInfoSection(),
                                SizedBox(height: 30),
                                CaloriesBalanceSection(),
                                SizedBox(height: 30),
                                SupplementIntakeSection(),
                                SizedBox(height: 50),
                              ],
                            ),
                          ),
                        // Show today's routine if the clock icon is selected
                        if (_selectedIconIndex == 1)
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Column(
                              children: [
                                Text(
                                  "Today's Routine",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                WorkoutRoutine(selectedDate: _selectedDate),
                              ],
                            ),
                          ),
                        // Show trainer, nutritionist, and gym sections if the phonebook icon is selected
                        if (_selectedIconIndex == 2)
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Column(
                              children: [
                                TrainerSection(),
                                SizedBox(height: 20),
                                NutritionistSection(),
                                SizedBox(height: 20),
                                GymSection(),
                              ],
                            ),
                          ),
                        // Show weight gain bar graph if the bar graph icon is selected
                        if (_selectedIconIndex == 3)
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Column(
                              children: [
                                Text(
                                  "Weight Gain Progress",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                WeightGainBarGraph(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 8, bottom: 16),
                  color: widget.backgroundColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon:
                                  Icon(Icons.chevron_left, color: Colors.grey),
                              onPressed: () => _navigateToWeek(-1),
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                            ),
                            Text(
                              DateFormat('MMMM yyyy').format(_weekDays[0]),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            IconButton(
                              icon:
                                  Icon(Icons.chevron_right, color: Colors.grey),
                              onPressed: () => _navigateToWeek(1),
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: _weekDays.map((day) {
                          bool isToday = _isToday(day);
                          bool isSelected = _isSameDay(day, _selectedDate);

                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedDate = day;
                                  if (widget.onDateSelected != null) {
                                    widget.onDateSelected!(day);
                                  }
                                });
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    DateFormat('E').format(day).substring(0, 3),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: isSelected
                                          ? Colors.grey
                                          : Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isSelected
                                          ? Colors.grey
                                          : isToday
                                              ? Colors.grey.withOpacity(0.1)
                                              : Colors.transparent,
                                    ),
                                    child: Center(
                                      child: Text(
                                        day.day.toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: isToday || isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: isSelected
                                              ? Colors.white
                                              : isToday
                                                  ? Colors.grey
                                                  : Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build an icon button
  Widget _buildIconButton(int index, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIconIndex = index; // Update the selected icon index
        });
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:
              _selectedIconIndex == index ? Colors.white : Colors.transparent,
          shape: BoxShape.circle,
          border: _selectedIconIndex == index
              ? Border.all(color: Colors.grey, width: 2)
              : null,
        ),
        child: Icon(
          icon,
          size: 30,
          color: _selectedIconIndex == index ? Colors.grey : Colors.grey[600],
        ),
      ),
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  bool _isMonday(DateTime date) {
    return date.weekday == DateTime.monday;
  }

  bool _isThursday(DateTime date) {
    return date.weekday == DateTime.thursday;
  }
}

// Custom Painter for Donut Chart (Nutrition)
class DonutChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final innerRadius = radius * 0.6; // Size of the donut hole

    // Define the colors as specified
    final proteinColor = Colors.grey[800]!; // Dark grey
    final carbsColor = Colors.grey[400]!; // Light grey
    final vitaminsColor = Colors.grey; // Medium grey
    final mineralsColor = Colors.black; // Black

    // Sample data percentages (adjust as needed)
    final proteinPercent = 0.35; // 35%
    final carbsPercent = 0.40; // 40%
    final vitaminsPercent = 0.15; // 15%
    final mineralsPercent = 0.10; // 10%

    // Paint configurations
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius - innerRadius;

    // Starting angle is -pi/2 (top of the circle)
    double startAngle = -pi / 2;

    // Draw protein section
    paint.color = proteinColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - (paint.strokeWidth / 2)),
      startAngle,
      2 * pi * proteinPercent,
      false,
      paint,
    );
    startAngle += 2 * pi * proteinPercent;

    // Draw carbs section
    paint.color = carbsColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - (paint.strokeWidth / 2)),
      startAngle,
      2 * pi * carbsPercent,
      false,
      paint,
    );
    startAngle += 2 * pi * carbsPercent;

    // Draw vitamins section
    paint.color = vitaminsColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - (paint.strokeWidth / 2)),
      startAngle,
      2 * pi * vitaminsPercent,
      false,
      paint,
    );
    startAngle += 2 * pi * vitaminsPercent;

    // Draw minerals section
    paint.color = mineralsColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - (paint.strokeWidth / 2)),
      startAngle,
      2 * pi * mineralsPercent,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// Custom Painter for Calories Balance Chart
class CaloriesBalanceChartPainter extends CustomPainter {
  final int consumed;
  final int burned;

  CaloriesBalanceChartPainter({
    required this.consumed,
    required this.burned,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final innerRadius = radius * 0.6; // Size of the donut hole

    // Define the colors
    final consumedColor = Colors.grey[800]!; // Dark grey for calories consumed
    final burnedColor = Colors.black; // Black for calories burned

    // Calculate percentages
    final total = consumed + burned.toDouble();
    final consumedPercent = consumed / total;
    final burnedPercent = burned / total;

    // Paint configurations
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius - innerRadius;

    // Starting angle is -pi/2 (top of the circle)
    double startAngle = -pi / 2;

    // Draw consumed section
    paint.color = consumedColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - (paint.strokeWidth / 2)),
      startAngle,
      2 * pi * consumedPercent,
      false,
      paint,
    );
    startAngle += 2 * pi * consumedPercent;

    // Draw burned section
    paint.color = burnedColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - (paint.strokeWidth / 2)),
      startAngle,
      2 * pi * burnedPercent,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// Supplement Intake Section with daily checkboxes
class SupplementIntakeSection extends StatefulWidget {
  @override
  _SupplementIntakeSectionState createState() =>
      _SupplementIntakeSectionState();
}

class _SupplementIntakeSectionState extends State<SupplementIntakeSection> {
  // Map to track supplement intake status
  Map<String, bool> supplementStatus = {
    "Creatine Monohydrate": false,
    "Protein Powder": false,
    "Pre-Workout Supplement": false,
    "Other Supplements": false,
  };

  @override
  void initState() {
    super.initState();
    // Check if we need to reset checkboxes based on last reset date
    _checkAndResetDailyStatus();
  }

  // Method to check if we need to reset checkboxes (every 24 hours)
  void _checkAndResetDailyStatus() {
    DateTime now = DateTime.now();
    DateTime lastReset = now; // This would be retrieved from storage

    // If it's a new day, reset all checkboxes
    if (now.day != lastReset.day ||
        now.month != lastReset.month ||
        now.year != lastReset.year) {
      setState(() {
        supplementStatus.forEach((key, value) {
          supplementStatus[key] = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Supplement Intake",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 16),
          Text(
            "Track your daily supplements. Checkboxes reset every 24 hours.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 16),
          ...supplementStatus.keys
              .map((supplement) => _buildSupplementCheckbox(supplement))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildSupplementCheckbox(String supplement) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: supplementStatus[supplement],
              onChanged: (bool? value) {
                setState(() {
                  supplementStatus[supplement] = value ?? false;
                });
              },
              activeColor: Colors.grey[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              supplement,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
                decoration: supplementStatus[supplement]!
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ),
          Text(
            supplementStatus[supplement]! ? "Taken" : "Not taken",
            style: TextStyle(
              fontSize: 14,
              color: supplementStatus[supplement]!
                  ? Colors.green[700]
                  : Colors.red[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// Weight Gain Bar Graph Widget
class WeightGainBarGraph extends StatelessWidget {
  // Sample data - you can replace with actual data
  final List<double> monthlyWeightGain = [
    0.8,
    1.2,
    0.5,
    0.9,
    1.5,
    0.7,
    1.0,
    1.3,
    0.4,
    0.6,
    1.1,
    0.9
  ];
  final List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  @override
  Widget build(BuildContext context) {
    // Calculate the maximum weight gain for Y-axis scaling
    double maxWeightGain =
        monthlyWeightGain.reduce((curr, next) => curr > next ? curr : next);

    return Container(
      padding: EdgeInsets.all(16),
      height: 250, // Graph height
      width: MediaQuery.of(context).size.width * 0.85, // Graph width
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Weight Gained (kg) by Month",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Y-axis labels
                Container(
                  width: 30,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("${maxWeightGain.toStringAsFixed(1)}",
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[700])),
                      Text("${(maxWeightGain * 0.75).toStringAsFixed(1)}",
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[700])),
                      Text("${(maxWeightGain * 0.5).toStringAsFixed(1)}",
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[700])),
                      Text("${(maxWeightGain * 0.25).toStringAsFixed(1)}",
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[700])),
                      Text("0.0",
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[700])),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                // Graph area
                Expanded(
                  child: Container(
                    height: 180,
                    child: CustomPaint(
                      size: Size.infinite,
                      painter: BarGraphPainter(
                          monthlyWeightGain: monthlyWeightGain,
                          maxWeightGain: maxWeightGain),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // X-axis labels
          Container(
            margin: EdgeInsets.only(left: 38), // Align with bars
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: months
                  .map((month) => Expanded(
                        child: Text(
                          month,
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[700]),
                          textAlign: TextAlign.center,
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for the bar graph
class BarGraphPainter extends CustomPainter {
  final List<double> monthlyWeightGain;
  final double maxWeightGain;

  BarGraphPainter({
    required this.monthlyWeightGain,
    required this.maxWeightGain,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final barWidth = size.width / (monthlyWeightGain.length * 1.5);
    final barMargin = barWidth / 2;
    final height = size.height;

    // Drawing horizontal grid lines
    final gridPaint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 1;

    for (int i = 0; i <= 4; i++) {
      final y = height - (height * (i / 4));
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }

    // Drawing bars
    final barPaint = Paint()
      ..color = Colors.grey[600]!
      ..style = PaintingStyle.fill;

    for (int i = 0; i < monthlyWeightGain.length; i++) {
      final barHeight = (monthlyWeightGain[i] / maxWeightGain) * height;
      final barLeft = i * ((barWidth + barMargin) * 1.5);

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            barLeft,
            height - barHeight,
            barWidth,
            barHeight,
          ),
          Radius.circular(4),
        ),
        barPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// New Workout Routine Widget
class WorkoutRoutine extends StatefulWidget {
  final DateTime selectedDate;

  WorkoutRoutine({required this.selectedDate});

  @override
  _WorkoutRoutineState createState() => _WorkoutRoutineState();
}

class _WorkoutRoutineState extends State<WorkoutRoutine> {
  // Map to track workout status
  Map<String, bool> workoutStatus = {};

  @override
  void initState() {
    super.initState();
    _initializeWorkoutStatus();
  }

  void _initializeWorkoutStatus() {
    if (_isMonday(widget.selectedDate) || _isThursday(widget.selectedDate)) {
      workoutStatus = {
        "Preacher Curl 3 x 14": false,
        "Bench Press 3 x 14": false,
        "Hammer Curl 3 x 14": false,
        "Peck Deck": false,
        "Lateral Raises": false,
        "Inclined Dumbbell Press": false,
        "Cardio 45 mins": false,
      };
    } else if (_isTuesday(widget.selectedDate) ||
        _isFriday(widget.selectedDate)) {
      workoutStatus = {
        "Barbell Squats 3 x 14": false,
        "Quad Extension 3 x 14": false,
        "Romanian Deadlifts 3 x 14": false,
        "Hamstring Curls 3 x 14": false,
        "Upper Back Dumbbell Row 3 x 14": false,
        "Lat Dumbbell Row 3 x 14": false,
        "Elbow Extension 3 x 14": false,
        "Skull Crushers 3 x 14": false,
        "Cardio 45 mins": false,
      };
    } else {
      workoutStatus = {
        "Rest Day": false,
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (workoutStatus.keys.first == "Rest Day")
          Text(
            "Rest Day",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          )
        else
          ...workoutStatus.keys
              .map((workout) => _buildWorkoutCheckbox(workout))
              .toList(),
      ],
    );
  }

  Widget _buildWorkoutCheckbox(String workout) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Checkbox(
            value: workoutStatus[workout],
            onChanged: (bool? value) {
              setState(() {
                workoutStatus[workout] = value ?? false;
              });
            },
            activeColor: Colors.grey[800],
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              workout,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
                decoration: workoutStatus[workout]!
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isMonday(DateTime date) {
    return date.weekday == DateTime.monday;
  }

  bool _isThursday(DateTime date) {
    return date.weekday == DateTime.thursday;
  }

  bool _isTuesday(DateTime date) {
    return date.weekday == DateTime.tuesday;
  }

  bool _isFriday(DateTime date) {
    return date.weekday == DateTime.friday;
  }
}

// Trainer Section
class TrainerSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Action when the trainer button is pressed
        print("Trainer button pressed");
      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("Images/PnM.png"), // Placeholder image
            radius: 30,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Trainer: PnM",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text("Subscription ends in 10 days",
                  style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

// Nutritionist Section
class NutritionistSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Action when the nutritionist button is pressed
        print("Nutritionist button pressed");
      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage:
                AssetImage("Images/kisha.png"), // Placeholder image
            radius: 30,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nutritionist: Kisha",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text("Subscription ends in 3 days",
                  style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

// Gym Section
class GymSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Action when the gym button is pressed
        print("Gym button pressed");
      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage:
                AssetImage("Images/gordon.png"), // Placeholder image
            radius: 30,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Gym: Gordon's Gym",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text("Subscription ends in 20 days",
                  style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

// Nutrition Info Section
class NutritionInfoSection extends StatelessWidget {
  final int totalCalories = 1850;
  final double proteins = 85.2;
  final double carbs = 210.5;
  final double vitamins = 750.8; // in mg
  final double minerals = 15.4; // in g

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side with donut chart
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Calories Consumed",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 8),
              Text(
                "$totalCalories kcal",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[900],
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: 100,
                height: 100,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      painter: DonutChartPainter(),
                      size: Size(100, 100),
                    ),
                    Text(
                      "Daily",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLegendItem('Protein', Colors.grey[800]!),
                    _buildLegendItem('Carbs', Colors.grey[400]!),
                    _buildLegendItem('Vitamins', Colors.grey),
                    _buildLegendItem('Minerals', Colors.black),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(width: 40),

          // Right side with nutrition details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nutrition Details",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 16),
              _buildNutrientInfo("Proteins", "${proteins.toStringAsFixed(1)} g",
                  Colors.grey[800]!),
              SizedBox(height: 12),
              _buildNutrientInfo("Carbohydrates",
                  "${carbs.toStringAsFixed(1)} g", Colors.grey[400]!),
              SizedBox(height: 12),
              _buildNutrientInfo(
                  "Vitamins", "${vitamins.toStringAsFixed(1)} mg", Colors.grey),
              SizedBox(height: 12),
              _buildNutrientInfo(
                  "Minerals", "${minerals.toStringAsFixed(1)} g", Colors.black),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String text, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildNutrientInfo(String label, String value, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Calories Balance Section
class CaloriesBalanceSection extends StatelessWidget {
  final int caloriesConsumed = 1850;
  final int caloriesBurned = 1350;
  final int netCalories = 500; // consumed - burned

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side with donut chart
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Calories Balance",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Net: $netCalories kcal",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[900],
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: 100,
                height: 100,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      painter: CaloriesBalanceChartPainter(
                        consumed: caloriesConsumed,
                        burned: caloriesBurned,
                      ),
                      size: Size(100, 100),
                    ),
                    Text(
                      "Daily",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLegendItem('Consumed', Colors.grey[800]!),
                    _buildLegendItem('Burned', Colors.black),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(width: 40),

          // Right side with calorie balance details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Energy Balance",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 16),
              _buildCalorieInfo(
                  "Consumed", "$caloriesConsumed kcal", Colors.grey[800]!),
              SizedBox(height: 12),
              _buildCalorieInfo("Burned", "$caloriesBurned kcal", Colors.black),
              SizedBox(height: 12),
              Divider(color: Colors.grey[400]),
              SizedBox(height: 12),
              _buildCalorieInfo("Net Balance", "$netCalories kcal",
                  netCalories > 0 ? Colors.green[700]! : Colors.red[700]!,
                  isHighlighted: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String text, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildCalorieInfo(String label, String value, Color color,
      {bool isHighlighted = false}) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: isHighlighted ? 18 : 16,
                fontWeight: FontWeight.bold,
                color: isHighlighted ? color : Colors.grey[900],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tiziappp2/presentation/productdetails.dart';
import 'package:tiziappp2/technicals/widgets/database.dart';
import 'package:tiziappp2/technicals/widgets/supportwidget.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // Sets trainer2o to true by default
  bool trainer2o = true, nutritionist = false, gyms = false;

  // We no longer need the dynamic title getter as we're using conditional widgets

  Stream? subItemStream;
  onLoad() async {
    subItemStream = await DatabaseMethods().getSubItem("Trainer");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
            top: 50.0,
            left: 20.0,
          ),
          child: Column(
            children: [
              // Title row is only shown for the selected category
              if (trainer2o) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Trainers",
                          style: AppWidget.boldTextFieledStyle(),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 20.0),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
              if (nutritionist) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Nutritionist",
                          style: AppWidget.boldTextFieledStyle(),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 20.0),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
              if (gyms) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Fitness Institution",
                          style: AppWidget.boldTextFieledStyle(),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 20.0),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(
                height: 20.0,
              ),
              Container(
                margin: const EdgeInsets.only(right: 20.0),
                child: showItem(),
              ),
              const SizedBox(
                height: 30.0,
              ),

              // Only show trainer content when trainer2o is true
              if (trainer2o) ...[
                // Trainers section with horizontal scroll
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Productdetails(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.asset(
                                      "Images/Jina_Trainer.png",
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    "Jina - Personal Trainer",
                                    style: AppWidget.smallBoldTextFieledStyle(),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "Personal Trainer",
                                    style: AppWidget
                                        .smallSemiBoldTextFieledStyle(),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "\Ksh1,000 per session",
                                    style: AppWidget.smallBoldTextFieledStyle(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.all(4),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    "Images/PnM.png",
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  "Poly n Mike - Couple's \nPersonal Trainers",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "Fitness Coaches",
                                  style:
                                      AppWidget.smallSemiBoldTextFieledStyle(),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "\Ksh14,000 per month",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),

                // Jin - Muay Thai Coach
                Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "Images/jin_woo.png",
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Jin - Muay Thai Coach",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Muay Thai athlete",
                                  style:
                                      AppWidget.smallSemiBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "\Ksh2,000 per session",
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

                const SizedBox(
                  height: 20.0,
                ),

                // Sarah - Yoga Instructor
                Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "Images/miley.png",
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Sarah - Yoga Instructor",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Certified Yoga Expert",
                                  style:
                                      AppWidget.smallSemiBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "\Ksh1,500 per session",
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

                const SizedBox(
                  height: 20.0,
                ),

                // David - Nutritionist
                Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "Images/Juma.png",
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "David - Nutritionist",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Sports Nutrition Expert",
                                  style:
                                      AppWidget.smallSemiBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "\Ksh3,000 per consultation",
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

                const SizedBox(
                  height: 20.0,
                ),

                // Fitness Zone Gym
                Container(
                  margin: const EdgeInsets.only(right: 20.0, bottom: 30.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "Images/Juma.png",
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Fitness Zone Gym",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Full Service Gym Facility",
                                  style:
                                      AppWidget.smallSemiBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "\Ksh5,000 per month",
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
              ],

              // Nutritionist content section
              if (nutritionist) ...[
                // Horizontal scroll section with two nutritionist items
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // First horizontal nutritionist placeholder
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    "Images/kisha.png",
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  "Kisha Wanjiku - Nutrition Expert",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "Sports Nutritionist",
                                  style:
                                      AppWidget.smallSemiBoldTextFieledStyle(),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "\Ksh2,500 per session",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),

                      Container(
                        margin: const EdgeInsets.all(4),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    "Images/malon.png",
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  "Malon Rivers - Diet Specialist",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "Clinical Nutritionist",
                                  style:
                                      AppWidget.smallSemiBoldTextFieledStyle(),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "\Ksh3,500 per consultation",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),

                Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "Images/Juma.png",
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Juma Waweru - Weight Management",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Weight Loss Specialist",
                                  style:
                                      AppWidget.smallSemiBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "\Ksh2,800 per session",
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

                const SizedBox(
                  height: 20.0,
                ),

                Container(
                  margin: const EdgeInsets.only(right: 20.0, bottom: 30.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "Images/Jina_Trainer.png",
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Jina Wickets - Performance Nutrition",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Athletic Performance Specialist",
                                  style:
                                      AppWidget.smallSemiBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "\Ksh4,000 per consultation",
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
              ],

              // Gym content section
              if (gyms) ...[
                // Horizontal scroll section with two gym items
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // First horizontal gym placeholder
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    "Images/gordon.png",
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  "Gordon's Gym",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "Modern Fitness Center",
                                  style:
                                      AppWidget.smallSemiBoldTextFieledStyle(),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "\Ksh4,500 per month",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),

                      Container(
                        margin: const EdgeInsets.all(4),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    "Images/Zumba.png",
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  "Fitness Hub",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "Premium Gym Facility",
                                  style:
                                      AppWidget.smallSemiBoldTextFieledStyle(),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "\Ksh6,000 per month",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),

                // First vertical gym placeholder
                Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "Images/Tizilogin.png",
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Tizi CrossFit Zone",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "CrossFit & Functional Training",
                                  style:
                                      AppWidget.smallSemiBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "\Ksh7,000 per month",
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

                const SizedBox(
                  height: 20.0,
                ),

                // Second vertical gym placeholder
                Container(
                  margin: const EdgeInsets.only(right: 20.0, bottom: 30.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "Images/FC.png",
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Flex Fitness",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Boutique Gym & Studio Classes",
                                  style:
                                      AppWidget.smallSemiBoldTextFieledStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "\Ksh5,500 per month",
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
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            trainer2o = true;
            nutritionist = false;
            gyms = false;

            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                color: trainer2o ? Colors.grey : Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                "Images/trainer2o.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: trainer2o ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            trainer2o = false;
            nutritionist = true;
            gyms = false;
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            color: nutritionist ? Colors.grey : Colors.white,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                "Images/nutritionist.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: nutritionist ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            trainer2o = false;
            nutritionist = false;
            gyms = true;
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            color: gyms ? Colors.grey : Colors.white,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                "Images/gyms.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: gyms ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}