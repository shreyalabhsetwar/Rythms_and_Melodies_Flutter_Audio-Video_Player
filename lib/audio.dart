import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

AnimationController _animationIconController1;

AudioCache audioCache;

AudioPlayer audioPlayer;

Duration _duration = new Duration();
Duration _position = new Duration();

bool issongplaying = false;

bool isplaying = false;

void seekToSeconds(int second) {
  Duration newDuration = Duration(seconds: second);
  audioPlayer.seek(newDuration);
}

myt() {
  Fluttertoast.showToast(
    msg: " Song Added to Favourites !!",
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP_RIGHT,
    timeInSecForIosWeb: 3,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 20.0,
  );
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    initPlayer();
  }

  void initPlayer() {
    _animationIconController1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
      reverseDuration: Duration(milliseconds: 750),
    );
    audioPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: audioPlayer);
    audioPlayer.durationHandler = (d) => setState(() {
          _duration = d;
        });
    audioPlayer.positionHandler = (p) => setState(() {
          _position = p;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child: Text("Rythms & Melodies")),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.favorite), onPressed: myt),
          Icon(Icons.pause_circle_filled),
          Icon(Icons.play_circle_filled),
        ],
        leading: Image(image: AssetImage('images/logo.jpg')),
      ),
      body: Container(
        //margin: EdgeInsets.symmetric(vertical: 20.0),
        height: double.infinity,
        width: double.infinity,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    //child: IconButton(
                    //  onPressed: () {},
                    //  icon: Icon(FontAwesomeIcons.chevronDown),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 62, vertical: 50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x46000000),
                          offset: Offset(0, 20),
                          spreadRadius: 0,
                          blurRadius: 30,
                        ),
                        BoxShadow(
                          color: Color(0x11000000),
                          offset: Offset(0, 10),
                          spreadRadius: 0,
                          blurRadius: 30,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        image: NetworkImage(
                            "https://upload.wikimedia.org/wikipedia/en/c/c8/Luis_Fonsi_Feat._Daddy_Yankee_-_Despacito_%28Official_Single_Cover%29.png"),
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.width * 0.7,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    "Despacito",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Luis Fonsi, Daddy Yankee"),
                  SizedBox(
                    height: 10,
                  ),
                  Slider(
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey,
                    value: _position.inSeconds.toDouble(),
                    max: _duration.inSeconds.toDouble(),
                    onChanged: (double value) {
                      setState(() {
                        seekToSeconds(value.toInt());
                        value = value;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //Text("${_position.inSeconds.toDouble()}"),
                        //Text("${_duration.inSeconds.toDouble()}"),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isplaying
                            ? _animationIconController1.reverse()
                            : _animationIconController1.forward();
                        isplaying = !isplaying;
                      });
                      if (issongplaying == false) {
                        audioCache.play("despacito.mp3");
                        setState(() {
                          issongplaying = true;
                        });
                      } else {
                        audioPlayer.pause();
                        setState(() {
                          issongplaying = false;
                        });
                      }
                    },
                    child: ClipOval(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2.5,
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                        ),
                        width: 75,
                        height: 75,
                        child: Center(
                          child: AnimatedIcon(
                            icon: AnimatedIcons.play_pause,
                            progress: _animationIconController1,
                            color: Colors.black,
                            size: 60,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            /*Container(
              width: 1000,
              color: Colors.red,
            ),*/
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    //child: IconButton(
                    //  onPressed: () {},
                    //  icon: Icon(FontAwesomeIcons.chevronDown),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 62, vertical: 50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x46000000),
                          offset: Offset(0, 20),
                          spreadRadius: 0,
                          blurRadius: 30,
                        ),
                        BoxShadow(
                          color: Color(0x11000000),
                          offset: Offset(0, 10),
                          spreadRadius: 0,
                          blurRadius: 30,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        image: NetworkImage(
                            "https://i1.sndcdn.com/artworks-000211076041-iyoj3q-t500x500.jpg"),
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.width * 0.7,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    "Shape of You",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Ed Sheeran"),
                  SizedBox(
                    height: 10,
                  ),
                  Slider(
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey,
                    value: _position.inSeconds.toDouble(),
                    max: _duration.inSeconds.toDouble(),
                    onChanged: (double value) {
                      setState(() {
                        seekToSeconds(value.toInt());
                        value = value;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //Text("${_position.inSeconds.toDouble()}"),
                        //Text("${_duration.inSeconds.toDouble()}"),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isplaying
                            ? _animationIconController1.reverse()
                            : _animationIconController1.forward();
                        isplaying = !isplaying;
                      });
                      if (issongplaying == false) {
                        audioCache.play("shape.mp3");
                        setState(() {
                          issongplaying = true;
                        });
                      } else {
                        audioPlayer.pause();
                        setState(() {
                          issongplaying = false;
                        });
                      }
                    },
                    child: ClipOval(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2.5,
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                        ),
                        width: 75,
                        height: 75,
                        child: Center(
                          child: AnimatedIcon(
                            icon: AnimatedIcons.play_pause,
                            progress: _animationIconController1,
                            color: Colors.black,
                            size: 60,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            /*Container(
              width: 1000,
              color: Colors.blue,
            ),*/
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    //child: IconButton(
                    //  onPressed: () {},
                    //  icon: Icon(FontAwesomeIcons.chevronDown),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 62, vertical: 50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x46000000),
                          offset: Offset(0, 20),
                          spreadRadius: 0,
                          blurRadius: 30,
                        ),
                        BoxShadow(
                          color: Color(0x11000000),
                          offset: Offset(0, 10),
                          spreadRadius: 0,
                          blurRadius: 30,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        image: NetworkImage(
                            "https://upload.wikimedia.org/wikipedia/en/b/b7/Katy_Perry_-_Prism_cover.png"),
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.width * 0.7,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    "Dark Horse",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Katy Perry,Juicy J"),
                  SizedBox(
                    height: 10,
                  ),
                  Slider(
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey,
                    value: _position.inSeconds.toDouble(),
                    max: _duration.inSeconds.toDouble(),
                    onChanged: (double value) {
                      setState(() {
                        seekToSeconds(value.toInt());
                        value = value;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //Text("${_position.inSeconds.toDouble()}"),
                        //Text("${_duration.inSeconds.toDouble()}"),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isplaying
                            ? _animationIconController1.reverse()
                            : _animationIconController1.forward();
                        isplaying = !isplaying;
                      });
                      if (issongplaying == false) {
                        audioCache.play("kp.mp3");
                        setState(() {
                          issongplaying = true;
                        });
                      } else {
                        audioPlayer.pause();
                        setState(() {
                          issongplaying = false;
                        });
                      }
                    },
                    child: ClipOval(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2.5,
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                        ),
                        width: 75,
                        height: 75,
                        child: Center(
                          child: AnimatedIcon(
                            icon: AnimatedIcons.play_pause,
                            progress: _animationIconController1,
                            color: Colors.black,
                            size: 60,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            /*Container(
              width: 1000,
              color: Colors.green,
            ),*/
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    //child: IconButton(
                    //  onPressed: () {},
                    //  icon: Icon(FontAwesomeIcons.chevronDown),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 62, vertical: 50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x46000000),
                          offset: Offset(0, 20),
                          spreadRadius: 0,
                          blurRadius: 30,
                        ),
                        BoxShadow(
                          color: Color(0x11000000),
                          offset: Offset(0, 10),
                          spreadRadius: 0,
                          blurRadius: 30,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        image: NetworkImage(
                            "https://static.stereogum.com/uploads/2020/01/justin-bieber-1578027924-640x636.jpg"),
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.width * 0.7,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    "Yummy",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Justin Bieber"),
                  SizedBox(
                    height: 10,
                  ),
                  Slider(
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey,
                    value: _position.inSeconds.toDouble(),
                    max: _duration.inSeconds.toDouble(),
                    onChanged: (double value) {
                      setState(() {
                        seekToSeconds(value.toInt());
                        value = value;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //Text("${_position.inSeconds.toDouble()}"),
                        //Text("${_duration.inSeconds.toDouble()}"),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isplaying
                            ? _animationIconController1.reverse()
                            : _animationIconController1.forward();
                        isplaying = !isplaying;
                      });
                      if (issongplaying == false) {
                        audioCache.play("yummy.mp3");
                        setState(() {
                          issongplaying = true;
                        });
                      } else {
                        audioPlayer.pause();
                        setState(() {
                          issongplaying = false;
                        });
                      }
                    },
                    child: ClipOval(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2.5,
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                        ),
                        width: 75,
                        height: 75,
                        child: Center(
                          child: AnimatedIcon(
                            icon: AnimatedIcons.play_pause,
                            progress: _animationIconController1,
                            color: Colors.black,
                            size: 60,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            /*Container(
              width: 1000,
              color: Colors.yellow,
            ),*/
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    //child: IconButton(
                    //  onPressed: () {},
                    //  icon: Icon(FontAwesomeIcons.chevronDown),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 62, vertical: 50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x46000000),
                          offset: Offset(0, 20),
                          spreadRadius: 0,
                          blurRadius: 30,
                        ),
                        BoxShadow(
                          color: Color(0x11000000),
                          offset: Offset(0, 10),
                          spreadRadius: 0,
                          blurRadius: 30,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        image: NetworkImage(
                            "https://i.pinimg.com/originals/0e/fd/a4/0efda41d3c7fcd07f323675d9390eb7c.jpg"),
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.width * 0.7,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    "Don't Let Me Down",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("The Chainsmokers,Daya"),
                  SizedBox(
                    height: 10,
                  ),
                  Slider(
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey,
                    value: _position.inSeconds.toDouble(),
                    max: _duration.inSeconds.toDouble(),
                    onChanged: (double value) {
                      setState(() {
                        seekToSeconds(value.toInt());
                        value = value;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //Text("${_position.inSeconds.toDouble()}"),
                        //Text("${_duration.inSeconds.toDouble()}"),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isplaying
                            ? _animationIconController1.reverse()
                            : _animationIconController1.forward();
                        isplaying = !isplaying;
                      });
                      if (issongplaying == false) {
                        audioCache.play("dont.mp3");
                        setState(() {
                          issongplaying = true;
                        });
                      } else {
                        audioPlayer.pause();
                        setState(() {
                          issongplaying = false;
                        });
                      }
                    },
                    child: ClipOval(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2.5,
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                        ),
                        width: 75,
                        height: 75,
                        child: Center(
                          child: AnimatedIcon(
                            icon: AnimatedIcons.play_pause,
                            progress: _animationIconController1,
                            color: Colors.black,
                            size: 60,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            /*Container(
              width: 1000,
              color: Colors.orange,
            ),*/
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    //child: IconButton(
                    //  onPressed: () {},
                    //  icon: Icon(FontAwesomeIcons.chevronDown),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 62, vertical: 50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x46000000),
                          offset: Offset(0, 20),
                          spreadRadius: 0,
                          blurRadius: 30,
                        ),
                        BoxShadow(
                          color: Color(0x11000000),
                          offset: Offset(0, 10),
                          spreadRadius: 0,
                          blurRadius: 30,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        image: NetworkImage(
                            "https://hi-static.z-dn.net/files/d38/c4937ea0a7d04823817a951db9799e99.jpg"),
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.width * 0.7,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    "On My Way",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Alan Walker,Sabrina Carpenter,Farruko"),
                  SizedBox(
                    height: 10,
                  ),
                  Slider(
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey,
                    value: _position.inSeconds.toDouble(),
                    max: _duration.inSeconds.toDouble(),
                    onChanged: (double value) {
                      setState(() {
                        seekToSeconds(value.toInt());
                        value = value;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //Text("${_position.inSeconds.toDouble()}"),
                        //Text("${_duration.inSeconds.toDouble()}"),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isplaying
                            ? _animationIconController1.reverse()
                            : _animationIconController1.forward();
                        isplaying = !isplaying;
                      });
                      if (issongplaying == false) {
                        audioCache.play("on.mp3");
                        setState(() {
                          issongplaying = true;
                        });
                      } else {
                        audioPlayer.pause();
                        setState(() {
                          issongplaying = false;
                        });
                      }
                    },
                    child: ClipOval(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2.5,
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                        ),
                        width: 75,
                        height: 75,
                        child: Center(
                          child: AnimatedIcon(
                            icon: AnimatedIcons.play_pause,
                            progress: _animationIconController1,
                            color: Colors.black,
                            size: 60,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
