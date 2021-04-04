import 'dart:convert';

import 'package:bpm/API/api.dart';
import 'package:bpm/Screens/Cardboard/cardBoardPage/cardBoardPageModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class get_AllCardBoards {

  static Future<Map> get_allcardboards(cardBoardType) async {

    print('card board :::::::::::: ${cardBoardType}');

    SharedPreferences token = await SharedPreferences.getInstance();

    final response = await http.post(api.siteName + '/panel/tasklist.json',
        body: {
          "token": '${token.getString('myIP_token')}',
          "pkg": '${token.getString('pkg')}',
          "device": '${token.getString('my_device')}',
          "page": '1',
          "per_page": '10000',
          "type": '${cardBoardType.toString()}',
        });
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);

      print('title:::::::${responseBody['title']}');

      List<cardBoardPageModel> cardBoards = [];
      responseBody['data'].forEach((item) {
        cardBoards.add(cardBoardPageModel.fromJson(item));
      });
      return {
        "allCardBoards": cardBoards,
        "forceWorkNumber": responseBody['total'],
        "empty": cardBoards.isEmpty ? true : false
      };
    }
  }
}
