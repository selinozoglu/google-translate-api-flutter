import 'package:translate/model/TranslationsModel.dart';

class Data{
  final List<Translations> translations;//data sınıfında translations listesi var

  Data({this.translations});
  factory Data.fromJson(Map<String, dynamic> parsedJson){
    var list = parsedJson['translations'] as List;

    List<Translations> translationsList = list.map((i) => Translations.fromJson(i)).toList();

    return Data(
        translations: translationsList
    );
  }
}
/*
{
    "data": {
        "translations": [
            {
                "translatedText": "Hello how are you? There is a presentation today",
                "detectedSourceLanguage": "tr"
            }
        ]
    }
}
 */

