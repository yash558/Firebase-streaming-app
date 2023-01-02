import 'package:flutter/material.dart';
import 'package:livestreamingapp/utils/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({required this.text, required this.onTap, super.key});
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: btnColor,
        minimumSize: const Size(double.infinity, 40),
      ),
      onPressed: onTap,
      child: Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
