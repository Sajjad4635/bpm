import 'dart:io';

import 'package:bpm/API/api.dart';
import 'package:bpm/Screens/Order/addOrder/additionalinformation/additionalInformation.dart';
import 'package:http/http.dart' as http;
import 'package:bpm/global/showWarning.dart';
import 'package:bpm/style/Colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

var productNameFn = TextEditingController();
var productNameEn = TextEditingController();
var number = TextEditingController();
var unitWeight = TextEditingController();
var length = TextEditingController();
var width = TextEditingController();
var height = TextEditingController();
var totalCBM = TextEditingController();
var numberInBox = TextEditingController();
var valueOfNumberInBox = TextEditingController();
var totalValue = TextEditingController();
var partNumber = TextEditingController();
var buyLink = TextEditingController();
var description = TextEditingController();

File imageFile;
File proformaInvoiceFile;
File packingListFile;
File attachedFile;

class addOrder extends StatefulWidget {
  @override
  _addOrderState createState() => _addOrderState();
}

class _addOrderState extends State<addOrder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
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
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: Center(
                  child: Text(
                    'ایجاد کالای سفارش',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        color: themeColor,
                        fontFamily: 'iran_yekan',
                        fontSize: 18.0),
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Container(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: TextField(
                  controller: productNameFn,
                  textAlign: TextAlign.center,
                  cursorColor: themeColor,
                  autofocus: false,
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontFamily: 'iran_yekan'),
                  decoration: InputDecoration(
                    counter: Offstage(),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'نام کالا*',
                    hintStyle: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'iran_yekan',
                        color: Colors.black38),
                    contentPadding:
                    const EdgeInsets.only(bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                  controller: productNameEn,
                  textAlign: TextAlign.center,
                  cursorColor: themeColor,
                  autofocus: false,
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontFamily: 'iran_yekan'),
                  decoration: InputDecoration(
                    counter: Offstage(),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'نام انگلیسی کالا',
                    hintStyle: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'iran_yekan',
                        color: Colors.black38),
                    contentPadding:
                    const EdgeInsets.only(bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: Center(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: DropdownButton<String>(
                      hint: Text(
                        'نوع کالا',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18.0, fontFamily: 'iran_yekan'),
                      ),
                      value: productType,
                      underline: Container(),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'iran_yekan',
                          color: Colors.black54),
                      onChanged: (String newValue) {
                        setState(() {
                          productType = newValue;
                        });
                      },
                      items: <String>[
                        "عادی",
                        "دایکیومنت",
                        "غیر معمول",
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                    '(کالاهای غیرنرمال شامل باتری و برند و موتور و پودر و ... هستند که امکان حمل هوایی از بعضی کشورها را ندارند)',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'iran_yekan',
                        fontSize: 13.0),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: Center(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: DropdownButton<String>(
                      hint: Text(
                        'واحد تعداد*',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18.0, fontFamily: 'iran_yekan'),
                      ),
                      value: unitNumber,
                      underline: Container(),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'iran_yekan',
                          color: Colors.black54),
                      onChanged: (String newValue) {
                        setState(() {
                          unitNumber = newValue;
                        });
                      },
                      items: <String>[
                        "عدد",
                        "کارتن",
                        "پالت",
                        "کیسه",
                        "قوطی",
                        "صندوق",
                        "بند",
                        "ورق",
                        "صفحه",
                        "پاکت",
                        "کانتینر",
                        "رول",
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                  controller: number,
                  textAlign: TextAlign.center,
                  cursorColor: themeColor,
                  autofocus: false,
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontFamily: 'iran_yekan'),
                  decoration: InputDecoration(
                    counter: Offstage(),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'تعداد*',
                    hintStyle: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'iran_yekan',
                        color: Colors.black38),
                    contentPadding:
                    const EdgeInsets.only(bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                  controller: unitWeight,
                  textAlign: TextAlign.center,
                  cursorColor: themeColor,
                  autofocus: false,
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontFamily: 'iran_yekan'),
                  decoration: InputDecoration(
                    counter: Offstage(),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'وزن واحد(kg)*',
                    hintStyle: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'iran_yekan',
                        color: Colors.black38),
                    contentPadding:
                    const EdgeInsets.only(bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 50.0,
                margin: EdgeInsets.only(right: 20.0, left: 20.0),
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                decoration: BoxDecoration(
                    color: themeColor,
                    borderRadius:
                    BorderRadius.all(Radius.circular(15.0)),
                    border: Border.all(color: Colors.white)),
                child: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'جمع وزن جرمی(kg)',
                      style: TextStyle(
                          fontSize: 13.0,
                          fontFamily: 'iran_yekan',
                          color: Colors.white),
                    ),
                    ((number.text == '')||(unitWeight.text == ''))
                        ? Text(
                      '0',
                      style: TextStyle(
                          fontSize: 13.0,
                          fontFamily: 'iran_yekan',
                          color: Colors.white),
                    )
                        : Text(
                      (double.parse(number.text) * double.parse(unitWeight.text)).toString(),
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
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        maxLength: 11,
                        controller: length,
                        textAlign: TextAlign.center,
                        cursorColor: themeColor,
                        autofocus: false,
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                            fontFamily: 'iran_yekan'),
                        decoration: InputDecoration(
                          counter: Offstage(),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'طول',
                          hintStyle: TextStyle(
                              fontSize: 13.0,
                              fontFamily: 'iran_yekan',
                              color: Colors.black38),
                          contentPadding: const EdgeInsets.only(
                              bottom: 8.0, top: 8.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: themeColor),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: themeColor),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        maxLength: 11,
                        controller: width,
                        textAlign: TextAlign.center,
                        cursorColor: themeColor,
                        autofocus: false,
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                            fontFamily: 'iran_yekan'),
                        decoration: InputDecoration(
                          counter: Offstage(),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'عرض',
                          hintStyle: TextStyle(
                              fontSize: 13.0,
                              fontFamily: 'iran_yekan',
                              color: Colors.black38),
                          contentPadding: const EdgeInsets.only(
                              bottom: 8.0, top: 8.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: themeColor),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: themeColor),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: TextField(
                        textDirection: TextDirection.rtl,
                        keyboardType: TextInputType.number,
                        maxLength: 11,
                        controller: height,
                        textAlign: TextAlign.center,
                        cursorColor: themeColor,
                        autofocus: false,
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                            fontFamily: 'iran_yekan'),
                        decoration: InputDecoration(
                          counter: Offstage(),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'ارتفاع',
                          hintStyle: TextStyle(
                              fontSize: 13.0,
                              fontFamily: 'iran_yekan',
                              color: Colors.black38),
                          contentPadding: const EdgeInsets.only(
                              bottom: 8.0, top: 8.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: themeColor),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: themeColor),
                            borderRadius: BorderRadius.circular(10.0),
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
                child: Center(
                  child: Text(
                    'ابعاد را برحسب cm وارد کنید!',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'iran_yekan',
                        fontSize: 13.0),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                  controller: totalCBM,
                  textAlign: TextAlign.center,
                  cursorColor: themeColor,
                  autofocus: false,
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontFamily: 'iran_yekan'),
                  decoration: InputDecoration(
                    counter: Offstage(),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'cbm کل',
                    hintStyle: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'iran_yekan',
                        color: Colors.black38),
                    contentPadding:
                    const EdgeInsets.only(bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 50.0,
                margin: EdgeInsets.only(right: 20.0, left: 20.0),
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                decoration: BoxDecoration(
                    color: themeColor,
                    borderRadius:
                    BorderRadius.all(Radius.circular(15.0)),
                    border: Border.all(color: Colors.white)),
                child: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'جمع وزن حجمی',
                      style: TextStyle(
                          fontSize: 13.0,
                          fontFamily: 'iran_yekan',
                          color: Colors.white),
                    ),
                    Text(
                      '0',
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
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                  controller: numberInBox,
                  textAlign: TextAlign.center,
                  cursorColor: themeColor,
                  autofocus: false,
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontFamily: 'iran_yekan'),
                  decoration: InputDecoration(
                    counter: Offstage(),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'تعداد کالا در هر جعبه',
                    hintStyle: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'iran_yekan',
                        color: Colors.black38),
                    contentPadding:
                    const EdgeInsets.only(bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: Center(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: DropdownButton<String>(
                      hint: Text(
                        'واحد ارزش کالا',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18.0, fontFamily: 'iran_yekan'),
                      ),
                      value: unitProductValue,
                      underline: Container(),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'iran_yekan',
                          color: Colors.black54),
                      onChanged: (String newValue) {
                        setState(() {
                          unitProductValue = newValue;
                        });
                      },
                      items: <String>[
                        "ریال",
                        "دلار",
                        "درهم امارات",
                        "یوان",
                        "یورو",
                        "ریال*",
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                  controller: valueOfNumberInBox,
                  textAlign: TextAlign.center,
                  cursorColor: themeColor,
                  autofocus: false,
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontFamily: 'iran_yekan'),
                  decoration: InputDecoration(
                    counter: Offstage(),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'ارزش واحد کالای در جعبه',
                    hintStyle: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'iran_yekan',
                        color: Colors.black38),
                    contentPadding:
                    const EdgeInsets.only(bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                  controller: totalValue,
                  textAlign: TextAlign.center,
                  cursorColor: themeColor,
                  autofocus: false,
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontFamily: 'iran_yekan'),
                  decoration: InputDecoration(
                    counter: Offstage(),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'ارزش کل کالا(ها)',
                    hintStyle: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'iran_yekan',
                        color: Colors.black38),
                    contentPadding:
                    const EdgeInsets.only(bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: Center(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: DropdownButton<String>(
                      hint: Text(
                        'HSCODE',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18.0, fontFamily: 'iran_yekan'),
                      ),
                      value: HSCODE,
                      underline: Container(),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'iran_yekan',
                          color: Colors.black54),
                      onChanged: (String newValue) {
                        setState(() {
                          HSCODE = newValue;
                        });
                      },
                      items: <String>[
                        "عادی",
                        "دایکیومنت",
                        "غیر معمول",
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                  controller: partNumber,
                  textAlign: TextAlign.center,
                  cursorColor: themeColor,
                  autofocus: false,
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontFamily: 'iran_yekan'),
                  decoration: InputDecoration(
                    counter: Offstage(),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'پارت نامبر',
                    hintStyle: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'iran_yekan',
                        color: Colors.black38),
                    contentPadding:
                    const EdgeInsets.only(bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                  controller: buyLink,
                  textAlign: TextAlign.center,
                  cursorColor: themeColor,
                  autofocus: false,
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontFamily: 'iran_yekan'),
                  decoration: InputDecoration(
                    counter: Offstage(),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'لینک خرید',
                    hintStyle: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'iran_yekan',
                        color: Colors.black38),
                    contentPadding:
                    const EdgeInsets.only(bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: (){
                  getImageFile();
                },
                child: Container(
                  height: 200.0,
                  margin: EdgeInsets.only(
                      left: 50.0,
                      right: 50.0
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: themeColor
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15.0))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'تصویر',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: themeColor,
                            fontFamily: 'iran_yekan',
                            fontSize: 15.0),
                      ),
                      SizedBox(height: 15.0,),
                      SvgPicture.asset('images/attachment.svg',
                          width: 20.0,
                          height: 20.0,
                          color: themeColor),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: (){
                  getProformaInvoiceFile();
                },
                child: Container(
                  height: 200.0,
                  margin: EdgeInsets.only(
                      left: 50.0,
                      right: 50.0
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: themeColor
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15.0))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'فایل Proforma Invoice',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: themeColor,
                            fontFamily: 'iran_yekan',
                            fontSize: 15.0),
                      ),
                      SizedBox(height: 15.0,),
                      SvgPicture.asset('images/attachment.svg',
                          width: 20.0,
                          height: 20.0,
                          color: themeColor),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: (){
                  getPackingListFile();
                },
                child: Container(
                  height: 200.0,
                  margin: EdgeInsets.only(
                      left: 50.0,
                      right: 50.0
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: themeColor
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15.0))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'فایل Packing List',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: themeColor,
                            fontFamily: 'iran_yekan',
                            fontSize: 15.0),
                      ),
                      SizedBox(height: 15.0,),
                      SvgPicture.asset('images/attachment.svg',
                          width: 20.0,
                          height: 20.0,
                          color: themeColor),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: (){
                  getAttachedFile();
                },
                child: Container(
                  height: 200.0,
                  margin: EdgeInsets.only(
                      left: 50.0,
                      right: 50.0
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: themeColor
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15.0))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'سایر فایل های پیوست',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: themeColor,
                            fontFamily: 'iran_yekan',
                            fontSize: 15.0),
                      ),
                      SizedBox(height: 15.0,),
                      SvgPicture.asset('images/attachment.svg',
                          width: 20.0,
                          height: 20.0,
                          color: themeColor),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                  controller: description,
                  textAlign: TextAlign.center,
                  cursorColor: themeColor,
                  autofocus: false,
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontFamily: 'iran_yekan'),
                  decoration: InputDecoration(
                    counter: Offstage(),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'توضیحات',
                    hintStyle: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'iran_yekan',
                        color: Colors.black38),
                    contentPadding:
                    const EdgeInsets.only(bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: (){
                  addProduct();
                },
                child: Container(
                  height: 50.0,
                  margin: EdgeInsets.only(
                      left: 80.0,
                      right: 80.0
                  ),
                  decoration: BoxDecoration(
                      color: themeColor,
                      borderRadius: BorderRadius.all(Radius.circular(15.0))
                  ),
                  child: Center(
                    child: Text(
                      'ثبت اطلاعات',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'iran_yekan',
                          fontSize: 15.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
  getImageFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      imageFile = File(result.files.single.path);
    } else {
      showWarnning(context, 'فایل یافت نشد!');
    }
  }
  getProformaInvoiceFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      proformaInvoiceFile = File(result.files.single.path);
    } else {
      showWarnning(context, 'فایل یافت نشد!');
    }
  }
  getPackingListFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      packingListFile = File(result.files.single.path);
    } else {
      showWarnning(context, 'فایل یافت نشد!');
    }
  }
  getAttachedFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      attachedFile = File(result.files.single.path);
    } else {
      showWarnning(context, 'فایل یافت نشد!');
    }
  }

  addProduct() async{
    SharedPreferences token = await SharedPreferences.getInstance();

    var response = await http.post(api.siteName + '/panel/orderaddproducts.json', body: {
      "token": '${token.getString('myIP_token')}',
      "pkg": '${token.getString('pkg')}',
      "device": '${token.getString('my_device')}',

//      totalCBM
//      numberInBox
//      valueOfNumberInBox
//      totalValue
//      partNumber
//      buyLink
//      description
//
//      "order_id": '${.text}',
//      "name": '${productNameFn.text}',
//      "name_en": '${productNameEn.text}',
//      "op_type": '${.text}',
//      "op_quantity": '${.text}',
//      "quantity": '${number.text}',
//      "width": '${width.text}',
//      "height": '${height.text}',
//      "length": '${length.text}',
//      "oneweight": '${unitWeight.text}',
//      "attach_pi": '${.text}',
//      "attach_pl": '${.text}',
    });
  }
}