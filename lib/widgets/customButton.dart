import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isHome;
  const CustomButton({
    super.key , required this.text , required this.onTap , required this.isHome});

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      onPressed: onTap,
      child: Text(
        text , 
        style: const TextStyle(
          fontSize:  16, 
          color: Colors.black,
        ),
      ),
    );
  }
}