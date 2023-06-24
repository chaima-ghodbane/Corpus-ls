import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:corpus_ls/View/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';
import 'package:get/get_core/src/get_main.dart';
import '../models/video_model.dart';
import 'ProfileVideos.dart';
import 'formation2.dart';




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

  final TextEditingController Name = TextEditingController();
  final TextEditingController LastName = TextEditingController();
  final TextEditingController NameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();
  final TextEditingController EmailController = TextEditingController();
  final CollectionReference _UserCollection =
        FirebaseFirestore.instance.collection('utilisateurs');
  final CollectionReference _VideosCollection =
        FirebaseFirestore.instance.collection('videos');


  List<VideoModel> videosList = [];

  late String videoid;

  final CollectionReference _ImagesCollection =
  FirebaseFirestore.instance.collection('images');

  late File? file ;
  late String name;

  late String imagepath ;
  late String userID ;

  Future<String> fetchUserData() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('utilisateurs')
        .where('ID', isEqualTo: userId)
        .get();

    if (querySnapshot.size > 0) {
      DocumentSnapshot document = querySnapshot.docs[0];
      String? name = document['name'] as String?;
      String? lastname = document['lastname'] as String?;

      if (name != null && lastname != null) {
        return '$name $lastname';
      }
    }

    return 'No Name';
  }



  Future<void> updateUsername(String name, String lastName, String email, String password) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    String userId = currentUser!.uid;

    // Update the user information in Firestore
    CollectionReference usersCollection = FirebaseFirestore.instance.collection('utilisateurs');
    DocumentSnapshot userSnapshot = await usersCollection.doc(userId).get();

    if (userSnapshot.exists) {
      // Update the "name" field only if the new value is not null or empty
      if (name.isNotEmpty) {
        await userSnapshot.reference.update({'name': name});
        print('Username updated in Firestore');
      }

      // Update the "lastname" field only if the new value is not null or empty
      if (lastName.isNotEmpty) {
        await userSnapshot.reference.update({'lastname': lastName});
        print('Lastname updated in Firestore');
      }

      // Update the email address in Firebase Authentication
      if (email.isNotEmpty) {
        await currentUser.updateEmail(email);
        print('Email address updated in Firebase Authentication');
      }

      // Update the password in Firebase Authentication
      if (password.isNotEmpty) {
        await currentUser.updatePassword(password);
        print('Password updated in Firebase Authentication');
      }
    } else {
      print('User not found');
    }
  }




  Future<List<Map<String, dynamic>>?> getVideosList() async {
    try {
      QuerySnapshot querySnapshot = await _VideosCollection.get();
      List<Map<String, dynamic>> itemsList = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }



  Future<String?> retrieveVideoID({String? userId}) async {
    if (userId != null) {
      QuerySnapshot snapshot = await _VideosCollection
          .where('userid', isEqualTo: userId)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.id;
      }
    }

    return null;
  }



  void retrieveVideosData({String? userId}) {
    if (userId != null) {
      _VideosCollection
          .where('userid', isEqualTo: userId)
          .snapshots()
          .listen((querySnapshot) {
        setState(() {
          videosList = querySnapshot.docs
              .map((document) => VideoModel.fromSnapshot(
              document as DocumentSnapshot<Map<String, dynamic>>))
              .toList();
        });
      });
    }
  }

  Future<void> selectImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image, // Specify that only image files should be picked
      allowMultiple: false,
    );

    if (result == null) return;

    final path = result.files.single.path!;

    setState(() {
      file = File(path);
    });

    await uploadImage();
  }

  Future<void> uploadImage() async {
    if (file == null) return;

    final fileName = path.basename(file!.path);
    final destination = 'images/$fileName';
    name = fileName;

    await FirebaseApi.uploadFile(destination, file!);

  }

  void addImage() async {
    final fileName = path.basename(file!.path);
    name = 'images/$fileName';

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await _ImagesCollection.add({'name': name, 'userid': userID});
        print('Image added successfully!');
        loadImageData(); // Reload the image data after adding the image
      } catch (e) {
        print('Error adding image: $e');
      }
    } else {
      print('User is not authenticated.');
    }
  }

  Future<String?> getImageData(String userId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('images')
        .where('userid', isEqualTo: userId)
        .get();

    if (querySnapshot.size > 0) {
      DocumentSnapshot document = querySnapshot.docs[0];
      String? path = document['name'] as String?;

      if (path != null) {
        return path;
      }
    }

    return null; // Return null if no path is found
  }

  Future<void> loadImageData() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String? path = await getImageData(userId);
    setState(() {
      imagepath = path!;
    });
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
      addImage();
      retrieveVideosData(userId: userID);
      loadImageData();
    }
  }
 @override
  void initState() {
    initialize();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [

      Column(
        children: [
      Row(
      mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back),
              color: Colors.grey,
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
          SizedBox(width: 230),
          Container(
            margin: EdgeInsets.only(right: 0, top: 20),
            height: 50,
            child: IconButton(
              icon: Icon(Icons.edit),
              iconSize: 30,
              color: Colors.grey,
              onPressed: () {
                print('pressed');
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
                                  'Nom'.tr,
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
                                  controller: NameController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(15, 8, 0, 8),
                                    hintText: 'Nom',
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
                                  'Prénom'.tr,
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
                                    controller: lastnameController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(15, 8, 0, 8),
                                      hintText: 'Prénom',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 30, left: 20),
                                child: Text(
                                  'Email'.tr,
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
                                  controller: EmailController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(15, 8, 0, 8),
                                    hintText: 'Email',
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
                                  'Mot de passe'.tr,
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
                                  controller: PasswordController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(15, 8, 0, 8),
                                    hintText: 'Mot de passe',
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
                                          await updateUsername(NameController.text,lastnameController.text,EmailController.text,PasswordController.text);
                                          Navigator.of(context).pop();

                                        },

                                        child: Text('Enregistrer'.tr,style: TextStyle(fontSize: 15)),
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



      GestureDetector(

        onTap: ()async
        {
            selectImage();
            uploadImage();

            print(imagepath);
           initialize();
            print(imagepath);


        },


        child: Container(
          margin: EdgeInsets.only(top: 30, left: 30),
          height: 100,
          width: 100,
          decoration: BoxDecoration(

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
         child:  Container(

           width:55,
           height :55,
           margin: EdgeInsets.only(left: 10),

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
        ),
      ),






      Container(
          margin: EdgeInsets.only(top: 20, left: 0),
          child: Container(
            margin: EdgeInsets.only(top: 20, left: 40),
            child: FutureBuilder<String>(
              future: fetchUserData(), // Call fetchUserData to get the user name
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Show a loading indicator while fetching data
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}'); // Show an error message if an error occurs
                } else {
                  String userName = snapshot.data ?? 'No Name';
                  return Text(userName,style: TextStyle(
                    fontWeight: FontWeight.bold,fontSize: 20
                  ),

                  ); // Display the user name
                }
              },
            ),

          ),
        ),




      //////********** Les vidéos
      Container(
        margin: EdgeInsets.only(top: 50, left: 30),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Text(
                      'Mes vidéos',
                      style: TextStyle(
                        fontSize: 23,
                        color: const Color(0xFF05acb2),
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,)
          ],
        ),
      ),
      //////********** Les vidéos
        Column(
          children: videosList.map((video) {
            return Container(
              margin: EdgeInsets.only(bottom: 10),
              width:330,
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
              child: GestureDetector(
                onTap: () async {
                  String path = video.name;
                  print('nom du video = $path');

                  // Check if the path is empty or undefined
                  if (path != null && path.isNotEmpty) {
                    String url = 'https://firebasestorage.googleapis.com/v0/b/test-1963f.appspot.com/o/${Uri.encodeComponent(path)}?alt=media';
                    print('video URL = $url');

                    String? retrievedVideoId = await retrieveVideoID(userId: video.userid);
                    print('retrievedVideoId = $retrievedVideoId');

                    String videoId = retrievedVideoId ?? '';

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileVideo(videoUrl: url, videoid: videoId),
                      ),
                    );
                  } else {
                    print('Error: Video path is empty or undefined');
                  }
                },
                onLongPress: (){
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
                                  margin: EdgeInsets.only(top: 10,left: 10),
                                  child: IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: Icon(Icons.arrow_back),
                                    color: Colors.grey,
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
                                  margin: EdgeInsets.only(top: 30, left: 20),
                                  child: Text(
                                    'titre'.tr,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontStyle: FontStyle.italic,
                                      color: Color(0XFF646E82),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only( left: 15, right: 15),
                                  child: TextField(
                                    controller: NameController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(15, 8, 0, 8),
                                      hintText: 'titre',
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
                                    'description'.tr,
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
                                      controller: lastnameController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(15, 8, 0, 8),
                                        hintText: 'description',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),


                                SizedBox(height: 50),
                                Container(
                                  padding: EdgeInsets.only(left: 40),
                                  width: 200,

                                  child: ElevatedButton(

                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF05acb2),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    onPressed:() async
                                    {
                                      await updateUsername(NameController.text,lastnameController.text,EmailController.text,PasswordController.text);
                                      Navigator.of(context).pop();

                                    },

                                    child: Text('Editer la vidéo'.tr,style: TextStyle(fontSize: 15)),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 40),
                                  width: 200,
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

                                    child: Text('Supprimer la vidéo'.tr,style: TextStyle(fontSize: 15)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );

                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Center(
                          child: Text(' ${video.title}',style: TextStyle(
                            fontSize: 13,fontWeight: FontWeight.bold,
                          ),),
                        ),
                      ),
                      Container(
                        child: Text(' ${video.description}',style: TextStyle(
                          fontSize: 15,
                        ),),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),

      ],
    ),
        ]
    ),

      bottomNavigationBar: SizedBox(
        width: 200,
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
          child: Row(
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
                child: IconButton(
                  icon: Icon(
                    Icons.person_2_rounded,
                    color: const Color(0xFF05acb2),
                  ),
                  iconSize: 30,
                  color: Colors.grey,
                  onPressed: () {
                    Get.to(Profile());
                  },
                ),
              ),
              Expanded(
                child: IconButton(
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
        ),
      ),
    );
  }
}
