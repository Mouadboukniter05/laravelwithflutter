import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';
import 'dart:async' ;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qrcodescanner/functions/GlobalState.dart';
import 'package:flutter/rendering.dart';


class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState()=> _LoginState();


}

class _LoginState extends State<Login> {
  GlobalKey qrkey = GlobalKey();
  var id;
  GlobalState _store = GlobalState.instance;
  QRViewController conttroller;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 5,
              child: QRView(key: qrkey,
                  overlay: QrScannerOverlayShape(
                      borderRadius: 10,
                      borderColor: Colors.red,
                      borderLength: 30,
                      borderWidth: 10,
                      cutOutSize: 300
                  ) ,
                  onQRViewCreated: _onQRViewCreate)
          ),
          Expanded(
              flex: 1,
              child: Text('scan result: $id') ),
          new FlatButton(
            onPressed: goahead,
            child: Text('ok',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22.0,
                  color: Colors.red,
                  backgroundColor: Colors.amberAccent)
              )
          )
        ],

      ),
    );
  }
  @override
  void dispose() {
    conttroller?.dispose();
    super.dispose();
  }

  Future<void> Errorss(id){
    return showDialog<void>(
      context:  context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$id'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("vous n'êtes pas dans nos bases de données"),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('ok',),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<List> jiblinaData() async {
    String myurl = "http://192.168.1.106/API/public/api/lako";
    http.Response response = await http.get(myurl,headers: {"Accept" : "application/json"});
    return json.decode(response.body);

   // debugPrint('Response body : ${response.body}');
  //  return 'succes';
  }
  void _onQRViewCreate(QRViewController controller){
    this.conttroller = controller;
    controller.scannedDataStream.listen((scandata){
      setState(() {
        id = scandata;
       // _store.set("id",id);
      });
      //_store.set("id",id);
    });
    //_store.set("id",id);

  }
  void goahead() async
  {
    /*
    if(id == null){
      debugPrint("dekhal if");
      Errorss(null);
    }
*/
    debugPrint("///////////////////////////daz////////////////////////////////////////////////////////////////");
    List data = await(this.jiblinaData());
    debugPrint("///////////////////////////dazget////////////////////////////////////////////////////////////////");
    int kl = int.parse(id);
    debugPrint("///////////////////////////daztrans////////////////////////////////////////////////////////////////");
    int k = data.length;
    debugPrint("///////////////////////////dazkolakola////////////////////////////////////////////////////////////////");
    setState(() {
      for(int i = 0 ; i<k-1 ;i++)
        {
          debugPrint("///////////////////////////dazkjndbqjgdvqjdgh////////////////////////////////////////////////////////////////");
          debugPrint("${data[i]['id']}");
          debugPrint("///////////////////////////haniiiiiiiiiiiiii////////////////////////////////////////////////////////////////");
          if(data[i]['id'] == 9){
            Navigator.of(context).pushNamed('/First');
            _store.set('amount', data[i]['amount']);
            _store.set('callback_url', data[i]['callback_url']);
           break;}
        }
    });
    debugPrint("///////////////////////////daz2////////////////////////////////////////////////////////////////");
    debugPrint("$k");
    debugPrint("///////////////////////////daz23////////////////////////////////////////////////////////////////");

    //debugPrint('${data[0]["cust_f_name"]}');

    setState(() {
      debugPrint("///////////////////////////////////////////////////dkhal///////////////////////////////////////////////////");
    // _store.set("product_url",data[k-1]["product_url"]);
      debugPrint("///////////////////////////////////////////////////dkhal1///////////////////////////////////////////////////");
      //_store.set("product_name",data[0]["product_name"]);
      //Navigator.of(context).pushNamed('/First');
    });
   // Navigator.of(context).pushNamed('/First');

  }
}
