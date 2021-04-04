import 'package:bpm/style/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with TickerProviderStateMixin{
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
                  child: SpinKitFoldingCube(
                    color: themeColor ,
                    size: 30.0,
                    duration: Duration(milliseconds: 1000),
                  ),
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
                        color: themeColor,
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