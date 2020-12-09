import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';

class Ingredients extends StatelessWidget {
  final String name;
  Ingredients({this.name = 'Ingredient'});
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    return Row(
      children: [
        Container(
          width: 18.w,
          height: 18.h,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.green[400],
            ),
            shape: BoxShape.circle,
            color: Colors.green[100],
          ),
          child: Icon(
            Icons.done_rounded,
            size: 13,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xff000000).withOpacity(0.7),
                fontSize: 15.sp,
                fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
