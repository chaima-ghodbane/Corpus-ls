import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:corpus_ls/View/home.dart';
import 'package:corpus_ls/View/newcompte.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  return runApp(const MaterialApp(
    home: se_connecter(),
  ));
}



class se_connecter extends StatefulWidget {
  const se_connecter({Key? key}) : super(key: key);

  @override
  State<se_connecter> createState() => _se_connecterState();
}

class _se_connecterState extends State<se_connecter> {
  @override
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();

  Widget build(BuildContext context) {


    return Scaffold(
      body:
      ListView(
          children: [
            Column(

              children: [
                Container(



                  child :
                  Column(
                    children: [

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



                            // container de emaaaaaaaaaaiiiiiiillllllllll
                            Container(
                              margin : EdgeInsets.only(top:30,left: 20),
                              child:

                              Text('email'.tr,style: TextStyle(fontSize: 17,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0XFF646E82)),),

                            ),
                            // container de text box
                            Container(
                              margin : EdgeInsets.only(top:20,left: 15,right: 15),

                              child: TextField(
                                controller: EmailController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(15, 8, 0, 8),

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


                            // container mottt de paaaaaaassssssseee
                            Container(
                              margin : EdgeInsets.only(top:30,left: 20),
                              child:
                              Text('pw'.tr,style: TextStyle(fontSize: 17,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0XFF646E82))),

                            ),

                            // container de text box
                            Container(
                              margin : EdgeInsets.only(top:20,left: 15,right: 15),

                              child: TextField(
                                obscureText: true,
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




                            // container de text box



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
                                onPressed:() {
                                  try{
                                    FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                      email: EmailController.text,
                                      password: PasswordController.text,
                                    )
                                        .then((value) {
                                      Get.to(MyHomePage());
                                    });
                                  }
                                  catch(e)
                                  {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Sign-In Failed'),
                                          content: Text(e.toString()),
                                          actions: [
                                            TextButton(
                                              child: Text('OK'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );

                                  }



                                },
                                child: Text('connecter'.tr,style: TextStyle(fontSize: 15)),
                              ),
                            ),

                            Container(
                                margin: EdgeInsets.only(top: 20),
                                child:Center(

                                  child:  GestureDetector(
                                    onTap: () {
                                      Get.to(Newcompte ());
                                    },
                                    child: Text('noacc'.tr),

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