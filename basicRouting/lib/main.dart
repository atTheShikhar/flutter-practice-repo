import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

final RouteObserver<Route> routeObserver = new RouteObserver<Route>(); 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Basic Routing',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => new HomePage(),
          '/second': (context) => new SecondPage(),
          '/third': (context) => new ThirdPage(),
          '/fourth': (context) => new FourthPage()
        },
      navigatorObservers: [routeObserver]
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.075),
            child: AppBar(title: Text('HomePage'))),
        drawer: AppMenu(),
        body: Center(
                child: RaisedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/second');
                    },
                    color: Colors.green,
                    child: Text('Second Page',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white)))));
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.075),
            child: AppBar(title: Text('Second Page'))),
        drawer: AppMenu(),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
		  color: Colors.red,
                  child: Text('Home Page', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)) //here
		),
              SizedBox(height: (MediaQuery.of(context).size.height * 0.05)),
              RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/third');
                  },
		  color: Colors.green,
                  child: Text('Third Page', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))
            ])));
  }
}

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.075),
            child: AppBar(title: Text('Third Page'))),
        drawer: AppMenu(),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Previous or SecondPage')),
              SizedBox(height: (MediaQuery.of(context).size.height * 0.05)),
              RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/fourth');
                  },
                  child: Text('Last Page'))
            ])),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
            tooltip: 'Back to Home',
            child: Icon(Icons.home)));
  }
}

class FourthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.075),
            child: AppBar(title: Text('Fourth and Last Page'))),
        drawer: AppMenu(),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Previous or ThirdPage')),
              SizedBox(height: (MediaQuery.of(context).size.height * 0.05)),
              RaisedButton(
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  },
                  child: Text('Home Page'))
            ])));
  }
}

class AppMenu extends StatefulWidget {
  @override
  AppMenuState createState() {
    return AppMenuState();
  }
}

class AppMenuState extends State<AppMenu> with RouteAware {
  String _activeRoute;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this,ModalRoute.of(context));
  }
  @override
  void didPush() {
    _activeRoute = ModalRoute.of(context).settings.name;
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.apps),
            title: Text('Home Page'),
            selected: _activeRoute == '/',
            onTap: () => Navigator.popAndPushNamed(context,'/')
          ),
          ListTile(
            leading: Icon(Icons.android),
            title: Text('Second Page'),
            selected: _activeRoute == '/second',
            onTap: () => Navigator.popAndPushNamed(context,'/second')
          ),
          ListTile(
            leading: Icon(Icons.alarm),
            title: Text('Third Page'),
            selected: _activeRoute == '/third',
            onTap: () => Navigator.popAndPushNamed(context,'/third')
          ),
          ListTile(
            leading: Icon(Icons.bookmark),
            title: Text('Fourth Page'),
            selected: _activeRoute == '/fourth',
            onTap: () => Navigator.popAndPushNamed(context,'/fourth')
          ),
          AboutListTile(
            icon: Icon(Icons.info),
            aboutBoxChildren: <Widget>[
              Text('This is a basic routing app!')
            ]
          )
        ]
      )
    );
  }
}