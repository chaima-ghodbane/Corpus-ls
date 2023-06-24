import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:corpus_ls/View/profile.dart';

import 'package:corpus_ls/View/home.dart';
import 'package:corpus_ls/View/notifications.dart';
import 'package:get/get.dart';

import 'inscription.dart';

void main() {
  return runApp( MaterialApp(

    home: Settings(),
  ));
}



class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  bool _isSwitched = true;
  bool _isSwitched1 = true;



  @override
  Widget build(BuildContext context) {


    return Scaffold(


      body: Container(

        child: ListView(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 290),

                    Container(
                      margin: EdgeInsets.only(top: 30),
                      height: 60,

                      child: IconButton(


                        icon: Icon(Icons.notifications_sharp),

                        iconSize: 30,
                        color: Colors.grey,
                        onPressed: () {
                          Get.to(Notifications());
                        },

                      ),
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(15),
                          color:const Color(0xFFEFEEF3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300]!,
                            blurRadius: 10,
                            offset: Offset(5, 5),
                          ),
                          BoxShadow( color: Colors.white, blurRadius: 10, offset: Offset(-5, -5), ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 100,),



                //////////////////////////////////////****************************





                Row(
                  children: [
                    Expanded(
                      flex : 1,
                      child: Container(
                        margin: EdgeInsets.only(top: 30,left: 20),

                        child: Text('Langue'.tr),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(top: 30,right: 3,left: 40),
                        padding: EdgeInsets.only(left: 5),


                        child: Container

                          (

                          padding: EdgeInsets.only(left: 7),
                         child : DropdownButton(
                           value: Get.locale?.languageCode,
                           items: [
                             DropdownMenuItem(
                               child: Text('English'),
                               value: 'en',
                             ),
                             DropdownMenuItem(
                               child: Text('Français'),
                               value: 'fr',
                             ),
                           ],
                           onChanged: (value) {
                             if (value == 'en') {
                               Get.updateLocale(Locale('en', 'US'));
                             }
                             else if (value == 'fr') {
                               Get.updateLocale(Locale('fr', 'FR'));
                             }
                             print(Get.locale); // Add this line to check the locale
                           },
                         ),


                          height: 35,
                          width: 120,
                        ),




                        decoration: BoxDecoration(


                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xFFEFEEF3) ,
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

                  ],
                ),






                ////////////////////***************************


                Row(
                  children: [
                    Expanded(
                      flex : 1,
                      child: Container(

                        margin: EdgeInsets.only(top: 30,left: 20),
                        child: Text('notifications'.tr),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(

                        margin: EdgeInsets.only(left: 130,top: 20),


                        child: Switch(
                          value: _isSwitched,
                          onChanged: ( bool value) {
                            print("Switch changed to $value");
                            setState(() {
                              _isSwitched = value;
                            });
                          },
                        ),
                      ),
                    ),

                  ],
                ),



                //////////////////////////////

                Row(
                  children: [
                    Expanded(
                      flex : 1,
                      child: Container(
                        margin: EdgeInsets.only(top: 30,left: 20),


                        child: Text('darkmode'.tr),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(left: 130,top: 20),
                        child: Switch(
                          value: _isSwitched1,
                          onChanged: (bool value1) {
                            print("Switch changed to $value1");
                            setState(() {
                              _isSwitched1 = value1;
                            });
                          },
                        ),
                      ),
                    ),




                  ],
                ),

                //////////////////////

                Container(

                  margin: EdgeInsets.only(left: 20),
                  child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Text('Déconnexion'),
                    ),
                    Expanded(
                        flex: 1,
                        child: IconButton(
                            onPressed: ()
                            {
                              FirebaseAuth.instance.signOut().then((value) {
                                Get.to(se_connecter());
                                print("Signed out");
                              });
                              
                            },
                            icon: Icon(Icons.logout),

                        )
                    )
                  ],
                ),)



              ],
            )
          ],
        ),


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


                    icon: Icon(Icons.home),

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

                    icon: Icon(Icons.settings,color: const Color(0xFF05acb2),),

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
