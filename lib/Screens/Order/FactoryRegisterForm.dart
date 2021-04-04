import 'package:bpm/style/Colors.dart';
import 'package:flutter/material.dart';

var factoryNameFn = TextEditingController();
var factoryNameEn = TextEditingController();
var factoryAddress = TextEditingController();
var factoryPostCode = TextEditingController();
var factoryPhone1 = TextEditingController();
var factoryPhone2 = TextEditingController();
var factoryEconomicCode = TextEditingController();
var factoryNationID = TextEditingController();
var factoryRegisterNumber = TextEditingController();
var factoryEmail = TextEditingController();
var factoryDescription = TextEditingController();

var factoryCity = null;
var factoryMethodOfIntroduction = null;

//**********************factory register form values********************************

class FactoryRegisterForm extends StatefulWidget {
  @override
  _FactoryRegisterFormState createState() => _FactoryRegisterFormState();
}

class _FactoryRegisterFormState extends State<FactoryRegisterForm> {
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
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: Center(
                  child: Text(
                    'ایجاد شرکت',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        color: themeColor,
                        fontFamily: 'iran_yekan',
                        fontSize: 18.0),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: TextField(
                  controller: factoryNameFn,
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
                    hintText: 'نام شرکت/سازمان*',
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
                  controller: factoryNameEn,
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
                    hintText: 'نام شرکت/سازمان انگلیسی*',
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
                        'شهر',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18.0, fontFamily: 'iran_yekan'),
                      ),
                      value: factoryCity,
                      underline: Container(),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'iran_yekan',
                          color: Colors.black54),
                      onChanged: (String newValue) {
                        setState(() {
                          factoryCity = newValue;
                        });
                      },
                      items: <String>[
                        "آقا",
                        "خانم",
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),//**********
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: TextField(
                  controller: factoryAddress,
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
                    hintText: 'آدرس',
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
                  controller: factoryPostCode,
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
                    hintText: 'کدپستی',
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
                  controller: factoryPhone1,
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
                    hintText: 'تلفن 1',
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
                  controller: factoryPhone2,
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
                    hintText: 'تلفن 2',
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
                  controller: factoryEconomicCode,
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
                    hintText: 'کداقتصادی',
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
                  controller: factoryNationID,
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
                    hintText: 'شناسه ملی',
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
                  controller: factoryRegisterNumber,
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
                    hintText: 'شماره ثبت',
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
                  controller: factoryEmail,
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
                    hintText: 'ایمیل',
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
                        'نحوه آشنایی با ما*',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18.0, fontFamily: 'iran_yekan'),
                      ),
                      value: factoryMethodOfIntroduction,
                      underline: Container(),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'iran_yekan',
                          color: Colors.black54),
                      onChanged: (String newValue) {
                        setState(() {
                          factoryMethodOfIntroduction = newValue;
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
              ),//*****
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: TextField(
                  controller: factoryDescription,
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
                  Navigator.pop(context);
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
}