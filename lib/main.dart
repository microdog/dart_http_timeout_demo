import 'dart:io';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HttpClient client;

  _MyHomePageState() {
    client = new HttpClient();
    client.badCertificateCallback = (cert, host, port) => true;

    // CRITICAL
    // Comment this line and the request will be finished with a
    // [SocketException] caused by system level timeout.
    // If a custom connectionTimeout is set and is shorter than
    // the system timeout, an unexpected [NoSuchMethodError] will
    // be thrown.
    client.connectionTimeout = new Duration(seconds: 1);
  }

  _send() async {
    // expected [SocketException] instead of [NoSuchMethodError]
    await client.getUrl(Uri.parse("http://10.255.255.1"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'click the button and check log',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _send,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
