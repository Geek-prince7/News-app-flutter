// import 'package:hive/hive.dart';
// part "cardmodel.g.dart";

// @HiveType(typeId: 0)
class CardModel {
  // @HiveField(0)
  final String id;
  // @HiveField(1)
  final String image;
  // @HiveField(2)
  final String title;
  // @HiveField(3)
  final String description;
  // @HiveField(4)
  final String url;
  // @HiveField(5)
  final String author;
  // final List<dynamic> category;
  // @HiveField(6)
  final String published;

  CardModel({required this.id,required this.image, required this.title, required this.url,required this.description,required this.author,required this.published});
  factory CardModel.fromJson(Map<String,dynamic> json){
    return CardModel(id: json['id'], image: json['image'], title: json['title'], url: json['url'], description: json['description'], author: json['author'], published: json['published']);
  }
}