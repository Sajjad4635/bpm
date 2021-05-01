import 'dart:convert';

import 'package:bpm/API/api.dart';
import 'package:bpm/Screens/Cardboard/Cardboard.dart';
import 'package:bpm/Screens/Cardboard/autoSendInvoiceToOwner/autoSendInvoiceToOwner.dart';
import 'package:bpm/Screens/Cardboard/cardBoardPage/cardBoardPageModel.dart';
import 'package:bpm/Screens/Cardboard/cardBoardPage/fechCardBoardPage.dart';
import 'package:bpm/Screens/Cardboard/cardBoardPage/showOrderDetail.dart';
import 'package:bpm/Screens/chat/allCustomers/allChatsView.dart';
import 'package:bpm/global/formFieldsVariables.dart';
import 'package:bpm/global/loadingPage.dart';
import 'package:bpm/style/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

var flagCardBoardPage = 0;
List<cardBoardPageModel> taskList = new List();
var forceWorkNumber;
var empty = false;

var duration;
var descController = TextEditingController();

var sendButton = Container(
  width: 120.0,
  height: 60.0,
  decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      color: themeColor),
  child: Center(
    child: Text(
      'ثبت اطلاعات',
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 15.0,
          fontFamily: 'iran_yekan',
          color: Colors.white),
    ),
  ),
);

var sendButtonDesc = Container(
  width: 120.0,
  height: 60.0,
  decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      color: themeColor),
  child: Center(
    child: Text(
      'ثبت اطلاعات',
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 15.0,
          fontFamily: 'iran_yekan',
          color: Colors.white),
    ),
  ),
);

class cardBoardPage extends StatefulWidget {
  var value, orderKey;

  cardBoardPage(this.value, this.orderKey);

  @override
  _cardBoardPageState createState() => _cardBoardPageState();
}

class _cardBoardPageState extends State<cardBoardPage> {
  final _firstScreenScaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    setState(() {
      if(flagCardBoardPage == 0){
        empty = false;
        forceWorkNumber = 0;
        taskList.clear();
        getTeskList();
        flagCardBoardPage = 1;
      }
    });

    return Scaffold(
      key: _firstScreenScaffoldKey,
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage('images/ic_back3.png'),
              fit: BoxFit.fitHeight,
              colorFilter: new ColorFilter.mode(
                  Colors.blue.withOpacity(0.15), BlendMode.dstATop),
            )),
        child: SafeArea(
            child: Column(
          children: [
            Expanded(
              child: (taskList.isEmpty) && (empty == false)
                  ? LoadingPage()
                  : (taskList.isEmpty) && (empty == true)
                      ? Container(
                          child: Center(
                            child: Text(
                              'اطلاعاتی وجود ندارد!',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  fontFamily: 'iran_yekan',
                                  color: themeColor,
                                  fontSize: 15.0),
                            ),
                          ),
                        )
                      : ListView.separated(
                          separatorBuilder: (context, indexSep) {
                            return Container(
                              margin: EdgeInsets.only(left: 30.0, right: 30.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: taskList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (context) =>
//                                            showOrderDetail(taskList[index].tn)));
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height / 4,
                                margin:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                decoration: BoxDecoration(
                                    color: int.parse(taskList[index].taskAlarmAfterTime) >= ((DateTime.now().millisecondsSinceEpoch)/1000).toInt()
                                    ? Color(0xffE5E5E5)
                                    : Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    border: Border.all(color: themeColor)),
                                child: Row(
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              taskList[index].tn == null
                                                  ? 'شماره سفارش : -'
                                                  : 'شماره سفارش : ${taskList[index].tn}',
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontFamily: 'iran_yekan',
                                                  color: themeColor),
                                            ),
                                            Text(
                                              taskList[index]
                                                          .userIdOwnerValue == null
                                                  ? 'صاحب سفارش : -'
                                                  : doNotShowEnglish(
                                                      'صاحب سفارش : ${taskList[index].userIdOwnerValue}'),
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontFamily: 'iran_yekan',
                                                  color: themeColor),
                                            ),
                                            Text(
                                              taskList[index]
                                                          .expertUserIdValue == null
                                                  ? 'مدیر مشتری : -'
                                                  : doNotShowEnglish(
                                                      'مدیر مشتری : ${taskList[index].expertUserIdValue}'),
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontFamily: 'iran_yekan',
                                                  color: themeColor),
                                            ),
                                            Text(
                                              taskList[index]
                                                          .orderStatusValue == null
                                                  ? 'وضعیت : -'
                                                  : 'وضعیت : ${taskList[index].orderStatusValue}',
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontFamily: 'iran_yekan',
                                                  color: themeColor),
                                            ),
                                            int.parse(taskList[index].taskAlarmAfterTime) >= ((DateTime.now().millisecondsSinceEpoch)/1000).toInt()
                                            ? Text(
                                              'به تعویق افتاده تا  ${taskList[index].taskAlarmAfterTimeValue}',
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontFamily: 'iran_yekan',
                                                  color: themeColor),
                                            )
                                            : Container()
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                postponing(taskList[index].tasklistId);
                                              },
                                              child: Container(
                                                height: 30.0,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5.0)),
                                                    color: themeColor),
                                                child: Center(
                                                  child: Text(
                                                    'به تعویق انداختن',
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 12.0,
                                                        fontFamily: 'iran_yekan',
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                descController.clear();
                                                taskList[index].taskComment == null
                                                ? descController.value = TextEditingValue(text: '')
                                                : descController.value = TextEditingValue(text: '${taskList[index].taskComment}');
                                                addDescription(taskList[index].tasklistId, index);
                                              },
                                              child: Container(
                                                height: 30.0,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5.0)),
                                                    color: themeColor),
                                                child: Center(
                                                  child: Text(
                                                    'توضیحات',
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 12.0,
                                                        fontFamily:
                                                            'iran_yekan',
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                print(taskList[index].actValue[0].key);
                                                launchURL(taskList[index].actValue[0].key);
                                              },
                                              child: Container(
                                                height: 30.0,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5.0)),
                                                    color: themeColor),
                                                child: Center(
                                                  child: Text(
                                                    'عملیات',
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 12.0,
                                                        fontFamily:
                                                            'iran_yekan',
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
            forceWorkNumber != 0
                ? Container(
                    margin: EdgeInsets.all(10.0),
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        color: Colors.red),
                    child: Center(
                      child: Text(
                        'تعداد کار در وضعیت بحرانی(${forceWorkNumber.toString()})',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'iran_yekan',
                            color: Colors.white),
                      ),
                    ),
                  )
                : Container()
          ],
        )),
      ),
    );
  }

  getTeskList() async {
    var response = await get_AllCardBoards.get_allcardboards(widget.orderKey);

    setState(() {
      taskList = response['allCardBoards'];
      forceWorkNumber = response['forceWorkNumber'];
      empty = response['empty'];
    });
  }

  postponing(taskID) {
    var durationValue;

    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            //this right here
            child: Container(
              height: MediaQuery.of(context).size.height / 1.5,
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: const Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: allTimes.isEmpty
                  ? LoadingPage()
                  : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: 10.0,
                        right: 10.0
                    ),
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: themeColor,
                    ),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'به تعویق انداختن به مدت',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'iran_yekan',
                              color: Colors.white),
                        ),
                        Text(
                          durationValue == null
                              ? '0 ساعت'
                              : '${(durationValue)}',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'iran_yekan',
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.all(8.0),
//                      decoration: BoxDecoration(
//                          border: Border.all(
//                            color: themeColor,
//                          ),
//                          borderRadius: BorderRadius.all(Radius.circular(15.0))
//                      ),
                      child: ListView.separated(
                        separatorBuilder: (context, sIndex){
                          return Container(
                            height: 1.0,
                            margin: EdgeInsets.only(
                                top: 8.0,
                                bottom: 8.0
                            ),
                            color: themeColor,
                          );
                        },
                        itemCount: allTimes.length,
                        itemBuilder: (context, index){
                          return InkWell(
                            onTap: (){
                              setState(() {
                                duration = allTimes[index].key;
                                durationValue = allTimes[index].value;
                              });
                            },
                            child: Container(
                              height: 30.0,
                              child: Center(
                                child: Text(
                                  '${allTimes[index].value}',
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: themeColor
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async{
                      setState(() {
                        sendButtonForward();
                      });

                      SharedPreferences token = await SharedPreferences.getInstance();

                      var response = await http.post(api.siteName + '/panel/tasklistdelay.json', body: {
                        "token": '${token.getString('myIP_token')}',
                        "pkg": '${token.getString('pkg')}',
                        "device": '${token.getString('my_device')}',
                        "time": '${duration.toString()}',
                        "task_id": '${taskID.toString()}',
                      });
                      print(response.statusCode);
                      print(response.body);

                      if(response.statusCode == 200){
                        setState(() {
                          sendButtonBack();
                          flagCardBoardPage = 0;
                        });
                        Navigator.pop(context);
                        _firstScreenScaffoldKey.currentState.showSnackBar(new SnackBar(
                            duration: new Duration(seconds: 2),
                            content: new GestureDetector(
                                onTap: () {
                                  _firstScreenScaffoldKey.currentState.hideCurrentSnackBar();
                                },
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    textDirection: TextDirection.rtl,
                                    children: <Widget>[
                                      Text(
                                        'عملیات با موفقیت انجام شد',
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(fontFamily: 'Aviny', fontSize: 13.0),
                                      ),
                                      Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      )
                                    ],
                                  ),
                                ))));
                      }
                    },
                    child: sendButton,
                  )
                ],
              ),
            ),
          );
        });
      },
      animationType: DialogTransitionType.size,
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 1),
    );
  }



  sendButtonForward() {
    setState(() {
      sendButton = Container(
        width: 120.0,
        height: 60.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: themeColor),
        child: Center(
          child: SpinKitThreeBounce(
            color: Colors.white,
            size: 30.0,
            duration: Duration(milliseconds: 1000),
          ),
        ),
      );
    });
  }

  sendButtonBack() {
    setState(() {
      sendButton = Container(
        width: 120.0,
        height: 60.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: themeColor),
        child: Center(
          child: Text(
            'ثبت اطلاعات',
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15.0,
                fontFamily: 'iran_yekan',
                color: Colors.white),
          ),
        ),
      );
    });
  }

  addDescription(taskID, index) {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            //this right here
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: const Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 30.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: themeColor,
                    ),
                    child: Center(
                      child: Text(
                        'توضیحات',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'iran_yekan',
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    child: TextField(
                      controller: descController,
                      textAlign: TextAlign.center,
                      cursorColor: mainColor,
                      autofocus: false,
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                          fontFamily: 'iran_yekan'),
                      decoration: InputDecoration(
                        counter: Offstage(),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'متنی وارد کنید',
                        hintStyle: TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'iran_yekan',
                            color: Colors.black38),
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: themeColor),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide: new BorderSide(color: themeColor),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState((){
                        sendDescToServer(taskID);
                      });
                    },
                    child: sendButtonDesc,
                  )
                ],
              ),
            ),
          );
        });
      },
      animationType: DialogTransitionType.size,
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 1),
    );
  }

  launchURL(_url) async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  sendDescToServer(taskID) async{
    sendButtonDescForward();
    SharedPreferences token = await SharedPreferences.getInstance();

    var response = await http.post(api.siteName + '/panel/tasklistcomment.json', body: {
      "token": '${token.getString('myIP_token')}',
      "pkg": '${token.getString('pkg')}',
      "device": '${token.getString('my_device')}',
      "task_id": '${taskID.toString()}',
      "comment": '${descController.text}'
    });
    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200){

      setState(() {
        flagCardBoardPage = 0;
      });

      sendButtonDescBack();
      Navigator.pop(context);
      _firstScreenScaffoldKey.currentState.showSnackBar(new SnackBar(
          duration: new Duration(seconds: 2),
          content: new GestureDetector(
              onTap: () {
                _firstScreenScaffoldKey.currentState.hideCurrentSnackBar();
              },
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Text(
                      'عملیات با موفقیت انجام شد',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontFamily: 'Aviny', fontSize: 13.0),
                    ),
                    Icon(
                      Icons.check,
                      color: Colors.green,
                    )
                  ],
                ),
              ))));
    }
  }

  sendButtonDescForward() {
    setState(() {
      sendButtonDesc = Container(
        width: 120.0,
        height: 60.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: themeColor),
        child: Center(
          child: SpinKitThreeBounce(
            color: Colors.white,
            size: 30.0,
            duration: Duration(milliseconds: 1000),
          ),
        ),
      );
    });
  }

  sendButtonDescBack() {
    setState(() {
      sendButtonDesc = Container(
        width: 120.0,
        height: 60.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: themeColor),
        child: Center(
          child: Text(
            'ثبت اطلاعات',
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15.0,
                fontFamily: 'iran_yekan',
                color: Colors.white),
          ),
        ),
      );
    });
  }
}