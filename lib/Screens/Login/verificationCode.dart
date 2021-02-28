import 'dart:convert';

import 'package:bpm/API/api.dart';
import 'package:bpm/Screens/FirstScreen/FirstScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bpm/global/showWarning.dart';
import 'package:bpm/style/Colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}

class verificationCode extends StatefulWidget {
  var  mobile, device, pkg, verifytoken;

  verificationCode( this.mobile, this.device, this.pkg, this.verifytoken);

  @override
  _verificationCodeState createState() => _verificationCodeState();
}

class _verificationCodeState extends State<verificationCode> {
  final verificationCode = TextEditingController();

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
        TextStyle(fontSize: 18.0, fontFamily: 'Aviny', color: Colors.white),
      ),
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verificationCode.clear();
  }

  @override
  Widget build(BuildContext context) {
    var pageWidth = MediaQuery.of(context).size.width;
    var pageHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: mainColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: pageWidth,
              height: pageHeight - MediaQuery.of(context).padding.top,
              decoration: BoxDecoration(color: Colors.white),
              child: Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Center(
                          child: Text(
                            'پیامکی حاوی کد تایید برای شما ارسال شد.',
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'iran_yekan'
                            ),
                          ),
                        ),
                      ),
                      Container(
                          width: pageWidth / 1.5,
                          height: pageHeight / 12,
                          decoration: BoxDecoration(
                              border: Border.all(color: mainColor),
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                              color: Color(0xffeaeaea)),
                          child: Center(
                            child: TextField(
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(fontSize: 15.0, fontFamily: 'iran_yekan'),
                              maxLength: 6,
                              controller: verificationCode,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: new InputDecoration(
                                counter: Offstage(),
                                alignLabelWithHint: true,
                                hintText: "کد پیامک شده",
                                hintStyle:
                                TextStyle(fontSize: 15.0, fontFamily: 'iran_yekan'),
                                border: InputBorder.none,),
                            ),
                          )),
                      InkWell(
                        onTap: () {
                      _RegisterCodeIsIncorrectFormat();
                        },
                        child: ContainerNext,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  conForward() {
    ContainerNext = Container(
      width: 120.0,
      height: 50.0,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  conBack()  {
    setState(() {
      ContainerNext = Container(
        decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        width: 120.0,
        height: 50.0,
        child: Center(
          child: Text(
            'ادامه',
            textDirection: TextDirection.rtl,
            style: TextStyle(
                fontSize: 18.0, fontFamily: 'Aviny', color: Colors.white),
          ),
        ),
      );
    });
  }

  _RegisterCodeIsIncorrectFormat() {
    if(verificationCode.text == ''){
      showWarnning(context, 'کد تایید را وارد کنید!');
    }else if (verificationCode.text.length < 5) {
      showWarnning(context, 'کد تایید باید پنج رقم باشد!');
    } else {
      sendDataToServer(verificationCode.text);
    }
  }

  sendDataToServer(code) async {

    SharedPreferences token = await SharedPreferences.getInstance();

    setState(() {
      conForward();
    });
  print(widget.mobile);
  print(widget.device);
  print(widget.pkg);
  print('${code.toString()}');
  print(token.getString('myIP_token'));
    final response = await http.post(api.siteName + '/auth/loginbycode.json',
        body: {
          "mobile": widget.mobile,
          "device": widget.device,
          "pkg": widget.pkg,
          "code": '${code.toString()}',
          "verifytoken": '${token.getString('myIP_token')}'
    });
    print(response.statusCode);
    print(response.body);
    print(json.decode(response.body)['status']);
    if(response.statusCode == 200){
      conBack();
      var responseBody = json.decode(response.body);
      if(responseBody['status'] == true){
        Navigator.push(context, MaterialPageRoute(builder: (context) => FirstScreen(1)));
      }else if(responseBody['status'] == false){
        showWarnning(context, '${responseBody['msg']}');
      }
    }else{
      conBack();
    }
  }

  codeIsWrong() {
    showWarnning(context, 'کد وارد شده نادرست است!');
  }

  youAreBaned() {
    showWarnning(context, 'شما 10 بار کد را نادرست وارد کردید!');
  }
}