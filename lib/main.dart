import 'package:flutter/material.dart';
import 'package:Melodies/audio.dart';
import 'package:Melodies/video.dart';
import 'package:Melodies/offline_video.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.teal);
    return new MaterialApp(
      home: MyBottomNavigationBar(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    MyHomePage(),
    VideoPlayerApp(),
    VideoPlayerApp1(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.music_note),
            title: new Text("Music"),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.video_library),
            title: new Text("Online Video"),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text("Offline Video"),
          ),
        ],
      ),
    );
  }
}
