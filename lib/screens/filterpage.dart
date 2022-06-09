import 'package:flutter/material.dart';
import 'package:foodcore/screens/restaurantdetails.dart';
import 'package:foodcore/tools/restaurantsModel.dart';

class filterpage extends StatefulWidget {
  final List<RestaurantsModel> rests;
  const filterpage({required this.rests});

  @override
  State<filterpage> createState() => _dineinpageState();
}

class _dineinpageState extends State<filterpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('Restaurants',
            style: TextStyle(
                color: Color.fromARGB(255, 231, 231, 231),
                fontWeight: FontWeight.bold,
                fontSize: 25,
                fontFamily: 'Alice')),
      ),
      body: ListView(
          shrinkWrap: true,
          primary: false,
          children: widget.rests.map(buildrestaurant).toList()),
    );
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
