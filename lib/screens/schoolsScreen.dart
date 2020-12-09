import 'package:flutter/material.dart';
import 'package:plyushka/classes/meal.dart';
import 'package:plyushka/components/schoolCard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';
import 'package:plyushka/data/data.dart';
import 'package:plyushka/classes/school.dart';
import 'user/login.dart';

class SchoolsScreen extends StatefulWidget {
  static const String id = 'schools_screen';

  @override
  _SchoolsScreenState createState() => _SchoolsScreenState();
}

class _SchoolsScreenState extends State<SchoolsScreen> {
  Future<List<School>> futureSchoolsList;
  bool pressed = false;

  void loader() {
    if (!mounted) return;
    setState(() {
      pressed = !pressed;
    });
  }

  @override
  void initState() {
    super.initState();
    futureSchoolsList = fetchSchools(context);
    pressed = false;
  }

  @override
  void dispose() {
    super.dispose();
    pressed = false;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    final Map map = ModalRoute.of(context).settings.arguments;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Color(0xffFDFDFD),
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 250.0,
                  floating: false,
                  pinned: true,
                  automaticallyImplyLeading: false,
                  actions: <Widget>[
                    IconButton(
                        icon: Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (map != null &&
                              map['checkedValue'] != null &&
                              map['checkedValue']) {
                            if (logOutInData != null) {
                              logOutInData();
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  LoginScreen.id,
                                  (Route<dynamic> route) => false,
                                  arguments: {'addToken': addTokenInData});
                            } else if (map != null &&
                                map['deleteAll'] != null) {
                              map['deleteAll']();
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  LoginScreen.id,
                                  (Route<dynamic> route) => false,
                                  arguments: {'addToken': map['addToken']});
                            }
                          } else {
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                LoginScreen.id,
                                (Route<dynamic> route) => false);
                          }
                        })
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text("Школы",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.sp,
                          )),
                      background: Image.asset(
                        "images/schools.png",
                        fit: BoxFit.cover,
                      )),
                ),
              ];
            },
            body: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overScroll) {
                overScroll.disallowGlow();
                return true;
              },
              child: FutureBuilder<List<School>>(
                future: futureSchoolsList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return SchoolCard(
                          id: snapshot.data[index].id,
                          title: snapshot.data[index].title,
                          callBack: loader,
                        );
                      },
                      itemCount: snapshot.data.length,
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text(
                      "Список школ пуст".toUpperCase(),
                      style: TextStyle(
                          color: Color(0xff222222),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700),
                    ));
                  }
                  // By default, show a loading spinner.
                  return Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xffEFA921))
//                        backgroundColor: Color(0xff2C2E5E),
                          ));
                },
              ),
            ),
          ),
        ),
        pressed
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
    );
  }
}
