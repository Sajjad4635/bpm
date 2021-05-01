import 'dart:convert';

import 'package:bpm/API/api.dart';
import 'package:bpm/global/formFieldsModel.dart';
import 'package:bpm/global/formFieldsVariables.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class get_User_Info {

  static Future<Map> get_user_info() async {
    SharedPreferences token = await SharedPreferences.getInstance();

    final responseUserGet = await http.post(api.siteName + '/panel/userget.json',
        body: {
          "token": '${token.getString('myIP_token')}',
          "pkg": '${token.getString('pkg')}',
          "device": '${token.getString('my_device')}',
        });

    print(responseUserGet.statusCode);
    print(responseUserGet.body);

    if (responseUserGet.statusCode == 200) {
      var responseBody = json.decode(responseUserGet.body);

      getAllData(responseBody);
      return {
        "person_name": responseBody['person']['name'],
        "total_action_cartable": responseBody['total_action_cartable'],
        "total_review_cartable": responseBody['total_review_cartable'],
        "empty": ((responseBody['person']['name'] == null) ||(responseBody['person']['name'] == '')) ? true : false
      };
    }else{
      get_user_info();
    }
  }

  static getAllData(responseBody) async{
    SharedPreferences token = await SharedPreferences.getInstance();

    var response = await http.post(api.siteName + '/panel/formfields.json', body: {
      "token": '${token.getString('myIP_token')}',
      "pkg": '${token.getString('pkg')}',
      "device": '${token.getString('my_device')}',
    });
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var responseBodyFormFields = json.decode(response.body);

      responseBodyFormFields['cartable_delay_time'].forEach((item) {
        allTimes.add(dataModel.fromJson(item));
      });
    }
  }
}
