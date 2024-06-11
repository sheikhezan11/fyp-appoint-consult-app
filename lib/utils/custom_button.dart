
import 'package:flutter/material.dart';



// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final bool isLoading;
  dynamic icon;
  // ignore: prefer_typing_uninitialized_variables
  final width;
  // ignore: prefer_typing_uninitialized_variables
  final height;
  String buttonTitle;
  Color clr,textClr;

 final dynamic ontapp;
  CustomButton(
      {super.key,
      required this.clr,
      required this.textClr,
      // required this.fontclr,
      this.icon,
      required this.buttonTitle,
      required this.width,
       this.isLoading = false,
      required this.height,
      required this.ontapp});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: ontapp,
      child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: clr,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade600,
                  spreadRadius: 0.05,
                  blurRadius: 2,
                  offset: const Offset(0, 0.45))
            ],
            borderRadius: BorderRadius.circular(7),
          ),
          child: Center(
            child:  isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
              buttonTitle,
              style: const TextStyle(fontSize: 20,color: Colors.white),
            ),
          ),
        
      ),
    );
  }
}