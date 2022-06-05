import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodcore/tools/userModel.dart';

class accountDetails extends StatefulWidget {

  @override
  State<accountDetails> createState() => _accountDetailsState();
}

class _accountDetailsState extends State<accountDetails> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  var users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(uid).get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          var USERMODEL = UserModel.fromMap(snapshot.data!.data());
          //print(USERMODEL.email);
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
                title: Text('Account Details',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        fontFamily: 'OpenSans')),
                centerTitle: true,
              ),
              body: Container(
                padding: EdgeInsets.fromLTRB(10, 40, 0, 0),
                child: Column(
                  children: [
                    Text('Personal information',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w100,
                            fontSize: 25,
                            fontFamily: 'OpenSans')),
                    Card(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width *
                                      32 /
                                      100,
                                  child: Text('First Name :',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          //fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          fontFamily: 'OpenSans')),
                                ),
                                Text('${USERMODEL.firstName}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                    )),
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width *
                                      32 /
                                      100,
                                  child: Text("Second Name :",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          //fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          fontFamily: 'OpenSans')),
                                ),
                                Text('${USERMODEL.secondName}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                    )),
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width *
                                      32 /
                                      100,
                                  child: Text("Email address :",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          //fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          fontFamily: 'OpenSans')),
                                ),
                                Text('${USERMODEL.email}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        }

        return Center(
          child: CircularProgressIndicator(
            strokeWidth: 3,
            backgroundColor: Colors.black,
            color: Colors.blueGrey,
          ),
        );
      },
    );
  }
}
