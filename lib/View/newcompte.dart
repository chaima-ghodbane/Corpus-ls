import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:corpus_ls/View/home.dart';
import 'package:corpus_ls/View/inscription.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart' as flutter;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';


class Newcompte extends StatefulWidget {
  const Newcompte({Key? key}) : super(key: key);

  @override
  State<Newcompte> createState() => _NewcompteState();
}



class _NewcompteState extends State<Newcompte> {

  @override
  final TextEditingController NomController = TextEditingController();
  final TextEditingController PrenomController = TextEditingController();
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();
  final CollectionReference _UserCollection =
  FirebaseFirestore.instance.collection('utilisateurs');


  void _addUser() async {


    User? user = FirebaseAuth.instance.currentUser;
    if (NomController !='' && PrenomController!='' && EmailController != '' && PrenomController!='') {
      try {
        await _UserCollection.add({'name': NomController.text,'password':PasswordController.text ,'lastname': PrenomController.text,'Email':EmailController.text,'ID':user?.uid});
        print('Video added successfully!');
      } catch (e) {
        print('Error adding video: $e');
      }
    } else
    {
      print('User is not authenticated.');
    }
  }


  Widget build(BuildContext context) {
    return Scaffold(
        body:
        ListView(
            children: [
         Column(

             children: [
               Container(

                // height: MediaQuery.of(context).size.height,

                 child :
                 Column(
                   children: [
                     // first container having the image
                     Center(
                       child: Container(
                         margin: EdgeInsets.only(top:60,bottom: 60),
                         width: 250,
                         height: 200,


                         decoration: BoxDecoration(
                           image: DecorationImage(

                             image: AssetImage('assets/images/logo.jpeg'),

                           ),
                           borderRadius: BorderRadius.circular(70),
                           color: Colors.white,
                           boxShadow: [
                             BoxShadow(
                               color: Colors.grey[300]!,
                               blurRadius: 10,
                               offset: Offset(5, 5),
                             ),
                             BoxShadow(
                               color: Colors.white,
                               blurRadius: 10,
                               offset: Offset(-5, -5),
                             ),
                           ],
                         ),

                       ),
                     ),


                     //2nd container having the text and the text box
                     Container(
                       padding: EdgeInsets.only(bottom: 50),

                       width: MediaQuery.of(context).size.width,


                       decoration: BoxDecoration(

                         //borderRadius: BorderRadius.circular(20),
                         color: Colors.white,
                         boxShadow: [
                           BoxShadow(
                             color: Colors.grey[300]!,
                             blurRadius: 10,
                             offset: Offset(5, 5),
                           ),
                           BoxShadow(
                             color: Colors.white,
                             blurRadius: 10,
                             offset: Offset(-5, -5),
                           ),
                         ],
                       ),

                       child: Column(

                         crossAxisAlignment: CrossAxisAlignment.start,

                         children: [
                           // container de text


                           /////////////////// Nommmmmmmmmmmmmmmm
                           Container(
                             margin : EdgeInsets.only(top:30,left: 20),
                             child:
                             Text("Nom",style: TextStyle(fontSize: 17,
                                 fontStyle: FontStyle.italic,
                                 color: Color(0XFF646E82))),

                           ),
                           // container de text box
                           Container(
                             margin : EdgeInsets.only(top:20,left: 15,right: 15),

                             child: TextField(
                               controller: NomController,
                               decoration: InputDecoration(
                                 contentPadding: EdgeInsets.fromLTRB(15, 8, 0, 8),
                                 //hintText: 'Nom.prenom@gmail.com',
                                 suffixIcon: Icon(Icons.family_restroom),
                                 hintStyle: TextStyle(
                                   color: Colors.grey,
                                 ),
                                 border: InputBorder.none,
                               ),
                             ),

                             decoration: BoxDecoration(


                               borderRadius: BorderRadius.circular(15),
                               color: Colors.white,
                               boxShadow: [
                                 BoxShadow(
                                   color: Colors.grey,
                                   blurRadius: 3,
                                   offset: Offset(5, 5),
                                 ),
                                 BoxShadow(
                                   color: Colors.white,
                                   blurRadius: 10,
                                   offset: Offset(5, 5),
                                 ),
                               ],
                             ),
                           ),

                           // container prenommmmmmmmmmmmmmmmm
                           Container(
                             margin : EdgeInsets.only(top:30,left: 20),
                             child:
                             Text("Prénom",style: TextStyle(fontSize: 17,
                                 fontStyle: FontStyle.italic,
                                 color: Color(0XFF646E82))),

                           ),

                           // container de text box
                           Container(
                             margin : EdgeInsets.only(top:20,left: 15,right: 15),

                             child: TextField(
                               controller: PrenomController,
                               decoration: InputDecoration(
                                 contentPadding: EdgeInsets.fromLTRB(15, 8, 0, 8),
                                 //hintText: 'Nom.prenom@gmail.com',
                                 suffixIcon: Icon(Icons.person),
                                 hintStyle: TextStyle(
                                   color: Colors.grey,
                                 ),
                                 border: InputBorder.none,
                               ),
                             ),

                             decoration: BoxDecoration(


                               borderRadius: BorderRadius.circular(15),
                               color: Colors.white,
                               boxShadow: [
                                 BoxShadow(
                                   color: Colors.grey,
                                   blurRadius: 3,
                                   offset: Offset(5, 5),
                                 ),
                                 BoxShadow(
                                   color: Colors.white,
                                   blurRadius: 10,
                                   offset: Offset(5, 5),
                                 ),
                               ],
                             ),
                           ),

                           // container de emaaaaaaaaaaiiiiiiillllllllll
                           Container(
                             margin : EdgeInsets.only(top:30,left: 20),
                             child:
                             Text("Adresse e-mail",style: TextStyle(fontSize: 17,
                                 fontStyle: FontStyle.italic,
                                 color: Color(0XFF646E82))),

                           ),
                           // container de text box
                           Container(
                             margin : EdgeInsets.only(top:20,left: 15,right: 15),

                             child: TextField(
                               controller: EmailController,
                               decoration: InputDecoration(
                                 contentPadding: EdgeInsets.fromLTRB(15, 8, 0, 8),
                                 //hintText: 'Nom.prenom@gmail.com',
                                 suffixIcon: Icon(Icons.mail),
                                 hintStyle: TextStyle(
                                   color: Colors.grey,
                                 ),
                                 border: InputBorder.none,
                               ),
                             ),

                             decoration: BoxDecoration(


                               borderRadius: BorderRadius.circular(15),
                               color: Colors.white,
                               boxShadow: [
                                 BoxShadow(
                                   color: Colors.grey,
                                   blurRadius: 3,
                                   offset: Offset(5, 5),
                                 ),
                                 BoxShadow(
                                   color: Colors.white,
                                   blurRadius: 10,
                                   offset: Offset(5, 5),
                                 ),
                               ],
                             ),
                           ),



                           // container de text box


                           Container(
                             margin : EdgeInsets.only(top:30,left: 20),
                             child:
                             Text("Mot de passe",style: TextStyle(fontSize: 17,
                                 fontStyle: FontStyle.italic,
                                 color: Color(0XFF646E82))),

                           ),
                           // container de text box
                           Container(
                             margin : EdgeInsets.only(top:20,left: 15,right: 15),

                             child: TextField(
                               controller: PasswordController,
                               decoration: InputDecoration(
                                 contentPadding: EdgeInsets.fromLTRB(15, 8, 0, 8),

                                 suffixIcon: Icon(Icons.password),
                                 hintStyle: TextStyle(
                                   color: Colors.grey,
                                 ),
                                 border: InputBorder.none,
                               ),
                             ),

                             decoration: BoxDecoration(


                               borderRadius: BorderRadius.circular(15),
                               color: Colors.white,
                               boxShadow: [
                                 BoxShadow(
                                   color: Colors.grey,
                                   blurRadius: 3,
                                   offset: Offset(5, 5),
                                 ),
                                 BoxShadow(
                                   color: Colors.white,
                                   blurRadius: 10,
                                   offset: Offset(5, 5),
                                 ),
                               ],
                             ),
                           ),
                           ///////////////////////////////////////////////



                           Container(
                             margin: EdgeInsets.only(top: 60,left: 80),
                             width: 200,
                             height: 50,

                             child: ElevatedButton(

                               style: ElevatedButton.styleFrom(
                                 backgroundColor: const Color(0xFF05acb2),
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(20),
                                 ),
                               ),
                               onPressed: () async {
                                    if (NomController !='' && PrenomController!='' && EmailController != '' && PrenomController!='')
                                      {
                                        final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword
                                          (email: EmailController.text,
                                            password: PasswordController.text).then((value)
                                        {
                                          print("user created succefully");
                                          Get.to(MyHomePage());
                                        }).onError((error, stackTrace) {
                                          print("Error ${error.toString()}");
                                        }
                                        );
                                      }

                                 _addUser();

                               },
                               child: Text('Créer',style: TextStyle(fontSize: 15)),
                             ),
                           ),

                           Container(
                               margin: EdgeInsets.only(top: 20),
                               child:Center(

                                 child:  GestureDetector(
                                   onTap: () {
                                     Get.to(se_connecter ());
                                   },
                                   child: Text("J'ai déjà un compte"),

                                 ),
                               )
                           )




                         ],

                       ),
                     ),

                   ],
                 ),

               ),

             ],
         ),
    ]

         ),
    );


  }
}
