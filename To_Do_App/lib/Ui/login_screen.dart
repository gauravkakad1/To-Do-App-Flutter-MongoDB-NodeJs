import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/Components/round_button.dart';
import 'package:to_do_app/Ui/home_screen.dart';
import 'signup_screen.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:to_do_app/config/config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isValid = true;
  late SharedPreferences sp;
  void initSharedpref()async{
     sp = await SharedPreferences.getInstance();
  }
  @override
  void initState() {
    // TODO: implement initState
    initSharedpref();
    super.initState();
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void loginUser()async{
    print("loginUser function called");

    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
      var reqUser = {
        "email":emailController.text,
        "password":passwordController.text
      };
      var response = await http.post(Uri.parse(loginUrl),
          headers: {"Content-Type":"application/json"},
          body: jsonEncode(reqUser)
      );
      print(response);
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);
      if(jsonResponse['status']){
        var mytoken = jsonResponse['token'];
        sp.setString('token', mytoken);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(token: mytoken,)));
      }else{
        print('Something went wrong');
      }

       setState(() {
        isValid= true;
      });

    }else{
      setState(() {
        isValid = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("Login Screen"),
            backgroundColor: Color(0xFF49a078),
          ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 50,),
              Image.asset('images/ToDoAppLogo.png',height: 150,width: 150,),
              SizedBox(height: 50,),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  prefixIcon: Icon(Icons.email_outlined,),
                  filled: true,
                    hintText: "abc@gmail.com",
                    labelText: "Enter your email",
                  errorText: isValid?null:"Enter correct email",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color : Color(0xFF0077b6)), // Border color when focused
                  ),

                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  prefixIcon: Icon(Icons.lock_open),
                  iconColor: Colors.red,
                  filled: true,
                  hintText: "password",
                  labelText: "Password",
                  errorText: isValid?null:"Enter correct password",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color : Color(0xFF0077b6)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color : Color(0xFF0077b6)), // Border color when focused
                  ),
                ),
              ),
              SizedBox(height: 40,),
              RoundButton(name: "Login", onpress: (){
                loginUser();
              }),
              SizedBox(height :10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an Account ? ").text.bold.bodyText1(context).makeCentered(),
                  InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                      },
                      child: Text("Sign Up").text.bold.bodyText1(context).makeCentered()),
                ],
              )
            ],
          ),
        ),
      )
    ));
  }
}
