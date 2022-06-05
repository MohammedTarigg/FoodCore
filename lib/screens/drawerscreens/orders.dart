import 'package:flutter/material.dart';

class orderspage extends StatefulWidget {

  @override
  State<orderspage> createState() => _orderspageState();
}

class _orderspageState extends State<orderspage> {
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
        title: Text('Orders',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                fontFamily: 'OpenSans')),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [Text('data'), Text('data'), Text('data')],
          ),
        ),
      ),
    );
  }
}
