import 'package:flutter/material.dart';
import 'package:Auctionza/ui/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

/*
void main() async =>
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(new MyApp());*/


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Auctionza',
      theme: new ThemeData(

        primarySwatch: Colors.blue,
      ),

      home: new LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}