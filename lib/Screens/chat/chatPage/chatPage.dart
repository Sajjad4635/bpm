import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:bpm/API/api.dart';
import 'package:bpm/Screens/chat/chatPage/Widgets/SendImageToServer.dart';
import 'package:bpm/Screens/chat/chatPage/Widgets/addTextToImage.dart';
import 'package:bpm/Screens/chat/chatPage/Widgets/sendFile.dart';
import 'package:bpm/Screens/chat/chatPage/Widgets/sendVoice.dart';
import 'package:bpm/Screens/chat/chatPage/chatPageModel.dart';
import 'package:bpm/Screens/chat/chatPage/fechChatPage.dart';
import 'package:bpm/Screens/chat/chatPage/sendTextToCustomer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bpm/style/Colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

var sendStatus = 0;

var flagChatPage = 0;
List<allChats> chats = new List();
var empty = false;
var chatPageFontSize;

final GlobalKey<ScaffoldState> _chatPageScaffoldKey = new GlobalKey<ScaffoldState>();
var chatController = TextEditingController();

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

var sendIcon = Container(
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

var sendingContainer = Container();

class ChatPage extends StatefulWidget {
  var userIdTitle;
  var page;
  var perPage;
  var orderId;
  var userId;
  var id;
  var index;

  ChatPage(
      this.userIdTitle, this.page, this.perPage, this.orderId, this.userId, this.id, this.index);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Directory appDirectory;
  Stream<FileSystemEntity> fileStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
    print("userId: " + widget.userId);
    messageStatusIsRead(widget.id, widget.index);
  }

  messageStatusIsRead(id, index) async{

    SharedPreferences token = await SharedPreferences.getInstance();

    var response = await http.post(api.siteName + '/panel/chatmessageread.json',body: {
      "token": '${token.getString('myIP_token')}',
      "pkg": '${token.getString('pkg')}',
      "device": '${token.getString('my_device')}',
      "id": '${id.toString()}',
      'all': 'true',
      'room_id': 'true'
    });

    print(response.statusCode);
    print(response.body);
  }

  Timer _timer;
  int _start = 2;

  startTimer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
                getAllLastChats();
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

  Widget build(BuildContext context) {
    var pageWidth = MediaQuery.of(context).size.width;
    var pageHeight = MediaQuery.of(context).size.height;

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
        resizeToAvoidBottomInset: false,
        key: _chatPageScaffoldKey,
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
                              top: MediaQuery.of(context).size.width / 80.0,
                              bottom: MediaQuery.of(context).size.width / 80.0),
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
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                ),
                                              )
                                            : chats[index].userIdCreated ==
                                                    chats[index].userId
                                                ? customerMessage(index)
                                                : managerMessage(index);
                                      },
                                    ),
                        )),
                        sendingContainer,
                        sendBox(widget.orderId, widget.userId, widget.page,
                            widget.perPage),
                        SizedBox(
                            height: MediaQuery.of(context).viewInsets.bottom),
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
        _image, chatController.text, widget.orderId, widget.userId);

    setState(() {
      if (response['status'] == 200) {
        sendingBack();
        getAllLastChats();
      }
    });
  }

  sendingForward() {
    setState(() {
      sendStatus = 1;
      sendingContainer = Container(
        height: 18.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'درحال ارسال...',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    fontSize: 10.0, fontFamily: 'iran_yekan', color: mainColor),
              ),
            ),
            SizedBox(
              width: 6.0,
            ),
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
      sendStatus = 0;
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
          width: MediaQuery.of(context).size.width,
          child: Center(
              child: PhotoView.customChild(
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 1.8,
            child: CachedNetworkImage(
              width: MediaQuery.of(context).size.width / 2,
              imageUrl: imageUrl,
              placeholder: (context, url) => Container(
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

class sendBox extends StatefulWidget {
  var orderId, userId, page, perPage;

  sendBox(this.orderId, this.userId, this.page, this.perPage);

  @override
  _sendBoxState createState() => _sendBoxState();
}

class _sendBoxState extends State<sendBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              if (chatController.text != '') {
                sendingForward();
                _save();
              }
            },
            child: chatController.text == ''
                ? Container(
                    width: 50.0,
                    height: 50.0,
                    child: Center(
                      child: RecorderView(
                        onSaved: (value, duration) =>
                            {print(value), sendVoiceToServer(value, duration)},
                      ),
                    ),
                  )
                : Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.all(Radius.circular(100.0))),
                    child: Center(
                      child: sendIcon,
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
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              child: Row(
                children: [
                  Expanded(
                    flex: 9,
                    child: flag == 0
                        ? Container(
                      height: 50.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'برای لغو به سمت راست بکشید',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'iran_yekan',
                                      color: mainColor),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: mainColor,
                                  size: 20.0,
                                )
                              ],
                            ),
                          )
                        : Container(
                            child: TextField(
                              controller: chatController,
                              textAlign: TextAlign.right,
                              decoration: new InputDecoration(
                                hintText: "یک پیام بنویسید",
                                hintStyle: TextStyle(
                                    fontFamily: 'iran_yekan', fontSize: 14.0),
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
    );
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
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddTextToImage(
                                  'camera', widget.orderId, widget.userId)));
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
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddTextToImage(
                                  'gallery', widget.orderId, widget.userId)));
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
                      Navigator.pop(context);
                      sendingForward();
                      getFile();
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

  _save() async {
    if (chatController.text.isEmpty) return;
//    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      sIForward();
      sendTextToCustomer(chatController.text,
          '${TimeOfDay.now().hour}' + ':' + '${TimeOfDay.now().minute}');
      chatController.clear();
    });
  }

  sendTextToCustomer(text, time) async {
    var response = await send_Text_To_Customer.send_text_to_customer(
        text, time, widget.userId, widget.orderId);
    setState(() {
      var sendStatus = response['sendStatus'];
      if (sendStatus == true) {
        sendingBack();
        getAllLastChats();
      } else {}
    });
  }

  sendVoiceToServer(File file, duration) async {
    setState(() {
      sendingForward();
    });
    var response = await SendVoice.sendVoice(
        file, duration, '', widget.orderId, widget.userId);

    if (response['status'] == 200) {
      setState(() {
        sendingBack();
      });
      getAllLastChats();
    }
  }

  getAllLastChats() async {
    var response = await gettest.getchatstest(
        widget.page, widget.perPage, widget.orderId, widget.userId);
    setState(() {
      chats = response['chats'];
      empty = response['empty'];
    });
  }

  getFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path);

      print('document: ' + file.toString());

      var response =
          await SendFile.sendFile(file, '', widget.orderId, widget.userId);

      if (response['status'] == 200) {
        setState(() {
          sendingBack();
          getAllLastChats();
        });
      }
    } else {
      // User canceled the picker
    }
  }

  sendingForward() {
    setState(() {
      sendStatus = 1;
      sendingContainer = Container(
        height: 18.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'درحال ارسال...',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    fontSize: 10.0, fontFamily: 'iran_yekan', color: mainColor),
              ),
            ),
            SizedBox(
              width: 6.0,
            ),
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
      sendStatus = 0;
      sendingContainer = Container(
        height: 18.0,
      );
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
}

//********************recorder values************
File pathTemp;
var flag;
//********************recorder values************

class RecorderView extends StatefulWidget {
  final Function(File path, String duration) onSaved;

  File path;

  RecorderView({Key key, @required this.onSaved}) : super(key: key);

  @override
  _RecorderViewState createState() => _RecorderViewState();
}

enum RecordingState {
  UnSet,
  Set,
  Recording,
  Stopped,
}

class _RecorderViewState extends State<RecorderView> {
  IconData _recordIcon = Icons.mic_none;
  String _recordText = 'Click To Start';
  RecordingState _recordingState = RecordingState.UnSet;

  // Recorder properties
  FlutterAudioRecorder audioRecorder;

  @override
  void initState() {
    super.initState();

    FlutterAudioRecorder.hasPermissions.then((hasPermision) {
      if (hasPermision) {
        _recordingState = RecordingState.Set;
        _recordIcon = Icons.mic;
        _recordText = 'Record';
      }
    });
  }

  @override
  void dispose() {
    _recordingState = RecordingState.UnSet;
    audioRecorder = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPressMoveUpdate: (detail) async {
          if ((detail.globalPosition.dx >= 80.0) &&
              (detail.globalPosition.dx <= 120.0)) {
            print(detail.globalPosition.dx);
            await audioRecorder.stop();
            _recordIcon = Icons.mic;
            flag = 1;
          }
        },
        onLongPressUp: () async {
          if (flag == 0) {
            await _stopRecording();
            _recordingState = RecordingState.Stopped;
            _recordIcon = Icons.mic;
            print('onLongPressUp');
            flag = 1;
          }
        },
        onLongPress: () async {
          setState(() {
            flag = 0;
          });
          print('onLongPress');
          await _recordVoice();
        },
        child: Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.all(Radius.circular(100.0))),
          child: Center(
            child: Icon(
              _recordIcon,
              color: Colors.white,
            ),
          ),
        ));
  }

  Future<void> _onRecordButtonPressed() async {
    switch (_recordingState) {
      case RecordingState.Set:
        break;

      case RecordingState.Recording:
        _recordText = 'Record new one';
        break;

      case RecordingState.Stopped:
        await _recordVoice();
        break;

      case RecordingState.UnSet:
        Scaffold.of(context).hideCurrentSnackBar();
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Please allow recording from settings.'),
        ));
        break;
    }
  }

  _initRecorder() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String filePath = appDirectory.path +
        '/' +
        DateTime.now().millisecondsSinceEpoch.toString() +
        '.aac';
    pathTemp = File.fromUri(Uri.parse(filePath));
    print(
        'pathhhhhhhhhhhhhhhhhhhhh:::::::: ${File.fromUri(Uri.parse(filePath))}');
    audioRecorder =
        FlutterAudioRecorder(filePath, audioFormat: AudioFormat.AAC);
    await audioRecorder.initialized;
  }

  _startRecording() async {
    await audioRecorder.start();
    // await audioRecorder.current(channel: 0);
  }

  _stopRecording() async {
    await audioRecorder.stop();

    var durationAudio = await audioRecorder.stop();

    widget.onSaved(pathTemp, durationAudio.duration.inMilliseconds.toString());
  }

  Future<void> _recordVoice() async {
    if (await FlutterAudioRecorder.hasPermissions) {
      await _initRecorder();

      await _startRecording();
      _recordingState = RecordingState.Recording;
      _recordIcon = Icons.stop;
      _recordText = 'Recording';
    } else {
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please allow recording from settings.'),
      ));
    }
  }
}

class managerMessage extends StatefulWidget {
  var index;

  managerMessage(this.index);

  @override
  _managerMessageState createState() => _managerMessageState(index);
}

class _managerMessageState extends State<managerMessage> {
  AudioPlayer audioPlayer = AudioPlayer();
  var index;
  var playIcon = Icons.play_arrow;

  _managerMessageState(this.index);

  var playStatus = 0;
  var dWidth = 0.0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return chats[index].result.message.image != null
        ? Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width / 5,
                      maxWidth: MediaQuery.of(context).size.width / 1.4),
                  decoration: BoxDecoration(
                      color: Color(0xff7BCDFF),
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
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FullScreenImage(
                                                  imageUrl:
                                                      '${chats[index].result.message.image.src}',
                                                )));
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                    child: CachedNetworkImage(
                                      width: MediaQuery.of(context).size.width / 1,
                                      imageUrl: '${chats[index].result.message.image.src}',
                                      placeholder: (context, url) => Container(
                                        alignment: Alignment.center,
                                        width: 50.0,
                                        height: 50.0,
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                          Text(
                            chats[index].text == null ? '' : chats[index].text,
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
                                Icon(
                                  Icons.check,
                                  size: 12,
                                ),
                                Center(
                                  child: Text(
                                    '${(DateTime.fromMillisecondsSinceEpoch(int.parse(chats[index].timeCreated) * 1000)).toString().split(' ')[1].split(':')[0]}' +
                                        ':' +
                                        '${(DateTime.fromMillisecondsSinceEpoch(int.parse(chats[index].timeCreated) * 1000)).toString().split(' ')[1].split(':')[1]}',
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
                          minWidth: MediaQuery.of(context).size.width / 5,
                          maxWidth: MediaQuery.of(context).size.width / 1.6),
                      decoration: BoxDecoration(
                          color: Color(0xff7BCDFF),
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
                                  openDocument(
                                      chats[index].result.message.document.src);
                                },
                                child: Container(
                                  padding:
                                      EdgeInsets.only(left: 10.0, right: 10.0),
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      color: Color(0xff8ABCD3)),
                                  child: Row(
                                    textDirection: TextDirection.ltr,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                          '${chats[index].result.message.document.name.toString().split('.')[1].toUpperCase()}',
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.check,
                                      size: 12,
                                    ),
                                    Center(
                                      child: Text(
                                        '${(DateTime.fromMillisecondsSinceEpoch(int.parse(chats[index].timeCreated) * 1000)).toString().split(' ')[1].split(':')[0]}' +
                                            ':' +
                                            '${(DateTime.fromMillisecondsSinceEpoch(int.parse(chats[index].timeCreated) * 1000)).toString().split(' ')[1].split(':')[1]}',
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
            : chats[index].result.message.voice != null
                ? Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          constraints: BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width / 5,
                              maxWidth:
                                  MediaQuery.of(context).size.width / 1.6),
                          decoration: BoxDecoration(
                              color: Color(0xff7BCDFF),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(0.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0))),
                          child: Container(
                              padding: const EdgeInsets.all(9.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                        color: Color(0xff8ABCD3)),
                                    child: Row(
                                      textDirection: TextDirection.ltr,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: IconButton(
                                              icon: Icon(
                                                playIcon,
                                                color: Color(0xff2D38BD),
                                                size: 35.0,
                                              ),
                                              onPressed: () async {
                                                if (playStatus == 0) {
                                                  playVoice(
                                                      chats[index]
                                                          .result
                                                          .message
                                                          .voice
                                                          .src,
                                                      double.parse(chats[index]
                                                          .result
                                                          .message
                                                          .voice
                                                          .duration));
                                                } else if (playStatus == 1) {
                                                  await audioPlayer.pause();
                                                  setState(() {
                                                    playIcon = Icons.play_arrow;
                                                    playStatus = 0;
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 6,
                                          child: Container(
                                            child: Center(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              100.0)),
                                                  color: Colors.black38,
                                                ),
                                                width: 100.0,
                                                height: 5.0,
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    100.0)),
                                                        color:
                                                            Colors.blueAccent,
                                                      ),
                                                      width: dWidth,
                                                      height: 10.0,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
//                                          child: lineTimeDuration(10),
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                              (int.parse((double.parse(chats[
                                                                          index]
                                                                      .result
                                                                      .message
                                                                      .voice
                                                                      .duration) /
                                                                  1000)
                                                              .toStringAsFixed(
                                                                  0)) %
                                                          60) <
                                                      10
                                                  ? '${(int.parse((double.parse(chats[index].result.message.voice.duration) / 1000).toStringAsFixed(0)) / 60).toStringAsFixed(0)}' +
                                                      ':' +
                                                      '0' +
                                                      '${int.parse((double.parse(chats[index].result.message.voice.duration) / 1000).toStringAsFixed(0)) % 60}'
                                                  : '${(int.parse((double.parse(chats[index].result.message.voice.duration) / 1000).toStringAsFixed(0)) / 60).toStringAsFixed(0)}' +
                                                      ':' +
                                                      '${int.parse((double.parse(chats[index].result.message.voice.duration) / 1000).toStringAsFixed(0)) % 60}',
                                              textDirection: TextDirection.ltr,
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontFamily: 'iran_yekan',
                                                color: Colors.black,
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Container(
                                    child: Row(
                                      textDirection: TextDirection.rtl,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.check,
                                          size: 12.0,
                                        ),
                                        Center(
                                          child: Text(
                                            '${(DateTime.fromMillisecondsSinceEpoch(int.parse(chats[index].timeCreated) * 1000)).toString().split(' ')[1].split(':')[0]}' +
                                                ':' +
                                                '${(DateTime.fromMillisecondsSinceEpoch(int.parse(chats[index].timeCreated) * 1000)).toString().split(' ')[1].split(':')[1]}',
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
                                minWidth: MediaQuery.of(context).size.width / 5,
                                maxWidth: MediaQuery.of(context).size.width / 2,
                            ),
                            padding: EdgeInsets.all(9.0),
                            decoration: BoxDecoration(
                                color: Color(0xff7BCDFF),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15.0),
                                    bottomRight: Radius.circular(0.0),
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0))),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  chats[index].result.message.text == null
                                      ? ''
                                      : chats[index].result.message.text,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: chatPageFontSize,
                                      fontFamily: 'iran_yekan'),
//                                                          textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    textDirection: TextDirection.rtl,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.check,
                                        size: 12.0,
                                      ),
                                      Center(
                                        child: Text(
                                          '${(DateTime.fromMillisecondsSinceEpoch(int.parse(chats[index].timeCreated) * 1000)).toString().split(' ')[1].split(':')[0]}' +
                                              ':' +
                                              '${(DateTime.fromMillisecondsSinceEpoch(int.parse(chats[index].timeCreated) * 1000)).toString().split(' ')[1].split(':')[1]}',
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
                            )
                            ),
                      ],
                    ),
                  );
  }

  playVoice(src, duration) async {
    setState(() {
      playIcon = Icons.pause;
      playStatus = 1;
    });
    await audioPlayer.play(src);
    audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        playStatus = 0;
        playIcon = Icons.play_arrow;
        audioPlayer.stop();
        dWidth = 0.0;
      });
    });
    if (playStatus == 1) {
      setState(() {
        Timer.periodic(Duration(seconds: 1), (timer) {
          print('width :::::::::::: $dWidth');
          if ((dWidth < 100.0) && (playStatus == 1)) {
            widthGrow(duration);
          } else {
            timer.cancel();
          }
        });
      });
    }
  }

  pauseVoice(src) async {
    await audioPlayer.pause();
  }

  timeGrow(timerVal) {}

  widthGrow(timerVal) {
    setState(() {
      dWidth = dWidth + (100.0 / (timerVal / 1000));
    });
  }
}

class customerMessage extends StatefulWidget {
  var index;

  customerMessage(this.index);

  @override
  _customerMessageState createState() => _customerMessageState(index);
}

class _customerMessageState extends State<customerMessage> {
  AudioPlayer audioPlayer = AudioPlayer();
  var index;
  var playIcon = Icons.play_arrow;

  _customerMessageState(this.index);

  var playStatus = 0;
  var dWidth = 0.0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return chats[index].result.message.image != null
        ? Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width / 5,
                      maxWidth: MediaQuery.of(context).size.width / 1.4,
                  ),
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
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FullScreenImage(
                                                  imageUrl:
                                                      '${chats[index].result.message.image.src}',
                                                )));
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                    child: CachedNetworkImage(
                                      width:
                                      MediaQuery.of(context).size.width / 1.4,
                                      imageUrl:
                                      '${chats[index].result.message.image.src}',
                                      placeholder: (context, url) => Container(
                                        alignment: Alignment.center,
                                        width: 50.0,
                                        height: 50.0,
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                          Text(
                            chats[index].text == null ? '' : chats[index].text,
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
                                Center(child: Text('')),
                                Center(
                                  child: Text(
                                    '${(DateTime.fromMillisecondsSinceEpoch(int.parse(chats[index].timeCreated) * 1000)).toString().split(' ')[1].split(':')[0]}' +
                                        ':' +
                                        '${(DateTime.fromMillisecondsSinceEpoch(int.parse(chats[index].timeCreated) * 1000)).toString().split(' ')[1].split(':')[1]}',
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width / 5,
                          maxWidth: MediaQuery.of(context).size.width / 1.6),
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
                                  openDocument(
                                      chats[index].result.message.document.src);
                                },
                                child: Container(
                                  padding:
                                      EdgeInsets.only(left: 10.0, right: 10.0),
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      color: Color(0xff8ABCD3)),
                                  child: Row(
                                    textDirection: TextDirection.ltr,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                          '${chats[index].result.message.document.name.toString().split('.')[1].toUpperCase()}',
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Center(
                                      child: Text(''),
                                    ),
                                    Center(
                                      child: Text(
                                        '${(DateTime.fromMillisecondsSinceEpoch(int.parse(chats[index].timeCreated) * 1000)).toString().split(' ')[1].split(':')[0]}' +
                                            ':' +
                                            '${(DateTime.fromMillisecondsSinceEpoch(int.parse(chats[index].timeCreated) * 1000)).toString().split(' ')[1].split(':')[1]}',
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
            : chats[index].result.message.voice != null
                ? Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          constraints: BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width / 5,
                              maxWidth: MediaQuery.of(context).size.width / 1.6),
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
                                  Container(
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                        color: Color(0xff8ABCD3)),
                                    child: Row(
                                      textDirection: TextDirection.ltr,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: IconButton(
                                              icon: Icon(
                                                playIcon,
                                                color: Color(0xff2D38BD),
                                                size: 35.0,
                                              ),
                                              onPressed: () {
                                                print(
                                                    'play status :::::::::::: $playStatus');
                                                if (playStatus == 0) {
                                                  print(
                                                      'fffff:::::::::::::::::::::::::${chats[index].result.message.voice.src}');
                                                  playVoice(
                                                      chats[index]
                                                          .result
                                                          .message
                                                          .voice
                                                          .src,
                                                      double.parse(chats[index]
                                                          .result
                                                          .message
                                                          .voice
                                                          .duration));
                                                } else if (playStatus == 1) {
                                                  print('aaaaaa');
                                                  pauseVoice();
                                                  setState(() {
                                                    playIcon = Icons.play_arrow;
                                                    playStatus = 0;
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 6,
                                          child: Container(
                                            child: Center(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              100.0)),
                                                  color: Colors.black38,
                                                ),
                                                width: 100.0,
                                                height: 5.0,
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    100.0)),
                                                        color:
                                                            Colors.blueAccent,
                                                      ),
                                                      width: dWidth,
                                                      height: 10.0,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
//                                          child: lineTimeDuration(10),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
//                                            double.parse(chats[index].result.message.voice.duration).toStringAsFixed(0),
                                            (int.parse((double.parse(chats[
                                                                        index]
                                                                    .result
                                                                    .message
                                                                    .voice
                                                                    .duration) /
                                                                1000)
                                                            .toStringAsFixed(
                                                                0)) %
                                                        60) <
                                                    10
                                                ? '${(int.parse((double.parse(chats[index].result.message.voice.duration) / 1000).toStringAsFixed(0)) / 60).toStringAsFixed(0)}' +
                                                    ':' +
                                                    '0' +
                                                    '${int.parse((double.parse(chats[index].result.message.voice.duration) / 1000).toStringAsFixed(0)) % 60}'
                                                : '${(int.parse((double.parse(chats[index].result.message.voice.duration) / 1000).toStringAsFixed(0)) / 60).toStringAsFixed(0)}' +
                                                    ':' +
                                                    '${int.parse((double.parse(chats[index].result.message.voice.duration) / 1000).toStringAsFixed(0)) % 60}',
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
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Container(
                                    child: Row(
                                      textDirection: TextDirection.rtl,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Center(
                                          child: Text(''),
                                        ),
                                        Center(
                                          child: Text(
                                            '${(DateTime.fromMillisecondsSinceEpoch(int.parse(chats[index].timeCreated) * 1000)).toString().split(' ')[1].split(':')[0]}' +
                                                ':' +
                                                '${(DateTime.fromMillisecondsSinceEpoch(int.parse(chats[index].timeCreated) * 1000)).toString().split(' ')[1].split(':')[1]}',
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          constraints: BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width / 5,
                              maxWidth: MediaQuery.of(context).size.width / 2),
                          decoration: BoxDecoration(
                              color: Color(0xffAAE4FF),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0))),
                          child: Container(
                              padding: EdgeInsets.all(9.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    chats[index].result.message.text == null
                                        ? ''
                                        : chats[index].result.message.text,
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: chatPageFontSize,
                                        fontFamily: 'iran_yekan'),
//                                                          textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Container(
                                    child: Row(
                                      textDirection: TextDirection.rtl,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
//                                                              Text(
//                                                                chats[index].synced
//                                                              ),
                                        Center(
                                          child: Text(''),
                                        ),
                                        Center(
                                          child: Text(
                                            '${(DateTime.fromMillisecondsSinceEpoch(int.parse(chats[index].timeCreated) * 1000)).toString().split(' ')[1].split(':')[0]}' +
                                                ':' +
                                                '${(DateTime.fromMillisecondsSinceEpoch(int.parse(chats[index].timeCreated) * 1000)).toString().split(' ')[1].split(':')[1]}',
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

  playVoice(src, duration) async {
    setState(() {
      playIcon = Icons.pause;
      playStatus = 1;
    });
    print('srccccc::::::::::::::::::::: $src');

    await audioPlayer.play(src);

    audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        playStatus = 0;
        playIcon = Icons.play_arrow;
        audioPlayer.stop();
        dWidth = 0.0;
      });
    });
    if (playStatus == 1) {
      setState(() {
        Timer.periodic(Duration(seconds: 1), (timer) {
          print('width :::::::::::: $dWidth');
          if ((dWidth < 100.0) && (playStatus == 1)) {
            widthGrow(duration);
          } else {
            timer.cancel();
          }
        });
      });
    }
  }

  pauseVoice() async {
    await audioPlayer.pause();
  }

  widthGrow(timerVal) {
    setState(() {
      dWidth = dWidth + (100.0 / (timerVal / 1000));
    });
  }
}

openDocument(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
