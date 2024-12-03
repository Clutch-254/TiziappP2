import 'package:flutter/material.dart';

class TextFieldIn extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final IconData icon;

  const TextFieldIn({
    super.key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: TextField(
        obscureText: isPass,
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color.fromARGB(128, 88, 86, 86),
            fontSize: 18,
          ),
          prefixIcon: Icon(
            icon,
            color: const Color.fromARGB(255, 78, 76, 76),
          ),
          contentPadding: const EdgeInsetsDirectional.symmetric(
              vertical: 15, horizontal: 20),
          border: InputBorder.none,
          filled: true,
          fillColor: const Color.fromARGB(255, 224, 219, 219),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 3,
              color: Color.fromARGB(128, 85, 82, 82),
            ),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
