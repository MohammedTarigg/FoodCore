import 'package:flutter/material.dart';
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
              delegate: SliverChildBuilderDelegate(
            childCount: 3,
            (context, index) => Container(),
          ))
        ],
      ),
    );
  }
}
