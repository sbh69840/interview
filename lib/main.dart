import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'cards_question_drag.dart';
import 'test_drag.dart';
import 'package:url_launcher/url_launcher.dart';

void main(){
  runApp(
    MaterialApp(
      home: ApiData(),
    )
  );
}

class ApiData extends StatefulWidget{

  @override
  ApiState createState() => ApiState();
}

class ApiState extends State<ApiData>{
  bool showTest = false;
  bool bgcolor = false;
  bool _loadingInProgress;
  final String url = "https://learncodeonline.in/api/android/datastructure.json";
  List data;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      // The value passed to Navigator.pop() or null.
      if (value != null) {
        _scaffoldKey.currentState.showSnackBar(
          new SnackBar(
            content: new Text('You selected: $value'),
          ),
        );
      }
    });
  }


  Future<String> getApiData() async{
    var res = await http.get(Uri.encodeFull(url),headers:{"Accept":"application/json"});
    setState((){
      var result = json.decode(res.body);
      data = result["questions"];

    });
    _dataLoaded();
    return "Done";

  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: new Center(
          child:new Text(
            "Train",
            style: TextStyle(color: showTest?Colors.black: Colors.blue,
            fontFamily: 'Caviar'
            ,
            fontWeight: FontWeight.bold,
            fontSize: 20.0),
            
          )
        ),
        title:new Center(
          child:new Switch
        (
          
          onChanged: (bool newValue) => setState(() => showTest = newValue),
          value: showTest,
          activeColor: Colors.red,
        )),
        actions: <Widget>[
          new Center(
          child:new Text(
            "Test",
            style: TextStyle(color:showTest?Colors.blue:Colors.black,
            fontFamily: 'Caviar'
            ,
            fontWeight: FontWeight.bold,
            fontSize: 20.0),
          )
        ),
        ],
        backgroundColor: Colors.white,
      ),
      backgroundColor: bgcolor?Colors.amber[100]:Colors.white,
      body: new Column
      (
        children: <Widget>
        [
          _buildBody(),
          buttonsRow(),
          Card(
            
            elevation: 15.0,
                    child: new FlatButton(

                      
                      onPressed: () =>launch(
                  'https://courses.learncodeonline.in'),
                      padding: new EdgeInsets.only(right: 110.0,left: 110.0),
                      child: 
                        Text("LearnCodeOnline ad",
                        textAlign: TextAlign.center,
                      style: 
                      TextStyle(fontSize: 10.0,
                      fontFamily: 'Caviar',
                      
                      color:Colors.black)),

                        
                      ),
                  ),
        ],
      ),
    );
  }
  Widget buttonsRow()
  {
    return new Container
    (
      margin: new EdgeInsets.symmetric(vertical: 18.0),
      child: new Row
      (
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>
        [
          
          new FloatingActionButton
          (
            onPressed: () {
              showDemoDialog<String>(
                context: context,
                child: new CupertinoAlertDialog(
                  title: Text(showTest?'Swipe right if answer is right or left for wrong.':'Swipe Right or Left to go to next Card on Train Page.',style: TextStyle(
                        fontFamily: 'Caviar',
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),),
                  
                  actions: <Widget>[
                    new CupertinoDialogAction(
                      child: const Text('Discard',style: TextStyle(
                        fontFamily: 'Caviar',
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),),
                      isDestructiveAction: true,
                      onPressed: () {
                        Navigator.pop(context, 'Discard');
                      },
                    ),
                    new CupertinoDialogAction(
                      child: const Text('Cancel',style: TextStyle(
                        fontFamily: 'Caviar',
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),),
                      isDefaultAction: true,
                      onPressed: () {
                        Navigator.pop(context, 'Cancel');
                      },
                    ),
                  ],
                ),
              );
            },
            backgroundColor: Colors.white,
            child: new Icon(Icons.subject, color: Colors.blue),
          ),
          new Padding(padding: new EdgeInsets.only(right: 8.0)),
          
        ],
      ),
    );
  }
  Widget _buildBody() {
    if (_loadingInProgress) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return showTest?new TestQuestionDraggable(data):new CardsQuestionDraggable(data);
    }
  }
  void _dataLoaded() {
    setState(() {
      _loadingInProgress = false;
    });
  }

  @override
  void initState(){
    super.initState();
    _loadingInProgress = true;
    this.getApiData();

  }


}
