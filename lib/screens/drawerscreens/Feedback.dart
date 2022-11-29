import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodcore/tools/feedbackmodel.dart';

class feedbackpage extends StatefulWidget {
  @override
  State<feedbackpage> createState() => _feedbackpageState();
}

class _feedbackpageState extends State<feedbackpage> {
  final _feedbackkey = GlobalKey<FormState>();
  final emailcotroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var feedbackcontroller = TextEditingController();
    var emailcontroller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blueGrey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Feedback',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                fontFamily: 'OpenSans')),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
            child: Form(
              key: _feedbackkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Issue :',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Card(
                      child: TextFormField(
                        controller: feedbackcontroller,
                        maxLines: 12,
                        textAlign: TextAlign.start,
                        //expands: true,
                        decoration: InputDecoration(
                            hintText: 'Please write your problem in details.',
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 156, 156, 156))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Color.fromARGB(255, 184, 184, 184)))),
                        validator: (value) {
                          if (value!.length < 40) {
                            return "please enter more details";
                          }
                          ;
                          return null;
                        },
                        onSaved: (value) {
                          feedbackcontroller.text = value!;
                        },
                        onFieldSubmitted: (value) {
                          feedbackcontroller.clear();
                        },
                      ),
                    ),
                  ),
                  Text(
                    'Email :',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Card(
                      child: TextFormField(
                        controller: emailcontroller,
                        //maxLines: 9,
                        textAlign: TextAlign.start,
                        //expands: true,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 156, 156, 156))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Color.fromARGB(255, 184, 184, 184)))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please Enter a valid Email");
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Please Enter a valid email");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          emailcontroller.text = value!;
                        },
                        onFieldSubmitted: (value) {
                          emailcontroller.clear();
                        },
                      ),
                    ),
                  ),
                  Divider(),
                  Container(
                    padding: EdgeInsets.only(left: 27),
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(214, 32, 32, 32),
                          foregroundColor: Colors.blueGrey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          padding: EdgeInsets.all(15)),
                      onPressed: () => {
                        if (_feedbackkey.currentState!.validate())
                          {
                            feedback(
                                feedbackcontroller.text, emailcontroller.text),
                          }
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void feedback(String feedback, String email) async {
    var FEEDBACKMODEL = FeedbackModel(feedback: feedback, email: email);
    var user = FirebaseAuth.instance.currentUser;
    //var database = FirebaseFirestore.instance.collection('feedbacks').doc(user!.uid).set(FEEDBACKMODEL.toMap());
    await FirebaseFirestore.instance
        .collection('feedbacks')
        .doc(user!.uid)
        .set(FEEDBACKMODEL.toMap());
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Done'),
        content: Text('Feedback submitted.'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
