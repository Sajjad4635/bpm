import 'package:bpm/Screens/FirstScreen/LightDrawerPage.dart';
import 'package:bpm/Screens/Operation/OpereationView.dart';
import 'package:bpm/Screens/Orders/OrdersView.dart';
import 'package:bpm/Screens/Wallet/WalletView.dart';
import 'package:bpm/Screens/chat/allCustomers/allChatsView.dart';
import 'package:bpm/style/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

final GlobalKey<ScaffoldState> _FirstScreenScaffoldKey = new GlobalKey<ScaffoldState>();

class FirstScreen extends StatefulWidget {

  var selecteIdex;

  FirstScreen(this.selecteIdex);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  static List<Widget> ScreensList = <Widget>[
    Orders(),
    Operation(),
    Wallet()
  ];

  void _onItemTapped(int index) {
    setState(() {
      widget.selecteIdex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        endDrawer: LightDrawerPage(),
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
                    IconButton(
                        icon: Icon(Icons.phone, color: backIconColor,),
                        onPressed: (){
                          launch("tel://+982142281");
                        }),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/3,
                    ),
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
                            'سفارشات',
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'iran_yekan',
                                fontSize: 12.0,
                                color:  widget.selecteIdex == 0
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
                          widget.selecteIdex = 1;
                        });
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset('images/operation.svg',
                              width: 23.0,
                              height: 23.0,
                              color: widget.selecteIdex == 1
                                  ? Colors.blueAccent
                                  : Colors.black54,),
                            Text(
                              'عملیات',
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'iran_yekan',
                                  fontSize: 12.0,
                                color: widget.selecteIdex == 1
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
                          widget.selecteIdex = 2;
                        });
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset('images/wallet.svg',
                              width: 23.0,
                              height: 23.0,
                              color: widget.selecteIdex == 2
                                  ? Colors.blueAccent
                                  : Colors.black54,),
                            Text(
                              'کیف پول',
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'iran_yekan',
                                  fontSize: 12.0,
                                color: widget.selecteIdex == 2
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
}
