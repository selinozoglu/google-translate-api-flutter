import 'package:translate/model/DataModel.dart';

class Ceviri{//ceviriler.json bana dönen response dosya.
  Data ceviriData;

  Ceviri({this.ceviriData});

  factory Ceviri.fromJson(Map<String, dynamic> parsedJson){
    return Ceviri(
        ceviriData: Data.fromJson(parsedJson['data'])
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

