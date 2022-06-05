import 'package:flutter/material.dart';

class aboutuspage extends StatefulWidget {

  @override
  State<aboutuspage> createState() => _aboutuspageState();
}

class _aboutuspageState extends State<aboutuspage> {
  @override
  Widget build(BuildContext context) {
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
          title: Text('Abous Us',
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
              padding: EdgeInsets.all(20),
              child: Card(
                child: Column(children: [
                  Card(
                    child: Text(
                        "Mohammed Tarig  is the Head of Food Core where he oversees all functions of the business including engineering, product and operations. A designer at heart, Mohammed is known for balancing sharp design thinking with thoughtful product strategy to create experiences that bring people together and encourage authentic communication."),
                    /*child: RichText(
                      text: TextSpan(text: "Mohammed Tarig  is the Head of Food Core where he oversees all functions of the business including engineering, product and operations. A designer at heart, Mohammed is known for balancing sharp design thinking with thoughtful product strategy to create experiences that bring people together and encourage authentic communication.",
                          //style: TextStyle(fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text:
                                    " is the Head of Food Core where he oversees all functions of the business including engineering, product and operations.",
                                style: TextStyle(fontWeight: FontWeight.normal),
                                children: [
                                  TextSpan(
                                      text:
                                          " A designer at heart, Mohammed is known for balancing sharp design thinking with thoughtful product strategy to create experiences that bring people together and encourage authentic communication.")
                                ])
                          ]),
                    ),*/
                  ),
                  Divider(thickness: 0.5),
                  Card(
                    child: Text(
                        "Mohammed has been at Food Core for more than ten years. He was design director for Food Core's mobile apps and then moved into product management where he led the News Feed product and engineering teams for many years. He was Head of News Feed prior to joining Food Core where he oversaw product before managing the entire organization."),
                  ),
                  Divider(thickness: 0.5),
                  Card(
                    child: Text(
                        'We’ve updated our Terms of Use, Data Policy, and Cookies Policy to reflect the new name on January 4, 2022. While our company name has changed, we are continuing to offer the same products, including Food Core from Meta. Our Data Policy and Terms of Use remain in effect, and this name change does not affect how we use or share data'),
                  )
                ]),
              ),
            )
          ],
        ));
  }
}

/*import 'package:flutter/material.dart';

class feedbackpage extends StatefulWidget {
  const feedbackpage({Key? key}) : super(key: key);

  @override
  State<feedbackpage> createState() => _feedbackpageState();
}

class _feedbackpageState extends State<feedbackpage> {
  var feedbackcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 5, 0, 0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(children: [
            ]),
          ],
        ),
      ),
    );
  }
}*/


/*import 'package:flutter/material.dart';

class feedbackpage extends StatelessWidget {
  const feedbackpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var feedbackcontroller = TextEditingController();
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
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(50, 100, 10, 0),
        child: Column(
          children: [
            Row(children: [
              Text('Issue',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      fontFamily: 'OpenSans')),
              Card(
                child: TextFormField(
                    controller: feedbackcontroller,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search ...',
                        filled: true,
                        fillColor: Color.fromARGB(28, 0, 0, 0),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 156, 156, 156))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 184, 184, 184)))),
                    onChanged: (value) {
                      feedbackcontroller.text = value;
                    }),
              )
            ]),
          ],
        ),
      ),
    );
  }
}*/
