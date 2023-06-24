import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  final String? id;
  final String name;
  final String description;
  final String title;
  final String userid;


  const VideoModel({
    this.id,
    required this.description,
    required this.name,
    required this.title,
    required this.userid,

  });
  toJson()
  {
    return {
      'name':name,'title':title,'userid':userid,'description':description
    };

  }

  factory VideoModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>>document){
    final data =document.data();
    return VideoModel(
      id:document.id,
      title: data!['title'],
      name: data!['name'],
      userid:data! ['userid'],
      description:data! ['description'],
    );
  }

}