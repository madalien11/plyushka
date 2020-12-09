import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plyushka/classes/date.dart';
import 'package:plyushka/classes/meal.dart';
import 'package:plyushka/data/data.dart';
import 'dart:ui';
import 'package:plyushka/screens/menuPage.dart';

int schoolId;
List<Date> dates = [];
int todayDateId;
bool firstWeek = true;
bool hasMeals = true;
String theVideoUrl;

class SchoolCard extends StatefulWidget {
  final String title;
  final int id;
  final Function callBack;
  SchoolCard(
      {@required this.title, @required this.id, @required this.callBack});

  @override
  _SchoolCardState createState() => _SchoolCardState();
}

class _SchoolCardState extends State<SchoolCard> {
  bool _isDisabled;
  bool assigned = false;
  List<Meal> menuTypesList;

  Future getSchoolDates(schoolId) async {
    var response = await Dates(id: schoolId).getData();
    if (response != null) {
      List datesList = response['data'];
      if (!mounted) return;
      setState(() {
        for (var date in datesList) {
          if (date['today']) {
            todayDateId = date['id'];
            firstWeek = date['week'].toInt() == 1;
          }
          Date s = Date(
            id: date['id'],
            name: date['name'],
            week: date['week'],
            date: date['date'],
            today: date['today'],
          );
          dates.add(s);
        }
      });
    }
    // TODO: hardcode
    // menuTypesList = await fetchTables(context, schoolId, todayDateId);
    menuTypesList = await fetchTables(context, schoolId, 15);
    if (menuTypesList.length < 1) {
      hasMeals = false;
    } else {
      hasMeals = true;
    }
  }

  Future getVideoLink(schoolId) async {
    var response = await VideoLinkGetter(id: schoolId).getData();
    if (response != null) {
      theVideoUrl = response['data'][0]['url'];
    }
  }

  @override
  void initState() {
    super.initState();
    _isDisabled = false;
  }

  @override
  void dispose() {
    super.dispose();
    _isDisabled = false;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    return Container(
      margin: EdgeInsets.all(8.w),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: ListTile(
            onTap: _isDisabled
                ? () => print('')
                : () async {
                    if (!mounted) return;
                    setState(() {
                      _isDisabled = true;
                    });
                    widget.callBack();
                    schoolId = widget.id;
                    await getSchoolDates(schoolId);
                    await getVideoLink(schoolId);
                    Navigator.pushNamed(context, MenuPage.id, arguments: {
                      'dates': dates,
                    });
                    widget.callBack();
                    if (!mounted) return;
                    setState(() {
                      _isDisabled = false;
                    });
                  },
            leading: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 65.w,
                minHeight: 55.h,
                maxWidth: 75.w,
                maxHeight: 75.h,
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xffEFA921),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                width: 65.w,
                height: 65.h,
                child: Image.asset(
                  "images/schoolIcon.png",
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            title: Text(
              widget.title,
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff242424)),
            ),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 6.h, bottom: 0.h),
              child: Text(
                widget.title,
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff242424).withOpacity(0.7)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
