import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

getApiKey() async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('api_key')) return prefs.getString('api_key');
 
  return null;
}

Future<String> cuttlyShorten(String url,String prefName) async {
  String apiKey = await getApiKey();
  if(apiKey == null || apiKey == ""){
     Fluttertoast.showToast(
        msg: "Api Key not set",);
    return null;
  }
  final response =
      await http.get('https://cutt.ly/api/api.php?key=$apiKey&short=$url&name=$prefName');

  if (response.statusCode == 200) {
    //print(url);
    //print(json.decode(response.body)["url"]["shortLink"]);
    if((json.decode(response.body))["url"]["status"] == 3)
     { Fluttertoast.showToast(
        msg: "Name Already Taken",);
        return null;}
    return (json.decode(response.body))["url"]["shortLink"];
  } 
  else
    return null;
}
