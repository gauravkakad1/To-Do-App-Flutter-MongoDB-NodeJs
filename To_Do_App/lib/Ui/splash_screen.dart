import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'login_screen.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Ui/home_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatefulWidget {
  final token;
  const SplashScreen({super.key,required this.token});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState(){
    // TODO: implement initState


    Timer(Duration(seconds: 3), () {
      if(widget.token!=null && JwtDecoder.isExpired(widget.token)==false){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen(token: widget.token) ));
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen() ));

      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage('images/ToDoAppLogo.png'),height: 200,width: 200,),
              Text('\nTo-Do App').text.bold.black.headline6(context).teal700.size(45).makeCentered(),
            ],
          ),
        )
    );
  }
}
