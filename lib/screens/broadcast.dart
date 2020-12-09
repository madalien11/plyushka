import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plyushka/components/myDrawer.dart';
import 'dart:ui';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:plyushka/components/schoolCard.dart';

class BroadcastScreen extends StatefulWidget {
  static const String id = 'broadcast_screen';
  @override
  _BroadcastScreenState createState() => _BroadcastScreenState();
}

class _BroadcastScreenState extends State<BroadcastScreen> {
  bool loading = false;
  bool _hasData = true;

  final String urlToStreamVideo =
      'http://distribution.bbb3d.renderfarming.net/video/mp4/bbb_sunflower_1080p_60fps_normal.mp4';
  final double playerWidth = 640;
  final double playerHeight = 360;
  VlcPlayerController _videoViewController;
  VlcPlayerController _videoViewController2;

  void loader() {
    if (!mounted) return;
    setState(() {
      loading = !loading;
    });
  }

  @override
  void dispose() {
    super.dispose();
    loading = false;
    _hasData = true;
  }

  @override
  void initState() {
    super.initState();
    _videoViewController = new VlcPlayerController(onInit: () {
      _videoViewController.play();
    });
    _videoViewController2 = new VlcPlayerController(onInit: () {
      _videoViewController2.play();
    });
    _videoViewController2.setStreamUrl(
        "http://distribution.bbb3d.renderfarming.net/video/mp4/bbb_sunflower_1080p_30fps_normal.mp4");
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    _videoViewController.play();
    _videoViewController2.setStreamUrl(
        "http://distribution.bbb3d.renderfarming.net/video/mp4/bbb_sunflower_1080p_30fps_normal.mp4");
    _videoViewController2.play();
    return Scaffold(
      drawer: MyDrawer(inBroadcasts: true),
      backgroundColor: Color(0xffFDFDFD),
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            'Трансляции',
            style: TextStyle(
                color: Color(0xff222222),
                fontSize: 18.sp,
                fontWeight: FontWeight.w400),
          ),
        ),
        elevation: 0,
        backgroundColor: Color(0xffFDFDFD),
      ),
      body: _hasData
          ? GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Stack(
                children: [
                  ListView(children: [
                    Row(
                      children: [
                        Expanded(child: Container()),
                        Expanded(
                          flex: 9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Text(
                                  'Зал',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff000000),
                                      fontSize: 18.sp),
                                ),
                              ),
                              SizedBox(
                                height: playerHeight,
                                width: playerWidth,
                                child: new VlcPlayer(
                                  aspectRatio: 16 / 9,
                                  url: theVideoUrl != null
                                      ? theVideoUrl
                                      : urlToStreamVideo,
                                  isLocalMedia: false,
                                  controller: _videoViewController,
                                  placeholder: Container(
                                    height: 250.0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        CircularProgressIndicator()
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Text(
                                  'Раздача',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff000000),
                                      fontSize: 18.sp),
                                ),
                              ),
                              SizedBox(
                                height: playerHeight,
                                width: playerWidth,
                                child: new VlcPlayer(
                                  aspectRatio: 16 / 9,
                                  url: theVideoUrl != null
                                      ? theVideoUrl
                                      : urlToStreamVideo,
                                  isLocalMedia: false,
                                  controller: _videoViewController2,
                                  placeholder: Container(
                                    height: 250.0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        CircularProgressIndicator()
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(child: Container()),
                      ],
                    )
                  ]),
                  loading
                      ? Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: GestureDetector(
                              onTap: () => print('smth'),
                              child: Center(
                                  child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Color(0xffEFA921))))))
                      : Container()
                ],
              ),
            )
          : Center(
              child: Text(
              "Список пуст".toUpperCase(),
              style: TextStyle(
                  color: Color(0xff2C2E5E),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700),
            )),
    );
  }
}
