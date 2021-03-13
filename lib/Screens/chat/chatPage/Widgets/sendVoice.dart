import 'dart:convert';

import 'package:bpm/API/api.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class SendVoice{
  static Future<Map> sendVoice(File _voicePath, String duration, String text, String orderId, String userId) async{

    print('dutatiooooooooooooooon ::::::::: $duration');
    print('_voicePatttttttttttttttth ::::::::: $_voicePath');

    if(duration == '0'){
      duration = '1000';
    }

//    File temp;
//
//    temp = _voicePath;

    SharedPreferences token = await SharedPreferences.getInstance();

    var stream = new http.ByteStream(DelegatingStream.typed(_voicePath.openRead()));

    // get file length
    var length = await _voicePath.length();

    // string to uri
    var uri = Uri.parse(api.siteName + '/panel/chatsendmessage.json');

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(_voicePath.path));

    // add file to multipart
    request.files.add(multipartFile);
    request.fields['token'] = '${token.getString('myIP_token')}';
    request.fields['pkg'] = '${token.getString('pkg')}';
    request.fields['device'] = '${token.getString('my_device')}';
//    request.fields['text'] = '${text.toString()}';
    request.fields['order_id'] = '${orderId.toString()}';
    request.fields['user_id'] = '${userId.toString()}';
    request.fields['type'] = '3';
    request.fields['size'] = '2';
    request.fields['duration'] = '${duration.toString()}';

    var response = await request.send();

//    var respStr = await response.stream.bytesToString();

    print(response.statusCode);
    if(response.statusCode == 200){
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
    }
    return {
      "status": response.statusCode
    };
  }
}