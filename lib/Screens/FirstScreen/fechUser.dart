import 'dart:convert';

import 'package:bpm/API/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class get_User_Info {

  static Future<Map> get_user_info() async {
    SharedPreferences token = await SharedPreferences.getInstance();

    final response = await http.post(api.siteName + '/panel/userget.json',
        body: {
          "token": '${token.getString('myIP_token')}',
          "pkg": '${token.getString('pkg')}',
          "device": '${token.getString('my_device')}',
        });

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);

      return {
        "person_name": responseBody['person']['name'],
        "total_action_cartable": responseBody['total_action_cartable'],
        "total_review_cartable": responseBody['total_review_cartable'],
        "empty": ((responseBody['person']['name'] == null) ||(responseBody['person']['name'] == '')) ? true : false
      };
    }
  }
}
