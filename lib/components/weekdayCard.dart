import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plyushka/components/schoolCard.dart';
import 'package:plyushka/data/data.dart';
import 'dart:ui';
import 'package:plyushka/screens/menuPage.dart';

String imageUrl = 'mon';
int containerColor = 0xffFFF0BC;
int textColor = 0xffF2BD00;

class WeekdayCard extends StatefulWidget {
  final String name;
  final int id;
  final int week;
  final String date;
  final bool today;
  final bool pressed;
  final Function callBack;
  final Function falseSetter;
  WeekdayCard({
    this.name,
    this.id,
    this.today,
    this.date,
    this.week,
    this.callBack,
    this.falseSetter,
    this.pressed,
  });

  @override
  _WeekdayCardState createState() => _WeekdayCardState();
}

class _WeekdayCardState extends State<WeekdayCard> {
  bool _isDisabled;

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
    var theDate = DateTime.parse(widget.date.substring(0, 19));
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    if (widget.name == 'Вторник') {
      imageUrl = 'вто';
      containerColor = 0xffDCF7FE;
      textColor = 0xff44A5B8;
    } else if (widget.name == 'Среда') {
      imageUrl = 'сре';
      containerColor = 0xffFBE5CF;
      textColor = 0xffF2943A;
    } else if (widget.name == 'Четверг') {
      imageUrl = 'чет';
      containerColor = 0xffF2D1FE;
      textColor = 0xffC061E1;
    } else if (widget.name == 'Пятница') {
      imageUrl = 'пят';
      containerColor = 0xffD0F9BE;
      textColor = 0xff45CD08;
    } else if (widget.name == 'Суббота') {
      imageUrl = 'суб';
      containerColor = 0xffFFB1DB;
      textColor = 0xffDD4296;
    } else if (widget.name == 'Воскресенье') {
      imageUrl = 'вос';
      containerColor = 0xffC5D1FF;
      textColor = 0xff5E7ADF;
    } else {
      imageUrl = 'пон';
      containerColor = 0xffFFF0BC;
      textColor = 0xffF2BD00;
    }

    return InkWell(
      onTap: _isDisabled
          ? () => print('')
          : () async {
              if (!mounted) return;
              setState(() {
                _isDisabled = true;
              });
              futureMenuTypesList = fetchTables(context, schoolId, widget.id);
              futureMenuTypesList.then((value) {
                widget.callBack(value);
              });
              // await Future.delayed(const Duration(milliseconds: 500), () {
              //   if (!mounted) return;
              //   setState(() {
              //     widget.falseSetter(widget.id);
              //   });
              // });

              widget.falseSetter(
                  widget.id,
                  theDate.day.toString() +
                      "-" +
                      theDate.month.toString() +
                      "-" +
                      theDate.year.toString());

              // if (_tables != null) _tables.clear();
              if (!mounted) return;
              setState(() {
                _isDisabled = false;
              });
            },
      child: Container(
        width: 40.w,
        margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 7.5.w),
        child: Stack(
          children: [
            Container(
                decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Color(0xffEFA921),
            )
                // decoration: pressedWeekDayIds[widget.id]
                //     ? BoxDecoration(
                //         borderRadius: BorderRadius.circular(30),
                //         color: Color(0xffEFA921),
                //       )
                //     : BoxDecoration(
                //         color: Colors.transparent,
                //       ),
                ),
            Center(
              child: Column(
                children: [
                  Spacer(),
                  Text(imageUrl,
                      style: TextStyle(
                          color: Color(0xffffffff),
                          // color: pressedWeekDayIds[widget.id]
                          //     ? Color(0xffffffff)
                          //     : Color(0xff000000),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400)),
                  Padding(
                    padding: EdgeInsets.only(top: 8.h, bottom: 5.h),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 15,
                      child: Text(theDate.day.toString(),
                          style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400)),
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
