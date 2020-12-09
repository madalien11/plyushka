import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plyushka/screens/menuPage.dart';

class FoodTypeCard extends StatefulWidget {
  final int id;
  final String imageUrl;
  final Function foodTypeSelector;
  FoodTypeCard(
      {@required this.imageUrl,
      @required this.id,
      @required this.foodTypeSelector});
  @override
  _FoodTypeCardState createState() => _FoodTypeCardState();
}

class _FoodTypeCardState extends State<FoodTypeCard> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    return GestureDetector(
      onTap: () {
        widget.foodTypeSelector(widget.id, true);
      },
      child: Container(
        width: 65.w,
        height: 65.h,
        decoration: BoxDecoration(
            color: pressedFoodTypeIds[widget.id]
                ? Color(0xffEFA921)
                : Colors.transparent,
            border: Border.all(
              color: Color(0xffEFA921),
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Image.asset(
          widget.imageUrl,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
