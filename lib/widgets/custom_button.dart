import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.buttonText,
      required this.onPressed,
      required this.backgroundColor,
      required this.textColor, this.buttonWidth, this.textSize});
  final String buttonText;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double? buttonWidth;
  final double? textSize;


  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          minimumSize:  Size(buttonWidth ?? 120, 50),
         
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(2))),
      child: Text(
        buttonText,
        style:  TextStyle(fontSize: textSize ?? 22, fontWeight: FontWeight.w500),
      ),
    );
  }
}
