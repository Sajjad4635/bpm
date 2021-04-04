import 'dart:convert';

import 'package:bpm/API/api.dart';
import 'package:bpm/Screens/Order/FactoryRegisterForm.dart';
import 'package:bpm/Screens/Order/UserRegisterForm.dart';
import 'package:bpm/Screens/Order/addOrder/addOrder.dart';
import 'package:bpm/Screens/Order/addOrder/finalReview/finalReview.dart';
import 'package:bpm/Screens/Order/checkOrderList.dart';
import 'package:bpm/global/loadingPage.dart';
import 'package:bpm/style/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:http/http.dart' as http;

var orderType;
var transportType;
var incoBrake;
var typeAndTypeOfTransport;

var orderTypeKey;
var transportTypeKey;
var incoBrakeKey;
var typeAndTypeOfTransportKey;

List <OrderInformation> allOrderType = new List();
List <OrderInformation> allTransportType = new List();
List <OrderInformation> allIncoBrake = new List();
List <OrderInformation> allTypeAndTypeOfTransport = new List();

var productType = null;
var unitNumber = null;
var unitProductValue = null;
var HSCODE = null;

var shipperCity = null;
var senderPerson = null;
var senderCompany = null;

var recipientCity = null;
var recipientPerson = null;
var recipientCompany = null;

var IssuanceOfSub_billOfLading = null; //صدور بارنامه فرعی
var Pre_invoiceTypeOfShipment = null; //نوع پیش فاکتور حمل
var Pre_invoiceTypeOfOtherServices = null; //نوع پیش فاکتور سایر خدمات
var Pre_invoiceInTheNameOfThePerson = null; //پیش فاکتور به نام فرد
var Pre_invoiceInTheNameOfTheCompany = null; //پیش فاکتور به نام شرکت

var flagAdditionalInformation = 0;

class AdditionalInformation extends StatefulWidget {
  @override
  _AdditionalInformationState createState() => _AdditionalInformationState();
}

class _AdditionalInformationState extends State<AdditionalInformation>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    setState(() {
      if (flagAdditionalInformation == 0) {
        getAllList();
        flagAdditionalInformation = 1;
      }
    });

    final List<Tab> myTabs = <Tab>[
      Tab(
        text: 'کالاهای این سفارش',
      ),
      Tab(
        text: 'اطلاعات فرستنده',
      ),
      Tab(
        text: 'اطلاعات گیرنده',
      ),
      Tab(
        text: 'مسیر سفارش',
      ),
    ];

    TabController _tabController;

    _tabController = new TabController(vsync: this, length: myTabs.length);

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
        child: DefaultTabController(
            length: 4,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: TabBar(
                controller: _tabController,
                unselectedLabelColor: Colors.black38,
                isScrollable: true,
                labelColor: themeColor,
                labelStyle: TextStyle(fontFamily: 'iran_yekan', fontSize: 14.0),
                tabs: myTabs,
              ),
              body: TabBarView(
                controller: _tabController,
                children: [
                  //*********************************TAB 1************************************************
                  Container(
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            child: ListView(
                              children: [
                                Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      checkOrderList()));
                                        },
                                        child: Container(
                                          width: 200.0,
                                          height: 50.0,
                                          margin: EdgeInsets.only(
                                              top: 10.0, bottom: 20.0),
                                          decoration: BoxDecoration(
                                              color: themeColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0))),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            textDirection: TextDirection.rtl,
                                            children: [
                                              Text(
                                                'کالاهای این سفارش',
                                                textDirection: TextDirection
                                                    .rtl,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'iran_yekan',
                                                    fontSize: 14.0),
                                              ),
                                              Icon(
                                                Icons.shopping_cart,
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        addOrder()));
                                          });
                                        },
                                        child: Container(
                                          width: 50.0,
                                          height: 50.0,
                                          margin: EdgeInsets.only(
                                              top: 10.0, bottom: 20.0),
                                          decoration: BoxDecoration(
                                              color: themeColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(100.0))),
                                          child: Center(
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setOrderType();
                                  },
                                  child: Container(
                                    height: 50.0,
                                    margin:
                                    EdgeInsets.only(left: 20.0, right: 20.0),
                                    padding:
                                    EdgeInsets.only(left: 15.0, right: 15.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                        border: Border.all(
                                            color: themeColor),
                                        color: Colors.white),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      textDirection: TextDirection.rtl,
                                      children: [
                                        Container(
                                          child: Center(
                                            child: Text(
                                              'نوع سفارش',
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: themeColor,
                                                  fontFamily: 'iran_yekan',
                                                  fontSize: 15.0),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Center(
                                            child: Text(
                                              orderType == null
                                                  ? 'انتخاب کنید'
                                                  : orderType,
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontFamily: 'iran_yekan'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    settransportType();
                              },
                                  child: Container(
                                    height: 50.0,
                                    margin:
                                    EdgeInsets.only(left: 20.0, right: 20.0),
                                    padding:
                                    EdgeInsets.only(left: 15.0, right: 15.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                        border: Border.all(
                                            color: themeColor),
                                        color: Colors.white),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      textDirection: TextDirection.rtl,
                                      children: [
                                        Container(
                                          child: Center(
                                            child: Text(
                                              'نوع حمل',
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: themeColor,
                                                  fontFamily: 'iran_yekan',
                                                  fontSize: 15.0),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Center(
                                            child: Text(
                                              transportType == null
                                                  ? 'انتخاب کنید'
                                                  : transportType,
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontFamily: 'iran_yekan'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                GestureDetector(
                                  onTap: () {

                                  },
                                  child: Container(
                                    height: 50.0,
                                    margin:
                                    EdgeInsets.only(left: 20.0, right: 20.0),
                                    padding:
                                    EdgeInsets.only(left: 15.0, right: 15.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                        border: Border.all(
                                            color: themeColor),
                                        color: Colors.white),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      textDirection: TextDirection.rtl,
                                      children: [
                                        Container(
                                          child: Center(
                                            child: Text(
                                              'اینکو ترمز',
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: themeColor,
                                                  fontFamily: 'iran_yekan',
                                                  fontSize: 15.0),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Center(
                                            child: Text(
                                              incoBrake == null
                                                  ? 'انتخاب کنید'
                                                  : incoBrake,
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontFamily: 'iran_yekan'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                GestureDetector(
                                  onTap: () {

                                  },
                                  child: Container(
                                    height: 50.0,
                                    margin:
                                    EdgeInsets.only(left: 20.0, right: 20.0),
                                    padding:
                                    EdgeInsets.only(left: 15.0, right: 15.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                        border: Border.all(
                                            color: themeColor),
                                        color: Colors.white),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      textDirection: TextDirection.rtl,
                                      children: [
                                        Container(
                                          child: Center(
                                            child: Text(
                                              'نوع زمان حمل',
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: themeColor,
                                                  fontFamily: 'iran_yekan',
                                                  fontSize: 15.0),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Center(
                                            child: Text(
                                              typeAndTypeOfTransport == null
                                                  ? 'انتخاب کنید'
                                                  : typeAndTypeOfTransport,
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontFamily: 'iran_yekan'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  height: 50.0,
                                  margin:
                                  EdgeInsets.only(right: 20.0, left: 20.0),
                                  padding:
                                  EdgeInsets.only(right: 20.0, left: 20.0),
                                  decoration: BoxDecoration(
                                      color: themeColor,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                      border: Border.all(color: Colors.white)),
                                  child: Row(
                                    textDirection: TextDirection.rtl,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'جمع وزن جرمی(kg)',
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            fontFamily: 'iran_yekan',
                                            color: Colors.white),
                                      ),
                                      ((number.text == '') ||
                                          (unitWeight.text == ''))
                                          ? Text(
                                        '0',
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            fontFamily: 'iran_yekan',
                                            color: Colors.white),
                                      )
                                          : Text(
                                        (double.parse(number.text) *
                                            double.parse(
                                                unitWeight.text))
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            fontFamily: 'iran_yekan',
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  height: 50.0,
                                  margin:
                                  EdgeInsets.only(right: 20.0, left: 20.0),
                                  padding:
                                  EdgeInsets.only(right: 20.0, left: 20.0),
                                  decoration: BoxDecoration(
                                      color: themeColor,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                      border: Border.all(color: Colors.white)),
                                  child: Row(
                                    textDirection: TextDirection.rtl,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'جمع وزن حجمی (kg)',
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            fontFamily: 'iran_yekan',
                                            color: Colors.white),
                                      ),
                                      ((number.text == '') ||
                                          (unitWeight.text == ''))
                                          ? Text(
                                        '0',
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            fontFamily: 'iran_yekan',
                                            color: Colors.white),
                                      )
                                          : Text(
                                        (double.parse(number.text) *
                                            double.parse(
                                                unitWeight.text))
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            fontFamily: 'iran_yekan',
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  height: 50.0,
                                  margin:
                                  EdgeInsets.only(right: 20.0, left: 20.0),
                                  padding:
                                  EdgeInsets.only(right: 20.0, left: 20.0),
                                  decoration: BoxDecoration(
                                      color: themeColor,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                      border: Border.all(color: Colors.white)),
                                  child: Row(
                                    textDirection: TextDirection.rtl,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'وزن قابل پرداخت سفارش (kg)',
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            fontFamily: 'iran_yekan',
                                            color: Colors.white),
                                      ),
                                      ((number.text == '') ||
                                          (unitWeight.text == ''))
                                          ? Text(
                                        '0',
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            fontFamily: 'iran_yekan',
                                            color: Colors.white),
                                      )
                                          : Text(
                                        (double.parse(number.text) *
                                            double.parse(
                                                unitWeight.text))
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            fontFamily: 'iran_yekan',
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  height: 50.0,
                                  margin:
                                  EdgeInsets.only(right: 20.0, left: 20.0),
                                  padding:
                                  EdgeInsets.only(right: 20.0, left: 20.0),
                                  decoration: BoxDecoration(
                                      color: themeColor,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                      border: Border.all(color: Colors.white)),
                                  child: Row(
                                    textDirection: TextDirection.rtl,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'ارزش کل',
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            fontFamily: 'iran_yekan',
                                            color: Colors.white),
                                      ),
                                      ((number.text == '') ||
                                          (unitWeight.text == ''))
                                          ? Text(
                                        '0',
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            fontFamily: 'iran_yekan',
                                            color: Colors.white),
                                      )
                                          : Text(
                                        (double.parse(number.text) *
                                            double.parse(
                                                unitWeight.text))
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            fontFamily: 'iran_yekan',
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _tabController
                                            .animateTo(
                                            _tabController.index + 1);
                                      },
                                      child: Container(
                                        width: 120.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                            color: Colors.white,
                                            border: Border.all(
                                                color: themeColor)),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              'ادامه',
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontFamily: 'iran_yekan',
                                                  color: themeColor),
                                            ),
                                            Icon(
                                              Icons.arrow_forward,
                                              color: themeColor,
                                              size: 20.0,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 120.0,
                                      height: 50.0,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20.0,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //*********************************TAB 1************************************************
                  //*********************************TAB 2************************************************
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20.0, right: 20.0),
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15.0)),
                              border: Border.all(color: themeColor),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            textDirection: TextDirection.rtl,
                            children: [
                              Container(
                                child: Center(
                                  child: Text(
                                    'شهر ارسال کننده',
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: themeColor,
                                        fontFamily: 'iran_yekan',
                                        fontSize: 15.0),
                                  ),
                                ),
                              ),
                              Container(
                                child: Center(
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: DropdownButton<String>(
                                      hint: Text(
                                        'انتخاب کنید',
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: 'iran_yekan'),
                                      ),
                                      value: shipperCity,
                                      underline: Container(),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: 'iran_yekan',
                                          color: Colors.black54),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          shipperCity = newValue;
                                        });
                                      },
                                      items: <String>[
                                        "tehran",
                                        "yen",
                                        "tabriz",
                                      ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20.0, right: 20.0),
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15.0)),
                              border: Border.all(color: themeColor),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            textDirection: TextDirection.rtl,
                            children: [
                              Container(
                                child: Center(
                                  child: Text(
                                    'شخص ارسال کننده',
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: themeColor,
                                        fontFamily: 'iran_yekan',
                                        fontSize: 15.0),
                                  ),
                                ),
                              ),
                              Container(
                                child: Center(
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: DropdownButton<String>(
                                      hint: Text(
                                        'انتخاب کنید',
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: 'iran_yekan'),
                                      ),
                                      value: senderPerson,
                                      underline: Container(),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: 'iran_yekan',
                                          color: Colors.black54),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          senderPerson = newValue;
                                        });
                                      },
                                      items: <String>[
                                        "tehran",
                                        "yen",
                                        "tabriz",
                                      ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          textDirection: TextDirection.rtl,
                          children: [
                            Text(
                              'افزودن شخص',
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: themeColor,
                                  fontFamily: 'iran_yekan',
                                  fontSize: 16.0),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UserRegisterForm()));
                              },
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(100.0)),
                                    color: themeColor),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20.0, right: 20.0),
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15.0)),
                              border: Border.all(color: themeColor),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            textDirection: TextDirection.rtl,
                            children: [
                              Container(
                                child: Center(
                                  child: Text(
                                    'شرکت ارسال کننده',
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: themeColor,
                                        fontFamily: 'iran_yekan',
                                        fontSize: 15.0),
                                  ),
                                ),
                              ),
                              Container(
                                child: Center(
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: DropdownButton<String>(
                                      hint: Text(
                                        'انتخاب کنید',
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: 'iran_yekan'),
                                      ),
                                      value: senderCompany,
                                      underline: Container(),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: 'iran_yekan',
                                          color: Colors.black54),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          senderCompany = newValue;
                                        });
                                      },
                                      items: <String>[
                                        "tehran",
                                        "yen",
                                        "tabriz",
                                      ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          textDirection: TextDirection.rtl,
                          children: [
                            Text(
                              'افزودن شرکت',
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: themeColor,
                                  fontFamily: 'iran_yekan',
                                  fontSize: 16.0),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FactoryRegisterForm()));
                              },
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(100.0)),
                                    color: themeColor),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          textDirection: TextDirection.rtl,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _tabController
                                    .animateTo(_tabController.index + 1);
                              },
                              child: Container(
                                width: 120.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                    color: Colors.white,
                                    border: Border.all(color: themeColor)),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'ادامه',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: 'iran_yekan',
                                          color: themeColor),
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: themeColor,
                                      size: 20.0,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _tabController
                                    .animateTo(_tabController.index - 1);
                              },
                              child: Container(
                                width: 120.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                    color: Colors.white,
                                    border: Border.all(color: themeColor)),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    Text(
                                      'قبلی',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: 'iran_yekan',
                                          color: themeColor),
                                    ),
                                    Icon(
                                      Icons.arrow_back,
                                      color: themeColor,
                                      size: 20.0,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //*********************************TAB 2************************************************
                  //*********************************TAB 3************************************************
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20.0, right: 20.0),
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15.0)),
                              border: Border.all(color: themeColor),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            textDirection: TextDirection.rtl,
                            children: [
                              Container(
                                child: Center(
                                  child: Text(
                                    'شهر دریافت کننده',
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: themeColor,
                                        fontFamily: 'iran_yekan',
                                        fontSize: 15.0),
                                  ),
                                ),
                              ),
                              Container(
                                child: Center(
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: DropdownButton<String>(
                                      hint: Text(
                                        'انتخاب کنید',
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: 'iran_yekan'),
                                      ),
                                      value: recipientCity,
                                      underline: Container(),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: 'iran_yekan',
                                          color: Colors.black54),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          recipientCity = newValue;
                                        });
                                      },
                                      items: <String>[
                                        "tehran",
                                        "yen",
                                        "tabriz",
                                      ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20.0, right: 20.0),
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15.0)),
                              border: Border.all(color: themeColor),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            textDirection: TextDirection.rtl,
                            children: [
                              Container(
                                child: Center(
                                  child: Text(
                                    'شخص دریافت کننده',
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: themeColor,
                                        fontFamily: 'iran_yekan',
                                        fontSize: 15.0),
                                  ),
                                ),
                              ),
                              Container(
                                child: Center(
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: DropdownButton<String>(
                                      hint: Text(
                                        'انتخاب کنید',
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: 'iran_yekan'),
                                      ),
                                      value: recipientPerson,
                                      underline: Container(),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: 'iran_yekan',
                                          color: Colors.black54),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          recipientPerson = newValue;
                                        });
                                      },
                                      items: <String>[
                                        "tehran",
                                        "yen",
                                        "tabriz",
                                      ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          textDirection: TextDirection.rtl,
                          children: [
                            Text(
                              'افزودن شخص',
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: themeColor,
                                  fontFamily: 'iran_yekan',
                                  fontSize: 16.0),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UserRegisterForm()));
                              },
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(100.0)),
                                    color: themeColor),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20.0, right: 20.0),
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15.0)),
                              border: Border.all(color: themeColor),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            textDirection: TextDirection.rtl,
                            children: [
                              Container(
                                child: Center(
                                  child: Text(
                                    'شرکت دریافت کننده',
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: themeColor,
                                        fontFamily: 'iran_yekan',
                                        fontSize: 15.0),
                                  ),
                                ),
                              ),
                              Container(
                                child: Center(
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: DropdownButton<String>(
                                      hint: Text(
                                        'انتخاب کنید',
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: 'iran_yekan'),
                                      ),
                                      value: recipientCompany,
                                      underline: Container(),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: 'iran_yekan',
                                          color: Colors.black54),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          recipientCompany = newValue;
                                        });
                                      },
                                      items: <String>[
                                        "tehran",
                                        "yen",
                                        "tabriz",
                                      ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          textDirection: TextDirection.rtl,
                          children: [
                            Text(
                              'افزودن شرکت',
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: themeColor,
                                  fontFamily: 'iran_yekan',
                                  fontSize: 16.0),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FactoryRegisterForm()));
                              },
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(100.0)),
                                    color: themeColor),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          textDirection: TextDirection.rtl,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _tabController
                                    .animateTo(_tabController.index + 1);
                              },
                              child: Container(
                                width: 120.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                    color: Colors.white,
                                    border: Border.all(color: themeColor)),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'ادامه',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: 'iran_yekan',
                                          color: themeColor),
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: themeColor,
                                      size: 20.0,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _tabController
                                    .animateTo(_tabController.index - 1);
                              },
                              child: Container(
                                width: 120.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                    color: Colors.white,
                                    border: Border.all(color: themeColor)),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    Text(
                                      'قبلی',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: 'iran_yekan',
                                          color: themeColor),
                                    ),
                                    Icon(
                                      Icons.arrow_back,
                                      color: themeColor,
                                      size: 20.0,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //*********************************TAB 3************************************************
                  //*********************************TAB 4************************************************
                  Container(
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20.0, right: 20.0),
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15.0)),
                              border: Border.all(color: themeColor),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            textDirection: TextDirection.rtl,
                            children: [
                              Container(
                                child: Center(
                                  child: Text(
                                    'صدور بارنامه فرعی',
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: themeColor,
                                        fontFamily: 'iran_yekan',
                                        fontSize: 15.0),
                                  ),
                                ),
                              ),
                              Container(
                                child: Center(
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: DropdownButton<String>(
                                      hint: Text(
                                        'انتخاب کنید',
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: 'iran_yekan'),
                                      ),
                                      value: IssuanceOfSub_billOfLading,
                                      underline: Container(),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: 'iran_yekan',
                                          color: Colors.black54),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          IssuanceOfSub_billOfLading = newValue;
                                        });
                                      },
                                      items: <String>[
                                        "....",
                                        "بله",
                                        "tabriz",
                                      ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20.0, right: 20.0),
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15.0)),
                              border: Border.all(color: themeColor),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            textDirection: TextDirection.rtl,
                            children: [
                              Container(
                                child: Center(
                                  child: Text(
                                    'نوع پیش فاکتور حمل',
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: themeColor,
                                        fontFamily: 'iran_yekan',
                                        fontSize: 15.0),
                                  ),
                                ),
                              ),
                              Container(
                                child: Center(
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: DropdownButton<String>(
                                      hint: Text(
                                        'انتخاب کنید',
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: 'iran_yekan'),
                                      ),
                                      value: Pre_invoiceTypeOfShipment,
                                      underline: Container(),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: 'iran_yekan',
                                          color: Colors.black54),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          Pre_invoiceTypeOfShipment = newValue;
                                        });
                                      },
                                      items: <String>[
                                        "رسمی",
                                        "غیر رسمی",
                                      ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20.0, right: 20.0),
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15.0)),
                              border: Border.all(color: themeColor),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            textDirection: TextDirection.rtl,
                            children: [
                              Container(
                                child: Center(
                                  child: Text(
                                    'نوع پیش فاکتور سایر خدمات',
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: themeColor,
                                        fontFamily: 'iran_yekan',
                                        fontSize: 15.0),
                                  ),
                                ),
                              ),
                              Container(
                                child: Center(
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: DropdownButton<String>(
                                      hint: Text(
                                        'انتخاب کنید',
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: 'iran_yekan'),
                                      ),
                                      value: Pre_invoiceTypeOfOtherServices,
                                      underline: Container(),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: 'iran_yekan',
                                          color: Colors.black54),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          Pre_invoiceTypeOfOtherServices =
                                              newValue;
                                        });
                                      },
                                      items: <String>[
                                        "رسمی",
                                        "غیر رسمی",
                                      ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20.0, right: 20.0),
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15.0)),
                              border: Border.all(color: themeColor),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            textDirection: TextDirection.rtl,
                            children: [
                              Container(
                                child: Center(
                                  child: Text(
                                    'پیش فاکتور به نام فرد',
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: themeColor,
                                        fontFamily: 'iran_yekan',
                                        fontSize: 15.0),
                                  ),
                                ),
                              ),
                              Container(
                                child: Center(
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: DropdownButton<String>(
                                      hint: Text(
                                        'انتخاب کنید',
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: 'iran_yekan'),
                                      ),
                                      value: Pre_invoiceInTheNameOfThePerson,
                                      underline: Container(),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: 'iran_yekan',
                                          color: Colors.black54),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          Pre_invoiceInTheNameOfThePerson =
                                              newValue;
                                        });
                                      },
                                      items: <String>[
                                        "tehran",
                                        "yen",
                                        "tabriz",
                                      ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          textDirection: TextDirection.rtl,
                          children: [
                            Text(
                              'افزودن شخص',
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: themeColor,
                                  fontFamily: 'iran_yekan',
                                  fontSize: 16.0),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UserRegisterForm()));
                              },
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(100.0)),
                                    color: themeColor),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20.0, right: 20.0),
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15.0)),
                              border: Border.all(color: themeColor),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            textDirection: TextDirection.rtl,
                            children: [
                              Container(
                                child: Center(
                                  child: Text(
                                    'پیش فاکتور به نام شرکت',
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: themeColor,
                                        fontFamily: 'iran_yekan',
                                        fontSize: 15.0),
                                  ),
                                ),
                              ),
                              Container(
                                child: Center(
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: DropdownButton<String>(
                                      hint: Text(
                                        'انتخاب کنید',
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: 'iran_yekan'),
                                      ),
                                      value: Pre_invoiceInTheNameOfTheCompany,
                                      underline: Container(),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: 'iran_yekan',
                                          color: Colors.black54),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          Pre_invoiceInTheNameOfTheCompany =
                                              newValue;
                                        });
                                      },
                                      items: <String>[
                                        "tehran",
                                        "yen",
                                        "tabriz",
                                      ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          textDirection: TextDirection.rtl,
                          children: [
                            Text(
                              'افزودن شرکت',
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: themeColor,
                                  fontFamily: 'iran_yekan',
                                  fontSize: 16.0),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FactoryRegisterForm()));
                              },
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(100.0)),
                                    color: themeColor),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          textDirection: TextDirection.rtl,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FinalReview()));
                              },
                              child: Container(
                                width: 120.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                    color: themeColor,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'ادامه',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'iran_yekan',
                                          fontSize: 18.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _tabController
                                    .animateTo(_tabController.index - 1);
                              },
                              child: Container(
                                width: 120.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                    color: Colors.white,
                                    border: Border.all(color: themeColor)),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    Text(
                                      'قبلی',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: 'iran_yekan',
                                          color: themeColor),
                                    ),
                                    Icon(
                                      Icons.arrow_back,
                                      color: themeColor,
                                      size: 20.0,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                  //*********************************TAB 4************************************************
                ],
              ),
            )),
      ),
    );
  }

  getAllList() async {
    var response = await http.post(api.siteName + '', body: {
    });

    var responseBody = json.decode(response.body);

    if (response.statusCode == 200) {
      if (responseBody['status'] == true) {

      }
    }
  }

  setOrderType() {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          //this right here
          child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height / 2,
            padding: EdgeInsets.only(
              top: 15.0,
              bottom: 15.0,
              left: 15.0,
              right: 15.0,
            ),
            decoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: allOrderType.isEmpty
                ? LoadingPage()
                : ListView.separated(
              separatorBuilder: (context, index) {
                return Container(
                  height: 10.0,
                );
              },
              itemCount: allOrderType.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      orderType = allOrderType[index].value;
                      orderTypeKey = allOrderType[index].key;
                      Navigator.pop(
                        context,
                      );
                    });
                  },
                  child: Container(
                    height: 40.0,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(7.0),
                      border: Border.all(color: themeColor),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: const Offset(0.0, 10.0),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '${allOrderType[index].value}',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: themeColor,
                            fontFamily: 'iran_yekan',
                            fontSize: 16.0),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
      animationType: DialogTransitionType.size,
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 1),
    );
  }

  settransportType() {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          //this right here
          child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height / 2,
            padding: EdgeInsets.only(
              top: 15.0,
              bottom: 15.0,
              left: 15.0,
              right: 15.0,
            ),
            decoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: allTransportType.isEmpty
                ? LoadingPage()
                : ListView.separated(
              separatorBuilder: (context, index) {
                return Container(
                  height: 10.0,
                );
              },
              itemCount: allTransportType.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      transportType = allTransportType[index].value;
                      transportTypeKey = allTransportType[index].key;
                      Navigator.pop(
                        context,
                      );
                    });
                  },
                  child: Container(
                    height: 40.0,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(7.0),
                      border: Border.all(color: themeColor),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: const Offset(0.0, 10.0),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '${allTransportType[index].value}',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: themeColor,
                            fontFamily: 'iran_yekan',
                            fontSize: 16.0),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
      animationType: DialogTransitionType.size,
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 1),
    );
  }
}

class OrderInformation {
  var key;
  var value;

  OrderInformation({
    this.key,
    this.value
  });

  factory OrderInformation.fromJson(Map<String, dynamic> json) {
    return OrderInformation(
        key: json['key'],
        value: json['value']);
  }
}