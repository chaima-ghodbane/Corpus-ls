import 'package:flutter/material.dart';
import 'package:corpus_ls/View/notifications.dart';
import 'package:get/get.dart';
//import 'package:corpus_ls/View/try.dart';


void main() {
  return runApp( MaterialApp(
    home: Membres(),
  ));
}

class Membres extends StatefulWidget {
  const Membres({Key? key}) : super(key: key);

  @override
  State<Membres> createState() => _MembresState();
}




class _MembresState extends State<Membres> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
     ListView(
       children: [
         Column(
           children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            child:    Row(

              children: [
                Container(
                  margin: EdgeInsets.only(left: 20),
                  height: 50,
                  width: 200,
                  child: Text("Liste des membres de formation",
                    style: TextStyle(fontSize: 20,
                        color: const Color(0XFF646E82),
                       // fontFamily:'Poppins-Bold',
                      fontWeight: FontWeight.bold,),
                  ),
                ),
                SizedBox(width: 80,),
                Container(

                  child: IconButton(


                    icon: Icon(Icons.close,size: 30),

                    iconSize: 30,
                    color: Colors.grey,
                    onPressed: () {
                      Get.back();
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
                ),

              ],
            ),

          ),
             Container(
               margin: EdgeInsets.only(top: 70,left: 20,right: 20),
               child: Column(
                 children: [
                   Container(

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
                     child:Column(
                       children: [
                         Row
                         (
                         children: [
                           Container(


                             width:55,
                             height :55,
                             margin: EdgeInsets.only(left: 10,bottom: 10),
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
                             margin: EdgeInsets.only(left: 25),
                             child: Text("Nom et prénom"),
                           ),

                         ],
                       ),
                         Divider(
                           color: Colors.grey,
                           thickness: 0.3,
                         ),
                         Row
                           (
                           children: [
                             Container(

                               width:55,
                               height :55,
                               margin: EdgeInsets.only(left: 10,bottom: 10),
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
                               margin: EdgeInsets.only(left: 25),
                               child: Text("Nom et prénom"),
                             ),



                           ],
                         ),
                         Divider(
                           color: Colors.grey,
                           thickness: 0.3,
                         ),
                         Row
                           (
                           children: [
                             Container(


                               width:55,
                               height :55,
                               margin: EdgeInsets.only(left: 10,bottom: 10),
                               decoration: BoxDecoration(
                                 image: DecorationImage(
                                   image: AssetImage('assets/images/formation1.jpg'),

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
                               margin: EdgeInsets.only(left: 25),
                               child: Text("Nom et prénom"),
                             ),

                           ],
                         ),
                         Divider(
                           color: Colors.grey,
                           thickness: 0.3,
                         ),
                         Row
                           (
                           children: [
                             Container(


                               width:55,
                               height :55,
                               margin: EdgeInsets.only(left: 10,bottom: 10),
                               decoration: BoxDecoration(
                                 image: DecorationImage(
                                   image: AssetImage('assets/images/pdp.jpg'),

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
                               margin: EdgeInsets.only(left: 25),
                               child: Text("Nom et prénom"),
                             ),

                           ],
                         ),

                       ],
                     )
                   ),


                 ],
               ),
             )
           ],
         ),
       ],
     )
    );
  }
}
