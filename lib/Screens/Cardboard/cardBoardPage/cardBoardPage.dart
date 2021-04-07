import 'package:bpm/Screens/Cardboard/cardBoardPage/cardBoardPageModel.dart';
import 'package:bpm/Screens/Cardboard/cardBoardPage/fechCardBoardPage.dart';
import 'package:bpm/Screens/chat/allCustomers/allChatsView.dart';
import 'package:bpm/global/loadingPage.dart';
import 'package:bpm/style/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

List<cardBoardPageModel> taskList = new List();
var forceWorkNumber;
var empty = false;

class cardBoardPage extends StatefulWidget {
  var value, orderKey;

  cardBoardPage(this.value, this.orderKey);

  @override
  _cardBoardPageState createState() => _cardBoardPageState();
}

class _cardBoardPageState extends State<cardBoardPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    empty = false;
    forceWorkNumber = 0;
    taskList.clear();
    getTeskList();
    print(widget.orderKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            showOrderDetail()));
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height / 4,
                                margin:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
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
                                                          .userIdOwnerTitle == null
                                                  ? 'صاحب سفارش : -'
                                                  : doNotShowEnglish(
                                                      'صاحب سفارش : ${taskList[index].userIdOwnerTitle}'),
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontFamily: 'iran_yekan',
                                                  color: themeColor),
                                            ),
                                            Text(
                                              taskList[index]
                                                          .userIdCreatedTitle == null
                                                  ? 'مدیر مشتری : -'
                                                  : doNotShowEnglish(
                                                      'مدیر مشتری : ${taskList[index].userIdCreatedTitle}'),
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontFamily: 'iran_yekan',
                                                  color: themeColor),
                                            ),
                                            Text(
                                              taskList[index]
                                                          .orderStatusTitle == null
                                                  ? 'وضعیت : -'
                                                  : 'وضعیت : ${taskList[index].orderStatusTitle}',
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontFamily: 'iran_yekan',
                                                  color: themeColor),
                                            ),
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
                                                postponing();
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
                                                addDescription();
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
                                                launchURL(
                                                    'https://fatertejarat.com');
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

  postponing() {
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
              height: MediaQuery.of(context).size.height / 2,
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
                        'به تعویق انداختن به مدت',
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
                    child: Center(
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: DropdownButton<String>(
                          hint: Text(
                            'انتخاب کنید',
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18.0, fontFamily: 'iran_yekan'),
                          ),
                          value: durationValue,
                          underline: Container(),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'iran_yekan',
                              color: Colors.black54),
                          onChanged: (String newValue) {
                            setState(() {
                              durationValue = newValue;
                            });
                          },
                          items: <String>[
                            "1",
                            "2",
                            "3",
                            "4",
                            "5",
                            "6",
                            "7",
                            "8",
                            "9",
                            "10",
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  value,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'iran_yekan',
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
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
//                              controller: verificationCode,
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
                    onTap: () {},
                    child: Container(
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
                    ),
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

  addDescription() {
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
//                              controller: verificationCode,
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
                    onTap: () {},
                    child: Container(
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
                    ),
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
}

class showOrderDetail extends StatefulWidget {
  @override
  _showOrderDetailState createState() => _showOrderDetailState();
}

class _showOrderDetailState extends State<showOrderDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SafeArea(
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Center(
                        child: Text(
                          'عملیات',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'iran_yekan',
                              color: themeColor),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'وضعیت',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'iran_yekan',
                              color: themeColor),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'زمان ورود وظیفه',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'iran_yekan',
                              color: themeColor),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'سفارش',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'iran_yekan',
                              color: themeColor),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'کالای سفارش',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'iran_yekan',
                              color: themeColor),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'خدمات موردنیاز',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'iran_yekan',
                              color: themeColor),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'وزن قابل پرداخت سفارش (kg)',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'iran_yekan',
                              color: themeColor),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'ارزش کل',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'iran_yekan',
                              color: themeColor),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'واحد ارزش',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'iran_yekan',
                              color: themeColor),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'ایجادکننده',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'iran_yekan',
                              color: themeColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showTimeDuration();
                      },
                      child: Container(
                        child: Center(
                          child: Text(
                            'عملیات',
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'iran_yekan',
                                color: themeColor),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'عملیات',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'iran_yekan',
                              color: themeColor),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'زمان ورود وظیفه',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'iran_yekan',
                              color: themeColor),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'سفارش',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'iran_yekan',
                              color: themeColor),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'کالای سفارش',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'iran_yekan',
                              color: themeColor),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'خدمات موردنیاز',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'iran_yekan',
                              color: themeColor),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'وزن قابل پرداخت سفارش (kg)',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'iran_yekan',
                              color: themeColor),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'ارزش کل',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'iran_yekan',
                              color: themeColor),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'واحد ارزش',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'iran_yekan',
                              color: themeColor),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'ایجادکننده',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'iran_yekan',
                              color: themeColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  var tiemsTitle = [
    '1',
    '2',
    '3',
    '5',
    '12',
    '24',
    '48',
    '72',
  ];

  showTimeDuration() {
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
              height: MediaQuery.of(context).size.height / 2,
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
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Center(
                        child: Text('انتخاب کنید',
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 17.0,
                                fontFamily: 'iran_yekan',
                                color: themeColor)),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: ListView.builder(
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return Card(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                print(tiemsTitle[index]);
                              });
                            },
                            child: Container(
                              height: 50.0,
                              child: Row(
                                textDirection: TextDirection.rtl,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('${tiemsTitle[index]}',
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: 'iran_yekan',
                                          color: themeColor)),
                                  Text('ساعت',
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: 'iran_yekan',
                                          color: themeColor)),
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
            ),
          );
        });
      },
      animationType: DialogTransitionType.size,
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 1),
    );
  }
}
