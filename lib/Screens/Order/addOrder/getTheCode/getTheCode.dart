import 'package:bpm/style/Colors.dart';
import 'package:flutter/material.dart';

var okColorBack = themeColor;
var okColorNum = Colors.white;
var noColorBack = Color(0xffDADADA);
var noColorNum = Colors.black;

int selectedStep = 0;

class GetTheCode extends StatefulWidget {
  @override
  _GetTheCodeState createState() => _GetTheCodeState();
}

class _GetTheCodeState extends State<GetTheCode> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage('images/ic_back3.png'),
            fit: BoxFit.fitHeight,
            colorFilter: new ColorFilter.mode(
                Colors.blue.withOpacity(0.15), BlendMode.dstATop),
          )),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            children: [
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/8,
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: Colors.orange
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'بررسی سفارش',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'iran_yekan',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17.0),
                            ),
                            Text(
                              'درحال بررسی توسط کارشناسان',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color:
                                  selectedStep >= 3 ? okColorNum : noColorNum,
                                  fontFamily: 'iran_yekan',
                                  fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/8,
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: themeColor
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'مذاکرات',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'iran_yekan',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17.0),
                            ),
                            Text(
                              'فعال',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color:
                                  selectedStep >= 3 ? okColorNum : noColorNum,
                                  fontFamily: 'iran_yekan',
                                  fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Center(
                            child: Icon(
                              Icons.list,
                              color: Colors.white,
                              size: 50.0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/8,
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: themeColor
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'بارکد ساز',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'iran_yekan',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17.0),
                            ),
                            Text(
                              'فعال',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color:
                                  selectedStep >= 3 ? okColorNum : noColorNum,
                                  fontFamily: 'iran_yekan',
                                  fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Center(
                            child: Icon(
                              Icons.airplanemode_active,
                              color: Colors.white,
                              size: 50.0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/8,
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: Colors.red
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'فایل های سفارش',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'iran_yekan',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17.0),
                            ),
                            Text(
                              'منتظر عملیات مشتری',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color:
                                  selectedStep >= 3 ? okColorNum : noColorNum,
                                  fontFamily: 'iran_yekan',
                                  fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Center(
                            child: Icon(
                              Icons.airplanemode_active,
                              color: Colors.white,
                              size: 50.0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/8,
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: Color(0xff0040C4)
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'استعلام حمل',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'iran_yekan',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17.0),
                            ),
                            Text(
                              'غیر فعال',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color:
                                  selectedStep >= 3 ? okColorNum : noColorNum,
                                  fontFamily: 'iran_yekan',
                                  fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Center(
                            child: Icon(
                              Icons.airplanemode_active,
                              color: Colors.white,
                              size: 50.0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/8,
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: Color(0xff0040C4)
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'سایر استعلام ها',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'iran_yekan',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17.0),
                            ),
                            Text(
                              'غیر فعال',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color:
                                  selectedStep >= 3 ? okColorNum : noColorNum,
                                  fontFamily: 'iran_yekan',
                                  fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Center(
                            child: Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 50.0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/8,
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: Color(0xff0040C4)
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'پیش فاکتور',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'iran_yekan',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17.0),
                            ),
                            Text(
                              'غیر فعال',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color:
                                  selectedStep >= 3 ? okColorNum : noColorNum,
                                  fontFamily: 'iran_yekan',
                                  fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Center(
                            child: Icon(
                              Icons.offline_pin,
                              color: Colors.white,
                              size: 50.0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/8,
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: Color(0xff0040C4)
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'پرداخت',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'iran_yekan',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17.0),
                            ),
                            Text(
                              'غیر فعال',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color:
                                  selectedStep >= 3 ? okColorNum : noColorNum,
                                  fontFamily: 'iran_yekan',
                                  fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Center(
                            child: Icon(
                              Icons.offline_pin,
                              color: Colors.white,
                              size: 50.0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/8,
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: Color(0xff0040C4)
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'بارگیری کالا',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'iran_yekan',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17.0),
                            ),
                            Text(
                              'غیر فعال',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color:
                                  selectedStep >= 3 ? okColorNum : noColorNum,
                                  fontFamily: 'iran_yekan',
                                  fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Center(
                            child: Icon(
                              Icons.airplanemode_active,
                              color: Colors.white,
                              size: 50.0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/8,
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: themeColor
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'کالاهای بارگیری شده',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'iran_yekan',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17.0),
                            ),
                            Text(
                              'فعال',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color:
                                  selectedStep >= 3 ? okColorNum : noColorNum,
                                  fontFamily: 'iran_yekan',
                                  fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Center(
                            child: Icon(
                              Icons.list,
                              color: Colors.white,
                              size: 50.0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/8,
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: themeColor
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'تراکنش های چین',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'iran_yekan',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17.0),
                            ),
                            Text(
                              'فعال',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color:
                                  selectedStep >= 3 ? okColorNum : noColorNum,
                                  fontFamily: 'iran_yekan',
                                  fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Center(
                            child: Icon(
                              Icons.list,
                              color: Colors.white,
                              size: 50.0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/8,
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: themeColor
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'تخفیف پیش فاکتور',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'iran_yekan',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17.0),
                            ),
                            Text(
                              'فعال',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color:
                                  selectedStep >= 3 ? okColorNum : noColorNum,
                                  fontFamily: 'iran_yekan',
                                  fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Center(
                            child: Icon(
                              Icons.list,
                              color: Colors.white,
                              size: 50.0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/8,
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: themeColor
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'تغییرات سفارش',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'iran_yekan',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17.0),
                            ),
                            Text(
                              'فعال',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color:
                                  selectedStep >= 3 ? okColorNum : noColorNum,
                                  fontFamily: 'iran_yekan',
                                  fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Center(
                            child: Icon(
                              Icons.list,
                              color: Colors.white,
                              size: 50.0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/8,
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: themeColor
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'وضعیت کلی بار',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'iran_yekan',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17.0),
                            ),
                            Text(
                              'فعال',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color:
                                  selectedStep >= 3 ? okColorNum : noColorNum,
                                  fontFamily: 'iran_yekan',
                                  fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Center(
                            child: Icon(
                              Icons.airplanemode_active,
                              color: Colors.white,
                              size: 50.0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
