import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class MyAppScaffold extends StatefulWidget {
  static const String id = 'video_screen';
  @override
  State<StatefulWidget> createState() => MyAppScaffoldState();
}

class MyAppScaffoldState extends State<MyAppScaffold> {
  String initUrl =
      "http://samples.mplayerhq.hu/MPEG-4/embedded_subs/1Video_2Audio_2SUBs_timed_text_streams_.mp4";

//  String initUrl = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4";
//  String initUrl = "/storage/emulated/0/Download/Test.mp4";
//  String initUrl = "/sdcard/Download/Test.mp4";

  String changeUrl =
      "http://distribution.bbb3d.renderfarming.net/video/mp4/bbb_sunflower_1080p_30fps_normal.mp4";

  Uint8List image;
  VlcPlayerController _videoViewController;
  bool isPlaying = true;
  double sliderValue = 0.0;
  double currentPlayerTime = 0;
  double volumeValue = 100;
  String position = "";
  String duration = "";
  int numberOfCaptions = 0;
  int numberOfAudioTracks = 0;
  bool isBuffering = true;
  bool getCastDeviceBtnEnabled = false;

  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _videoViewController = new VlcPlayerController(onInit: () {
      _videoViewController.play();
    });
    _videoViewController.addListener(() {
      if (!this.mounted) return;
      if (_videoViewController.initialized) {
        var oPosition = _videoViewController.position;
        var oDuration = _videoViewController.duration;
        if (oDuration.inHours == 0) {
          var strPosition = oPosition.toString().split('.')[0];
          var strDuration = oDuration.toString().split('.')[0];
          position =
              "${strPosition.split(':')[1]}:${strPosition.split(':')[2]}";
          duration =
              "${strDuration.split(':')[1]}:${strDuration.split(':')[2]}";
        } else {
          position = oPosition.toString().split('.')[0];
          duration = oDuration.toString().split('.')[0];
        }
        sliderValue = _videoViewController.position.inSeconds.toDouble();
        numberOfCaptions = _videoViewController.spuTracksCount;
        numberOfAudioTracks = _videoViewController.audioTracksCount;

        switch (_videoViewController.playingState) {
          case PlayingState.PAUSED:
            setState(() {
              isBuffering = false;
            });
            break;

          case PlayingState.STOPPED:
            setState(() {
              isPlaying = false;
              isBuffering = false;
            });
            break;
          case PlayingState.BUFFERING:
            setState(() {
              isBuffering = true;
            });
            break;
          case PlayingState.PLAYING:
            setState(() {
              isBuffering = false;
            });
            break;
          case PlayingState.ERROR:
            setState(() {});
            print("VLC encountered error");
            break;
          default:
            setState(() {});
            break;
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Plugin example app'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: _createCameraImage,
      ),
      body: Builder(builder: (context) {
        return Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(
                height: 250,
                child: new VlcPlayer(
                  aspectRatio: 16 / 9,
                  url: initUrl,
                  isLocalMedia: false,
                  controller: _videoViewController,
                  // Play with vlc options
                  options: [
                    '--quiet',
//                '-vvv',
                    '--no-drop-late-frames',
                    '--no-skip-frames',
                    '--rtsp-tcp',
                  ],
                  hwAcc: HwAcc.DISABLED,
                  // or {HwAcc.AUTO, HwAcc.DECODING, HwAcc.FULL}
                  placeholder: Container(
                    height: 250.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[CircularProgressIndicator()],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  FlatButton(
                      child: isPlaying
                          ? Icon(Icons.pause_circle_outline)
                          : Icon(Icons.play_circle_outline),
                      onPressed: () => {playOrPauseVideo()}),
                ],
              ),
              Divider(height: 1),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  children: [
                    FlatButton(
                      child: Text("Change URL"),
                      onPressed: () =>
                          _videoViewController.setStreamUrl(changeUrl),
                    ),
                    FlatButton(
                        child: Text("+speed"),
                        onPressed: () =>
                            _videoViewController.setPlaybackSpeed(2.0)),
                    FlatButton(
                        child: Text("Normal"),
                        onPressed: () =>
                            _videoViewController.setPlaybackSpeed(1)),
                    FlatButton(
                        child: Text("-speed"),
                        onPressed: () =>
                            _videoViewController.setPlaybackSpeed(0.5)),
                  ],
                ),
              ),
              Divider(height: 1),
              Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("position=" +
                        _videoViewController.position.inSeconds.toString() +
                        ", duration=" +
                        _videoViewController.duration.inSeconds.toString() +
                        ", speed=" +
                        _videoViewController.playbackSpeed.toString()),
                    Text(
                        "ratio=" + _videoViewController.aspectRatio.toString()),
                    Text("size=" +
                        _videoViewController.size.width.toString() +
                        "x" +
                        _videoViewController.size.height.toString()),
                    Text("state=" +
                        _videoViewController.playingState.toString()),
                  ],
                ),
              ),
              Divider(height: 1),
              image == null
                  ? Container()
                  : Container(child: Image.memory(image)),
            ],
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _videoViewController.dispose();
    super.dispose();
  }

  void playOrPauseVideo() {
    String state = _videoViewController.playingState.toString();

    if (state == "PlayingState.PLAYING") {
      _videoViewController.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      _videoViewController.play();
      setState(() {
        isPlaying = true;
      });
    }
  }

  void _createCameraImage() async {
    Uint8List file = await _videoViewController.takeSnapshot();
    setState(() {
      image = file;
    });
  }
}
