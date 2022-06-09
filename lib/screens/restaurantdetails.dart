import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodcore/tools/mealsmodel.dart';
import 'package:foodcore/tools/restaurantsModel.dart';

class restaurantdetails extends StatefulWidget {
  final RestaurantsModel restaurant;
  const restaurantdetails({required this.restaurant});

  @override
  State<restaurantdetails> createState() => _restaurantdetailsState();
}

class _restaurantdetailsState extends State<restaurantdetails> {
  @override
  Widget build(BuildContext context) {
    var mealsdatabase = FirebaseFirestore.instance
        .collection('restaurants/${widget.restaurant.name}/meals')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MealsModel.fromMap(doc.data()))
            .toList());
    //print(widget.restaurant.name);

    return StreamBuilder<List<MealsModel>>(
        stream: mealsdatabase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.active) {
            var meal = snapshot.data;
            //print(meal);
            return Scaffold(
              appBar: AppBar(
                //backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(widget.restaurant.name,
                    style: TextStyle(
                        color: Color.fromARGB(255, 231, 231, 231),
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        fontFamily: 'Alice')),
                centerTitle: true,
              ),
              body: CustomScrollView(
                slivers: [
                  SliverList(
                      delegate: SliverChildListDelegate(
                    [
                      GestureDetector(
                        onTap: () {},
                        child: Card(
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage(widget.restaurant.image),
                                    height: 120,
                                    width: MediaQuery.of(context).size.width),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  height: 120,
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
                              /*Positioned(
                            bottom: 30,
                            left: 10,
                            child: Text(
                              widget.restaurant.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontFamily: 'OpenSans'),
                            ),
                          ),*/
                              Positioned(
                                bottom: 15,
                                left: 15,
                                child: Text(
                                  widget.restaurant.description,
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
                      ),
                    ],
                  )),
                  SliverList(
                      delegate: SliverChildListDelegate(
                          meal!.map(mealbuilder).toList()))
                ],
              ),
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
                    postmealtoorders(meal.name, meal.price, meal.image);
                  },
                  icon: Icon(Icons.shopping_basket_outlined)),
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

void postmealtoorders(String name, int price, String image) async {
  var firestore = FirebaseFirestore.instance;
  var user = FirebaseAuth.instance.currentUser;
  var meal = MealsModel(name: name, price: price, image: image);
  await firestore
      .collection('users/${user!.uid}/orders')
      .doc(meal.name)
      .set(meal.toMap());
}
