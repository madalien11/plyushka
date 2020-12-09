import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransportManCard extends StatelessWidget {
  TransportManCard(
      {this.id, this.fio, this.img, this.experience, this.description});
  final int id;
  final String fio;
  final String img;
  final String experience;
  final String description;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      child: Container(
          height: 120.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Center(
              child: Row(
                children: [
                  Expanded(
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 40.h,
                      backgroundImage: img != null
                          ? NetworkImage(img)
                          : AssetImage('images/icon.png'),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fio != null ? fio : 'Иванов Максим Васильевич',
                          style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 14.h),
                        Text(
                          experience != null
                              ? 'Стаж ' + experience + ' лет'
                              : 'Стаж 15 лет',
                          style: TextStyle(
                              color: Color(0xffEFA921),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
