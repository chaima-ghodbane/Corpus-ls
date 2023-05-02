import 'package:flutter/material.dart';
import 'package:corpus_ls/View/notifications.dart';
import 'package:get/get.dart';

void main() {
  return runApp(const MaterialApp(
    home: Settings(),
  ));
}


class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    String? dropdownValue = '  Selectionner  ';
    bool _isSwitched = false;

    return Scaffold(


      body: Container(
        color:const Color(0xFFEFEEF3),
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
                      flex : 2,
                      child: Container(
                        margin: EdgeInsets.only(top: 30,left: 20,),

                        child: Text("Choisir la langue"),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(top: 30,right: 3,),


                        child: DropdownButton<String>(
                          underline: null,
                          value: dropdownValue,
                          icon: Icon(Icons.arrow_drop_down_outlined,color: const Color(0xFF36ACEF) ,),
                          iconSize: 24,

                          elevation: 16,
                          style: TextStyle(color: const Color(0xFF646E82) ),

                          onChanged: ( newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });

                          },


                          items: <String>['  Selectionner  ', 'Français', 'Anglais', 'Espagnol']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          })
                              .toList(),
                        ),

                        height: 35,
                        width: 125,



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
                        child: Text("Activer les notifications"),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(

                        margin: EdgeInsets.only(left: 130,top: 20),
                        child: Switch(
                          value: _isSwitched,
                          onChanged: (bool value) {
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


                        child: Text("Activer le dark mode"),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(left: 130,top: 20),
                        child: Switch(
                          value: _isSwitched,
                          onChanged: (bool value) {
                            setState(() {
                              _isSwitched = value;
                            });
                          },
                        ),
                      ),
                    ),

                  ],
                )

                //////////////////////



              ],
            )
          ],
        ),

      )




    );
  }
}
