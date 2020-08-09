import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VideoPlayerApp1 extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Video',
        home: VideoPlayerScreen1());
  }
}

class VideoPlayerScreen1 extends StatefulWidget {
  VideoPlayerScreen1({Key key}) : super(key: key);

  @override
  _VideoPlayerScreenState1 createState() => _VideoPlayerScreenState1();
}

class _VideoPlayerScreenState1 extends State<VideoPlayerScreen1> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    _controller = VideoPlayerController.asset('assets/video.mp4');
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  myt() {
    Fluttertoast.showToast(
      msg: " Video Added to Favourites !!",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP_RIGHT,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 20.0,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child: Text("Rythms & Melodies")),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.favorite), onPressed: myt),
          //Icon(Icons.favorite),
          Icon(Icons.pause_circle_filled),
          Icon(Icons.play_circle_filled),
        ],
        leading: Image(image: AssetImage('images/images.jpg')),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
