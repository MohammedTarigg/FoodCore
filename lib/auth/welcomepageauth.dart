import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodcore/auth/welcomePage.dart';
import 'package:foodcore/screens/home.dart';

class welcomepageauth extends StatefulWidget {
  const welcomepageauth({Key? key}) : super(key: key);

  @override
  State<welcomepageauth> createState() => _welcomepageauthState();
}

class _welcomepageauthState extends State<welcomepageauth> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        //print('0');
        if (snapshot.hasData) {
          //print('1');
          return page1();
        } else {
          //print('2');
          return welcomepage();
        }
      },
    );
  }
}













/*import 'package:flutter/material.dart';

class welcomepagebody extends StatefulWidget {
  const welcomepagebody({Key? key}) : super(key: key);

  @override
  State<welcomepagebody> createState() => _welcomepagebodyState();
}

class _welcomepagebodyState extends State<welcomepagebody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(children: [
      Container(
          //padding: EdgeInsets.only(top: 20),
          margin: EdgeInsets.only(top: 60),
          height: 200,
          alignment: Alignment.center,
          child: Image.asset(
            'assets/images/logo.png',
          )),
      Padding(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Text(
              'Food Core',
              style: TextStyle(
                  color: Color.fromARGB(255, 231, 231, 231),
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  fontFamily: 'Alice'),
            ),
            Text(' ',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Alice')),
          ],
        ),
      ),
      Padding(padding: const EdgeInsets.all(10), child: emailField),
      Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 5), child: passwordField),
      Container(
        padding: EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width - 20,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 216, 216, 216),
              onPrimary: Color.fromRGBO(160, 148, 227, 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              padding: EdgeInsets.all(15)),
          onPressed: () => {
            //forkeyvalidator
            // signIn(emailController.text, passwordController.text),
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const page1()),
            )
          },
          child: Text(
            'Login',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
      Container(
          padding: EdgeInsets.only(top: 10),
          width: MediaQuery.of(context).size.width - 15,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Don't have an account? ",
                  style: TextStyle(color: Colors.white),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterModal()));
                    },
                    child: Text(
                      'SignUp',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ))
              ])),
    ]));
  }
}
*/