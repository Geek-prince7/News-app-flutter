import 'package:flutter/material.dart';
import 'package:news_app/Bookmark.dart';
import 'package:news_app/Home.dart';
import 'package:news_app/Search.dart';



void main() async {
  // await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Latest News'),
      routes: {
        "search":(context)=>SearchPage(title:"Search"),
        "home":(context)=>MyHomePage(title: "Latest News"),
        "bookmark":(context)=>BookmarkPage(title:"Saved"),
      },
    );
  }
}




