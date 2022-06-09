import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodcore/auth/registerModal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodcore/screens/home.dart';

class welcomepage extends StatefulWidget {
  const welcomepage({Key? key}) : super(key: key);

  @override
  State<welcomepage> createState() => _welcomepageState();
}

class _welcomepageState extends State<welcomepage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          if (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onFieldSubmitted: (value) {
          emailController.text = value;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(28, 0, 0, 0),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromARGB(255, 184, 184, 184))),
          icon: Icon(
            Icons.mail,
            color: Colors.white,
          ),
          contentPadding: EdgeInsets.fromLTRB(10, 15, 20, 15),
          label: Text(
            "Email",
            style: TextStyle(color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: true,
        // ignore: body_might_complete_normally_nullable
        validator: (value) {
          if (value == null || value.isEmpty || value.length <= 5) {
            return 'password length must be 6 or more';
          }
        },
        onFieldSubmitted: (value) {
          passwordController.text = value;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(28, 0, 0, 0),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromARGB(255, 184, 184, 184))),
          // prefixIcon: Icon(Icons.vpn_key),
          icon: Icon(
            Icons.vpn_key,
            color: Colors.white,
          ),
          contentPadding: EdgeInsets.fromLTRB(10, 15, 20, 15),
          label: Text(
            "Password",
            style: TextStyle(color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    Future signIn() async {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => page1()));
        // ignore: unused_catch_clause
      } on FirebaseAuthException catch (e) {
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: Text('Error'),
                  content: Text('Account is not registered'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: Text('OK'),
                    ),
                  ],
                ));
      }
    }

    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 84, 112, 126),
          Color.fromARGB(255, 116, 152, 184),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
              child: ListView(children: [
            Form(
              key: _loginKey,
              child: Column(
                children: [
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
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                      child: passwordField),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 216, 216, 216),
                          onPrimary: Colors.blueGrey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          padding: EdgeInsets.all(15)),
                      onPressed: () => {
                        if (_loginKey.currentState!.validate())
                          {
                            signIn(),
                          }
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
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterModal()));
                                },
                                child: Text(
                                  'SignUp',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ))
                          ])),
                ],
              ),
            ),
          ])),
        ),
      ),
    );
  }

  /*void validateEmail(String value) {
    bool _isValid = false;
    _isValid = EmailValidator.validate(value);
    if (_isValid) {
      emailController.text = value;
    } else if (value.isEmpty) {
      Fluttertoast.showToast(
          msg: 'Enter Email',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: 'Enter a Valid Email',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
  }*/
}
