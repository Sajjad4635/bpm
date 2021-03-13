import 'dart:ffi';

import 'package:bpm/Screens/Order/OrderView.dart';
import 'package:bpm/style/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cardboard extends StatefulWidget {
  @override
  _CardboardState createState() => _CardboardState();
}

class _CardboardState extends State<Cardboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60.0,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 5.0),
                ),
              ],
            ),
            child: Center(
              child: Text(
                'کارتابل های اجرایی',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: 'iran_yekan',
                  fontSize: 15.0,
                  color: Colors.white
                ),
              ),
            ),
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Order()));
        },
        child: Icon(
          Icons.shopping_cart,
        ),
      ),
    );
  }
}
