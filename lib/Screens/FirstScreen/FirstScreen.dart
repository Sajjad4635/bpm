import 'dart:async';

import 'package:bpm/API/api.dart';
import 'package:bpm/Screens/Cardboard/Cardboard.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bpm/Screens/Login/PhoneNumber.dart';
import 'package:bpm/Screens/chat/allCustomers/allChatsView.dart';
import 'package:bpm/global/deleteToken.dart';
import 'package:bpm/style/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

var drawerTitleList = [
  'پیشخوان',
  'کارتابل من',
  'اطلاع رسانی و آموزش',
  'پیام های من',
  'سفارش ها',
  'گزارش های مدیریتی',
  'گزارش های فنی',
  'انبار ها',
  'نرخ های ارز',
  'پرداخت',
  'گفت و گو با مشتری',
  'شماره تلفن های داخلی هلدینگ',
  'پیغام های مشتریان',
  'پروفایل کاربری',
  'تغییر کلمه عبور',
  'خروج',
];

var drawerIconList = [
  Icons.apps,
  Icons.folder,
  Icons.add_alarm_sharp,
  Icons.inbox,
  Icons.line_style,
  Icons.timeline,
  Icons.bug_report,
  Icons.stacked_bar_chart,
  Icons.monetization_on,
  Icons.attach_money,
  Icons.comment,
  Icons.phone,
  Icons.unarchive,
  Icons.contact_mail,
  Icons.lock,
  Icons.arrow_forward,
];

final GlobalKey<ScaffoldState> _FirstScreenScaffoldKey = new GlobalKey<ScaffoldState>();

var flagFirstScreen = 0;

class FirstScreen extends StatefulWidget {

  var selecteIdex;
  var userName;

  FirstScreen(this.selecteIdex, this.userName);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkFirebaseToken();
//    getUserDetail();
  }

  static List<Widget> ScreensList = <Widget>[
    Cardboard(),
    AllCustomers(),
  ];

  @override
  Widget build(BuildContext context) {
    setState(() {
      if(flagFirstScreen == 0){
        flagFirstScreen = 1;
      }
    });

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage('images/ic_back3.png'), fit: BoxFit.fitHeight,
            colorFilter: new ColorFilter.mode(Colors.blue.withOpacity(0.15), BlendMode.dstATop),
          )
      ),
      child: Scaffold(
          key: _FirstScreenScaffoldKey,
          backgroundColor: Colors.transparent,
          endDrawer: Directionality(
            textDirection: TextDirection.rtl,
            child: ClipPath(
              clipper: OvalLeftBorderClipper(),
              child: Drawer(
                child: Container(
                  padding: const EdgeInsets.only(left: 16.0, right: 40),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage('images/ic_back3.png'), fit: BoxFit.fitHeight,
                        colorFilter: new ColorFilter.mode(Colors.blue.withOpacity(0.15), BlendMode.dstATop),
                      )
                  ),
                  width: 300,
                  child: SafeArea(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  flex: 6,
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
//                                 gradient: LinearGradient(
//                                   colors: [Color(0xff00d170), Color(0xff00d170)],
//                                 )
                                    ),
//                              child: CircleAvatar(
//                                radius: 40,
//                                backgroundImage: AssetImage('images/Nerd-bro.png'),
//                              ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      '${widget.userName.toString()}',
                                      style: TextStyle(
                                          color: mainColor,
                                          fontFamily: 'iran_yekan',
                                          fontSize: 18.0
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30.0),
                          Expanded(
                            flex: 8,
                            child: Container(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: ListView.separated(
                                separatorBuilder: (context, index){
                                  return SizedBox(height: 5.0,);
                                },
                                itemCount: drawerTitleList.length,
                                itemBuilder: (context, index){
                                  return InkWell(
                                    onTap: () {
                                      navigatorRoot(index, context);
                                    },
                                    child: _buildRow(
                                        drawerIconList[index],
                                        Text(
                                          "${drawerTitleList[index].toString()}",
                                        )),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          appBar: AppBar(
            leading: Container(),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            actions: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: 8.0
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: Icon(Icons.menu, color: backIconColor,),
                          onPressed: (){
                            _FirstScreenScaffoldKey.currentState.openEndDrawer();
                          }),
//                    Container(
//                      color: Colors.red,
//                      child: Center(
//                        child: Text(
//                          'تایمر یادت نره',
//                          textDirection: TextDirection.rtl,
//                          textAlign: TextAlign.center,
//                          style: TextStyle(
//                              fontFamily: 'iran_yekan',
//                              fontSize: 16.0,
//                              color: mainColor),
//                        ),
//                      ),
//                    ),
                      Container(
                        width: MediaQuery.of(context).size.width/4,
                        child: Center(
                          child: Image.asset('images/ic_psp_logo.png'),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          body: Container(
            child: Container(
              child: ScreensList.elementAt(widget.selecteIdex),
            ),
          ),
          bottomNavigationBar: Container(
            width: MediaQuery.of(context).size.width,
            height: 60.0,
            decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black38,
                    offset: Offset(1.0, 3.0),
                    blurRadius: 5.0,
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                )
            ),
            child: Row(
              children: [
                Expanded(
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          widget.selecteIdex = 0;
                        });
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset('images/clipboard.svg',
                              width: 23.0,
                              height: 23.0,
                              color: widget.selecteIdex == 0
                                  ? Colors.blueAccent
                                  : Colors.black54,),
                            Text(
                              'کارتابل',
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'iran_yekan',
                                fontSize: 12.0,
                                color: widget.selecteIdex == 0
                                    ? Colors.blueAccent
                                    : Colors.black54,),
                            ),
                          ],
                        ),
                      ),
                    )
                ),
                Expanded(
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          flagAllCustomers = 0;
                          widget.selecteIdex = 1;
                        });
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset('images/chat.svg',
                              width: 23.0,
                              height: 23.0,
                              color: widget.selecteIdex == 1
                                  ? Colors.blueAccent
                                  : Colors.black54,),
                            Text(
                              'پیام ها',
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'iran_yekan',
                                fontSize: 12.0,
                                color:  widget.selecteIdex == 1
                                    ? Colors.blueAccent
                                    : Colors.black54,),
                            ),
                          ],
                        ),
                      ),
                    )
                ),
              ],
            ),
          )
      ),
    );
  }

  Widget _buildRow(IconData icon, Text title, {bool showBadge = false}) {
    final TextStyle tStyle =
    TextStyle(color: mainColor, fontSize: 14.0, fontFamily: 'iran_yekan');
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(children: [
        Icon(
          icon,
          color: mainColor,
        ),
        SizedBox(width: 10.0),
        Text(
          title.data,
          style: tStyle,
        ),
        Spacer(),
//        if (showBadge)
//          Material(
//            color: Colors.deepOrange,
//            elevation: 5.0,
//            shadowColor: Colors.red,
//            borderRadius: BorderRadius.circular(5.0),
//            child: Container(
//              width: 25,
//              height: 25,
//              alignment: Alignment.center,
//              decoration: BoxDecoration(
//                color: Colors.deepOrange,
//                borderRadius: BorderRadius.circular(5.0),
//              ),
//              child: Text(
//                "10+",
//                style: TextStyle(
//                    color: Colors.white,
//                    fontSize: 12.0,
//                    fontWeight: FontWeight.bold),
//              ),
//            ),
//          )
      ]),
    );
  }

  showDialogExitAcount(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            //this right here
            child: Container(
              padding: EdgeInsets.only(
                top: 15.0,
                bottom: 15.0,
                left:15.0,
                right: 15.0,
              ),
              decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: const Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                // To make the card compact
                children: <Widget>[
                  Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/Warning-rafiki.png'))),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'آیا می خواهید از حساب خود خارج شوید؟',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Aviny',
                        fontSize: 20.0,
                        color: Colors.black54),
                  ),
                  SizedBox(height: 24.0),

                  InkWell(
                    onTap: (){
                      exitAcount();
                      Navigator.pushNamedAndRemoveUntil(context, '/phoneNumber', (route) => false);
                    },
                    child: Container(
                      width: 75.0,
                      height: 45.0,
                      decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(18.0)),
                      child: Center(
                        child: Text(
                          'تایید',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Aviny',
                              fontSize: 20.0,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }



  exitAcount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('firebase_token');
    prefs.remove('myIp_token');
  }

  navigatorRoot(index, context) {
    if(index == 15){
      deleteToken();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => phoneNumber()));
    }
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

  firebaseCloudMessaging_Listeners() {
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
    SharedPreferences token = await SharedPreferences.getInstance();

    var response = await http.post(api.siteName + '/panel/customerappconfig.json', body: {
      "version_code": '${100000}',
      "firebase_token": '${firebase_token.toString()}',
      "token": '${token.getString('myIP_token')}',
      "pkg": '${token.getString('pkg')}',
      "device": '${token.getString('my_device')}',
    });

    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 200){
      print('fireBaseToken recived!');
    }
  }
}