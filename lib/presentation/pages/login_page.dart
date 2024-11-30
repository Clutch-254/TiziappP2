import 'package:flutter/material.dart';
import 'package:tiziappp2/technicals/widgets/supportwidget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                            "Log In",
                            style: AppWidget.boldTextFieledStyle(),
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
                              hintText: 'Enter password',
                              hintStyle: AppWidget.smallBoldTextFieledStyle(),
                              prefixIcon: Icon(
                                Icons.password,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            child: Text(
                              "Forgot password?",
                              style: AppWidget.smallBoldTextFieledStyle(),
                            ),
                          ),
                          SizedBox(
                            height: 50.0,
                          ),
                          Material(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              width: 200,
                              decoration: BoxDecoration(
                                color: Color(0xFF454545),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  "LOG IN",
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
                  Text(
                    "Don't have an account? Sign Up",
                    style: AppWidget.smallBoldTextFieledStyle(),
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
