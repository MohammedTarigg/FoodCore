import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodcore/screens/restaurantdetails.dart';
import 'package:foodcore/tools/globals.dart';
import 'package:foodcore/tools/restaurantsModel.dart';
import 'package:foodcore/tools/globals.dart' as globals;
//import 'package:anim_search_bar/anim_search_bar.dart';

class searchpage extends StatefulWidget {
  const searchpage({Key? key}) : super(key: key);

  @override
  State<searchpage> createState() => _searchpageState();
}

bool ash(String restauarntname) {
  int index = 0;
  if (globals.searchtext!.isNotEmpty) {
    if (globals.searchtext!.toLowerCase()[index] ==
        restauarntname.toLowerCase()[index]) {
      index = index + 1;
      return true;
    } else {
      return false;
    }
  }
  return false;
}

class _searchpageState extends State<searchpage> {
  var database = FirebaseFirestore.instance
      .collection('restaurants')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => RestaurantsModel.fromMap(doc.data()))
          .toList());
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    globals.context = context;
    globals.searchtext = searchController.text;
    return Column(children: [
      /*AnimSearchBar(
        width: MediaQuery.of(context).size.width - 100,
        textController: searchController,
        onSuffixTap: () {
          setState(() {
            searchController.clear();
          });
        },
      ),*/
      Container(
          margin: EdgeInsets.fromLTRB(25, 10, 25, 5),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                hintText: 'Search ...',
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 156, 156, 156))),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 184, 184, 184)))),
            autofocus: true,
            onChanged: (value) {
              setState(() {
                globals.searchtext = value.toLowerCase();
              });
            },
          )),
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
}

Widget buildrestaurant(RestaurantsModel restaurant) => GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => restaurantdetails(restaurant: restaurant)));
    },
    child: ash(restaurant.name) //== restaurant.name.toLowerCase()
        ? Card(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image(
                    fit: BoxFit.cover,
                    image: AssetImage(restaurant.image),
                    height: 150,
                    width: MediaQuery.of(globals.context).size.width,
                  ),
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
          )
        : SizedBox());
