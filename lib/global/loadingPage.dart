import 'package:bpm/style/Colors.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 100.0,
                height: 100.0,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              Container(
                child: Center(
                  child: Text('در حال دریافت اطلاعات ...',
                      textDirection:
                      TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'iran_yekan',
                        fontSize: 12.0,
                        color: Colors.black54,
                      )),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
