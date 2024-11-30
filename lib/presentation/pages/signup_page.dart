import 'package:flutter/material.dart';
import 'package:tiziappp2/presentation/pages/login_page.dart';

import '../../technicals/widgets/supportwidget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF757575),
                    Color(0xFF424242),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 3,
              ),
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Text(
                "",
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 60.0,
                left: 20.0,
                right: 20.0,
              ),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Tizi",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Sign Up",
                            style: AppWidget.boldTextFieledStyle(),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Create username',
                              hintStyle: AppWidget.smallBoldTextFieledStyle(),
                              prefixIcon: Icon(
                                Icons.person,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter email',
                              hintStyle: AppWidget.smallBoldTextFieledStyle(),
                              prefixIcon: Icon(
                                Icons.email,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Create password',
                              hintStyle: AppWidget.smallBoldTextFieledStyle(),
                              prefixIcon: Icon(
                                Icons.password,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 60.0,
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(20),
                            elevation: 5,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              width: 200,
                              decoration: BoxDecoration(
                                color: Color(0xFF454545),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  "SIGN UP",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Already have an account? Log In",
                      style: AppWidget.smallBoldTextFieledStyle(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
