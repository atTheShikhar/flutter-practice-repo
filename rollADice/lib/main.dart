import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Roll A Dice",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo
      ),
      home: DiceHomePage()
    );
  }
}

class DiceHomePage extends StatefulWidget {
  @override
  _DiceHomePageState createState() {
    return _DiceHomePageState();
  }
}

class _DiceHomePageState extends State<DiceHomePage> {
  int diceValueInt = 1;
  void roll() {
    setState(() {
      Random rand = new Random();
      diceValueInt = rand.nextInt(6) + 1;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Roll a Dice'),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Developer info',style: TextStyle(fontWeight: FontWeight.bold)),
                    content: Text('Source at: \ngithub.com/Shikhar2811'),
                    actions: [
                      FlatButton(
                        child: Text('CLOSE'),
                        onPressed: () {Navigator.of(context).pop();}
                      )
                    ]
                  );
                }
              );
            }
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height * 0.2),
              width: (MediaQuery.of(context).size.height * 0.2),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                  style: BorderStyle.solid
                ),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),                  
                boxShadow: [BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0,7.0),
                  blurRadius: 7.0,
                )]
              ),
              child: Center(
                child: Text(diceValueInt.toString(),
                            style: TextStyle(
                              fontSize: 50.0,
                              fontWeight: FontWeight.bold
                            )
                           )
              )
            ),
            SizedBox( height: (MediaQuery.of(context).size.height * 0.1)),
            RaisedButton(
              padding: EdgeInsets.fromLTRB(40.0,13.0,40.0,13.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
              elevation: 4.0,
              onPressed: roll,
              color: Colors.red,
              child: Text('ROLL',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 15.0)
                         )
            )
          ]
        )        
      )
    );
  }
}

















