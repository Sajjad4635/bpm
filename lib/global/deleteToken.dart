import 'package:shared_preferences/shared_preferences.dart';

deleteToken() async{
  SharedPreferences token = await SharedPreferences.getInstance();

  token.remove('myIP_token');
}