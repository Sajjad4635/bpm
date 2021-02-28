import 'package:bpm/Screens/Login/PhoneNumber.dart';
import 'package:bpm/global/deleteToken.dart';
import 'package:bpm/style/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class LightDrawerPage extends StatelessWidget {

  final Color active = mainColor;
  final Color activeT = Colors.black87;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ClipPath(
        clipper: OvalLeftBorderClipper(),
        child: Drawer(
          child: Container(
            padding: const EdgeInsets.only(left: 16.0, right: 40),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xffffffff), Color(0xffffffff)],
                    end: Alignment.bottomRight,
                    begin: Alignment.topRight),
                boxShadow: [BoxShadow(color: Colors.black45)]),
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
                                'نام کاربر',
                                style: TextStyle(
                                    color: mainColor,
                                    fontFamily: 'iran_yekan'),
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
    );
  }

  Widget _buildRow(IconData icon, Text title, {bool showBadge = false}) {
    final TextStyle tStyle =
    TextStyle(color: activeT, fontSize: 14.0, fontFamily: 'iran_yekan');
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(children: [
        Icon(
          icon,
          color: active,
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
}
