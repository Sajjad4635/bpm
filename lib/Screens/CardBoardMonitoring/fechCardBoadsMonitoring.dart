import 'dart:convert';

import 'package:bpm/API/api.dart';
import 'package:bpm/Screens/CardBoardMonitoring/cardBoardModelMonitoring.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class get_AllCardBoardsMonitoring {

  static Future<Map> get_allcardboardsmonitoring() async {
    SharedPreferences token = await SharedPreferences.getInstance();

    final response = await http.post(api.siteName + '/panel/tasklisttitlelist.json',
        body: {
          "token": '${token.getString('myIP_token')}',
          "pkg": '${token.getString('pkg')}',
          "device": '${token.getString('my_device')}',
          "isreview": '1'
        });
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      List<AllCardBoardsMonitoring> cardBoards = [];
      responseBody['data'].forEach((item) {
        cardBoards.add(AllCardBoardsMonitoring.fromJson(item));
      });
      return {
        "allCardBoardsMonitoring": cardBoards,
        "empty": cardBoards.isEmpty ? true : false
      };
    }
  }
}
