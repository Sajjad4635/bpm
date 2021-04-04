import 'dart:convert';

import 'package:bpm/API/api.dart';
import 'package:bpm/Screens/Order/UserRegisterForm.dart';
import 'package:bpm/Screens/Order/addOrder/ServiceSelection/serviceTypeModel.dart';
import 'package:bpm/Screens/Order/addOrder/additionalinformation/additionalInformation.dart';
import 'package:bpm/Screens/Order/addOrder/selectOrderOwner.dart';
import 'package:bpm/Screens/Order/getAllUsers.dart';
import 'package:bpm/global/SearchUserModel.dart';
import 'package:bpm/global/loadingPage.dart';
import 'package:bpm/global/showWarning.dart';
import 'package:bpm/style/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

var flagServiceSelection = 0;

var ownerOfOrder;
var ownerOfOrderID;

List <GetAllOrderServices> serviceType = new List();
var serviceSelected = [];
var serviceSelectedValue = [];

var nextBtn = Container(
  width: 80.0,
  height: 40.0,
  decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      color: themeColor),
  child: Center(
    child: Text(
      'ادامه',
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.white,
          fontFamily: 'iran_yekan',
          fontSize: 16.0),
    ),
  ),
);

class ServiceSelection extends StatefulWidget {
  @override
  _ServiceSelectionState createState() => _ServiceSelectionState();
}

class _ServiceSelectionState extends State<ServiceSelection> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      if (flagServiceSelection == 0) {
        getServiceType();
        flagServiceSelection = 1;
      }
    });

    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage('images/ic_back3.png'),
              fit: BoxFit.fitHeight,
              colorFilter: new ColorFilter.mode(
                  Colors.blue.withOpacity(0.15), BlendMode.dstATop),
            )),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: serviceType.isEmpty
              ? LoadingPage()
              : Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0),
                padding: EdgeInsets.all(10.0),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: themeColor),
                child: Column(
                  children: [
                    Text(
                      'شما 2 سفارش تکمیل نشده دارید.',
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'iran_yekan',
                          fontSize: 16.0),
                    ),
                    Text(
                      'برای مشاهده سفارش های تکمیل نشده و تکمیل آنها روی این متن کلیک کنید.',
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'iran_yekan',
                          fontSize: 12.0),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'صاحب سفارش',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'iran_yekan',
                        fontSize: 16.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    textDirection: TextDirection.rtl,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => selectOrderOwner(
                              setSelectedName: (userName, userID) {
                                setUserName(userName, userID);
                              }
                          )));
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
                                ownerOfOrder == null
                                    ? 'انتخاب کنید'
                                    : '${ownerOfOrder.toString()}',
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserRegisterForm()));
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
                      )
                    ],
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 1.2,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: themeColor),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                child: Column(
                  children: [
                    Container(
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        color: themeColor,
                      ),
                      child: Center(
                        child: Text(
                          'خدمات مورد نیاز خود را انتخاب نمایید',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'iran_yekan',
                              fontSize: 16.0),
                        ),
                      ),
                    ),
                    Container(
                      width: 150.0,
                      height: 200.0,
                      child: ListView.builder(
                        itemCount: serviceType.length,
                        itemBuilder: (context, index) {
                          return Row(
                            textDirection: TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: serviceSelectedValue[index],
                                onChanged: (bool value) {
                                  setState(() {
                                    serviceSelectedValue[index] = value;
                                    value
                                        ? serviceSelected.add(
                                        serviceType[index].key)
                                        : serviceSelected.remove(
                                        serviceType[index].key);
                                  });
                                },
                              ),
                              Text(
                                '${serviceType[index].value}',
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'iran_yekan',
                                    fontSize: 16.0),
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  print(serviceSelected);
                  if (ownerOfOrder == null) {
                    showWarnning(
                        context, 'امکان ثبت سفارش بدون صاحب سفارش وجود ندارد.');
                  } else if (serviceSelected.isEmpty) {
                    showWarnning(context,
                        'لازم است حداقل یکی از سرویس ها را انتخاب نمایید');
                  } else {
                    sendServicesSelectedToServer();
                  }
                },
                child: nextBtn,
              )
            ],
          ),
        ));
  }

  getServiceType() async {
    SharedPreferences token = await SharedPreferences.getInstance();

    var response = await http.post(
        api.siteName + '/panel/formfields.json', body: {
      "token": '${token.getString('myIP_token')}',
      "pkg": '${token.getString('pkg')}',
      "device": '${token.getString('my_device')}',
    });

    print(response.body);
    print(response.statusCode);

    var responseBody = json.decode(response.body)['orderservices'];

    if (response.statusCode == 200) {
      setState(() {
        responseBody.forEach((item) {
          serviceType.add(GetAllOrderServices.fromJson(item));
        });
      });
      for(int i=0;i<serviceType.length;i++){
        serviceSelectedValue.add(false);
      }
    }
    print(serviceType.toString());
  }

  sendServicesSelectedToServer() async {
    nextBtnForward();

    SharedPreferences token = await SharedPreferences.getInstance();

    var response = await http.post(
        api.siteName + '/panel/experts/orderaddstep1.json', body: {
      "token": '${token.getString('myIP_token')}',
      "pkg": '${token.getString('pkg')}',
      "device": '${token.getString('my_device')}',
      "services": '${serviceSelected.toString().replaceAll('[', '').replaceAll(']', '')}',
      "user_id_owner": '${ownerOfOrderID.toString()}'
    });
    print(response.statusCode);
    print(response.body);

    var responseBody = json.decode(response.body);

    if (response.statusCode == 200) {
      print(responseBody['status']);
      if(responseBody['status'] == true){
        nextBack();
        Navigator.push(context, MaterialPageRoute(builder: (context) => AdditionalInformation()));
      }
    }
  }

  nextBtnForward() {
    setState(() {
      nextBtn = Container(
        width: 80.0,
        height: 40.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: themeColor),
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

  nextBack() {
    setState(() {
      nextBtn = Container(
        width: 80.0,
        height: 40.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: themeColor),
        child: Center(
          child: Text(
            'ادامه',
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'iran_yekan',
                fontSize: 16.0),
          ),
        ),
      );
    });
  }

  setUserName(userName, userID) {
    setState(() {
      ownerOfOrder = userName;
      ownerOfOrderID = userID;
    });
  }
}