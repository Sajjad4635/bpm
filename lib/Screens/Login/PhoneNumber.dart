import 'dart:convert';

import 'package:bpm/API/api.dart';
import 'package:bpm/Screens/Login/passwordPage.dart';
import 'package:bpm/Screens/Login/verificationCode.dart';
import 'package:device_info/device_info.dart';
import 'package:bpm/global/showWarning.dart';
import 'package:bpm/style/Colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final PhoneNumberController = TextEditingController();
var stu_id;
var base_stu_n;
var major_stu_n = 100;//beacuse null used for bedone reshte

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}

class phoneNumber extends StatefulWidget {
  @override
  _phoneNumberState createState() => _phoneNumberState();
}

class _phoneNumberState extends State<phoneNumber> {
  var ContainerNext = Container(
    width: 120.0,
    height: 50.0,
    child: Center(
      child: Text(
        'ورود به برنامه',
        textDirection: TextDirection.rtl,
        style:
        TextStyle(fontSize: 15.0, fontFamily: 'iran_yekan', color: Colors.black54),
      ),
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PhoneNumberController.clear();
  }

  @override
  Widget build(BuildContext context) {
    var pageWidth = MediaQuery.of(context).size.width;
    var pageHeight = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top
      ),
      child: Scaffold(
          backgroundColor: mainColor,
          body: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('images/ic_back3.png'),
                    fit: BoxFit.fitHeight,
                    colorFilter: new ColorFilter.mode(
                        Colors.blue.withOpacity(0.15), BlendMode.dstATop),
                  )),
              child: Column(
                children: [
                  Container(
                    height: 60.0,
                    padding: EdgeInsets.only(
                      right: 12.0,
                      left: 12.0,
                    ),
                    child: Row(
                      textDirection: TextDirection.rtl
                      ,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ورود به برنامه',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontFamily: 'iran_yekan',
                              fontSize: 15.0,
                              color: Colors.black54
                          ),
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
                  Expanded(
                    child: Center(
                      child: Container(
                        width: pageWidth/1.4,
                        height: 300.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10.0,
                              offset: const Offset(0.0, 5.0),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                                flex: 8,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15.0),
                                        topRight: Radius.circular(15.0)
                                      ),
                                      gradient: LinearGradient(
                                          colors: [Color(0xff3E99CE) ,Color(0xff2085BF)],
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight
                                      )
                                  ),
                                  child:  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('شماره تلفن همراه خود را وارد نمایید',
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                            fontFamily: 'iran_yekan',
                                            fontSize: 18.0,
                                            color: Colors.white
                                        ),),
                                      Text('کد ورود برای شما ارسال می شود',
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                            fontFamily: 'iran_yekan',
                                            fontSize: 16.0,
                                            color: Colors.white
                                        ),),
                                      Container(
                                        padding: EdgeInsets.only(
                                          left: 20.0,
                                          right: 20.0
                                        ),
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          maxLength: 11,
                                          controller: PhoneNumberController,
                                          textAlign: TextAlign.center,
                                          cursorColor: mainColor,
                                          autofocus: false,
                                          style: TextStyle(fontSize: 15.0, color: Colors.black, fontFamily: 'iran_yekan'),
                                          decoration: InputDecoration(
                                            counter: Offstage(),
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText: 'شماره موبایل',
                                            hintStyle: TextStyle(
                                                fontSize: 13.0,
                                                fontFamily: 'iran_yekan',
                                                color: Colors.black38
                                            ),
                                            contentPadding:
                                            const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white),
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white),
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )

                            ),
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                onTap: () {
                                  _PhoneNumIsIncorrectFormat();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(15.0),
                                      bottomLeft: Radius.circular(15.0),
                                    )
                                  ),
                                  child: Center(
                                    child: ContainerNext,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )

          )),
    );
  }

  conForward() {
    ContainerNext = Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  conBack() {
    setState(() {
      ContainerNext = Container(
        width: 120.0,
        height: 50.0,
        child: Center(
          child: Text(
            'ورود به برنامه',
            textDirection: TextDirection.rtl,
            style:
            TextStyle(fontSize: 15.0, fontFamily: 'iran_yekan', color: Colors.black54),
          ),
        ),
      );
    });
  }


  _PhoneNumIsIncorrectFormat() async{
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if(PhoneNumberController.text == ''){
      showWarnning(context, 'شماره موبایل را وارد کنید.');
    }else if ((PhoneNumberController.text.length == 11) &&
        '${PhoneNumberController.text[0]}' == '0' && '${PhoneNumberController.text[1]}' == '9') {
      sendDataToServer('${androidInfo.model}');
    } else {
      showWarnning(context, 'شماره موبایل نادرست است!');
    }
  }

  sendDataToServer(deviceName) async {
    setState(() {
      conForward();
    });

    SharedPreferences token = await SharedPreferences.getInstance();

    print(deviceName);

    final response = await http.post(api.siteName + '/auth/login.json',
        body: {
          "mobile": '${PhoneNumberController.text}',
          "device": 'mobile:${deviceName.toString()}',
          "pkg": 'express.psp.bpm.expert'
    });

    print(response.statusCode);
    print(response.body);
    var responseBody = json.decode(response.body);
    stu_id = json.decode(response.body);

    print(responseBody);
    if(response.statusCode == 200){
      setState(() {
        conBack();
      });
      if(responseBody['nextform'] == 'code'){
        if (responseBody['status'] == true) {
        token.setString('verifytoken', responseBody['verifytoken']);
        conBack();
      }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => verificationCode(
                    '${PhoneNumberController.text}',
                    '${deviceName.toString()}',
                    'express.psp.bpm.expert')));
      }else if(responseBody['nextform'] == 'password'){
        Navigator.push(context, MaterialPageRoute(builder: (context) => passwordPage(
            '${PhoneNumberController.text}',
            '${deviceName.toString()}',
            'express.psp.bpm.expert',
        )));
      }

    }else if(response.statusCode == 500){
      conBack();
    }else{
      conBack();
    }
  }
}
