import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VideoPlayerApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Video',
        home: VideoPlayerScreen());
  }
}

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({Key key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    _controller = VideoPlayerController.network(
        'https://vod-progressive.akamaized.net/exp=1596974726~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F380%2F15%2F376904163%2F1573569420.mp4~hmac=3bc1c2e297f523dbbfa002a7938b9de2eb157b3864d1157364c4e65f8ace1718/vimeo-prod-skyfire-std-us/01/380/15/376904163/1573569420.mp4?filename=video.mp4');
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
