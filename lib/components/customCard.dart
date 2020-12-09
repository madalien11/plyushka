import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plyushka/classes/Ingredient.dart';
import 'package:plyushka/data/data.dart';
import 'dart:ui';
import 'package:plyushka/screens/singleMeal.dart';

class CustomCard extends StatefulWidget {
  final int id;
  final String title;
  final String subtitle;
  final String description;
  final String imageUrl;
  final int price;
  final int tableNum;
  final bool isCertified;
  final int num;
  final Function callBack;
  CustomCard({
    @required this.id,
    @required this.title,
    this.subtitle,
    @required this.description,
    this.price = 1000,
    this.tableNum = 1,
    @required this.imageUrl,
    this.isCertified = false,
    @required this.num,
    this.callBack,
  });

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool _isDisabled;
  List<Ingredient> _ingredients = [];

  Future getIngredients(id) async {
    var response = await IngredientsGetter(id: id).getData();
    if (response != null) {
      List _ingredientsList = response['data']['ingredient'];
      List _certificatesList = response['data']['certificate'];
      if (!mounted) return;
      setState(() {
        for (var ingredient in _ingredientsList) {
          Ingredient s = Ingredient(
            id: ingredient['id'],
            name: ingredient['name'],
            images: _certificatesList,
          );
          _ingredients.add(s);
        }
      });
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
    if (_ingredients != null) _ingredients.clear();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    String img = widget.imageUrl.toString();
    return InkWell(
      onTap: _isDisabled
          ? () => print('')
          : () async {
              if (!mounted) return;
              setState(() {
                _isDisabled = true;
              });
//                  widget.callBack();
              try {
                await getIngredients(widget.id);
              } catch (e) {
                print(e);
              }
              Navigator.pushNamed(context, SingleMealScreen.id, arguments: {
                'price': widget.price,
                'ingredients': _ingredients,
                'description': widget.description,
                'id': widget.id,
                'title': widget.title,
                'isCertified': widget.isCertified,
                'imageUrl': img,
              });
//                  Navigator.pushNamed(context, SingleMealScreen.id);
//                  widget.callBack();
              if (!mounted) return;
              setState(() {
                _isDisabled = false;
              });
            },
      child: Container(
        height: 120.h,
        margin: EdgeInsets.only(left: 8.w, right: 8.w, top: 2.h, bottom: 2.h),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      img,
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Color(0xff4A62AA))));
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 8.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            widget.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff000000).withOpacity(0.85)),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Center(
                          child: Text(
                            widget.description,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color(0xff9D9D9D),
                                fontSize: 12.sp),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Text(
                              widget.price.toString() + 'тг',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Color(0xffEFA921),
                                  fontWeight: FontWeight.w400),
                            ),
                            Spacer(),
                            FlatButton(
                                onPressed: _isDisabled
                                    ? () => print('')
                                    : () async {
                                        if (!mounted) return;
                                        setState(() {
                                          _isDisabled = true;
                                        });
                                        await getIngredients(widget.id);
                                        Navigator.pushNamed(
                                            context, SingleMealScreen.id,
                                            arguments: {
                                              'price': widget.price,
                                              'ingredients': _ingredients,
                                              'description': widget.description,
                                              'id': widget.id,
                                              'title': widget.title,
                                              'isCertified': widget.isCertified,
                                              'imageUrl': img,
                                            });
                                        if (!mounted) return;
                                        setState(() {
                                          _isDisabled = false;
                                        });
                                      },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                color: Color(0xffEFA921),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Text(
                                    'Подробнее',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
