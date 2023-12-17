import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:to_do_app/Components/round_button.dart';
import 'package:to_do_app/Ui/login_screen.dart';
import 'package:to_do_app/config/config.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart'as http;


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isValid = true;

  void registerUser() async{
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
      var regBody = {
        "email":emailController.text,
        "password":passwordController.text
      };
      var response = await http.post(Uri.parse(registerationUrl),
          headers: {"Content-Type":"application/json"},
          body: jsonEncode(regBody)
      );
      var jsonResponse = jsonDecode(response.body);
      if(jsonResponse['status']){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      }else{
        print("SomeThing Went Wrong");
      }
      setState(() {
        isValid = true;
      });
    }else{
      setState(() {
        isValid = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("Sign Up screen"),

      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 50,),
              Image.asset('images/ToDoAppLogo.png', height: 150, width: 150,),
              SizedBox(height: 50,),
              "Create Account ".text
                  .headline5(context)
                  .bold
                  .uppercase
                  .make(),
              SizedBox(height: 10),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  prefixIcon: Icon(Icons.email_outlined,),
                  filled: true,
                  hintText: "xyz",
                  labelText: "Enter your name",
                  errorText: isValid ? null : "Enter correct name",

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                        color: Color(0xFF0077b6)), // Border color when focused
                  ),

                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  prefixIcon: Icon(Icons.email_outlined,),
                  filled: true,
                  hintText: "abc@gmail.com",
                  labelText: "Enter your email",
                  errorText: isValid ? null : "Enter correct email",

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                        color: Color(0xFF0077b6)), // Border color when focused
                  ),

                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  prefixIcon: Icon(Icons.lock_open),
                  iconColor: Colors.red,
                  filled: true,
                  hintText: "password",
                  labelText: "Password",
                  errorText: isValid ? null : "Enter correct password",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Color(0xFF0077b6)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                        color: Color(0xFF0077b6)), // Border color when focused
                  ),
                ),
              ),
              SizedBox(height: 40,),
              RoundButton(name: "Sign Up", onpress: () {
                registerUser();
              }, isLoading: false,),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an Account ? ").text.bold.bodyText1(
                      context).makeCentered(),
                  InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (
                            context) => LoginScreen()));
                      },
                      child: Text("Login").text.bold.bodyText1(context)
                          .makeCentered()),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}