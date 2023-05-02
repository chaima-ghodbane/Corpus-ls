import 'package:flutter/material.dart';
import 'package:corpus_ls/View/home.dart';
import 'package:get/get.dart';


void main() {
  return runApp(const MaterialApp(
    home: se_connecter(),
  ));
}



class se_connecter extends StatefulWidget {
  const se_connecter({Key? key}) : super(key: key);

  @override
  State<se_connecter> createState() => _se_connecterState();
}

class _se_connecterState extends State<se_connecter> {
  @override
  final TextEditingController Email = TextEditingController();
  final TextEditingController Password = TextEditingController();
  Widget build(BuildContext context) {

    return Scaffold(
        body:
        ListView(
          children: [
            Container(

              height: MediaQuery.of(context).size.height,

              child :
              Column(
                children: [
                  // first container having the image
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top:60,bottom: 60),
                      width: 280,
                      height: 220,


                      decoration: BoxDecoration(
                        image: DecorationImage(

                          image: AssetImage('assets/images/logo.jpeg'),

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


                  //2nd container having the text and the text box
                  Container(
                    padding: EdgeInsets.only(bottom: 50),

                    width: MediaQuery.of(context).size.width,


                    decoration: BoxDecoration(

                      //borderRadius: BorderRadius.circular(20),
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

                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        // container de text
                        Container(
                            margin : EdgeInsets.only(top:30,left: 20),
                            child:
                            Text("Adresse Mail",style: TextStyle(fontSize: 17,
                                                                fontStyle: FontStyle.italic,
                                                                color: Color(0XFF646E82))),



                        ),


                        // container de text box


                        Container(
                          margin : EdgeInsets.only(top:20,left: 15,right: 15),

                          child: TextField(
                            controller: Email,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(15, 8, 0, 8),
                              hintText: 'Nom.prenom@gmail.com',
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

                        /////////////////////////////////////////////////
                        Container(

                            margin : EdgeInsets.only(top:30,left: 20),
                            child:
                            Text("Mot de passe",style: TextStyle(fontSize: 17,fontStyle: FontStyle.italic,color: Colors.blueGrey))

                        ),


                        // container de text box


                        Container(
                          margin : EdgeInsets.only(top:20,left: 15,right: 15),

                          child: TextField(
                            controller: Password,
                            obscureText: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(15, 8, 0, 8),
                              hintText: '**********',
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
                        ///////////////////////////////////////////////


                        Container(
                          margin: EdgeInsets.only(top: 60,left: 80),
                          width: 200,
                          height: 50,

                          child: ElevatedButton(

                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              Get.to(Home());
                              String MyEmail =Email.text;
                              print("this is your email  : "+MyEmail);
                              String MyPassword =Password.text;
                              print("this is your pw  : "+MyPassword);

                            },
                            child: Text('Se connecter',style: TextStyle(fontSize: 15)),
                          ),
                        ),
                      ],

                    ),
                  ),








                ],
              ),

            ),




          ],
        )

    );
  }
}

