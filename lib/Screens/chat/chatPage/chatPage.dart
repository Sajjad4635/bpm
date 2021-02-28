import 'dart:async';
import 'dart:io';

import 'package:bpm/Screens/chat/chatPage/Widgets/SendImageToServer.dart';
import 'package:bpm/Screens/chat/chatPage/Widgets/test.dart';
import 'package:bpm/Screens/chat/chatPage/chatPageModel.dart';
import 'package:bpm/Screens/chat/chatPage/fechChatPage.dart';
import 'package:bpm/Screens/chat/chatPage/sendTextToCustomer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bpm/style/Colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

var flagChatPage = 0;
List<allChats> chats = new List();
var empty = false;
var chatPageFontSize;

var sendVoiceIcon = Container(
  child: Center(
    child: Icon(Icons.mic, color: Colors.white),
  ),
);
var sendTextIcon = Container(
  child: Center(
    child:
    Icon(Icons.send, textDirection: TextDirection.rtl, color: Colors.white),
  ),
);

var sendImgIcon = Container(
  width: 20.0,
  height: 20.0,
  child: Center(
    child: Icon(Icons.attach_file, color: mainColor),
  ),
);

var sendingContainer = Container(
  height: 18.0,
);

class ChatPage extends StatefulWidget {
  var userIdTitle;
  var page;
  var perPage;
  var orderId;
  var userId;

  ChatPage(this.userIdTitle, this.page, this.perPage, this.orderId,
      this.userId);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    startTimer();
    print("userId: " + widget.userId);
  }

  var chatController = TextEditingController();

  _save() async {
    if (chatController.text.isEmpty) return;
//    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      sIForward();
      sendTextToStudent(chatController.text, '${TimeOfDay
          .now()
          .hour}' + ':' + '${TimeOfDay
          .now()
          .minute}');
      chatController.clear();
    });
  }

  Timer _timer;
  int _start = 20;

  startTimer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) =>
          setState(
                () {
              if (_start < 1) {
                timer.cancel();
              } else {
                _start = _start - 1;
                if (_start == 0) {
                  flagChatPage = 0;
                  _start = 20;
                }
              }
            },
          ),
    );
  }

  @override
  void dispose() {
//    _timer.cancel();
    super.dispose();
  }

  ImagePicker picker = new ImagePicker();

  Future getImageFromGallery() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      addImage(File(pickedFile.path));
    });
  }
  Future getImageFromCamera() async {
    var pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      addImage(File(pickedFile.path));
    });
  }

//  Future getFile()async{
//    FilePickerResult result = await FilePicker.platform.pickFiles();
//
//    if(result != null) {
//      PlatformFile file = result.files.first;
//
//      print(file.name);
//      print(file.bytes);
//      print(file.size);
//      print(file.extension);
//      print(file.path);
//    } else {
//      // User canceled the picker
//    }
//  }

  Widget build(BuildContext context) {
    var pageWidth = MediaQuery
        .of(context)
        .size
        .width;
    var pageHeight = MediaQuery
        .of(context)
        .size
        .height;

    setState(() {
      if (flagChatPage == 0) {
        chats.clear();
        getAllLastChats();
        flagChatPage = 1;
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
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomPadding: false,
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
                        '${widget.userIdTitle.toString()}',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'iran_yekan',
                            fontSize: 16.0,
                            color: topTitleColor),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: backIconColor,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ],
                  ),
                ))
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
//              IconButton(icon: Icon(Icons.add), onPressed: (){
//                setState(() {
//                  chats.insert(0 ,allChats(
//                      text: 'sajjad',
//                      timeCreated: '12',
//                      userId: widget.userId,
//                      orderId: widget.orderId
//                  ));
//                  getAllLastChats();
//                });
//              }),
              Expanded(
                child: Container(
                    padding: EdgeInsets.all(pageWidth / 30.0),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 80.0,
                                  bottom: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 80.0),
                              child: (chats.isEmpty) && (empty == false)
                                  ? Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      'درحال دریافت اطلاعات...',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          fontFamily: 'iran_yekan',
                                          fontSize: 15.0,
                                          color: mainColor),
                                    ),
                                  ],
                                ),
                              )
                                  : (chats.isEmpty) && (empty == true)
                                  ? Container(
                                child: Center(
                                  child: Text(
                                    'پیامی وجود ندارد!',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        fontFamily: 'iran_yekan',
                                        color: mainColor),
                                  ),
                                ),
                              )
                                  : ListView.separated(
                                physics: BouncingScrollPhysics(),
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 10.0);
                                },
                                reverse: true,
                                itemCount: chats.length,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  return chats.isEmpty
                                      ? Scaffold(
                                    body: Container(
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  )
                                      : chats[index].userIdCreated ==
                                      chats[index].userId
                                      ? customerMessage(context, index)
                                      : managerMessage(context, index);
                                },
                              ),
                            )),
                        sendingContainer,
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 60.0,
                                offset: const Offset(0.0, 5.0),
                              ),
                            ],
                          ),
                          child: Row(
                            textDirection: TextDirection.ltr,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  sendingForward();
                                  _save();
                                },
                                child: Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100.0))),
                                  child: Center(
                                    child: sendTextIcon,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                flex: 9,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25.0))),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 9,
                                        child: Container(
                                          child: TextField(
                                            controller: chatController,
                                            textAlign: TextAlign.right,
                                            decoration: new InputDecoration(
                                              hintText: "یک پیام بنویسید",
                                              hintStyle: TextStyle(
                                                  fontFamily: 'iran_yekan',
                                                  fontSize: 14.0),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: InkWell(
                                          onTap: () {
                                            openDialogSelectOption();
                                          },
                                          child: sendImgIcon,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery
                                .of(context)
                                .viewInsets
                                .bottom),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getAllLastChats() async {
    var response = await gettest.getchatstest(
        widget.page, widget.perPage, widget.orderId, widget.userId);
    setState(() {
      chats = response['chats'];
      empty = response['empty'];
    });
  }

  sendTextToStudent(text, time) async {
    var response = await send_Text_To_Customer.send_text_to_customer(
        text, time, widget.userId, widget.orderId);
    setState(() {
      var sendStatus = response['sendStatus'];
      if (sendStatus == true) {

        sendingBack();
        getAllLastChats();
//        setState(allChats(
//              text: text,
//              timeCreated: time,
//              userId: widget.userId,
//              orderId: widget.orderId
//          )
      } else {}
    });
  }

  sIForward() {
    setState(() {
      sendVoiceIcon = Container(
        width: 20.0,
        height: 20.0,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }

  sIBack() {
    setState(() {
      sendVoiceIcon = Container(
        child: Center(
          child: Icon(Icons.mic, color: Colors.white),
        ),
      );
    });
  }

  sImgForward() {
    setState(() {
      sendImgIcon = Container(
        width: 20.0,
        height: 20.0,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }

  sImgBack() {
    setState(() {
      sendImgIcon = Container(
        width: 20.0,
        height: 20.0,
        child: Center(
          child: Icon(Icons.attach_file, color: mainColor),
        ),
      );
    });
  }

  addImage(File _image) async {
    var response = await SendImageToServer.sendImageToServer(
        _image,
        chatController.text,
        widget.orderId,
        widget.userId);

    setState(() {
      if(response['status'] == 200){
        sendingBack();
        getAllLastChats();
      }
    });
  }

  openDialogSelectOption() {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          //this right here
          child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height / 2,
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
                Expanded(
                  child: InkWell(
                    onTap: () {
                      sendingForward();
                      getImageFromCamera();
                      Navigator.pop(context);
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 70.0,
                            height: 70.0,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(100.0)),
                                color: Color(0xffFFCB39)),
                            child: Center(
                              child: Icon(
                                Icons.camera_alt,
                                size: 32.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            'دوربین',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'iran_yekan',
                                color: mainColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
//                      sendingForward();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => test()));
//                      Navigator.pop(context);
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 70.0,
                            height: 70.0,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(100.0)),
                                color: Color(0xff0DA527)),
                            child: Center(
                              child: Icon(
                                Icons.photo,
                                size: 32.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            'گالری',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'iran_yekan',
                                color: mainColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
//                      getFile();
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 70.0,
                            height: 70.0,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(100.0)),
                                color: Color(0xffD01414)),
                            child: Center(
                              child: Icon(
                                Icons.insert_drive_file,
                                size: 32.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            'فایل',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'iran_yekan',
                                color: mainColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      animationType: DialogTransitionType.size,
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 1),
    );
  }

  sendingForward() {
    setState(() {
      sendingContainer = Container(
        height: 18.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text('درحال ارسال...',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    fontSize: 10.0,
                    fontFamily: 'iran_yekan',
                    color: mainColor
                ),
              ),
            ),
            SizedBox(width: 6.0,),
            Container(
              width: 8.0,
              height: 8.0,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          ],
        ),
      );
    });
  }

  sendingBack() {
    setState(() {
      sendingContainer = Container(
        height: 18.0,
      );
    });
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  final String tag;

  const FullScreenImage({Key key, this.imageUrl, this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: GestureDetector(
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Center(
              child: PhotoView.customChild(
                minScale: PhotoViewComputedScale.contained * 0.8,
                maxScale: PhotoViewComputedScale.covered * 1.8,
                child: CachedNetworkImage(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 2,
                  imageUrl: imageUrl,
                  placeholder: (context, url) =>
                      Container(
                        alignment: Alignment.center,
                        width: 20.0,
                        height: 20.0,
                        child: CircularProgressIndicator(),
                      ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.contain,
                ),
              )
//            Image.asset(imageUrl, fit: BoxFit.cover,),
          ),
        ),
        onTap: () {
//          Navigator.pop(context);
        },
      ),
    );
  }
}

Widget managerMessage(context, index) {
  return chats[index].result.message.image != null
      ? Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          constraints: BoxConstraints(
              minWidth: MediaQuery
                  .of(context)
                  .size
                  .width / 5,
              maxWidth: MediaQuery
                  .of(context)
                  .size
                  .width / 2),
          decoration: BoxDecoration(
              color: Color(0xff0DB0FC),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(0.0),
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0))),
          child: Container(
              padding: const EdgeInsets.all(9.0),
              child: Column(
                children: <Widget>[
                  chats[index].result.message.image == null
                      ? Container()
                      : InkWell(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) =>
                          FullScreenImage(
                            imageUrl: '${chats[index].result.message.image
                                .src}',
                          )));
                    },
                    child: CachedNetworkImage(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 2,
                      imageUrl: '${chats[index].result.message.image.src}',
                      placeholder: (context, url) =>
                          Container(
                            alignment: Alignment.center,
                            width: 50.0,
                            height: 50.0,
                            child: CircularProgressIndicator(),
                          ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    chats[index].text == null
                        ? ''
                        : chats[index].text,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: chatPageFontSize,
                        fontFamily: 'iran_yekan'),
                    textDirection: TextDirection.rtl,
//                                                          textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    child: Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
//                                                              Text(
//                                                                chats[index].synced
//                                                              ),
                        Center(
                          child: Icon(
                            Icons.check,
                            color: mainColor,
                            size: 15.0,
                          ),
//                          child: SvgPicture.asset('images/double-check.svg',
//                            width: 15.0,
//                            height: 15.0,
//                            color: Colors.black54,),
                        ),
                        Center(
                          child: Text(
                            '${(DateTime.fromMillisecondsSinceEpoch(
                                int.parse(chats[index].timeCreated) * 1000))
                                .toString()
                                .split(' ')[1].split(':')[0]}' +
                                ':' +
                                '${(DateTime.fromMillisecondsSinceEpoch(
                                    int.parse(chats[index].timeCreated) * 1000))
                                    .toString()
                                    .split(' ')[1].split(':')[1]}',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 10.0,
                              fontFamily: 'iran_yekan',
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
//
        ),
      ],
    ),
  )
      : chats[index].result.message.document != null
      ? Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          constraints: BoxConstraints(
              minWidth: MediaQuery
                  .of(context)
                  .size
                  .width / 5,
              maxWidth: MediaQuery
                  .of(context)
                  .size
                  .width / 2),
          decoration: BoxDecoration(
              color: Color(0xff0DB0FC),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(0.0),
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0))),
          child: Container(
              padding: const EdgeInsets.all(9.0),
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      sendPriceToServer(
                          chats[index].result.message.document.src);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 10.0,
                          right: 10.0
                      ),
                      height: 60.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: Color(0xff8ABCD3)
                      ),
                      child: Row(
                        textDirection: TextDirection.ltr,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.insert_drive_file,
                            color: Color(0xff2D38BD),
                            size: 35.0,
                          ),
                          Text(
                            '${chats[index].result.message.document.showName}',
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontFamily: 'iran_yekan',
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '${chats[index].result.message.document.name
                                .toString().split('.')[1].toUpperCase()}',
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontFamily: 'iran_yekan',
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    child: Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
//                                                              Text(
//                                                                chats[index].synced
//                                                              ),
                        Center(
                          child: Center(
                            child: Icon(
                              Icons.check,
                              color: mainColor,
                              size: 15.0,
                            ),
//                          child: SvgPicture.asset('images/double-check.svg',
//                            width: 15.0,
//                            height: 15.0,
//                            color: Colors.black54,),
                          ),
                        ),
                        Center(
                          child: Text(
                            '${(DateTime.fromMillisecondsSinceEpoch(
                                int.parse(chats[index].timeCreated) * 1000))
                                .toString()
                                .split(' ')[1].split(':')[0]}' +
                                ':' +
                                '${(DateTime.fromMillisecondsSinceEpoch(
                                    int.parse(chats[index].timeCreated) * 1000))
                                    .toString()
                                    .split(' ')[1].split(':')[1]}',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 10.0,
                              fontFamily: 'iran_yekan',
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
//
        ),
      ],
    ),
  )
      : Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          constraints: BoxConstraints(
              minWidth: MediaQuery
                  .of(context)
                  .size
                  .width / 5,
              maxWidth: MediaQuery
                  .of(context)
                  .size
                  .width / 2),
          decoration: BoxDecoration(
              color: Color(0xff0DB0FC),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(0.0),
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0))),
          child: Container(
              padding: const EdgeInsets.all(9.0),
              child: Column(
                children: <Widget>[
                  Text(
                    chats[index].text == null
                        ? ''
                        : chats[index].text,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: chatPageFontSize,
                        fontFamily: 'iran_yekan'),
                    textDirection: TextDirection.rtl,
//                                                          textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    child: Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
//                                                              Text(
//                                                                chats[index].synced
//                                                              ),
                        Center(
                          child: Icon(
                            Icons.check,
                            color: mainColor,
                            size: 15.0,
                          ),
//                          child: SvgPicture.asset('images/double-check.svg',
//                            width: 15.0,
//                            height: 15.0,
//                            color: Colors.black54,),
                        ),
                        Center(
                          child: Text(
                            '${(DateTime.fromMillisecondsSinceEpoch(
                                int.parse(chats[index].timeCreated) * 1000))
                                .toString()
                                .split(' ')[1].split(':')[0]}' +
                                ':' +
                                '${(DateTime.fromMillisecondsSinceEpoch(
                                    int.parse(chats[index].timeCreated) * 1000))
                                    .toString()
                                    .split(' ')[1].split(':')[1]}',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 10.0,
                              fontFamily: 'iran_yekan',
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
//
        ),
      ],
    ),
  );
}

Widget customerMessage(context, index) {
  return chats[index].result.message.image != null
      ? Container(
    child: Row(
      mainAxisAlignment:
      MainAxisAlignment.start,
      crossAxisAlignment:
      CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          constraints: BoxConstraints(
              minWidth: MediaQuery
                  .of(context)
                  .size
                  .width / 5,
              maxWidth: MediaQuery
                  .of(context)
                  .size
                  .width / 2),
          decoration: BoxDecoration(
              color: Color(0xffAAE4FF),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0.0),
                  bottomRight: Radius.circular(15.0),
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0))),
          child: Container(
              padding: const EdgeInsets.all(9.0),
              child: Column(
                children: <Widget>[
                  chats[index].result.message.image == null
                      ? Container()
                      : InkWell(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) =>
                          FullScreenImage(
                            imageUrl: '${chats[index].result.message.image
                                .src}',
                          )));
                    },
                    child: CachedNetworkImage(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 2,
                      imageUrl: '${chats[index].result.message.image.src}',
                      placeholder: (context, url) =>
                          Container(
                            alignment: Alignment.center,
                            width: 50.0,
                            height: 50.0,
                            child: CircularProgressIndicator(),
                          ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    chats[index].text == null
                        ? ''
                        : chats[index].text,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: chatPageFontSize,
                        fontFamily: 'iran_yekan'),
                    textDirection: TextDirection.rtl,
//                                                          textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    child: Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: Text('')
                        ),
                        Center(
                          child: Text(
                            '${(DateTime.fromMillisecondsSinceEpoch(
                                int.parse(chats[index].timeCreated) * 1000))
                                .toString()
                                .split(' ')[1].split(':')[0]}' +
                                ':' +
                                '${(DateTime.fromMillisecondsSinceEpoch(
                                    int.parse(chats[index].timeCreated) * 1000))
                                    .toString()
                                    .split(' ')[1].split(':')[1]}',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 10.0,
                              fontFamily: 'iran_yekan',
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
//
        ),
      ],
    ),
  )
      : chats[index].result.message.document != null
      ? Container(
    child: Row(
      mainAxisAlignment:
      MainAxisAlignment.start,
      crossAxisAlignment:
      CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          constraints: BoxConstraints(
              minWidth: MediaQuery
                  .of(context)
                  .size
                  .width / 5,
              maxWidth: MediaQuery
                  .of(context)
                  .size
                  .width / 1.4),
          decoration: BoxDecoration(
              color: Color(0xffAAE4FF),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0.0),
                  bottomRight: Radius.circular(15.0),
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0))),
          child: Container(
              padding: const EdgeInsets.all(9.0),
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      sendPriceToServer(
                          chats[index].result.message.document.src);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 10.0,
                          right: 10.0
                      ),
                      height: 60.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: Color(0xff8ABCD3)
                      ),
                      child: Row(
                        textDirection: TextDirection.ltr,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Icon(
                                Icons.insert_drive_file,
                                color: Color(0xff2D38BD),
                                size: 35.0,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Text(
                              '${chats[index].result.message.document.showName}',
                              textDirection: TextDirection.ltr,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'iran_yekan',
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '${chats[index].result.message.document.name
                                  .toString().split('.')[1].toUpperCase()}',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'iran_yekan',
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    child: Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
//                                                              Text(
//                                                                chats[index].synced
//                                                              ),
                        Center(
                          child: Text(''),
                        ),
                        Center(
                          child: Text(
                            '${(DateTime.fromMillisecondsSinceEpoch(
                                int.parse(chats[index].timeCreated) * 1000))
                                .toString()
                                .split(' ')[1].split(':')[0]}' +
                                ':' +
                                '${(DateTime.fromMillisecondsSinceEpoch(
                                    int.parse(chats[index].timeCreated) * 1000))
                                    .toString()
                                    .split(' ')[1].split(':')[1]}',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 10.0,
                              fontFamily: 'iran_yekan',
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
//
        ),
      ],
    ),
  )
      : Container(
    child: Row(
      mainAxisAlignment:
      MainAxisAlignment.start,
      crossAxisAlignment:
      CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          constraints: BoxConstraints(
              minWidth: MediaQuery
                  .of(context)
                  .size
                  .width / 5,
              maxWidth: MediaQuery
                  .of(context)
                  .size
                  .width / 2),
          decoration: BoxDecoration(
              color: Color(0xffAAE4FF),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0.0),
                  bottomRight: Radius.circular(15.0),
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0))),
          child: Container(
              padding: const EdgeInsets.all(9.0),
              child: Column(
                children: <Widget>[
                  Text(
                    chats[index].text == null
                        ? ''
                        : chats[index].text,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: chatPageFontSize,
                        fontFamily: 'iran_yekan'),
                    textDirection: TextDirection.rtl,
//                                                          textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    child: Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
//                                                              Text(
//                                                                chats[index].synced
//                                                              ),
                        Center(
                          child: Text(''),
                        ),
                        Center(
                          child: Text(
                            '${(DateTime.fromMillisecondsSinceEpoch(
                                int.parse(chats[index].timeCreated) * 1000))
                                .toString()
                                .split(' ')[1].split(':')[0]}' +
                                ':' +
                                '${(DateTime.fromMillisecondsSinceEpoch(
                                    int.parse(chats[index].timeCreated) * 1000))
                                    .toString()
                                    .split(' ')[1].split(':')[1]}',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 10.0,
                              fontFamily: 'iran_yekan',
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
//
        ),
      ],
    ),
  );
}

sendPriceToServer(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}