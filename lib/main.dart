import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'malice.dart';
import 'nastavitve.dart';
import 'domov.dart';
import 'urnik.dart';
import 'data.dart';
import 'isci.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return DarkLightTheme();
  }
}

class DarkLightTheme extends StatefulWidget {
  const DarkLightTheme({
    Key key,
  }) : super(key: key);

  @override
  State<DarkLightTheme> createState() => _DarkLightThemeState();
}

class _DarkLightThemeState extends State<DarkLightTheme> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'ŠCV app'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  Data data = new Data();

  final List<Widget> _childrenWidgets =[];

  _MyHomePageState(){
    _childrenWidgets.add(new DomovPage(data:data));
    _childrenWidgets.add(new MalicePage());
    _childrenWidgets.add(new IsciPage());
    _childrenWidgets.add(new UrnikPage(data: data));
    _childrenWidgets.add(new NastavitvePage(data: data));
  }

  void changeView(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        backgroundColor: data.izbranaSola.color,
      ),
      body: _childrenWidgets[selectedIndex],
       // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black.withOpacity(0.1), //here set your transparent level
        elevation: 0,
        selectedItemColor:  data.izbranaSola.color,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        
        items: [BottomNavigationBarItem(icon: Icon(Icons.home_rounded),label: "Domov"),BottomNavigationBarItem(icon: Icon(Icons.fastfood),label: "Malice"),BottomNavigationBarItem(icon: Icon(Icons.person_search),label: "Poišči osebe"),BottomNavigationBarItem(icon: Icon(Icons.calendar_today_rounded),label: "Urnik"),BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Nastavitve")]
        ,//selectedItemColor: Colors.black,
        //unselectedItemColor: Colors.black,
        currentIndex: selectedIndex,
        onTap: changeView,),
    );
  }
}
