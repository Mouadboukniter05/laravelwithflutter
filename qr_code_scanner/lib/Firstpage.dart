import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qrcodescanner/functions/GlobalState.dart';

class First extends StatefulWidget  {
  @override
  State<StatefulWidget> createState() {
    return FirstState();
  }
}



class FirstState extends State<First>{
  var name;
  var pr;

  GlobalState _store = GlobalState.instance;
  Future<List> getData() async {
    var id = _store.get("id");
    String myurl = "http://192.168.1.106/API/public/api/lako/$id";
    http.Response response = await http.get(myurl,headers: {"Accept" : "application/json"});
    return json.decode(response.body);
  }
  Widget widgetMine() {
    return FutureBuilder(
        future: getData(),
        // ignore: missing_return
        builder:(BuildContext context  ,AsyncSnapshot<List> snapshot)  {
          debugPrint('${snapshot.data}');
          if(snapshot.hasData){
            List content = snapshot.data;
            return new ListView.builder(
              itemCount: content.length,
              itemBuilder: (BuildContext context, int index) {
                return new ListTile(
                  contentPadding: EdgeInsets.only(top: 5.0),
                  title: new Text('${content[index]['projet_title']}',
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: 25.0,
                    ),
                  ),
                  subtitle: new Text('${content[index]['projet']}',
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: 16.0,
                    ),
                  ),
                  leading: new CircleAvatar(
                    child: new Text('P ${content[index]['id']}'),
                    foregroundColor: Colors.cyan,
                    backgroundColor: Colors.pink,

                  ),
                  onTap: ()=>{ showMoreInfo(context ,' ${content[index]['projet_title']} ',' ${content[index]['projet']}'), },
                );

              },
            );
          }



          new Container(
              child:
              new Text('attendez, nous avons un problème')
          );

        }


    );
  }
  Future<void> showMoreInfo(context , String title ,String body ) async{
    return showDialog<void>(
      context:  context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text( '$body'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  //static List data;
  /*void _onClear(){
    setState(() {
      __userController.clear();
      __passwordController.clear();
    });
  }*/
  /*  void mess(){
    if(data.length==null) {
      _neverSatisfied('plese wait, be patiant', 'getting data');
    }
      }*/

  Future<void> _neverSatisfied(String test,String TIT  ) async {
    return showDialog<void>(
      context:  context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(TIT),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text( '$test'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //getData();
    //mess();
    //getDatas();
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.indigo,
      ),
      body:  new Center(

            child: new ListView(

              children: <Widget>[
                new Padding(padding: EdgeInsets.only(top:150.0)),
                new Text("Bonjour",style: TextStyle(fontSize: 50.0,color: Colors.cyan),textAlign: TextAlign.center,),
                new Text("${_store.get("amount")} ",style: TextStyle(fontSize: 20.0,color: Colors.cyan),textAlign: TextAlign.center,),
                new Text(" ${_store.get("callback_url")} ",style: TextStyle(fontSize: 20.0,color: Colors.cyan),textAlign: TextAlign.center,),
              ],
            ),

          ),





    );
  }


}
