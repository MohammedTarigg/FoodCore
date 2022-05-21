import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodcore/tools/restaurantsModel.dart';

class homebody extends StatefulWidget {
  @override
  State<homebody> createState() => _homebodyState();
}

var conto = 'asa';

class _homebodyState extends State<homebody> {
  var database = FirebaseFirestore.instance
      .collection('restaurants')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => RestaurantsModel.fromMap(doc.data()))
          .toList());
  @override
  Widget build(BuildContext context) {
    return ListView(padding: EdgeInsets.only(top: 5), children: [
      Row(
        children: [
          GestureDetector(
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
            },
            child: Card(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 31 / 100,
                    child: Image.asset('assets/images/booking.jpg'),
                  ),
                  Text(
                    'Dine in',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontFamily: 'OpenSans'),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
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
            },
            child: Card(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 31 / 100,
                    child: Image.asset('assets/images/takeaway.jpg'),
                  ),
                  Text(
                    'Take away',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontFamily: 'OpenSans'),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
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
            },
            child: Card(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 31 / 100,
                    child: Image.asset('assets/images/delivery.jpg'),
                  ),
                  Text(
                    'Dilevery',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontFamily: 'OpenSans'),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      StreamBuilder<List<RestaurantsModel>>(
          stream: database,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.active) {
              return ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: snapshot.data!.map(buildrestaurant).toList());
            }
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                backgroundColor: Colors.black,
                color: Colors.blueGrey,
              ),
            );
          })
    ]);
  }

  Widget buildrestaurant(RestaurantsModel restaurant) => GestureDetector(
        onTap: () {},
        child: Card(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image(
                    fit: BoxFit.cover,
                    image: AssetImage(restaurant.image),
                    height: 150,
                    width: MediaQuery.of(context).size.width),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        //Color.fromARGB(204, 255, 255, 255),
                        //Color.fromARGB(0, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0),
                        Color.fromARGB(153, 0, 0, 0),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                left: 10,
                child: Text(
                  restaurant.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'OpenSans'),
                ),
              ),
              Positioned(
                bottom: 15,
                left: 15,
                child: Text(
                  restaurant.description,
                  style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white,
                      fontFamily: 'OpenSans'),
                ),
              ),
            ],
          ),
        ),
      );
}
