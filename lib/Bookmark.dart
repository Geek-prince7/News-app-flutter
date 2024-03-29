import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/cardModel.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:news_app/SwipeCard.dart';
import 'package:news_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key, required this.title});
  final String title;

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}
class _BookmarkPageState extends State<BookmarkPage> {
  late List<CardModel> cards=[];
  String keywords="";

  Future<void> callAPI()async{
    final prefs=await SharedPreferences.getInstance();
    Set<String> keys=prefs.getKeys();
    // List<CardModel> mycard=[];
    for(var key in keys){
      if(key.contains('data-'))
      {
        String? val=prefs.getString(key);
        if(val!=null){
          CardModel obj=CardModel.fromJson(jsonDecode(val) );
          cards.add(obj);

        }

      }

    }

    setState(() {

    });


  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callAPI();

  }
  void filterItems(String query) {
    keywords=query;
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
      body: cards.length == 0 ? Center(child: Text("error occured!"),) : SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            // TextField(
            //   onChanged: filterItems,
            //   decoration: InputDecoration(
            //     labelText: 'Search',
            //     prefixIcon: Icon(Icons.search),
            //     border: OutlineInputBorder(),
            //   ),),
            Container(
              height: MediaQuery.of(context).size.height/1.3,
              child: Swiper(
                itemCount: cards.length,
                itemBuilder: (BuildContext context, int index) {
                  return SwipeCard(card: cards[index]);
                },
                loop: false,
                layout: SwiperLayout.STACK,
              ),
            ),

          ],
        ),
      ),
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
                Navigator.of(context).pushNamed("home");

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