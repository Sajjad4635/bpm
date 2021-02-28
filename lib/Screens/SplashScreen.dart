import 'dart:async';

import 'package:bpm/Screens/FirstScreen/FirstScreen.dart';
import 'package:flutter/material.dart';
import 'package:bpm/Screens/Login/PhoneNumber.dart';
import 'package:bpm/style/Colors.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    chekLogin();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: mainColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width/3),
          color: Colors.white,
          child: Center(
            child: Image.asset('images/ic_psp_logo.png'),
          ),
        ),
      ),
    );
  }

  checkToken(token) async{
    print('checkToken');
    if (token == null) {
      print('token null');
      Timer(Duration(seconds: 3), navigationToPhone);
    } else {
      Timer(Duration(seconds: 3), navigationToFirstScreen);
    }
  }

  chekLogin() async {
    print('check Login');
    SharedPreferences token = await SharedPreferences.getInstance();

    if (await checkInternetConnection()) {
      checkToken(token.getString('myIP_token'));
    }else {
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
          duration: new Duration(hours: 2),
          content: new GestureDetector(
              onTap: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
                chekLogin();
              },
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Text(
                      'شما آفلاین هستید برای تلاش مجدد کلیک کنید!',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontFamily: 'Aviny', fontSize: 13.0),
                    ),
                    Icon(
                      Icons.signal_wifi_off,
                      color: Colors.white,
                    )
                  ],
                ),
              ))));
    }
  }

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }

  void navigationToPhone() {
    print('navigationToPhone');
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => phoneNumber()), (route) => false);
  }

  void navigationToFirstScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => FirstScreen(1)));
  }
}
