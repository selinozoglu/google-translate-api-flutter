
class Translations{
  final String translatedText;//translations listesinde bulunan text parametreleri
  final String detectedSourceLanguage;

  Translations({this.detectedSourceLanguage,this.translatedText});

  factory Translations.fromJson(Map<String, dynamic> parsedJson){
    return Translations(
        translatedText: parsedJson['translatedText'],
        detectedSourceLanguage: parsedJson['detectedSourceLanguage']
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

