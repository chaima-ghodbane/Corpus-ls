import 'package:flutter/material.dart';
import 'package:corpus_ls/View/home.dart';
import 'package:get/get.dart';

void main() {
  return runApp(const MaterialApp(
    home: Notifications(),
  ));
}

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(



      body: Container(
        margin: EdgeInsets.only(top: 40,left: 10),
        child: ListView(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child:Container(
                        child: Text("Notifications",style: TextStyle(color: const Color(0XFF646E82),fontSize: 18)),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child:
                        Container(
                          margin: EdgeInsets.only(right: 10),

                          child: IconButton(

                            icon: Icon(Icons.notifications_sharp),

                            iconSize: 30,
                            color: const Color(0XFF61DBD0),
                            onPressed: () {
                              Get.to(Notifications());
                            },

                          ),
                          decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(15),
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
                        )
                    ),


                  ],
                ),

                //////////////////////// 1st notification

                Container(
                  height: 90,
                  width: 300,
                  margin: EdgeInsets.only(top: 70),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(15),
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
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Container(
                        margin: EdgeInsets.only(left: 10),
                        height:50,
                        width: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/formateur1.jpg'),

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

                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10,left: 20),
                              width: 180,
                              child: Text("Admin a commenté votre vidéo"),
                            ),
                            Container(

                              child: Text("Il y a une minute                ",
                                  style: TextStyle( color: const Color(0xFF36ACEF))),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),


                ////////////////////////////////////////////
                /////////// 2bd notification



                Container(
                  height: 90,
                  width: 300,
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(15),
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
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Container(
                        margin: EdgeInsets.only(left: 10),
                        height:50,
                        width: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/formateur2.jpg'),

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

                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10,left: 20),
                              width: 180,
                              child: Text("Admin a commenté votre vidéo"),
                            ),
                            Container(

                              child: Text("Il y a une minute                ",style: TextStyle( color: const Color(0xFF36ACEF))),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),





                ////////////////////////////////////////////////
              ],
            ),

          ],
        ),
      ),










    );
  }
}
