import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String name;
  final VoidCallback onpress;
  final bool isLoading;

  const RoundButton({super.key, this.isLoading = false , required this.name , required this.onpress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child:Container(
        height: 50,width: 200,
        child: Center(
            child: isLoading?CircularProgressIndicator(color: Colors.white,):Text(name, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),
        decoration: BoxDecoration(color: Color(0xFF43aa8b),borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
