import 'package:flutter/material.dart';

import '../color_app.dart';


class Textfieldcustom extends StatelessWidget {
  final String lableText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool? obSecure;
  final Widget? suffixIcon;

  const Textfieldcustom(
      {super.key,
        this.obSecure,
        this.suffixIcon,
      required this.lableText,
      required this.controller,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(

        style: TextStyle(
          fontSize:20,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),        obscureText: obSecure??false,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon:suffixIcon??const SizedBox() ,
          labelText: lableText,
          labelStyle: const TextStyle(
            fontSize: 18,  // Font size for the label
            fontWeight: FontWeight.w500, // Font weight for the label
            color: Colors.grey, // Label color
          ),

          errorStyle: const TextStyle(
            fontSize: 12.0, // Set the font size of the error text
            color: Colors.red, // Set the color of the error text
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue), // Change this to your desired color
          ),
          // To change the color when the text field is not focused
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue), // Change this to your desired color
          ),
          // To change the color when there's an error
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent), // Change this to your desired color
          ),
          // To change the color when focused and there is an error
          focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent), // Change this to your desired color
          ),
        ),
      ),
    );
  }
}
