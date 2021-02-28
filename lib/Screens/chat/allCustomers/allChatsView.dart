import 'package:bpm/Screens/chat/allCustomers/allChatsModel.dart';
import 'package:bpm/Screens/chat/allCustomers/fechAllChats.dart';
import 'package:bpm/Screens/chat/chatPage/chatPage.dart';
import 'package:bpm/global/loadingPage.dart';
import 'package:bpm/style/Colors.dart';
import 'package:flutter/material.dart';

var aa = 1;
var empty = false;
List<getAllCustomers> allChatsDetail = new List();
var getData = false;

class AllCustomers extends StatefulWidget {
  @override
  _AllCustomersState createState() => _AllCustomersState();
}


class _AllCustomersState extends State<AllCustomers> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allChatsDetail.clear();
    getAllChatsData();
  }
  @override
  Widget build(BuildContext context) {
    var pageWidth = MediaQuery.of(context).size.width;
    var pageHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage('images/ic_back3.png'), fit: BoxFit.fitHeight,
            colorFilter: new ColorFilter.mode(Colors.blue.withOpacity(0.15), BlendMode.dstATop),
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: Container(),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          actions: [
            Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: pageWidth / 30.0),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'لیست گفت و گو ها',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'iran_yekan',
                            fontSize: 16.0,
                            color: topTitleColor
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.arrow_back, color: backIconColor,),
                          onPressed: (){
                            Navigator.pop(context);
                          })
                    ],
                  ),
                ))
          ],
        ),
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
              padding: EdgeInsets.all(pageWidth / 30.0),
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
                              allChatsDetail[index].user_id_title,
                              1,
                              10000,
                              allChatsDetail[index].order_id,
                              allChatsDetail[index].user_id,
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
                                            AssetImage('images/customerIcon.png'),
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
                                            child: Text(
                                              allChatsDetail[index].user_id_title == null
                                                  ? 'بدون نام'
                                                  : allChatsDetail[index]
                                                  .user_id_title,
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                fontFamily: 'iran_yekan',
                                                color: mainColor,
                                                fontSize: 16.0,
                                              ),
                                            ),
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
                                    flex: 1,
                                    child: Container(
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        '13:20',
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'iran_yekan',
                                            fontSize: 12.0,
                                            color: topTitleColor
                                        ),
                                      ),
                                    ),
                                  )


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
