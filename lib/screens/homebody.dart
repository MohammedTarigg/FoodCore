import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodcore/screens/filterpage.dart';
import 'package:foodcore/screens/restaurantdetails.dart';
import 'package:foodcore/tools/restaurantsModel.dart';

class homebody extends StatefulWidget {
  @override
  State<homebody> createState() => _homebodyState();
}

class _homebodyState extends State<homebody> {
  var database = FirebaseFirestore.instance
      .collection('restaurants')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => RestaurantsModel.fromMap(doc.data()))
          .toList());
  var types = [];
  List<RestaurantsModel> rests = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<RestaurantsModel>>(
        stream: database,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.active) {
            rests = snapshot.data!;
            snapshot.data!.forEach((element) {
              types.add(element.type);
            });
            print(types);
            return ListView(padding: EdgeInsets.only(top: 5), children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      rests = [];
                      snapshot.data!.forEach((element) {
                        if (element.type.contains('dinein')) {
                          print(element.name);
                          setState(() {
                            rests.add(element);
                          });
                        }
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => filterpage(rests: rests)));
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
                                fontWeight: FontWeight.w600,
                                fontFamily: 'OpenSans'),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      rests = [];
                      snapshot.data!.forEach((element) {
                        if (element.type.contains('takeaway')) {
                          print(element.name);
                          setState(() {
                            rests.add(element);
                          });
                        }
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => filterpage(rests: rests)));
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
                                fontWeight: FontWeight.w600,
                                fontFamily: 'OpenSans'),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      rests = [];
                      snapshot.data!.forEach((element) {
                        if (element.type.contains('delivery')) {
                          print(element.name);
                          setState(() {
                            rests.add(element);
                          });
                        }
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => filterpage(rests: rests)));
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
                                fontWeight: FontWeight.w600,
                                fontFamily: 'OpenSans'),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: rests.map(buildrestaurant).toList())
            ]);
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

  Widget buildrestaurant(RestaurantsModel restaurant) => GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      restaurantdetails(restaurant: restaurant)));
        },
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
