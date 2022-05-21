import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodcore/auth/welcomePage.dart';
import 'package:foodcore/screens/drawerscreens/Acoount.dart';
import 'package:foodcore/screens/drawerscreens/Feedback.dart';
import 'package:foodcore/screens/drawerscreens/aboutus.dart';
import 'package:foodcore/screens/homebody.dart';
import 'package:foodcore/screens/search.dart';
import 'package:foodcore/tools/userModel.dart';

class page1 extends StatefulWidget {
  const page1({Key? key}) : super(key: key);

  @override
  State<page1> createState() => _page1State();
}

class _page1State extends State<page1> {
  var user = FirebaseAuth.instance.currentUser!;
  var database = FirebaseFirestore.instance.collection('users');
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  List<Widget> _widgetOptions = [
    homebody(),
    searchpage(),
  ];
//  Map resturants = {
//    'KFC': {0: {}}
//  };

  @override
  Widget build(BuildContext context) {
    final drawertextstyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontFamily: 'OpenSans',
      color: Colors.black87,
    );
    return FutureBuilder<DocumentSnapshot>(
        future: database.doc(user.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            //print(snapshot);
            //print(snapshot.data);
            var USERMODEL = UserModel.fromMap(snapshot.data!.data());
            //print(USERMODEL.email);
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                elevation: 0,
                title: Text('Food Core',
                    style: TextStyle(
                        color: Color.fromARGB(255, 231, 231, 231),
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        fontFamily: 'Alice')),
              ),
              drawer: Drawer(
                backgroundColor: Colors.blueGrey,
                child: Column(
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      accountName: Text(
                          '${USERMODEL.firstName} ${USERMODEL.secondName}'),
                      accountEmail: Text(user.email!,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'OpenSans',
                            color: Colors.white,
                          )),
                    ),
                    ListTile(
                        title: Text("Account", style: drawertextstyle),
                        leading:
                            Icon(Icons.manage_accounts, color: Colors.black54),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => accountDetails()));
                        }),
                    Divider(thickness: 1),
                    ListTile(
                        title: Text("Orders", style: drawertextstyle),
                        leading: Icon(Icons.view_list_outlined,
                            color: Colors.black54),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text('Sorry'),
                              content: Text('This feature not implemented yet'),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }),
                    ListTile(
                        title: Text("Favourite", style: drawertextstyle),
                        leading:
                            Icon(Icons.favorite_border, color: Colors.black54),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text('Sorry'),
                              content: Text('This feature not implemented yet'),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }),
                    Divider(thickness: 1),
                    ListTile(
                        title: Text("History", style: drawertextstyle),
                        leading: Icon(Icons.history, color: Colors.black54),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text('Sorry'),
                              content: Text('This feature not implemented yet'),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }),
                    Divider(thickness: 1),
                    ListTile(
                        title: Text("Feedback", style: drawertextstyle),
                        leading: Icon(Icons.feedback_outlined,
                            color: Colors.black54),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => feedbackpage()));
                        }),
                    ListTile(
                        title: Text("About us", style: drawertextstyle),
                        leading:
                            Icon(Icons.info_outline, color: Colors.black54),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => aboutuspage()));
                        }),
                    ListTile(
                      title: Text("Log out", style: drawertextstyle),
                      leading: Icon(Icons.logout, color: Colors.black54),
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => welcomepage()));
                      },
                    ),
                  ],
                ),
              ),
              body: _widgetOptions.elementAt(_selectedIndex),
              bottomNavigationBar: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.search), label: 'Search'),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.black,
                onTap: _onItemTapped,
              ),
            );
          }
          return Scaffold(
              body: Center(
            child: CircularProgressIndicator(
              strokeWidth: 3,
              backgroundColor: Colors.black,
              color: Colors.blueGrey,
            ),
          ));
        });
  }
}
