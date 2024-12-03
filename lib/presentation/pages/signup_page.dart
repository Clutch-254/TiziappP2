import 'package:flutter/material.dart';
import 'package:tiziappp2/presentation/pages/login_page.dart';
import 'package:tiziappp2/technicals/widgets/text_field.dart';

import '../../technicals/widgets/button.dart';
import '../../technicals/widgets/supportwidget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height / 2.8,
                width: double.infinity,
                child: Image.asset("Images/logo.png"),
              ),
              TextFieldIn(
                textEditingController: nameController,
                hintText: "Create username",
                icon: Icons.person,
              ),
              TextFieldIn(
                textEditingController: emailController,
                hintText: "Enter email",
                icon: Icons.email,
              ),
              TextFieldIn(
                textEditingController: passwordController,
                hintText: "Enter password",
                icon: Icons.password,
              ),
              ThisButton(onTab: () {}, text: "Sign Up"),
              SizedBox(height: height / 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Alraedy have an account? ",
                    style: AppWidget.smallBoldTextFieledStyle(),
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
                      "Log In",
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
