import 'dart:convert';

import 'package:bpm/API/api.dart';
import 'package:bpm/global/SearchUserModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetAllUserExpert {

  static Future<Map> getallusersexpert() async {
    SharedPreferences token = await SharedPreferences.getInstance();

    final response = await http.post(api.siteName + '/panel/userexpertsearch.json.json',
        body: {
          "token": '${token.getString('myIP_token')}',
          "pkg": '${token.getString('pkg')}',
          "device": '${token.getString('my_device')}',
        });
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      List<UserSearch> allUserExpert = [];
      responseBody.forEach((item) {
        allUserExpert.add(UserSearch.fromJson(item));
      });
      return {
        "allUserExpert": allUserExpert,
        "empty": allUserExpert.isEmpty ? true : false
      };
    }
  }
}
