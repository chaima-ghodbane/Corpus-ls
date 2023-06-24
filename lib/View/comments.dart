import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


void main() {
  return runApp(MaterialApp(
    home: CommentsScreen(),
  ));

}


class CommentsScreen extends StatefulWidget {
  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentController = TextEditingController();


  final CollectionReference _commentsCollection2 =
  FirebaseFirestore.instance.collection('comments');





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _commentController,
            decoration: InputDecoration(
              labelText: 'Enter your comment',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _addComment();

            },
            child: Text('Add Comment'),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _commentsCollection2.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final comments = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final commentData = comments[index].data() as Map<String, dynamic>;

                    return Container(
                      child: Column(
                        children: [
                          Container(
                            child: Text(''),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Text(commentData['comment']),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );


                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addComment() async {
    final comment = _commentController.text;

    if (comment.isNotEmpty) {
      await _commentsCollection2.add({'comment': comment,});
      _commentController.clear();
    }
  }
}

