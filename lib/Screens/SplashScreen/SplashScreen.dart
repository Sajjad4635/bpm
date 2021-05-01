import 'dart:async';

import 'package:bpm/API/api.dart';
import 'package:bpm/Screens/FirstScreen/FirstScreen.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
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

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _firstScreenScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    chekLogin();
//    fffremove();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _firstScreenScaffoldKey,
      backgroundColor: mainColor,
      body: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width/3),
        color: Colors.white,
        child: Center(
          child: Image.asset('images/ic_psp_logo.png'),
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
      checkFirebaseToken();
    }
  }

  chekLogin() async {
    print('check Login');
    SharedPreferences token = await SharedPreferences.getInstance();

    if (await checkInternetConnection()) {
      checkToken(token.getString('myIP_token'));
    }else {
      _firstScreenScaffoldKey.currentState.showSnackBar(new SnackBar(
          duration: new Duration(hours: 2),
          content: new GestureDetector(
              onTap: () {
                _firstScreenScaffoldKey.currentState.hideCurrentSnackBar();
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

  void navigationToFirstScreen() async{

    SharedPreferences token = await SharedPreferences.getInstance();

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => FirstScreen(1, token.getString('userName'))), (route) => false);
  }

  checkFirebaseToken() async{
    SharedPreferences sharedFirebase = await SharedPreferences.getInstance();

    var firebaseToken = sharedFirebase.getString('firebase_token');

    if (firebaseToken == null) {
      print('nulllllllllllllll');
      firebaseCloudMessaging_Listeners();
    } else {
      print('nooooootnuslllllllllllll');
      saveFirebaseTokenInServer(firebaseToken);
    }
  }

  void firebaseCloudMessaging_Listeners() {
    print('bbbbbbbbbbbb');
    _firebaseMessaging.getToken().then((firebase_token) {

      saveFirebaseTokenInServer(firebase_token);
    });
  }

  saveIpToken(String token) async {
    SharedPreferences fireBaseToken = await SharedPreferences.getInstance();

    await fireBaseToken.setString('firebase_token', token);
  }
  saveFirebaseTokenInServer(firebase_token) async{

    saveIpToken(firebase_token);

    print('fireBaseToken::::::::::::: $firebase_token');
    print('aaaaaaaaaaaaaaa');
    print('aaaaaaaaaaaaaaa');
    SharedPreferences token = await SharedPreferences.getInstance();
    print('Token::::::::::::: ${token.getString('myIP_token')}');
    print('my_device::::::::::::: ${token.getString('my_device')}');

    var response = await http.post(api.siteName + '/panel/customerappconfig.json', body: {
      "version_code": '${100000}',
      "firebase_token": '${firebase_token.toString()}',
      "token": '${token.getString('myIP_token')}',
      "pkg": '${token.getString('pkg')}',
      "device": '${token.getString('my_device')}',
    });

    print('start');

    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 200){
      Timer(Duration(seconds: 1), navigationToFirstScreen);
    }else if(response.statusCode == 401){
      navigationToPhone();
    }
  }

  fffremove() async{
    SharedPreferences token = await SharedPreferences.getInstance();
    token.remove('firebase_token');
    token.remove('myIP_token');
    print('removed');
  }
}
