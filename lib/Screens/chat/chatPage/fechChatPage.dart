import 'dart:convert';

import 'package:bpm/API/api.dart';
import 'package:bpm/Screens/chat/chatPage/chatPageModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class gettest {
  static Future<Map> getchatstest(page, perPage, orderId, userId) async {
    print('22222222222222222222222222222');
    SharedPreferences token = await SharedPreferences.getInstance();

    print('${token.getString('myIP_token')}');
    print('${token.getString('pkg')}');
    print('${token.getString('my_device')}');
    print('${page.toString()}');
    print('${perPage.toString()}');
    print('${orderId.toString()}');
    print('${userId.toString()}');

    final response = await http.post(api.siteName + '/panel/chatmessageslist.json', body: {
      "token": '${token.getString('myIP_token')}',
      "pkg": '${token.getString('pkg')}',
      "device": '${token.getString('my_device')}',
      "page": '${page.toString()}',
      "per_page": '${perPage.toString()}',
      "order_id": orderId == '0' ? '' : '${orderId.toString()}',
      "user_id": '${userId.toString()}',
    });

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      List<allChats> getAllMessages = [];
      responseBody['data'].forEach((item) {
        getAllMessages.add(allChats.fromJson(item));
      });
      return {
        "chats": getAllMessages,
        "empty": getAllMessages.isEmpty ? true : false
      };
    }
  }
}
