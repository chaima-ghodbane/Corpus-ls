import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
   final String? id;
   final String name;
   final String lastname;
   final String email;


  const UserModel({
    this.id,
    required this.email,
    required this.name,
    required this.lastname,

});
  toJson()
  {
    return {
    'name':name,'lastname':lastname,'Email':email
  };

}

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>>document){
    final data =document.data();
    return UserModel(
        id:document.id,
        email: data!['Email'],
        name: data!['name'],
        lastname:data! ['lastname'],
    );
  }

}