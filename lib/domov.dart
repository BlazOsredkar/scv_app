import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'data.dart';

class DomovPage extends StatefulWidget{
  DomovPage({Key key, this.title,this.data}) : super(key: key);

  final String title;

  final Data data;

  _DomovPageState createState() => _DomovPageState();
}

class _DomovPageState extends State<DomovPage>{

  WebViewController _myController;
      final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  String title = "PIN koda za prevzem malice: Loading...";
  String denarTitle = "Stanje na vašem računu: Loading...";

  final List<StatelessWidget> homeWidgets = [];


  @override
  Widget build(BuildContext context){
      return Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              onStart(),
              for(Widget w in homeWidgets) w
            ],
          ),
        ),
      );
  }

  Container onStart(){
    var wv = new WebView(initialUrl: "https://malice.scv.si/",javascriptMode: JavascriptMode.unrestricted,onWebViewCreated:(WebViewController c){
        _myController = c;
      },onPageFinished: (String url){
          readJS(url);
      });
    wv.createState();
    Container(child: wv,height: 0,width: 0,);
    return Container(child: wv,height: 0,width: 0,);
  }

  void readJS(String url) async{
    if(url=="https://malice.scv.si/"){
      await _myController.evaluateJavascript("let arr=[]");
      await _myController.evaluateJavascript("document.querySelectorAll(\"div\").forEach(e=>{\nif(!e.firstElementChild){\n  arr.push(e.innerText);\n}\n})");
      var pin_div = await _myController.evaluateJavascript("arr.find(e=>e.includes(\"PIN koda za prevzem malice:\"))");
      var stanje_div = await _myController.evaluateJavascript("arr.find(e=>e.includes(\"Stanje na vašem računu:\"))");
      var menij_danes = await _myController.evaluateJavascript("document.querySelector(\".md-card-success .md-card-toolbar-heading-text\").innerText");
      setState(() {
        homeWidgets.add(new homeWidget(title: "PIN",content:pin_div,color: widget.data.izbranaSola.color,));
        homeWidgets.add(new homeWidget(title: "Denar",content:stanje_div,color: widget.data.izbranaSola.color,));
        homeWidgets.add(new homeWidget(title: "Naročeni menij",content:"Naročeni menij: "+menij_danes,color: widget.data.izbranaSola.color,));

        this.denarTitle = stanje_div;
        this.title = pin_div;
      });
    }
  }

}

class homeWidget extends StatelessWidget{
  homeWidget({Key key,this.title,this.content,this.color}) : super(key: key);

  final String title;
  final String content;
  final Color color;

  @override
  Widget build(BuildContext context){
    return Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(title),
              Text(this.content)
            ],
          mainAxisAlignment: MainAxisAlignment.center),
        ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: this.color),
          left: BorderSide(color: this.color),
          right: BorderSide(color: this.color),
          top: BorderSide(color: this.color)
        ),
          borderRadius: BorderRadius.circular(12)),height: 60,
        );
  }
}