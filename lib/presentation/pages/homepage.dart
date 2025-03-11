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
  // Set trainer2o to true by default
  bool trainer2o = true, nutritionist = false, gyms = false;

  Stream? subItemStream;
  onLoad() async {
    subItemStream = await DatabaseMethods().getSubItem("Trainer");
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Trainers",
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
                child: showItem(),
              ),
              SizedBox(
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
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "Personal Trainer",
                                    style: AppWidget
                                        .smallSemiBoldTextFieledStyle(),
                                  ),
                                  SizedBox(
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
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "Fitness Coaches",
                                  style:
                                      AppWidget.smallSemiBoldTextFieledStyle(),
                                ),
                                SizedBox(
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
                SizedBox(
                  height: 30.0,
                ),

                // Jin - Muay Thai Coach
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
                              "Images/jin_woo.png",
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
                                  "Jin - Muay Thai Coach",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ),
                              SizedBox(
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
                              SizedBox(
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

                SizedBox(
                  height: 20.0,
                ),

                // Sarah - Yoga Instructor
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
                              "Images/miley.png",
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
                                  "Sarah - Yoga Instructor",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ),
                              SizedBox(
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
                              SizedBox(
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

                SizedBox(
                  height: 20.0,
                ),

                // David - Nutritionist
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
                              "Images/Juma.png",
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
                                  "David - Nutritionist",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ),
                              SizedBox(
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
                              SizedBox(
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

                SizedBox(
                  height: 20.0,
                ),

                // Fitness Zone Gym
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
                              "Images/Juma.png",
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
                                  "Fitness Zone Gym",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ),
                              SizedBox(
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
                              SizedBox(
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
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "Sports Nutritionist",
                                  style:
                                      AppWidget.smallSemiBoldTextFieledStyle(),
                                ),
                                SizedBox(
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
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "Clinical Nutritionist",
                                  style:
                                      AppWidget.smallSemiBoldTextFieledStyle(),
                                ),
                                SizedBox(
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
                              "Images/Juma.png",
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
                                  "Juma Waweru - Weight Management",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ),
                              SizedBox(
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
                              SizedBox(
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
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "Images/Jina_Trainer.png",
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
                                  "Jina Wickets - Performance Nutrition",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ),
                              SizedBox(
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
                              SizedBox(
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
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "Modern Fitness Center",
                                  style:
                                      AppWidget.smallSemiBoldTextFieledStyle(),
                                ),
                                SizedBox(
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
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "Premium Gym Facility",
                                  style:
                                      AppWidget.smallSemiBoldTextFieledStyle(),
                                ),
                                SizedBox(
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
                SizedBox(
                  height: 30.0,
                ),

                // First vertical gym placeholder
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
                              "Images/Tizilogin.png",
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
                                  "Tizi CrossFit Zone",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ),
                              SizedBox(
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
                              SizedBox(
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

                SizedBox(
                  height: 20.0,
                ),

                // Second vertical gym placeholder
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
                              "Images/FC.png",
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
                                  "Flex Fitness",
                                  style: AppWidget.smallBoldTextFieledStyle(),
                                ),
                              ),
                              SizedBox(
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
                              SizedBox(
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
              padding: EdgeInsets.all(10),
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
              padding: EdgeInsets.all(10),
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
              padding: EdgeInsets.all(10),
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
