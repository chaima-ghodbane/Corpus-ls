import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'notifications.dart';

class Form11 extends StatefulWidget {
  const Form11({Key? key}) : super(key: key);

  @override
  State<Form11> createState() => _Form11State();
}

class _Form11State extends State<Form11> {
  String dataSource = "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4";

  VideoPlayerController? _controller;
  final TextEditingController _commentController = TextEditingController();
  final CollectionReference _commentsCollection = FirebaseFirestore.instance.collection('comments');

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
      body: ListView(
        children: [
          SafeArea(
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
                    margin: EdgeInsets.all(10),
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
                    height: 280,
                    child: Column(
                      children: [
                        Expanded(
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
                                  Duration newPosition = _controller!.value.position - Duration(seconds: 2);
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
                                    _controller!.value.isPlaying ? _controller!.pause() : _controller!.play();
                                    setState(() {}); // Add this line to rebuild the UI and update the icon
                                  },
                                  icon: Icon(_controller!.value.isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.grey),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  // Calculate the new position to seek to
                                  Duration newPosition = _controller!.value.position + Duration(seconds: 2);
                                  // Ensure that the new position is not greater than the video duration
                                  newPosition = newPosition > _controller!.value.duration ? _controller!.value.duration : newPosition;
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
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              'Commentaires',
                              style: TextStyle(
                                fontSize: 25,
                                color: const Color(0xFF05acb2),
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 200, // Set a fixed height for the container
                          child: StreamBuilder<QuerySnapshot>(
                            stream: _commentsCollection.snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(child: CircularProgressIndicator());
                              }
                              final comments = snapshot.data!.docs;
                              return ListView.builder(
                                itemCount: comments.length,
                                itemBuilder: (context, index) {

                                  final commentData = comments[index].data() as Map<String, dynamic>;
                                  return Dismissible(
                                    key: Key(commentData['comment']),
                                    direction: DismissDirection.startToEnd,
                                    background: Container(
                                      padding: EdgeInsets.only(left: 16),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Icon(Icons.delete, color: Colors.white),
                                      ),
                                      color: Colors.red, // Set a different color for the container
                                    ),
                                    onDismissed: (direction) {
                                      // Delete the comment here
                                      _deleteComment(comments[index].reference);
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(commentData['username']),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          margin: EdgeInsets.symmetric(vertical: 4),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(commentData['comment']),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Container(
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
                                  width: 300,
                                  margin: EdgeInsets.only(top: 10),
                                  child: TextField(
                                    controller: _commentController,
                                    decoration: InputDecoration(
                                      hintText: 'Add a comment...',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none, // Remove the border
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  onPressed: () async {
                                    String user_name = await fetchUserData();
                                    String comment = _commentController.text;
                                    _commentsCollection.add({'comment': comment, 'username': user_name});
                                    _commentController.clear();
                                  },

                                  icon: Icon(Icons.send),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]
      ),
    );
  }
}
void _deleteComment(DocumentReference commentRef) {
  commentRef.delete();
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
