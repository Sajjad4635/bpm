import 'dart:convert';

import 'package:bpm/API/api.dart';
import 'package:bpm/Screens/chat/allCustomers/allChatsModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class get_AllCustomers_Info {

  static Future<Map> get_allCustomers_info() async {
    SharedPreferences token = await SharedPreferences.getInstance();

    print('${token.getString('myIP_token')}');
    print('${token.getString('pkg')}');
    print('${token.getString('my_device')}');

    final response = await http.post(api.siteName + '/panel/chatorderrooms.json',
    body: {
      "token": '${token.getString('myIP_token')}',
      "pkg": '${token.getString('pkg')}',
      "device": '${token.getString('my_device')}',
    });
    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 401){
      print('sssssssssssssssssssssssssssssssssss');
    }
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      List<getAllCustomers> getchatsfs = [];
      responseBody['data'].forEach((item) {
        getchatsfs.add(getAllCustomers.fromJson(item));
      });
      return {
        "allChats": getchatsfs,
        "empty": getchatsfs.isEmpty ? true : false
      };
    }
//    else if(response.statusCode == 401){
//      await get_allCustomers_info();
//    } else if(response.statusCode == 500){
//      await get_allCustomers_info();
//    }
  }
}
