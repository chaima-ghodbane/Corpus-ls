import 'package:cloud_firestore/cloud_firestore.dart';

class ImageModel {
  final String? id;
  final String name;
  final String userid;


  const ImageModel({
    this.id,

    required this.name,

    required this.userid,

  });
  toJson()
  {
    return {
      'name':name,'userid':userid,
    };

  }

  factory ImageModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>>document){
    final data =document.data();
    return ImageModel(
      id:document.id,
      name: data!['name'],
      userid:data! ['userid'],
    );
  }

}