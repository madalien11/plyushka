import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plyushka/screens/menuPage.dart';

class MenuCard extends StatefulWidget {
  final int id;
  final String title;
  final String subtitle;
  final Function foodTypeSelector;
  final Function changePressedTableId;
  MenuCard(
      {this.title,
      this.subtitle,
      this.id,
      this.foodTypeSelector,
      this.changePressedTableId});

  @override
  _MenuCardState createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    return GestureDetector(
      onTap: () {
        widget.foodTypeSelector(widget.id, false);
        widget.changePressedTableId(widget.id);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Container(
          width: 220.w,
          decoration: BoxDecoration(
              border: pressedMenuTypeIds[widget.id]
                  ? Border.all(
                      width: 5.w,
                      color: Color(0xffEFA921),
                    )
                  : null,
              image: DecorationImage(
                image: AssetImage('images/menu.png'),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                widget.subtitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
