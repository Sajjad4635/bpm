import 'dart:convert';

import 'package:bpm/API/api.dart';
import 'package:bpm/Screens/FirstScreen/FirstScreen.dart';
import 'package:device_info/device_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bpm/global/showWarning.dart';
import 'package:bpm/style/Colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class passwordPage extends StatefulWidget {

  var  mobile, device, pkg;

  passwordPage( this.mobile, this.device, this.pkg);

  @override
  _passwordPageState createState() => _passwordPageState();
}

class _passwordPageState extends State<passwordPage> {

  final password = TextEditingController();

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
    password.clear();
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
                            'کلمه عبور خود را وارد کنید',
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
                              controller: password,
                              obscureText: true,
                              textAlign: TextAlign.center,
                              decoration: new InputDecoration(
                                counter: Offstage(),
                                alignLabelWithHint: true,
                                hintText: "کلمه عبور",
                                hintStyle:
                                TextStyle(fontSize: 15.0, fontFamily: 'iran_yekan'),
                                border: InputBorder.none,),
                            ),
                          )),
                      InkWell(
                        onTap: () {
                          _checkPassword();
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

  _checkPassword() {
    if(password.text == ''){
      showWarnning(context, 'کلمه عبور را وارد کنید!');
    }else {
      sendDataToServer(password.text);
    }
  }

  sendDataToServer(code) async {
    setState(() {
      conForward();
    });
  print(widget.mobile);
  print(widget.device);
  print(widget.pkg);
  print('${password.text}');



    final response = await http.post(api.siteName + '/auth/loginbypassword.json',
        body: {
          "mobile": widget.mobile,
          "device": 'mobile:'+'${widget.device}',
          "pkg": widget.pkg,
          "password": '${password.text}',
        });
    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 200){
      setState(() {
        conBack();
      });
      var responseBody = json.decode(response.body);

      if(responseBody['status'] == false){
        showWarnning(context, 'کلمه عبور یا نام کاربری نادرست است!');
      }else if(responseBody['status'] == true){

        saveAllTokens(responseBody['user']['crypttoken'], responseBody['user']['id']);
        print(responseBody['user']['crypttoken']);

        Navigator.push(context, MaterialPageRoute(builder: (context) => FirstScreen(1)));
      }
    }else{
      conBack();
    }
  }

  saveAllTokens(myIP_token, user_id) async{
    SharedPreferences token = await SharedPreferences.getInstance();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;


    token.setString('myIP_token', '${myIP_token.toString()}');
    token.setString('my_device', 'mobile:${androidInfo.model}');
    token.setString('pkg', 'express.psp.bpm.expert');
    token.setString('user_id', '${user_id.toString()}');
  }
}

