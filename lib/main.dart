import 'package:flutter/material.dart';
import 'package:news_app/Bookmark.dart';
import 'package:news_app/Home.dart';
import 'package:news_app/Search.dart';



void main() async {
  // await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier=ValueNotifier(ThemeMode.light);
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: themeNotifier, builder: (_,ThemeMode currentMode,__){
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        darkTheme: ThemeData.dark(),
        themeMode: currentMode,
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(title: 'Latest News'),
        routes: {
          "search":(context)=>SearchPage(title:"Search"),
          "home":(context)=>MyHomePage(title: "Latest News"),
          "bookmark":(context)=>BookmarkPage(title:"Saved"),
        },
      );

    });
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   debugShowCheckedModeBanner: false,
    //   home: const MyHomePage(title: 'Latest News'),
    //   routes: {
    //     "search":(context)=>SearchPage(title:"Search"),
    //     "home":(context)=>MyHomePage(title: "Latest News"),
    //     "bookmark":(context)=>BookmarkPage(title:"Saved"),
    //   },
    // );
  }
}




