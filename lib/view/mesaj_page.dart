import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:translate/controller/global_variables.dart';
import 'package:translate/controller/message_controller.dart';
import 'package:translate/model/CeviriModel.dart';


TextEditingController textController = new TextEditingController();

void sendSms(String message, List<String> recipents) async {
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
            child: TextField(//gonderilecek turkçe mesaj inputu
              style: TextStyle(
                  fontSize: 24,
                  height: 1.5,
              ),
              controller: textController,
              decoration: InputDecoration(
                icon: Icon(Icons.sms, color: Colors.deepOrange),
                hintText: "Çevirilecek Turkce mesajı buraya yazın...",
                border: OutlineInputBorder(),
                hintStyle: TextStyle(fontSize: 16),
              ),
              onChanged: (text) {
                gonderilecekMesajTurkce = text;
                print(gonderilecekMesajTurkce);
              },
            ),
          ),
          RaisedButton( //çevir butonu
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.deepPurple)),
            color: Colors.white,
            child: Container(
                width: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Cevir',style: TextStyle(fontSize: 18),),
                    Icon(
                      Icons.refresh,
                      color: Colors.deepPurple,
                    )
                  ],
                )),
            onPressed: () {
              setState(() {//frameworke durumun değiştiğini haber verir
                service().then((value) {
                  gonderilecekMesajIngilizce =
                      value.ceviriData.translations[0].translatedText;
                  print(gonderilecekMesajIngilizce);
                });
              });
            },
          ),
          Container( //gonderilecek ingilizce mesajı gosteren container
            child: FutureBuilder<Ceviri>(
                future: service(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done)
                    return Text(gonderilecekMesajIngilizce != null
                        ? '${gonderilecekMesajIngilizce}'
                        : '',
                    style: TextStyle(fontSize: 22),);
                  else
                    return CircularProgressIndicator();
                }),
          ),
          RaisedButton( ///sms gonder butonu
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
                    Text('Gönder',style: TextStyle(fontSize: 16),),
                    Icon(
                      Icons.send,
                      color: Colors.deepOrange,
                    )
                  ],
                )),
            onPressed: () {
              setState(() {
                sendSms('$gonderilecekMesajIngilizce', ['0123']);
              });
            },
          ),
        ],
      ),
    );
  }
}

