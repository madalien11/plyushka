import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plyushka/screens/schoolsScreen.dart';
import 'user/login.dart';

class UselessWelcomeScreen extends StatefulWidget {
  static const String id = 'useless_welcome_screen';
  @override
  _UselessWelcomeScreenState createState() => _UselessWelcomeScreenState();
}

class _UselessWelcomeScreenState extends State<UselessWelcomeScreen> {
  final _pageViewController = new PageController();
  bool loggedIn = false;
  Function addToken;
  Function deleteAll;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (loggedIn) {
        Navigator.pushReplacementNamed(context, SchoolsScreen.id);
      } else {
        Navigator.pushReplacementNamed(context, LoginScreen.id,
            arguments: {'addToken': addToken, 'deleteAll': deleteAll});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    Map map = ModalRoute.of(context).settings.arguments;
    print(map['loggedIn']);
    if (map != null) if (map['loggedIn'] != null) loggedIn = map['loggedIn'];
    if (map != null) if (map['deleteAll'] != null) deleteAll = map['deleteAll'];
    if (map != null) if (map['addToken'] != null) addToken = map['addToken'];
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: _pageViewController,
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: Color(0xffffffff),
                  padding: EdgeInsets.symmetric(horizontal: 85.w),
                  child: Image.asset(
                    "images/icon.png",
                    fit: BoxFit.scaleDown,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
