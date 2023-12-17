import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("To-Do App",style: TextStyle(fontWeight: FontWeight.bold,)),
            backgroundColor: Colors.amberAccent,
            centerTitle: true,
          ),
          body: Container(),
        )
    );
  }
}
