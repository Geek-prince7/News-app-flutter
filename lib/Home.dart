import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/Drawer.dart';
import 'package:news_app/cardModel.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/SwipeCard.dart';
import 'package:news_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  late List<CardModel> cards=[];
  String category="";

  Future<void> callAPI()async{
    http.Response response;

    final prefs=await SharedPreferences.getInstance();
    prefs.setString("token", "TkTN5N_Vo2eHqbXpyu2P5r3Xw0YNkib8QEWrqmVkMIf3YV9J");
    String cat=category==""?"":"&category="+category;
    String url='https://api.currentsapi.services/v1/latest-news?apiKey=${prefs.getString('token')}'+cat;
    response=await http.get(Uri.parse(url));
    if(response.statusCode==200){
      setState(() {
        var mappedResp=json.decode(response.body);
        final List<dynamic> jsonData=mappedResp['news'];
        cards = jsonData.map((json) => CardModel.fromJson(json)).toList();

      });
    }
    else{
      print("failed");
    }


  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     callAPI();

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: (){
            MyApp.themeNotifier.value=MyApp.themeNotifier.value==ThemeMode.light?ThemeMode.dark:ThemeMode.light;
          },
              icon:Icon(MyApp.themeNotifier.value==ThemeMode.light?Icons.dark_mode:Icons.light_mode)
          )
        ],
      ),
      body: cards.length == 0 ? Center(child: Text("No data!"),) : Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height/1.35,
            child: Swiper(
              itemCount: cards.length,
              itemBuilder: (BuildContext context, int index) {
                return SwipeCard(card: cards[index]);
              },
              loop: false,
              layout: SwiperLayout.STACK,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: (){

                category="";
                callAPI();

              }, child: Text('none')),
              ElevatedButton(onPressed: (){
                // setState(() {
                  category="general";
                  callAPI();
                // });
              }, child: Text('general')),
              ElevatedButton(onPressed: (){
                // setState(() {
                  category="politics";
                  callAPI();
                // });
              }, child: Text('politics')),

            ],
          )
        ],
      ),
      drawer: const PersistDrawer(),
      bottomNavigationBar: Container(
        height: 60,

        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {

              },
              icon: const Icon(
                Icons.home_outlined,
                color: Colors.white,
                size: 35,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {

                Navigator.of(context).pushNamed("search");
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
                size: 35,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                Navigator.of(context).pushNamed("bookmark");

              },
              icon: const Icon(
                Icons.bookmark,
                color: Colors.white,
                size: 35,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {

              },
              icon: const Icon(
                Icons.person_outline,
                color: Colors.white,
                size: 35,
              ),
            ),
          ],
        ),
      ),

    );
  }
}