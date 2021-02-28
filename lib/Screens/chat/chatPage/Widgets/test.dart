import 'dart:io';

import 'package:bpm/Screens/chat/chatPage/Widgets/SendImageToServer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bpm/Screens/chat/chatPage/ChatPage.dart';

class test extends StatefulWidget {

  var orderId, userId;

  @override
  _testState createState() => _testState();
}

class _testState extends State<test> {

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
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Container(
                  child: _image == null
                      ? Text('No image selected.')
                      : Image.file(_image)
              ),
              TextFormField(
                controller: _controller,
              )
            ],
          ),
        ),
      ),
    );
  }

  ImagePicker picker = new ImagePicker();
  var _image;

  Future getImageFromGallery() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
      addImage(File(pickedFile.path));
    });
  }
  addImage(File _image) async {
    var response = await SendImageToServer.sendImageToServer(
        _image,
        _controller.text,
        widget.orderId,
        widget.userId);

    setState(() {
      if(response['status'] == 200){
        flagChatPage = 0;
        Navigator.pop(context);
//        getAllLastChats();
      }
    });
  }
}
