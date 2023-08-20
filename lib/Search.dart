import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:news_app/News.dart';
import 'package:news_app/cardModel.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/SwipeCard.dart';
import 'package:news_app/cardModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.title});
  final String title;

  @override
  State<SearchPage> createState() => _SearchPageState();
}
class _SearchPageState extends State<SearchPage> {
  late List<CardModel> cards=[];
  String keywords="";

  Future<void> callAPI()async{
    http.Response response;

    final prefs=await SharedPreferences.getInstance();
    prefs.setString("token", "TkTN5N_Vo2eHqbXpyu2P5r3Xw0YNkib8QEWrqmVkMIf3YV9J");
    String key=keywords==""?"":"&keywords="+keywords;
    String url='https://api.currentsapi.services/v1/search?apiKey=${prefs.getString('token')}'+key;
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
  void filterItems(String query) {
    keywords=query;
    callAPI();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: cards.length == 0 ? Center(child: Text("error occured!"),) : SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            TextField(
              onChanged: filterItems,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),),
            Container(
              height: MediaQuery.of(context).size.height/1.37,
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