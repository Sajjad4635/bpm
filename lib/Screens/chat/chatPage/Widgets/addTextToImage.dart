import 'dart:io';

import 'package:bpm/Screens/chat/chatPage/Widgets/SendImageToServer.dart';
import 'package:bpm/Screens/chat/chatPage/chatPage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

var sendContainer = Container(
  width: 45.0,
  height: 45.0,
  decoration: BoxDecoration(
      color: Colors.blueAccent,
      borderRadius: BorderRadius.all(
          Radius.circular(100.0))),
  child: Center(
    child:
    Icon(Icons.send, textDirection: TextDirection.rtl, color: Colors.white),
  ),
);

class AddTextToImage extends StatefulWidget {

  var type, orderId, userId;


  AddTextToImage(this.type, this.orderId, this.userId);

  @override
  _AddTextToImageState createState() => _AddTextToImageState();
}

class _AddTextToImageState extends State<AddTextToImage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImageFromGallery();
  }

  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 10.0,
                      right: 10.0
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.clear,
                              color: Colors.white,
                              size: 17.0,
                            ),
                            onPressed: (){
                              Navigator.pop(context);
                            }),
                        Text(
                          '',
                          style: TextStyle(
                            fontFamily: 'iran_yekan',
                            color: Colors.white,
                            fontSize: 15.0
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                        child: _image == null
                            ? Text('No image selected.')
                            : Container(
                          child: Center(
                            child: Image.file(_image, fit: BoxFit.cover,),
                          ),
                        )
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(
                        left: 10.0,
                        right: 10.0
                    ),
                    height: 60.0,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: (){
                            conForward();
                            addImage(_image);
                          },
                          child: sendContainer,
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 10.0,
                                right: 10.0
                            ),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child:  TextFormField(
                                controller: _controller,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'iran_yekan',
                                    color: Colors.white
                                ),
                                decoration: InputDecoration(
                                    hintText: 'یک عنوان برای عکس بنویسید...',
                                    hintStyle: TextStyle(
                                        fontSize: 14.0,
                                        fontFamily: 'iran_yekan',
                                        color: Color(0xff8F8E8E),
                                    ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.image,
                          color: Colors.white,
                          size: 20.0,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ImagePicker picker = new ImagePicker();
  File _image;

  Future getImageFromGallery() async {
    var pickedFile;

    if(widget.type == 'gallery'){
      pickedFile = await picker.getImage(source: ImageSource.gallery);
    }else if(widget.type == 'camera'){
      pickedFile = await picker.getImage(source: ImageSource.camera);
    }

    setState(() {
      _image = File(pickedFile.path);
    });
  }
  addImage(File _image) async {
    var response = await SendImageToServer.sendImageToServer(
        _image,
        _controller.text,
        widget.orderId,
        widget.userId);
    if(response['status'] == 200){
      setState(() {
        flagChatPage = 0;
      });
      conBack();
      print('aaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbb');
      Navigator.pop(context);
    }
  }

  conForward() {
    setState(() {
      sendContainer = Container(
        width: 45.0,
        height: 45.0,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }

  conBack(){
    setState(() {
      sendContainer = Container(
        width: 45.0,
        height: 45.0,
        decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.all(
                Radius.circular(100.0))),
        child: Center(
          child:
          Icon(Icons.send, textDirection: TextDirection.rtl, color: Colors.white),
        ),
      );
    });
  }
}
