import 'package:flutter/material.dart';
import 'package:tiziappp2/presentation/pages/signup_page.dart';
import 'package:tiziappp2/technicals/widgets/button.dart';
import 'package:tiziappp2/technicals/widgets/supportwidget.dart';

import '../../technicals/widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height / 2.7,
                width: double.infinity,
                child: Image.asset("Images/logo.png"),
              ),
              TextFieldIn(
                textEditingController: emailController,
                hintText: "Enter email",
                icon: Icons.email,
              ),
              TextFieldIn(
                textEditingController: passwordController,
                hintText: "Enter password",
                icon: Icons.lock,
              ),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot password?",
                    style: AppWidget.smallBoldTextFieledStyle(),
                  ),
                ),
              ),
              ThisButton(onTab: () {}, text: "Log In"),
              SizedBox(height: height / 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Dont have an account? ",
                    style: AppWidget.smallBoldTextFieledStyle(),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
