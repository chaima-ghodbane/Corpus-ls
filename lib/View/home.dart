import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:corpus_ls/View/formation1.dart';
import 'package:corpus_ls/View/settings.dart';
import 'package:corpus_ls/View/profile.dart';
import 'package:corpus_ls/View/formation2.dart';
import 'package:corpus_ls/View/notifications.dart';
import 'package:corpus_ls/translations/translations_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My App',
      home: MyHomePage(),
      translations: MyTranslations(),
      locale: Locale('en', 'US'),
      fallbackLocale: Locale('en', 'US'),


    );
  }
}
class MyHomePage extends StatelessWidget {
  @override
  final TextEditingController Motcle = TextEditingController();
  Widget build(BuildContext context) {
    return  Scaffold(

      body:
      ListView(
        children: [
          Container(

              child : Column (
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  ////////////////  Container qui contient la pdp et notif

                  Container(
                      child :
                      Row(

                          children: [


                           GestureDetector(
                             onTap:(){ Get.to(Profile());},
                             child:  Container(
                               margin: EdgeInsets.only(top: 30,left: 30),
                               height:70,
                               width: 70,
                               decoration: BoxDecoration(
                                 image: DecorationImage(
                                   image: AssetImage('assets/images/user.jpg'),

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


                            SizedBox(width: 200,),

                            Container(
                              margin: EdgeInsets.only(top: 30),
                              height: 60,


                              child: IconButton(
                                // padding: EdgeInsets.only(top: 75),

                                icon: Icon(Icons.notifications_sharp),

                                iconSize: 30,
                                color: Colors.grey,
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


                          ]
                      )
                  ),
                  SizedBox(height: 60),

                  Container(
                      margin: EdgeInsets.only(left: 30,bottom: 25),
                      width: 205,
                      height: 30,


                      child : Text('Mesformations'.tr,

                          style: TextStyle( fontSize: 25,
                              color: const Color(0xFF05acb2),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500))
                  ),

                 /* Container(
                    margin: EdgeInsets.only(left: 20,right: 20),
                    child:
                    Row(

                      children: [
                        Expanded(
                          child: TextField(
                            // controller: Motcle,

                            decoration: InputDecoration(
                              hintText: 'Recherche'.tr,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                            ),

                          ),
                        ),

                        IconButton(
                          onPressed: (){
                            //String Mymotcle = Motcle.text;
                            //print(Mymotcle);

                          },
                          icon: Icon(Icons.search),
                          color: const Color(0xFF05acb2),
                        ),
                      ],
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

                  */////////////////////////////////

                  //////////////// ///////////////////Les formations affichées****************//////////


                  Container(



                      margin: EdgeInsets.only(top: 14,bottom: 10),
                      padding: EdgeInsets.only(right: 15,left: 15,top: 15,bottom: 15),


                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,

                          children :[


                            /* ****first formation ********/

                            Container(


                              margin: EdgeInsets.only(right: 15),
                              padding: EdgeInsets.only(bottom: 2),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                width: 241,
                                height: 366,
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
                                child:
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(

                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(

                                          child: Image.asset(
                                            'assets/images/logo-learny-box.png',


                                            height:15.6,
                                            width: 76,
                                          ),


                                        ),

                                        SizedBox(width: 45),

                                        Container(
                                          width : 36,
                                          height : 28,
                                          child : Text("Jina Levant", style: TextStyle( fontSize: 12)),

                                        ),


                                        Container(

                                          width:40,
                                          height :40,
                                          margin: EdgeInsets.only(left: 10),
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



                                      ],
                                    ),




                                    Container(
                                      width :198,
                                      height :44 ,
                                      margin: EdgeInsets.only(top:30),

                                      child:   GestureDetector(
                                        onTap: () {
                                          Get.to(Formation1());
                                        },
                                        child: Text(
                                            'titreform1'.tr,
                                            style: TextStyle( fontSize: 18,
                                                color: const Color(0xFF05acb2),
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.w500)
                                        ),

                                      ),
                                    ),







                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: Text('description1'.tr,
                                          style: TextStyle( fontSize: 12,
                                              color: const Color(0xFF646E82),

                                              fontWeight: FontWeight.w500)),
                                    ),


                                    Container(
                                      margin: EdgeInsets.only(top:10),
                                      width: 233,
                                      height: 130,
                                      decoration: BoxDecoration(

                                        borderRadius: BorderRadius.circular(10.0),

                                      ),
                                      child: Center(
                                        child: InkWell(
                                            onTap: () {

                                              Get.to(Formation1());

                                            },
                                            child:

                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Image.asset(
                                                'assets/images/formation1.jpg',
                                                width: 200,
                                                height: 200,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),







                            ///////////////////// 2 eme formation$




                            Container(
                              padding: EdgeInsets.only(bottom: 2),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                width: 241,
                                height: 366,
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
                                child:
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(

                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(

                                          child: Image.asset(
                                            'assets/images/logo-learny-box.png',


                                            height:15.6,
                                            width: 76,
                                          ),


                                        ),

                                        SizedBox(width: 30),

                                        Container(
                                          width : 50,
                                          height : 28,
                                          child : Text("Jina Levant", style: TextStyle( fontSize: 12)),

                                        ),


                                        Container(

                                          width:40,
                                          height :40,
                                          margin: EdgeInsets.only(left: 10),
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




                                      ],
                                    ),
                                    Container(
                                      width :198,
                                      height :44 ,
                                      margin: EdgeInsets.only(top:30),


                                      child:   GestureDetector(
                                        onTap: () {
                                           Get.to(Formation2());
                                        },
                                        child: Text(
                                            'titreform2'.tr,
                                            style: TextStyle( fontSize: 18,
                                                color: const Color(0xFF05acb2),
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.w500)
                                        ),

                                      ),

                                    ),

                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text('description2'.tr,
                                          style: TextStyle( fontSize: 12,
                                              color: const Color(0xFF646E82),

                                              fontWeight: FontWeight.w500)),
                                    ),


                                    Container(
                                      margin: EdgeInsets.only(top:10),
                                      width: 233,
                                      height: 130,
                                      decoration: BoxDecoration(

                                        borderRadius: BorderRadius.circular(10.0),

                                      ),
                                      child: Center(
                                        child: InkWell(
                                            onTap: () {

                                               Get.to(Formation2());

                                            },
                                            child:

                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Image.asset(
                                                'assets/images/formation2.jpg',
                                                width: 200,
                                                height: 200,
                                                fit: BoxFit.cover,
                                              ),
                                            )


                                        ),
                                      ),


                                    ),

                                  ],
                                ),
                              ),
                            ),



                          ],

                        ),

                      )

                  ),



                ],



              )
          ),


        ],
      ),
      bottomNavigationBar: SizedBox(
          width: 200,

          child:

          Container(
            margin: EdgeInsets.only(left: 20,right: 20,bottom: 20),
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



            child:  Row(
              children: [
                Expanded(
                  child: IconButton(


                    icon: Icon(Icons.home,color: const Color(0xFF05acb2),),

                    iconSize: 30,
                    color: Colors.grey,
                    onPressed: () {
                      Get.to(MyHomePage());
                    },

                  ),
                ),

                Expanded(
                  child:  IconButton(
                    //padding: EdgeInsets.only(top: 75),

                    icon: Icon(Icons.person_2_rounded),

                    iconSize: 30,
                    color: Colors.grey,
                    onPressed: () {
                      Get.to(Profile());
                    },

                  ),
                ),
                Expanded(
                  child:  IconButton(
                    // padding: EdgeInsets.only(top: 75),

                    icon: Icon(Icons.settings),

                    iconSize: 30,
                    color: Colors.grey,
                    onPressed: () {
                      Get.to(Settings());
                    },

                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}






