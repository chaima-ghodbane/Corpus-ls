import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'notifications.dart';





class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  String dataSource = "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4";

  VideoPlayerController? _controller;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SafeArea(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 20),
                  child: Row(
                    children: [
                      Container(
                        child : IconButton(
                          onPressed: (){
                            Get.back();

                          },
                          icon:Icon (Icons.arrow_back),
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
                          margin: EdgeInsets.only(left: 25,right: 25),
                          child: Center(
                            child: Text("Introduction",style: TextStyle(fontSize: 16,
                              color: const Color(0xFF646E82),)),
                          )

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
                Container(
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

                  height: 300,
                  child: Column(
                    children: [
                      Expanded(


                        child: _controller?.value.isInitialized ?? false
                            ? AspectRatio(
                          aspectRatio: _controller!.value.aspectRatio,
                          child: ClipRRect(

                            borderRadius: BorderRadius.circular(15),

                            child:
                            VideoPlayer(_controller!),


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
                        child:  Row(
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
                              icon:Icon(Icons.skip_previous,color: Colors.grey,),
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
                                onPressed: (){
                                  _controller!.value.isPlaying ? _controller!.pause() : _controller!.play();
                                  setState(() {}); // Add this line to rebuild the UI and update the icon
                                },
                                icon: Icon(_controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,color: Colors.grey,),
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
                              icon:Icon(Icons.skip_next,color: Colors.grey,),
                            ),

                          ],
                        ),
                      ),







                    ],
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(top: 30,),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10,),
                          child: Text('Commentaires', style: TextStyle( fontSize: 25,
                              color: const Color(0xFF05acb2),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500)),
                        ),

                        Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 70,
                          child: Row(

                            children: [
                              Container(

                                width:50,
                                height :50,
                                margin: EdgeInsets.only(left: 10),
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
                                margin: EdgeInsets.only(left: 20),
                                child: Text("Michael Scofield"),
                              ),



                            ],

                          ),


                        ),

                        Container(
                          //margin : EdgeInsets.only(top:20,left: 15,right: 15),
                          width: 300,
                          child: TextField(

                            //controller: Email,
                            decoration: InputDecoration(
                              hintText: "Morem ipsum dolor sit amet, ",

                              contentPadding: EdgeInsets.fromLTRB(15, 8, 0, 8),
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
                          margin: EdgeInsets.only(top: 20),
                          height: 70,
                          child: Row(

                            children: [
                              Container(

                                width:50,
                                height :50,
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

                              Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Text("Michael Scofield"),
                              ),



                            ],

                          ),


                        ),

                        Container(
                          //margin : EdgeInsets.only(top:20,left: 15,right: 15),
                          width: 300,
                          child: TextField(

                            //controller: Email,
                            decoration: InputDecoration(
                              hintText: "Morem ipsum dolor sit amet, ",

                              contentPadding: EdgeInsets.fromLTRB(15, 8, 0, 8),
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
                          margin: EdgeInsets.only(top: 20),
                          height: 70,
                          child: Row(

                            children: [
                              Container(

                                width:50,
                                height :50,
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

                              Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Text("Michael Scofield"),
                              ),



                            ],

                          ),


                        ),

                        Container(
                          margin : EdgeInsets.only(bottom:30),
                          width: 300,
                          child: TextField(

                            //controller: Email,
                            decoration: InputDecoration(
                              hintText: "Morem ipsum dolor sit amet, ",

                              contentPadding: EdgeInsets.fromLTRB(15, 8, 0, 8),
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


                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),

      bottomNavigationBar: SizedBox(
          width: 200,

          child:

          Row(
            children: [
              Expanded(child: Container(
                //margin : EdgeInsets.only(bottom:3),
                width: 300,
                child: TextField(


                  decoration: InputDecoration(
                    hintText: 'Comment'.tr,

                    contentPadding: EdgeInsets.fromLTRB(15, 8, 0, 8),
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
              ),),
              Expanded(child: IconButton(onPressed:(){}, icon: Icon(Icons.send)))
            ],
          )
      ),
    );
  }
}
