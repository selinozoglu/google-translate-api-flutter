import 'package:translate/model/Data.dart';

class Ceviri{//ceviriler.json bana dönen response dosya.
  Data ceviriData;

  Ceviri({this.ceviriData});

  factory Ceviri.fromJson(Map<String, dynamic> parsedJson){
    return Ceviri(
        ceviriData: Data.fromJson(parsedJson['data'])
    );
  }
}

