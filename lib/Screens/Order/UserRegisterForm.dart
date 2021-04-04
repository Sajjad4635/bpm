import 'dart:convert';

import 'package:bpm/API/api.dart';
import 'package:bpm/Screens/Order/addOrder/selectUserExpertName.dart';
import 'package:bpm/global/showWarning.dart';
import 'package:bpm/style/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

var userFirstNameFn = TextEditingController();
var userLastNameFn = TextEditingController();
var userFirstNameEn = TextEditingController();
var userLastNameEn = TextEditingController();
var userEmail = TextEditingController();
var userNationCode = TextEditingController();
var userMobile1 = TextEditingController();
var userMobile2 = TextEditingController();
var userPhone1 = TextEditingController();
var userPhone2 = TextEditingController();
var userPostCode = TextEditingController();
var userAddress = TextEditingController();
var userDescription = TextEditingController();

var userGender = null;
var userMethodOfIntroduction = null;

var userExperstName;
var userExperstID;
//**********************user register form values********************************

class UserRegisterForm extends StatefulWidget {
  @override
  _UserRegisterFormState createState() => _UserRegisterFormState();
}

class _UserRegisterFormState extends State<UserRegisterForm> {

  var sendDataToServer = Container(
    width: 120.0,
    height: 50.0,
    decoration: BoxDecoration(
        color: themeColor,
        borderRadius: BorderRadius.all(Radius.circular(15.0))),
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
  );

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
                    'ایجاد شخص',
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
                  controller: userFirstNameFn,
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
                    hintText: 'نام*',
                    hintStyle: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'iran_yekan',
                        color: Colors.black38),
                    contentPadding:
                        const EdgeInsets.only(bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColor),
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
                  controller: userLastNameFn,
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
                    hintText: 'نام خانوادگی*',
                    hintStyle: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'iran_yekan',
                        color: Colors.black38),
                    contentPadding:
                        const EdgeInsets.only(bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColor),
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
                  controller: userFirstNameEn,
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
                    hintText: 'نام انگلیسی*',
                    hintStyle: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'iran_yekan',
                        color: Colors.black38),
                    contentPadding:
                        const EdgeInsets.only(bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColor),
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
                  controller: userLastNameEn,
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
                    hintText: 'نام خانوادگی انگلیسی*',
                    hintStyle: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'iran_yekan',
                        color: Colors.black38),
                    contentPadding:
                        const EdgeInsets.only(bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColor),
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
                        'جنسیت',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 18.0, fontFamily: 'iran_yekan'),
                      ),
                      value: userGender,
                      underline: Container(),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'iran_yekan',
                          color: Colors.black54),
                      onChanged: (String newValue) {
                        setState(() {
                          userGender = newValue;
                        });
                      },
                      items: <String>[
                        "آقا",
                        "خانم",
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              value,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'iran_yekan',
                                  color: Colors.black54),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ), //*****
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: TextField(
                  controller: userEmail,
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
                      borderSide: BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColor),
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
                  controller: userNationCode,
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
                    hintText: 'کدملی',
                    hintStyle: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'iran_yekan',
                        color: Colors.black38),
                    contentPadding:
                        const EdgeInsets.only(bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () {
                  selectUserExpertDialog();
                },
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 2,
                  height: 50.0,
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(color: themeColor),
                      color: Colors.white),
                  child: Container(
                    child: Center(
                      child: Text(
                        userExperstName == null
                            ? 'انتخاب کنید'
                            : '${userExperstName.toString()}',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'iran_yekan',
                            fontSize: 14.0),
                      ),
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
                  controller: userMobile1,
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
                    hintText: 'موبایل1*',
                    hintStyle: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'iran_yekan',
                        color: Colors.black38),
                    contentPadding:
                        const EdgeInsets.only(bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColor),
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
                  child: Text(
                    '(شماره موبایل باید با کد کشور شروع شود، مثال 989121112233)',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'iran_yekan',
                        fontSize: 13.0),
                  ),
                ),
              ), //111111
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: TextField(
                  controller: userMobile2,
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
                    hintText: 'موبایل2',
                    hintStyle: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'iran_yekan',
                        color: Colors.black38),
                    contentPadding:
                        const EdgeInsets.only(bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColor),
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
                  child: Text(
                    '(شماره موبایل باید با کد کشور شروع شود، مثال 989121112233)',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'iran_yekan',
                        fontSize: 13.0),
                  ),
                ),
              ), //111111
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: TextField(
                  controller: userPhone1,
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
                    hintText: 'تلفن ثابت 1',
                    hintStyle: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'iran_yekan',
                        color: Colors.black38),
                    contentPadding:
                        const EdgeInsets.only(bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColor),
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
                  controller: userPhone2,
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
                    hintText: 'تلفن ثابت 2',
                    hintStyle: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'iran_yekan',
                        color: Colors.black38),
                    contentPadding:
                        const EdgeInsets.only(bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColor),
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
                  controller: userPostCode,
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
                      borderSide: BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColor),
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
                  controller: userAddress,
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
                      borderSide: BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColor),
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
                        style:
                            TextStyle(fontSize: 18.0, fontFamily: 'iran_yekan'),
                      ),
                      value: userMethodOfIntroduction,
                      underline: Container(),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'iran_yekan',
                          color: Colors.black54),
                      onChanged: (String newValue) {
                        setState(() {
                          userMethodOfIntroduction = newValue;
                        });
                      },
                      items: <String>[
                        "تبلیغات محیطی",
                        "تبلیغات در فضای مجازی",
                        "وب سایت",
                        "آشنایان و همکاران",
                        "بازاریاب های تلفنی",
                        "موتورهای جست و جو",
                        "پیامک تبلیغاتی",
                        "تراکت و بروشور",
                        "بیلبورد",
                        "معرفی شده از طرف مشتری",
                        "معرفی شده از طرف چین",
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              value,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'iran_yekan',
                                  color: Colors.black54),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ), //*****
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: TextField(
                  controller: userDescription,
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
                      borderSide: BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      addPerson();
                    },
                    child: sendDataToServer,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 120.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                          color: themeColor,
                          borderRadius: BorderRadius.all(Radius.circular(15.0))),
                      child: Center(
                        child: Text(
                          'بازگشت',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'iran_yekan',
                              fontSize: 15.0),
                        ),
                      ),
                    ),
                  )
                ],
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

  addPerson() async {
    sendDataToServerForward();

    SharedPreferences token = await SharedPreferences.getInstance();

    print('${token.getString('myIP_token')}');
    print('${userMobile1.text}');
    print('${token.getString('my_device')}');

    var response = await http.post(api.siteName + '/panel/experts/personadd.json', body: {
      "token": '${token.getString('myIP_token')}',
      "pkg": '${token.getString('pkg')}',
      "device": '${token.getString('my_device')}',

      "firstname": '${userFirstNameFn.text}',
      "lastname": '${userLastNameFn.text}',
      "firstname_en": '${userFirstNameEn.text}',
      "lastname_en": '${userLastNameEn.text}',
      "codemelli": '${userNationCode.text}',
      "expert_user_id": '${userExperstID.toString}',
      "gender": '${userGender.toString}' == 'مرد' ? '1' : '0',
      "email": '${userEmail.text}',
      "how_find_us": 'outdoor_ads',
//      "language": '${.text.toString}',
      "mobile1": '${userMobile1.text}',
      "mobile2": '${userMobile2.text}',
      "phone1": '${userPhone1.text}',
      "phone2": '${userPhone2.text}',
      "postalcode": '${userPostCode.text}',
      "address": '${userAddress.text}',
      "text": '${userDescription.text}',
    });

    print(response.statusCode);
    print(response.body);
    
    if(response.statusCode == 200){
      sendDataToServerBack();

      var responseBody = json.decode(response.body);
      
      if(responseBody['status'] == true){
        showDialogTaskDone(context, '${responseBody['msg']}');
      }else{
        showWarnning(context, '${responseBody['msg'].toString().replaceAll('[', '').replaceAll(']', '')}');
      }
    }else{
      sendDataToServerBack();
    }
  }

  selectUserExpertDialog() {

      showAnimatedDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
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
              child: selectUserExpert(
                  setSelectedUserExpertName: (userExpertName, userExpertID) {
                    setUserExpertName(userExpertName, userExpertID);
                  }
              ),
            ),
          );
        },
        animationType: DialogTransitionType.size,
        curve: Curves.fastOutSlowIn,
        duration: Duration(seconds: 1),
      );

  }

  setUserExpertName(String userExpertName, String userExpertID) {
    setState(() {
      userExperstName = userExpertName;
      userExperstID = userExpertID;
    });
  }

  sendDataToServerForward(){
    setState(() {
      sendDataToServer = Container(
        width: 120.0,
        height: 50.0,
        decoration: BoxDecoration(
            color: themeColor,
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: Center(
          child: SpinKitThreeBounce(
            color: Colors.white ,
            size: 10.0,
            duration: Duration(milliseconds: 1000),
          ),
        ),
      );
    });
  }

  sendDataToServerBack() {
    setState(() {
      sendDataToServer = Container(
        width: 120.0,
        height: 50.0,
        decoration: BoxDecoration(
            color: themeColor,
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
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
      );
    });
  }
}
