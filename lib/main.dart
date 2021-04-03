import 'package:flutter/material.dart';
import 'dart:async';

// This project
import 'package:worktimer/styles/sizes.dart';

void main() {
  runApp(MyApp());
}

String formatTime(int milliseconds) {
  var secs = milliseconds ~/ 1000;
  var hours = (secs ~/ 3600).toString().padLeft(2, '0');
  var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
  //var seconds = (secs % 60).toString().padLeft(2, '0');

  return "$hours:$minutes";
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  Stopwatch _stopwatch;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _timer = new Timer.periodic(new Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  _startStopwatch() {
    _stopwatch.start();
  }

  _pauseStopwatch() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
    }
  }

  _stopStopwatch() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
    }

    _stopwatch.reset();
  }

  // Play icon
  Widget playButton() => IconButton(
        icon: Icon(Icons.play_arrow_rounded),
        color: Colors.grey.shade600,
        onPressed: _startStopwatch,
      );

  // Pause icon
  Widget pauseButton() => IconButton(
        icon: Icon(Icons.pause_rounded),
        color: Colors.grey.shade600,
        onPressed: _pauseStopwatch,
      );

  // Stop icon
  Widget stopButton() => IconButton(
        icon: Icon(Icons.stop_rounded),
        color: Colors.grey.shade600,
        onPressed: _stopStopwatch,
      );

  // Tabs
  Widget _nav(BuildContext context) => Container(
        height: 0.1 * height(context),
        decoration: new BoxDecoration(
          color: Colors.grey.shade200,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Timer    "),
            Text("Projects    "),
            Text("History")
          ],
        ),
      );

  // Time
  Widget _time(BuildContext context) => Container(
        height: 0.3 * height(context),
        decoration: new BoxDecoration(
          color: Colors.grey.shade100,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              formatTime(_stopwatch.elapsedMilliseconds),
              style: new TextStyle()
                  .merge(Theme.of(context).textTheme.headline1)
                  .merge(TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );

  // Projects
  Widget _projects(BuildContext context) => Container(
      height: 0.45 * height(context),
      decoration: new BoxDecoration(
        color: Colors.grey.shade300,
      ),
      child: Row(
        children: <Widget>[Text("Project A")],
      ));

  // Buttons
  Widget _buttons(BuildContext context) => Container(
        height: 0.15 * height(context),
        decoration: new BoxDecoration(color: Colors.green),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            playButton(),
            pauseButton(),
            stopButton(),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _nav(context),
            _time(context),
            _projects(context),
            _buttons(context),
          ],
        ),
      ),
    );
  }
}
