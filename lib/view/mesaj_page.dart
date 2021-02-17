import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:translate/controller/global_variables.dart';
import 'package:translate/controller/message_controller.dart';
import 'package:translate/model/Ceviri.dart';


TextEditingController textController = new TextEditingController();

void mesajGonder(String message, List<String> recipents) async {
  String _result = await sendSMS(message: message, recipients: recipents)
      .catchError((onError) {
    print(onError);
  });
  print(_result);
}

class MessagePageScreen extends StatefulWidget {
  @override
  _MessagePageScreenState createState() => _MessagePageScreenState();
}

@override
class _MessagePageScreenState extends State<MessagePageScreen> {
  Future<Ceviri> futureCeviri;

  void initState() {
    // TODO: implement initState
    super.initState();
    futureCeviri = Controller().getJsonBody();
  }

  Future<Ceviri> service() async {//controller sınıfının getjsonbody metodunu çağırıyor
    var sonuc = await Controller().getJsonBody();
    return sonuc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Translate My SMS'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                icon: Icon(Icons.sms, color: Colors.deepOrange),
                hintText: "Gonderilecek Turkce Mesaj.",
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                gonderilecekMesajTurkce = text;
                print(gonderilecekMesajTurkce);
              },
            ),
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.white)),
            color: Colors.white,
            child: Container(
                width: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Cevir'),
                    Icon(
                      Icons.refresh,
                      color: Colors.deepPurple,
                    )
                  ],
                )),
            onPressed: () {
              setState(() {//sayfayı yenileyen fonk
                service().then((value) {//sonucu parçalayıp
                  gonderilecekMesajIngilizce =
                      value.ceviriData.translations[0].translatedText;//bunu aldı
                  print(gonderilecekMesajIngilizce);
                });
              });
            },
          ),
          Container(
            child: FutureBuilder<Ceviri>(
                future: service(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done)
                    return Text(gonderilecekMesajIngilizce != null
                        ? 'Title from Post JSON : ${gonderilecekMesajIngilizce}'
                        : '');
                  else
                    return CircularProgressIndicator();
                }),
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.red)),
            color: Colors.white,
            child: Container(
                width: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Gönder'),
                    Icon(
                      Icons.send,
                      color: Colors.deepOrange,
                    )
                  ],
                )),
            onPressed: () {
              setState(() {
                mesajGonder('$gonderilecekMesajIngilizce', ['0123']);
              });
            },
          ),
        ],
      ),
    );
  }
}

