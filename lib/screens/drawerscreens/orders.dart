import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodcore/tools/mealsmodel.dart';

class orderspage extends StatefulWidget {
  @override
  State<orderspage> createState() => _orderspageState();
}

class _orderspageState extends State<orderspage> {
  var user = FirebaseAuth.instance.currentUser;
  int Total = 0;
  //List<MealsModel> meals = [];
  int Totalamount = 0;
  int delivery = 20;

  @override
  Widget build(BuildContext context) {
    var ordersdatabase = FirebaseFirestore.instance
        .collection('users/${user!.uid}/orders')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => MealsModel.fromMap(doc)).toList());

    return StreamBuilder<List<MealsModel>>(
        stream: ordersdatabase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.active) {
            var meals = snapshot.data!;
            snapshot.data!
                .toList()
                .forEach((item) => Total = Total + item.price);
            Totalamount = delivery + Total;
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
                title: Text('Orders',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        fontFamily: 'OpenSans')),
                centerTitle: true,
              ),
              body: ListView(children: [
                ListView(
                  primary: false,
                  shrinkWrap: true,
                  children: meals.map(mealbuilder).toList(),
                ),
                Card(
                  child: Column(
                    children: [
                      Divider(color: Colors.white),
                      Row(children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 60,
                          child: Text(
                            'Delivery fee',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Text(
                          '${delivery.toString()} \$',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                          ),
                        ),
                      ]),
                      Divider(color: Colors.white),
                      Row(children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 60,
                          child: Text(
                            'Total amount',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          '${Totalamount.toString()} \$',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                      Divider(color: Colors.white),
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text('Accepted'),
                          content: Text('Confirmed Order'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text('Checkout'))
              ]),
            );
          }
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 3,
              backgroundColor: Colors.black,
              color: Colors.blueGrey,
            ),
          );
        });
  }

  Widget mealbuilder(MealsModel meal) => Card(
        child: Row(children: [
          SizedBox(width: MediaQuery.of(context).size.width * 0.03),
          Column(children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.48,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Text("${meal.price} QR"),
                ],
              ),
            ),
          ]),
          Column(
            children: [
              SizedBox(height: 28),
              IconButton(
                  onPressed: () {
                    deletemealfromorders(meal.name);
                    setState(() {
                      Total = Total - meal.price;
                      Totalamount = Total + delivery;
                    });
                  },
                  icon: Icon(Icons.close))
            ],
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.35,
              child: Image.network(
                meal.image,
              )),
        ]),
      );
}

void deletemealfromorders(String name) async {
  var firestore = FirebaseFirestore.instance;
  var user = FirebaseAuth.instance.currentUser;
  await firestore.collection('users/${user!.uid}/orders').doc(name).delete();
}
