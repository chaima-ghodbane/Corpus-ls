import 'package:flutter/material.dart';
import 'package:corpus_ls/View/notifications.dart';
import 'package:get/get.dart';

void main() {
  return runApp(const MaterialApp(
    home: Profile(),
  ));
}

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  String? dropdownValue = '  Selectionner  ';
  Widget build(BuildContext context) {
    return Scaffold(

      body:

       ListView(
         children: [
           Column(

               children: [

                 Row(

                   mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                     Container(


                       margin: EdgeInsets.only(right: 20,top: 40),
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
                           ]
                       ),
                     ),
                   ],
                 ),

                 Container(
                   margin: EdgeInsets.only(top: 30,left: 30),
                   height:100,
                   width: 100,
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
                   margin: EdgeInsets.only(top: 20,left: 40),
                   child: Text("Nom et prénom"),
                 ),



                 //////********** Les vidéos
                 Container(
                   margin: EdgeInsets.only(top: 50,left:30),
                   child: Column(

                     children: [
                       Container(

                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Text("Mes vidéos"),
                           ],
                         ),


                       ),

                       Container(
                         child: Row(
                           children: [
                             Container(
                               margin: EdgeInsets.only(right:30),
                               child: Text("Trier par "),
                             ),

                             Container(
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


                                 items: <String>['  Selectionner  ', 'Nom', 'Durée', 'Date']
                                     .map<DropdownMenuItem<String>>((String value) {
                                   return DropdownMenuItem<String>(
                                     value: value,
                                     child: Text(value),
                                   );
                                 })
                                     .toList(),
                               ),

                             ),
                           ],
                         ),
                       ),

                       Container(
                         
                       )






                     ],

                   ),

                 )

                 //////********** Les vidéos
               ]
           )
         ],
       )

          

    );





  }
}
