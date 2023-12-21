import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/Ui/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sp = await SharedPreferences.getInstance();
  var myToken = sp.getString('token')??"";
  runApp( MyApp(myToken: myToken));
}

class MyApp extends StatelessWidget {
  final myToken;
  const MyApp({Key? key, required this.myToken}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do-App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green
      ),

      home: SplashScreen(token: myToken),
    );
  }
}
