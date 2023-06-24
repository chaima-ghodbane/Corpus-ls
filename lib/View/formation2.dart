import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:corpus_ls/View/intro1.dart';
import 'package:corpus_ls/View/profile.dart';
import 'package:corpus_ls/View/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';



void main() {
  return runApp(const MaterialApp(
    home: Formation2(),
  ));

}


class Formation2 extends StatefulWidget {
  const Formation2({Key? key}) : super(key: key);

  @override
  State<Formation2> createState() => _Formation2State();
}

class _Formation2State extends State<Formation2> {
  File? file ;
  late String name;
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController TitleController = TextEditingController();
  final CollectionReference _VideosCollection =
  FirebaseFirestore.instance.collection('videos');
  late String userID;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if(result==null) return ;
    final path = result .files.single.path!;
    setState(() =>  file = File(path));
    await uploadFile();

  }

  Future<void> uploadFile() async {
    if (file == null) return;

    final fileName = path.basename(file!.path);
    final destination = 'files/$fileName';
    name=fileName;
    FirebaseApi.uploadFile(destination,file!);
  }

  void _addVideo() async {
    final fileName = path.basename(file!.path);
    name = 'files/$fileName';

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await _VideosCollection.add({'name': name, 'userid': userID,'title':TitleController.text,'description':descriptionController.text});
        print('Video added successfully!');
      } catch (e) {
        print('Error adding video: $e');
      }
    } else {
      print('User is not authenticated.');
    }
  }


  void _showAlertDialog(BuildContext context) {


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(bottom: 50),
              width: MediaQuery.of(context).size.width,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30, left: 20),
                    child: Text(
                      'Titre'.tr,
                      style: TextStyle(
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                        color: Color(0XFF646E82),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 15, right: 15),
                    child: TextField(
                      controller: TitleController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(15, 8, 0, 8),
                       hintText: 'Ajouter un titre pour votre vidéo',
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
                  Container(
                    margin: EdgeInsets.only(top: 30, left: 20),
                    child: Text(
                      'Description'.tr,
                      style: TextStyle(
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                        color: Color(0XFF646E82),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(top: 20, left: 15, right: 15),
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
                    child: Container(
                      height: 50,
                      child: TextFormField(
                          controller: descriptionController,
                          decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(15, 8, 0, 8),
                          hintText: 'Ajouter une description',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),


                  SizedBox(height: 50),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 120,
                          child: ElevatedButton(

                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF05acb2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed:() async
                            {
                             await uploadFile();
                             getUserDocumentId();
                             initialize();
                              _addVideo();
                              Navigator.of(context).pop();
                              TitleController.text='';
                              descriptionController.text='';

                            },

                            child: Text('Publier'.tr,style: TextStyle(fontSize: 15)),
                          ),
                        ),

                        SizedBox(width: 30,),
                        Container(
                          width: 120,
                          child: ElevatedButton(

                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF05acb2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed:() {
                              Navigator.of(context).pop();
                            },

                            child: Text('Annuler'.tr,style: TextStyle(fontSize: 15)),
                          ),
                        ),




                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }





  Future<String?> getUserDocumentId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('utilisateurs')
          .where('ID', isEqualTo: user.uid)
          .limit(1)
          .get();
      if (querySnapshot.size > 0) {
        return querySnapshot.docs[0].id;
      }
    }
    return null;
  }


  @override
  void initialize() async {

    String? userId = await getUserDocumentId();
    if (userId != null) {
      setState(() {
        userID = userId;
      });

      _addVideo();


    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body:

      SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 20,left: 10),
                        child :  Row(
                          children: [
                            Container(
                              child : IconButton(
                                  onPressed: (){
                                    Get.back();

                                  },
                                  icon:Icon (Icons.arrow_back)
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

                            Container(
                                height: 40,
                                width: 180,
                                margin: EdgeInsets.only(left: 25,right: 25),
                                child: Center(
                                  child: Text('titreform2'.tr,style: TextStyle(fontSize: 16,
                                    color: const Color(0xFF646E82),)),
                                )
                            ),

                            Container(

                              child: IconButton(
                                // padding: EdgeInsets.only(top: 75),

                                icon: Icon(Icons.notifications_sharp),

                                iconSize: 30,
                                color: Colors.grey,
                                onPressed: () {
                                  //Get.to(Notifications());


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
                          ],
                        )
                    ),


                    Container(
                      margin: EdgeInsets.only(top: 60,left: 20.5),
                      child: Row(
                        children: [

                          Container(

                            width:55,
                            height :55,
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

                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text("Jina Levant"),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Image.asset(
                                  'assets/images/logo-learny-box.png',
                                  height:20,
                                  width: 80,
                                ),


                              ),

                            ],
                          ),
                          Container(
                            child: SizedBox(
                              width: 110,
                            ),
                          ),





                        ],
                      ),


                    ),

                    Container(
                        margin: EdgeInsets.only(left :30,top: 30,bottom: 15,right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Description",
                              style: TextStyle(
                                fontWeight: FontWeight.bold, // Apply bold style
                              ),
                            ),

                          ],
                        )

                    ),


                    Container(
                      width: 330,
                      height: 63,
                      margin: EdgeInsets.only(left :30,top: 10,bottom: 15,right: 30),
                      child: Text('description2'.tr),
                    ),

                    Container(
                      child: Row(

                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 30),
                              width: 205,
                              height: 35,
                              child: Text("Leçons",style: TextStyle(fontSize: 22,color: const Color(0xFF05acb2), ),)
                          ),


                          SizedBox(width: 40),



                          Container(
                            width: 50,
                            height: 50,
                            child: IconButton(
                              onPressed: () async {
                                try {
                                  await selectFile();
                                  print('File selected successfully.');
                                } catch (error) {
                                  print('Error selecting file: $error');
                                }
                                _showAlertDialog(context);
                              },
                              icon: Icon(Icons.video_call),color: const Color(0xFF05acb2),),
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

                    Row(

                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left:30),
                          child: Text("15 Leçons"),
                        ),
                      ],
                    ),


                    Container(
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
                            margin: EdgeInsets.only(top: 24),
                            height: 100,
                            width:330,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      child:   Container(

                                        margin: EdgeInsets.only(top: 15,left:33),
                                        child: Text("1",style: TextStyle(fontSize: 50,
                                            fontWeight: FontWeight.w400,color: Color(0XFF646E82))),

                                      ),

                                      onTap: () {

                                        Get.to(Form11());

                                        //////////////////////////////
                                        ///////////////////////////////

                                      },
                                    ),

                                    Container(
                                        margin: EdgeInsets.only(left: 24,top: 15),
                                        child:
                                        Column(
                                          children: [
                                            Container(
                                              child: Text("Introduction"),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Text("15 min          "),
                                            ),

                                          ],
                                        )
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 120,top: 15),
                                      child: Icon(Icons.play_arrow,color: Color(0XFF646E82)),


                                    )
                                  ],
                                ),


                              ],
                            ),
                          ),


                          //////////////////////////////////////////////////////////////////



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
                            margin: EdgeInsets.only(top: 24),
                            height: 100,
                            width:330,
                            child: Column(
                              children: [
                                Row(

                                  children: [
                                    Container(

                                      margin: EdgeInsets.only(top: 15,left:33),
                                      child: Text("2",style: TextStyle(fontSize: 50,
                                          fontWeight: FontWeight.w400,color: Color(0XFF646E82))),

                                    ),

                                    Container(
                                        margin: EdgeInsets.only(left: 24,top: 15),
                                        child:
                                        Column(
                                          children: [
                                            Container(
                                              child: Text("Introduction"),
                                            ),

                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Text("15 min          "),
                                            ),

                                          ],
                                        )
                                    ),


                                    Container(
                                      margin: EdgeInsets.only(left: 120,top: 15),
                                      child: Icon(Icons.lock,color: Color(0XFF646E82)),

                                    )

                                  ],
                                ),


                              ],
                            ),
                          ),



                          //////////////////////////////////////////////////////////////////////////////


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
                            margin: EdgeInsets.only(top: 24),
                            height: 100,
                            width:330,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(

                                      margin: EdgeInsets.only(top: 15,left:33),
                                      child: Text("3",style: TextStyle(fontSize: 50,
                                          fontWeight: FontWeight.w400,color: Color(0XFF646E82))),

                                    ),
                                    Container(
                                        margin: EdgeInsets.only(left: 24,top: 15),
                                        child:
                                        Column(
                                          children: [
                                            Container(
                                              child: Text("Introduction"),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Text("15 min          "),
                                            ),

                                          ],
                                        )
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(left: 120,top: 15),
                                      child: Icon(Icons.lock,color: Color(0XFF646E82)),


                                    )
                                  ],
                                ),


                              ],
                            ),
                          ),

                          ///////////////////////////////////////////////////////////////////
                        ],
                      ),

                    ),
                  ],
                )
              ],
            ),
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



  class FirebaseApi {
  static UploadTask? uploadFile(String destination, File file) {
  try {
  final ref = FirebaseStorage.instance.ref(destination);
  return ref.putFile(file);
  } catch (e) {
  print('Error uploading file: $e');
  return null;
  }
  }

}

