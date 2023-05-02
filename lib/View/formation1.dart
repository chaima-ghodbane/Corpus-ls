import 'package:flutter/material.dart';
import 'package:corpus_ls/View/notifications.dart';
import 'package:get/get.dart';
//import 'package:corpus_ls/View/try.dart';


void main() {
  return runApp(const MaterialApp(
    home: formation1(),
  ));
}




class formation1 extends StatefulWidget {
  const formation1({Key? key}) : super(key: key);


  @override

  _formation1State createState() => _formation1State();
}

class _formation1State extends State<formation1> {

  int _selectedIndex = 0;


  // List of widgets that correspond to each item in the navigation bar
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page'),
    Text('Search Page'),
    Text('Profile Page'),
  ];

  // Handler for when an item in the navigation bar is selected
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:

      ListView(
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
                            child: Text("LICENCE DE CODEUR EN LFPS",style: TextStyle(fontSize: 16,
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

                      child: IconButton(
                        onPressed: (){


                          showDialog(

                            context: context,
                            builder: (BuildContext context) {
                              return
                              Scaffold(

                                  body:
                                  Container(

                                    child: ListView(
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
                                    ),
                                  )
                              );
                              },
                          );
                          },




                        icon: Icon(Icons.people_rounded),
                        iconSize: 30,color:Colors.grey ,),
                    )



                  ],
                ),


              ),

              Container(
                  margin: EdgeInsets.only(left :30,top: 30,bottom: 15,right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Description"),

                    ],
                  )

              ),


              Container(
                width: 330,
                height: 63,
                margin: EdgeInsets.only(left :30,top: 10,bottom: 15,right: 30),
                child: Text("Morem ipsum dolor sit amet, "
                    "consectetur adipiscing elit. Etiam eu Morem ipsum dolor sitMorem ipsum dolor sit amet, Morem"),
              ),

              Container(
                child: Row(

                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 30),
                        width: 205,
                        height: 35,
                        child: Text("Leçons",style: TextStyle(fontSize: 22,color: const Color(0xFF61DBD0) ),)
                    ),


                    SizedBox(width: 40),


                    Container(
                      width: 50,
                      height: 50,
                      child: IconButton(onPressed: (){
                        //Get.to(MyHomePage());
                      }, icon: Icon(Icons.video_call),color: const Color(0xFF61DBD0)),
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
                // Set the height of the Container to fit the screen
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
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
                                Container(

                                  margin: EdgeInsets.only(top: 15,left:33),
                                  child: Text("1",style: TextStyle(fontSize: 50,
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
              ),




            ],


          ),
        ],
      ),


      bottomNavigationBar:
      BottomNavigationBar(

        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,




        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(

            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],

        currentIndex: _selectedIndex,

        onTap: _onItemTapped,

      ),




    );
  }
}
