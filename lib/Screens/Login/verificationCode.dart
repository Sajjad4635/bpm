import 'dart:convert';

import 'package:bpm/API/api.dart';
import 'package:bpm/Screens/FirstScreen/FirstScreen.dart';
import 'package:bpm/global/glabalVariables.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  var  mobile, device, pkg;

  verificationCode(this.mobile, this.device, this.pkg);

  @override
  _verificationCodeState createState() => _verificationCodeState();
}

class _verificationCodeState extends State<verificationCode> {
  final verificationCode = TextEditingController();

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
    verificationCode.clear();
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
              padding: EdgeInsets.only(
                right: 12.0,
                left: 12.0,
              ),
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
                      textDirection: TextDirection.rtl,
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              right: 12.0,
                                              top: 12.0
                                          ),
                                          child: Row(
                                            textDirection: TextDirection.rtl,
                                            children: [
                                              Icon(
                                                Icons.arrow_back,
                                                color: Colors.white,
                                                size: 15.0,
                                              ),
                                              Text('تغییر شماره',
                                                textDirection: TextDirection.rtl,
                                                style: TextStyle(
                                                    fontFamily: 'iran_yekan',
                                                    fontSize: 14.0,
                                                    color: Colors.white
                                                ),),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Text('کد برای شماره ' + '${widget.mobile}' + 'ارسال شد',
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                            fontFamily: 'iran_yekan',
                                            fontSize: 14.0,
                                            color: Colors.white
                                        ),),
                                      Text('لطفا کد دریافتی را وارد کنید',
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                            fontFamily: 'iran_yekan',
                                            fontSize: 12.0,
                                            color: Colors.white
                                        ),),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 20.0,
                                            right: 20.0
                                        ),
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          maxLength: 6,
                                          controller: verificationCode,
                                          textAlign: TextAlign.center,
                                          cursorColor: mainColor,
                                          autofocus: false,
                                          style: TextStyle(fontSize: 15.0, color: Colors.black, fontFamily: 'iran_yekan'),
                                          decoration: InputDecoration(
                                            counter: Offstage(),
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText: '- - - - -',
                                            hintStyle: TextStyle(
                                                fontSize: 20.0,
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
                                  _RegisterCodeIsIncorrectFormat();
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
      width: 120.0,
      height: 50.0,
      child: Center(
        child: SpinKitThreeBounce(
          color: themeColor,
          size: 30.0,
          duration: Duration(milliseconds: 1000),
        ),
      ),
    );
  }

  conBack()  {
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
    print('jkalfdadkjlkfdjslkjldsf;kjldfsakljdfsdlfskja');
  print(widget.mobile);
  print(widget.device);
  print(widget.pkg);
  print('${code.toString()}');
  print(token.getString('verifytoken'));
    print('jkalfdadkjlkfdjslkjldsf;kjldfsakljdfsdlfskja');
    final response = await http.post(api.siteName + '/auth/loginbycode.json',
        body: {
          "mobile": widget.mobile,
          "device": 'mobile:${widget.device}',
          "pkg": widget.pkg,
          "code": '${code.toString()}',
          "verifytoken": '${token.getString('verifytoken')}'
    });
    print(response.statusCode);
    print(response.body);
    print(json.decode(response.body)['status']);
    if(response.statusCode == 200){
      conBack();
      var responseBody = json.decode(response.body);
      if(responseBody['status'] == false){
        showWarnning(context, 'کد وارد شده نادرست است!');
      }else if(responseBody['status'] == true){

        print('nameasdfasdf::::::::::::::::::::::: ${responseBody['person']['name']}');

        saveAllTokens(responseBody['user']['crypttoken'], responseBody['user']['id']);
        setState(() {
          flagFirstScreen = 0;
        });

        token.setString('userName', responseBody['person']['name']);


        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => FirstScreen(0, responseBody['person']['name'])), (route) => false);
      }else if(responseBody['status'] == false){
        showWarnning(context, '${responseBody['msg']}');
      }
    }else{
      conBack();
    }
  }

  saveAllTokens(myIP_token, user_id) async{
    SharedPreferences token = await SharedPreferences.getInstance();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    print('myIPTOKEN:::::::::::::::::::::::$myIP_token');


    token.setString('myIP_token', '${myIP_token.toString()}');
    token.setString('my_device', 'mobile:${androidInfo.model}');
    token.setString('pkg', 'express.psp.bpm.expert');
    token.setString('user_id', '${user_id.toString()}');
  }
}