import 'dart:async';

import 'package:bpm/Screens/chat/allCustomers/allChatsModel.dart';
import 'package:bpm/Screens/chat/allCustomers/fechAllChats.dart';
import 'package:bpm/Screens/chat/chatPage/chatPage.dart';
import 'package:bpm/global/loadingPage.dart';
import 'package:bpm/style/Colors.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';

var customerIcon = [
  'images/user1.png',
  'images/user2.png',
  'images/user3.png',
  'images/user4.png',
  'images/user5.png',
  'images/user6.png',
  'images/user7.png',
];

var aa = 1;
var empty = false;
List<getAllCustomers> allChatsDetail = new List();
var getData = false;
var flagAllCustomers = 0;

class AllCustomers extends StatefulWidget {
  @override
  _AllCustomersState createState() => _AllCustomersState();
}


class _AllCustomersState extends State<AllCustomers> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  Timer _timer;
  int _start = 2;

  startTimer() async {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
            if (_start == 0) {
              if (sendStatus == 0) {
                getAllChatsData();
              }
              _start = 5;
            }
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    setState(() {
      if(flagAllCustomers == 0){
        allChatsDetail.clear();
        getAllChatsData();
        flagAllCustomers = 1;
      }
    });
    var pageWidth = MediaQuery.of(context).size.width;
    var pageHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
            child: (allChatsDetail.isEmpty) && (empty == false)
                ? LoadingPage()
                : (allChatsDetail.isEmpty) && (empty == true)
                ? Container(
              child: Center(
                child: Text(
                  'پیامی وجود ندارد!',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontFamily: 'Aviny', color: mainColor),
                ),
              ),
            )
                : Container(
              padding: EdgeInsets.only(
                left: pageWidth / 30.0,
                right: pageWidth / 30.0
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 9,
                    child: ListView.separated(
                      separatorBuilder: (context, separatedIndex) {
                        return Container(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 5.0,
                              ),
                              SizedBox(
                                height: 1,
                                child: Container(
                                  margin: EdgeInsets.only(
//                                  left: pageWidth/6,
                                    right: pageWidth / 6,
                                  ),
                                  color: Colors.black12,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              )
                            ],
                          ),
                        );
                      },
                      itemCount: allChatsDetail.length,
//                    itemCount: 5,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            flagChatPage = 0;
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(
                              doNotShowEnglish(allChatsDetail[index].user_id_title),
                              1,
                              10000,
                              allChatsDetail[index].order_id,
                              allChatsDetail[index].user_id,
                              allChatsDetail[index].id,
                              index
                            )));
//                          setState(() {
//                            numOfChats = numOfChats - allChatsDetail[index].numOfMessages;
//                            allChatsDetail[index].numOfMessages = 0;
//                          });
//                          flagchatPageChild = 0;
//                          Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (context) => chatPage(
//                                      allChatsDetail[index].studentId,
//                                      allChatsDetail[index].isNew,
//                                      allChatsDetail[index].studentName,
//                                      allChatsDetail[index].numOfMessages
//                                  ))).then((value) => flagchatPageChild = 0);
                          },
                          child: Container(
                            height: pageHeight / 9,
                            child: Center(
                              child: Row(
                                textDirection: TextDirection.rtl,
                                children: <Widget>[
                                  Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100.0)),
                                        image: DecorationImage(
                                            image:
                                            AssetImage(customerIcon[int.parse(allChatsDetail[index].user_id) % 7]),
                                            fit: BoxFit.cover)),
                                  ),
                                  Expanded(
                                    flex: 7,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                right: pageWidth / 30.0),
                                            alignment: Alignment.centerRight,
                                            child: Marquee(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(35.0)),
                                                ),
                                                child: Container(
                                                  child: Text(
                                                    allChatsDetail[index].user_id_title == null
                                                        ? 'بدون نام'
                                                        : '${doNotShowEnglish(allChatsDetail[index].user_id_title)}- ${allChatsDetail[index].order_tn_title}',
                                                    textDirection: TextDirection.rtl,
                                                    style: TextStyle(
                                                      fontFamily: 'iran_yekan',
                                                      color: mainColor,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              direction: Axis.horizontal,
                                              textDirection: TextDirection.rtl,
                                              animationDuration: Duration(seconds: 1),
                                              backDuration: Duration(milliseconds: 1000),
                                              pauseDuration: Duration(milliseconds: 100),
                                              directionMarguee: DirectionMarguee.TwoDirection,
                                            )
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                right: pageWidth / 30.0),
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              allChatsDetail[index].last_message == null
                                                  ? ''
                                                  : allChatsDetail[index]
                                                  .last_message,
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                fontFamily: 'iran_yekan',
                                                color: mainColor,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: ((allChatsDetail[index].unread_expert == null) || (allChatsDetail[index].unread_expert == '0'))
                                              ? Container()
                                              : ClipOval(
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: 20.0,
                                              height: 20.0,
                                              color: Color(0xff311b92),
                                              child: Text(
                                                int.parse(allChatsDetail[index].unread_expert) < 99
                                                    ? '${allChatsDetail[index].unread_expert}'
                                                    : '+99',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10.0,
                                                    fontFamily: 'iran_yekan'
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.bottomLeft,
                                          child: '${(DateTime.fromMillisecondsSinceEpoch(int.parse(allChatsDetail[index].last_message_date) * 1000)).toString().split(' ')[0]}'
                                              == '${DateTime.now().year}-${DateTime.now().month < 10 ? '0${DateTime.now().month}' : DateTime.now().month}-${DateTime.now().day < 10 ? '0${DateTime.now().day}' : DateTime.now().day}'
                                              ? Text(
                                            '${(DateTime.fromMillisecondsSinceEpoch(int.parse(allChatsDetail[index].last_message_date) * 1000)).toString().split(' ')[1].split(':')[0]}' +
                                                ':' +
                                                '${(DateTime.fromMillisecondsSinceEpoch(int.parse(allChatsDetail[index].last_message_date) * 1000)).toString().split(' ')[1].split(':')[1]}',
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                              fontSize: 10.0,
                                              fontFamily: 'iran_yekan',
                                              color: Colors.black,
                                            ),
                                          )
                                              : '${(DateTime.fromMillisecondsSinceEpoch(int.parse(allChatsDetail[index].last_message_date) * 1000)).toString().split(' ')[0]}'
                                              == '${DateTime.now().year}-${DateTime.now().month < 10 ? '0${DateTime.now().month}' : DateTime.now().month}-${DateTime.now().day-1 < 10 ? '0${DateTime.now().day-1}' : DateTime.now().day-1}'
                                              ? Text(
                                            'دیروز',
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                              fontSize: 10.0,
                                              fontFamily: 'iran_yekan',
                                              color: Colors.black,
                                            ),
                                          )
                                              : Text(
                                            '${allChatsDetail[index].last_message_date_title.toString().split('   ')[0]}',
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                              fontSize: 10.0,
                                              fontFamily: 'iran_yekan',
                                              color: Colors.black,
                                            ),
                                          ),
//                                      Text(
//                                          '${(DateTime.fromMillisecondsSinceEpoch(int.parse(allChatsDetail[index].last_message_date)*1000)).toString().split(' ')[0]}'
////                                          '${DateTime.now().year}-${DateTime.now().month < 10 ? '0${DateTime.now().month}' : DateTime.now().month}-${DateTime.now().day < 10 ? '0${DateTime.now().day}' : DateTime.now().day}'
//                                      )
//                                      Text(
//                                        '${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}'
//                                      )
                                        )
                                      ],
                                    ),
                                  ),


//                                Expanded(
//                                  child: Container(
//                                      child:
////                                    ((allChatsDetail[index].numOfMessages == 0) ||
////                                        (allChatsDetail[index].numOfMessages == null))
////                                        ?
//                                      Container()
////                                        : Container(
////                                      alignment: Alignment.center,
////                                      width: 20.0,
////                                      height: 20.0,
////                                      decoration: BoxDecoration(
////                                          borderRadius:
////                                          BorderRadius.all(
////                                              Radius.circular(
////                                                  100.0)),
////                                          color: mainColor),
////                                      child: Center(
////                                        child: Text(
////                                          '${allChatsDetail[index].numOfMessages}',
////                                          style: TextStyle(
////                                              color: Colors.white),
////                                        ),
////                                      ),
////                                    ),
//                                  ),
//                                )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )
        ),
      ),
    );
  }

  getAllChatsData() async {
    var response = await get_AllCustomers_Info.get_allCustomers_info();
    setState(() {
      allChatsDetail = response['allChats'];
      empty = response['empty'];
    });
  }

  openDialogSendGroupMessage() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            //this right here
            child: Container(
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
              child: Container(
                child: Column(
                  children: [

                  ],
                ),
              ),
            ),
          );
        });
  }
}

String doNotShowEnglish(String name){

  name = name.replaceAll('a', '');
  name = name.replaceAll('b', '');
  name = name.replaceAll('c', '');
  name = name.replaceAll('d', '');
  name = name.replaceAll('e', '');
  name = name.replaceAll('f', '');
  name = name.replaceAll('g', '');
  name = name.replaceAll('h', '');
  name = name.replaceAll('i', '');
  name = name.replaceAll('j', '');
  name = name.replaceAll('k', '');
  name = name.replaceAll('l', '');
  name = name.replaceAll('m', '');
  name = name.replaceAll('n', '');
  name = name.replaceAll('o', '');
  name = name.replaceAll('p', '');
  name = name.replaceAll('q', '');
  name = name.replaceAll('r', '');
  name = name.replaceAll('s', '');
  name = name.replaceAll('t', '');
  name = name.replaceAll('u', '');
  name = name.replaceAll('v', '');
  name = name.replaceAll('w', '');
  name = name.replaceAll('x', '');
  name = name.replaceAll('y', '');
  name = name.replaceAll('z', '');

  name = name.replaceAll('A', '');
  name = name.replaceAll('B', '');
  name = name.replaceAll('C', '');
  name = name.replaceAll('D', '');
  name = name.replaceAll('E', '');
  name = name.replaceAll('F', '');
  name = name.replaceAll('G', '');
  name = name.replaceAll('H', '');
  name = name.replaceAll('I', '');
  name = name.replaceAll('J', '');
  name = name.replaceAll('K', '');
  name = name.replaceAll('L', '');
  name = name.replaceAll('M', '');
  name = name.replaceAll('N', '');
  name = name.replaceAll('O', '');
  name = name.replaceAll('P', '');
  name = name.replaceAll('Q', '');
  name = name.replaceAll('R', '');
  name = name.replaceAll('S', '');
  name = name.replaceAll('T', '');
  name = name.replaceAll('U', '');
  name = name.replaceAll('V', '');
  name = name.replaceAll('W', '');
  name = name.replaceAll('X', '');
  name = name.replaceAll('Y', '');
  name = name.replaceAll('Z', '');

  return name;
}