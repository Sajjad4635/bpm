import 'dart:convert';

import 'package:bpm/API/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class send_Text_To_Customer {
  static Future<Map> send_text_to_customer(text, time, customerID, orderId) async {

    SharedPreferences token = await SharedPreferences.getInstance();
    final response = await http.post(api.siteName + '/panel/chatsendmessage.json', body: {
      "token": '${token.getString('myIP_token')}',
      "pkg": '${token.getString('pkg')}',
      "device": '${token.getString('my_device')}',
      "text": '${text.toString()}',
      "order_id": '${orderId.toString()}',
      "user_id": '${customerID.toString()}',
      "type": '1',
    });

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      var sendStatus = responseBody['status'];
      return {
        "sendStatus": sendStatus,
      };
    }
  }
}
