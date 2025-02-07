import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isHome;
  const CustomButton({
    super.key , required this.text , required this.onTap ,  this.isHome = false});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return  ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          isHome ? width/5 : width,
         50)
      ),
      child:  Text(
        text , 
        style: const TextStyle(
          fontSize:  16, 
          color: Colors.black,
          fontWeight: FontWeight.w600
        ),
      ),
    );
  }
}