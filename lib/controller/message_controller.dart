import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:translate/model/Ceviri.dart';
import 'package:translate/controller/global_variables.dart';

class Controller{
  String toLanguageCode = 'en';
  String apiKey = 'AIzaSyC8cBHedYNMTlUAB2pSQa-Ommj86Dbfgxo';

  Future<Ceviri> getJsonBody() async{
    final response = await http.get(
      'https://translation.googleapis.com/language/translate/v2?target=$toLanguageCode&key=$apiKey&q=$gonderilecekMesajTurkce',
    );
    if(response.statusCode == 200){
      return Ceviri.fromJson(jsonDecode(response.body));
    }else {
      throw Exception('olmadı');
    }
  }
}
/*
{
    "data": {
        "translations": [
            {
                "translatedText": "good morning"
            }
        ]
    }
}
 */