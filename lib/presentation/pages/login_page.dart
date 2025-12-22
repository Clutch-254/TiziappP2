import 'package:flutter/material.dart';
import 'package:tiziappp2/presentation/pages/signup_page.dart';
import 'package:tiziappp2/technicals/widgets/button.dart';
import 'package:tiziappp2/technicals/widgets/supportwidget.dart';

import '../../technicals/bottomnav.dart';
import '../../technicals/widgets/authentication.dart';
import '../../technicals/widgets/snack_bar.dart';
import '../../technicals/widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

        @override
    // ignore: unused_element
    void despose(){
      super.dispose();
      emailController.dispose();
      passwordController.dispose();
    }
    
      void loginUser() async {
      // Firebase disabled - bypass authentication
      // String res = await AuthenServ().loginUser(
      //   email: emailController.text,
      //   password: passwordController.text,
      // );

      // Auto-login without Firebase
      String res = "Success!";

      //if log in is successful user navigates to homepage else error message displayed
      if (res == "Success!") {
        setState(() {
          isLoading = true;
        });
        //navigate to homepage
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Bottomnav(),
          ),
        );
      }else {
        setState(() {
          isLoading = false;
        });
        //displays error
        showSnackBar(context, res);
      }
    }

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
                isPass: true,
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
              ThisButton(onTab: loginUser, text: "Log In"),
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
