import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodcore/auth/welcomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodcore/screens/home.dart';
import 'package:foodcore/tools/userModel.dart';

class RegisterModal extends StatefulWidget {
  const RegisterModal({Key? key}) : super(key: key);

  @override
  State<RegisterModal> createState() => _RegisterModalState();
}

class _RegisterModalState extends State<RegisterModal> {
  bool isLoading = false;
  final _registerkey = GlobalKey<FormState>();
  final firstNameEditingController = TextEditingController();
  final secondNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();
  loading() {
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final firstNameField = TextFormField(
        autofocus: false,
        controller: firstNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("First Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
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
          contentPadding: EdgeInsets.fromLTRB(10, 15, 20, 15),
          label: Text("First Name", style: TextStyle(color: Colors.white)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final secondNameField = TextFormField(
        autofocus: false,
        controller: secondNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Second Name cannot be Empty");
          }
          return null;
        },
        onChanged: (value) {
          secondNameEditingController.text = value;
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
          contentPadding: EdgeInsets.fromLTRB(10, 15, 20, 15),
          label: Text("Second Name", style: TextStyle(color: Colors.white)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onChanged: (value) {
          emailEditingController.text = value;
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
            color: Color.fromARGB(255, 218, 218, 218),
          ),
          contentPadding: EdgeInsets.fromLTRB(10, 15, 20, 15),
          label: Text('Email', style: TextStyle(color: Colors.white)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: true,
        // ignore: body_might_complete_normally_nullable
        validator: (value) {
          RegExp regex = RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onChanged: (value) {
          passwordEditingController.text = value;
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
            Icons.vpn_key,
            color: Color.fromARGB(255, 218, 218, 218),
          ),
          contentPadding: EdgeInsets.fromLTRB(10, 15, 20, 15),
          label: Text('Password', style: TextStyle(color: Colors.white)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: true,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "Password don't match";
          }
          return null;
        },
        onChanged: (value) {
          confirmPasswordEditingController.text = value;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(28, 0, 0, 0),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Color.fromARGB(255, 218, 218, 218),
          )),
          icon: Icon(
            Icons.vpn_key,
            color: Color.fromARGB(255, 212, 212, 212),
          ),
          contentPadding: EdgeInsets.fromLTRB(10, 15, 20, 15),
          label: Text(
            'Confirm Password',
            style: TextStyle(color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 84, 112, 126),
                  Color.fromARGB(255, 155, 176, 194),
                ], begin: Alignment.bottomLeft, end: Alignment.topRight))),
            Column(
              children: [
                SizedBox(height: 85),
                Container(
                  width: MediaQuery.of(context).size.width - 30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Form(
                  key: _registerkey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Flexible(child: firstNameField),
                          SizedBox(width: 3),
                          Flexible(child: secondNameField),
                          SizedBox(width: 10)
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(7, 10, 10, 7),
                        child: emailField,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(7, 5, 10, 7),
                        child: passwordField,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(7, 5, 10, 7),
                        child: confirmPasswordField,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 10,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(204, 255, 255, 255),
                        onPrimary: Colors.blueGrey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.all(15)),
                    onPressed: () => {
                      if (_registerkey.currentState!.validate())
                        {
                          loading(),
                          signUp(emailEditingController.text,
                              passwordEditingController.text),
                        }
                    },
                    child: isLoading
                        ? CircularProgressIndicator(
                            strokeWidth: 6,
                            backgroundColor: Colors.black,
                            color: Colors.blueGrey,
                          )
                        : Text(
                            'Register',
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
                            "Already have an account? ",
                            style: TextStyle(
                                color: Color.fromARGB(255, 218, 218, 218)),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => welcomepage()));
                              },
                              child: Text(
                                'SignIn',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ))
                        ])),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()});
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text('Error'),
              content: Text('Please enter a valid email address.'),
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
          break;
        case "user-disabled":
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text('Error'),
              content: Text('This email has been disabled.'),
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
          break;
        case "too-many-requests":
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text('Error'),
              content: Text('Too many requests ,try again later.'),
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
          break;
        case "operation-not-allowed":
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text('Error'),
              content:
                  Text('Signing in with Email and Password is not enabled.'),
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
          break;
        case "email-already-in-use":
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text('Error'),
              content: Text(
                  'Someone already has this email address. Try another email.'),
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
          break;
        default:
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text('Error'),
              content: Text('An undefined Erorr happened, try again.'),
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
  }

  postDetailsToFirestore() async {
    var firebaseFirestore = FirebaseFirestore.instance;
    var user = FirebaseAuth.instance.currentUser;

    UserModel USERMODEL = UserModel();

    // writing all the values
    USERMODEL.email = user!.email;
    USERMODEL.uid = user.uid;
    USERMODEL.firstName = firstNameEditingController.text;
    USERMODEL.secondName = secondNameEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(USERMODEL.toMap());

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page1()));
  }
}
