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
    decoration: BoxDecoration(
        color: mainColor, borderRadius: BorderRadius.all(Radius.circular(15.0))),
    width: 120.0,
    height: 50.0,
    child: Center(
      child: Text(
        'ادامه',
        textDirection: TextDirection.rtl,
        style:
        TextStyle(fontSize: 14.0, fontFamily: 'iran_yekan', color: Colors.white),
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
    var pageWith = MediaQuery.of(context).size.width;
    var pageHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: mainColor,
        body: SafeArea(
          child: SingleChildScrollView(
              child: Container(decoration: new BoxDecoration(
                color: Colors.white,
                image: DecorationImage(

                  image: new AssetImage('images/phoneNumimg.jpg'),
                  fit: BoxFit.fill,
                ),
              ),

                width: pageWith,
                height: pageHeight - MediaQuery.of(context).padding.top,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: pageHeight / 2,
                    ),
                    Container(
                        width: pageWith / 1.5,
                        height: pageHeight / 12,
                        decoration: BoxDecoration(
                            border: Border.all(color: mainColor),
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            color: Color(0xffeaeaea)),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                margin: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  image: DecorationImage(
                                    image: AssetImage('images/iriFlag.png'), fit: BoxFit.cover
                                  )
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Center(
                                  child: Text(
                                    '+98',
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                        fontSize: 14.0, fontFamily: 'iran_yekan'),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Container(
                                child: Center(
                                  child: TextField(
                                    textAlignVertical: TextAlignVertical.center,
                                    style: TextStyle(
                                      fontFamily: 'iran_yekan',
                                      fontSize: 15.0,
                                    ),
                                    keyboardType: TextInputType.number,
                                    maxLength: 11,

                                    controller: PhoneNumberController,
                                    textAlign: TextAlign.left,
                                    cursorColor: mainColor,
                                    decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        alignLabelWithHint: true,
                                        counter: Offstage()),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                    InkWell(
                      onTap: () {
                        _PhoneNumIsIncorrectFormat();
                      },
                      child: ContainerNext,
                    )
                  ],
                ),
              )),
        ));
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
        decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.all(Radius.circular(45.0))),
        width: 120.0,
        height: 50.0,
        child: Center(
          child: Text(
            'ادامه',
            textDirection: TextDirection.rtl,
            style: TextStyle(
                fontSize: 18.0, fontFamily: 'iran_yekan', color: Colors.white),
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
    }else if ((PhoneNumberController.text.length == 10) &&
        '${PhoneNumberController.text[0]}' == '9') {
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
    
    final response = await http.post(api.siteName + '/auth/login.json',
        body: {
          "mobile": '0'+'${PhoneNumberController.text}',
          "device": '${deviceName.toString()}',
          "pkg": 'express.psp.bpm.expert'
    });

    print(response.statusCode);
    print(response.body);
    var responseBody = json.decode(response.body);
    stu_id = json.decode(response.body);
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
                    '0'+'${PhoneNumberController.text}',
                    '${deviceName.toString()}',
                    'express.psp.bpm.expert',
                    token.getString('verifytoken'))));
      }else if(responseBody['nextform'] == 'password'){
        Navigator.push(context, MaterialPageRoute(builder: (context) => passwordPage(
            '0'+'${PhoneNumberController.text}',
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
