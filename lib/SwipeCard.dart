import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news_app/cardModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SwipeCard extends StatelessWidget {
  final CardModel card;

  SwipeCard({required this.card});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: card.image=="" || card.image==null || card.image=="None"?Container(child: Center(child: (Text("No image to show!")),),):Image.network(card.image, fit: BoxFit.cover),

              ),
              ListTile(
                title: Text(card.title),
                subtitle: Text(card.description),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Implement navigation or dialog to show full story
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(card.title),
                              content: Text(card.description),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Close'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('Read Full Story'),
                    ),
                    InkWell(onTap: () async{
                      // var box = await Hive.openBox('cards');
                      final prefs=await SharedPreferences.getInstance();
                      String? news=prefs.getString("data-"+card.id);
                      if(news!=null){
                        // final newsObject=jsonDecode(news);
                        await prefs.remove("data-"+card.id);


                        const snack=SnackBar(content: Text("removed"),);
                        ScaffoldMessenger.of(context).showSnackBar(snack);
                      }
                      else{
                        String newsJson=jsonEncode({"id":card.id,"description":card.description,"title":card.title,"image":card.image,"url":card.url,"author":card.author,"published":card.published});
                        await prefs.setString("data-"+card.id, newsJson);
                        const snack=SnackBar(content: Text("saved"),);
                        ScaffoldMessenger.of(context).showSnackBar(snack);
                      }


                      // print('message ------------------- ${msg}');



                    }, child: Icon(Icons.bookmark,color: Colors.blue,size: 35,),)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
