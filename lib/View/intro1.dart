import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'home.dart';
import 'profile.dart';
import 'notifications.dart';

class Form11 extends StatefulWidget {
  const Form11({Key? key}) : super(key: key);

  @override
  State<Form11> createState() => _Form11State();
}

class _Form11State extends State<Form11> {
  String dataSource = "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4";

  VideoPlayerController? _controller;

  TextEditingController Name = TextEditingController();
  TextEditingController LastName = TextEditingController();


  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(dataSource)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

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






@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
              child: Row(
                children: [
                  Container(
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
                    height: 40,
                    width: 180,
                    margin: EdgeInsets.only(left: 25, right: 25),
                    child: Center(
                      child: Text(
                        "Introduction",
                        style: TextStyle(
                          fontSize: 16,
                          color: const Color(0xFF646E82),
                        ),
                      ),
                    ),
                  ),
                  Container(
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
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(


                child: Container(

                  height: 300,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(

                          height: 200,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.only(top: 100),
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
                          child: Center(
                            child: Column(
                              children: [
                                Container(
                                  height: 200, // Adjust this height as needed
                                  child: _controller?.value.isInitialized ?? false
                                      ? AspectRatio(
                                    aspectRatio: _controller!.value.aspectRatio,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: VideoPlayer(_controller!),
                                    ),
                                  )
                                      : Container(),
                                ),
                                VideoProgressIndicator(
                                  _controller!,
                                  allowScrubbing: true,
                                  padding: EdgeInsets.all(0.0),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  width: 250,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          // Calculate the new position to seek to
                                          Duration newPosition =
                                              _controller!.value.position - Duration(seconds: 2);
                                          // Ensure that the new position is not negative
                                          newPosition = newPosition.isNegative ? Duration.zero : newPosition;
                                          // Seek to the new position
                                          _controller!.seekTo(newPosition);
                                        },
                                        icon: Icon(Icons.skip_previous, color: Colors.grey),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(150),
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
                                        child: IconButton(
                                          onPressed: () {
                                            _controller!.value.isPlaying
                                                ? _controller!.pause()
                                                : _controller!.play();
                                            setState(() {}); // Add this line to rebuild the UI and update the icon
                                          },
                                          icon: Icon(
                                            _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          // Calculate the new position to seek to
                                          Duration newPosition =
                                              _controller!.value.position + Duration(seconds: 2);
                                          // Ensure that the new position is not greater than the video duration
                                          newPosition = newPosition > _controller!.value.duration
                                              ? _controller!.value.duration
                                              : newPosition;
                                          // Seek to the new position
                                          _controller!.seekTo(newPosition);
                                        },
                                        icon: Icon(Icons.skip_next, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              ),


          ],
        ),
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

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Form11(),
    );
  }
}
