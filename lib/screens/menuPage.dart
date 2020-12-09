import 'package:flutter/material.dart';
import 'package:plyushka/classes/meal.dart';
import 'package:plyushka/components/customCard.dart';
import 'package:plyushka/components/foodTypeCard.dart';
import 'package:plyushka/components/myDrawer.dart';
import 'package:plyushka/components/schoolCard.dart';
import 'package:plyushka/components/weekdayCard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';
import 'package:plyushka/classes/date.dart';
import 'package:plyushka/components/menuCard.dart';
import 'package:plyushka/data/data.dart';

List<int> datesId = [];
List<Date> weekDates = [];
Map<int, bool> pressedFoodTypeIds = {1: false, 2: false, 3: false, 4: false};
Map<int, bool> pressedWeekDayIds = {};
Map<int, bool> pressedMenuTypeIds = {1: true};
int tableId = 1;
int selectedFoodType = 1;
Map<int, List<Meal>> foodsByType = {
  1: [],
  2: [],
  3: [],
  4: [],
};
List<Meal> mealsInScreen = [];
List<Meal> initialMealsInScreen = [];
Future<List<Meal>> futureMenuTypesList;
String chosenDate = '';

class MenuPage extends StatefulWidget {
  static const String id = 'menu_screen';
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  bool thisWeek = firstWeek;
  List<Widget> datesWidgets1 = [];
  List<Widget> datesWidgets2 = [];
  bool loading = false;
  bool _hasData = true;
  int initialLabelIndex = 0;
  Future<List<Meal>> futureFoodsList;
  bool foodTypePressed = false;
  bool firstFillOfData = false;

  void loader(value) {
    if (!mounted) return;
    setState(() {
      if (value.length < 1) {
        hasMeals = false;
      } else {
        hasMeals = true;
      }
    });
  }

  void falseSetter(int id, String date) {
    // Future.delayed(const Duration(milliseconds: 500), () {});
    if (!mounted) return;
    pressedWeekDayIds.forEach((key, value) {
      pressedWeekDayIds[key] = false;
    });
    setState(() {
      pressedWeekDayIds[id] = true;
      chosenDate = date;
    });
  }

  bool checkAddDate(i) {
    if (!datesId.contains(i)) {
      datesId.add(i);
      return true;
    } else
      return false;
  }

  bool checkFoodTypeSelected() {
    bool result = false;
    pressedFoodTypeIds.forEach((key, value) {
      if (pressedFoodTypeIds[key]) {
        selectedFoodType = key;
        result = true;
      }
    });
    return result;
  }

  void foodTypeSelector(int id, bool foodType) {
    if (foodType) {
      pressedFoodTypeIds.forEach((key, value) {
        if (key != id) pressedFoodTypeIds[key] = false;
      });
      setState(() {
        pressedFoodTypeIds[id] = !pressedFoodTypeIds[id];
      });
      foodTypePressed = false;
      pressedFoodTypeIds.forEach((key, value) {
        if (pressedFoodTypeIds[key]) foodTypePressed = true;
      });
    } else {
      setState(() {
        pressedFoodTypeIds.forEach((key, value) {
          pressedFoodTypeIds[key] = false;
        });
        pressedMenuTypeIds.forEach((key, value) {
          if (key != id) pressedMenuTypeIds[key] = false;
        });
        pressedMenuTypeIds[id] = true;
      });
    }
  }

  List<Widget> widgetBuilder(dates) {
    // if (firstFillOfData) {
    //   datesWidgets1.clear();
    //   datesWidgets2.clear();
    //   datesId.clear();
    // }
    // print(pressedWeekDayIds);
    setState(() {
      for (var date in dates) {
        if (!mounted) return [];
        if (checkAddDate(date.id)) {
          if (!pressedWeekDayIds.containsKey(date.id) && !firstFillOfData) {
            print('falsification');
            pressedWeekDayIds[date.id] = false;
          }
          if (date.week == 1) {
            if (todayDateId == date.id) {
              setState(() {
                thisWeek = true;
              });
              setState(() => initialLabelIndex = 0);
            }
            datesWidgets1.add(WeekdayCard(
                id: date.id,
                name: date.name,
                week: date.week,
                date: date.date,
                today: date.today,
                callBack: loader,
                falseSetter: falseSetter,
                pressed: pressedWeekDayIds[date.id]));
          } else if (date.week == 2) {
            if (todayDateId == date.id) {
              setState(() {
                thisWeek = false;
              });
              setState(() => initialLabelIndex = 1);
            }
            datesWidgets2.add(WeekdayCard(
                id: date.id,
                name: date.name,
                week: date.week,
                date: date.date,
                today: date.today,
                callBack: loader,
                falseSetter: falseSetter,
                pressed: pressedWeekDayIds[date.id]));
          }
        }
      }
    });
    firstFillOfData = true;
    if (datesWidgets1.length < 1 && datesWidgets2.length < 1) _hasData = false;
    return thisWeek ? datesWidgets1 : datesWidgets2;
  }

  void changePressedTableId(id) {
    if (!mounted) return;
    setState(() {
      tableId = id;
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (datesId != null) datesId.clear();
    if (weekDates != null) weekDates.clear();
    pressedWeekDayIds.forEach((key, value) {
      pressedWeekDayIds[key] = false;
    });
    pressedFoodTypeIds.forEach((key, value) {
      pressedFoodTypeIds[key] = false;
    });
    pressedMenuTypeIds.forEach((key, value) {
      if (key != 1)
        pressedMenuTypeIds[key] = false;
      else
        pressedMenuTypeIds[key] = true;
    });
    if (foodsByType != null) {
      foodsByType.forEach((key, value) {
        foodsByType[key].clear();
      });
    }
    loading = false;
    _hasData = true;
  }

  @override
  void initState() {
    super.initState();
    // TODO: hardcode
    futureMenuTypesList = fetchTables(context, schoolId, 15);
    // futureMenuTypesList = fetchTables(context, schoolId, todayDateId);
    if (hasMeals) {
      tableId = 1;
    } else {
      tableId = 0;
    }
    futureFoodsList = fetchMeals(context, tableId);
    var now = DateTime.now();
    chosenDate = now.day.toString() +
        "-" +
        now.month.toString() +
        "-" +
        now.year.toString();
  }

  @override
  Widget build(BuildContext context) {
    Map map = ModalRoute.of(context).settings.arguments;
    if (map != null) if (map['dates'] != null) weekDates = map['dates'];
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    if (hasMeals) {
      tableId = 1;
    } else {
      tableId = 0;
    }
    futureFoodsList = fetchMeals(context, tableId);
    return Scaffold(
      drawer: MyDrawer(inMenu: true),
      backgroundColor: Color(0xffFDFDFD),
      appBar: AppBar(
        title: Text(chosenDate),
        elevation: 0,
        backgroundColor: Color(0xffFDFDFD),
      ),
      body: _hasData
          ? Dismissible(
              resizeDuration: null,
              // ignore: missing_return
              confirmDismiss: (direction) {
                if (!mounted) return;
                setState(() {
                  thisWeek =
                      direction == DismissDirection.endToStart ? false : true;
                  setState(() => initialLabelIndex = thisWeek ? 0 : 1);
                });
              },
              key: ValueKey(thisWeek),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16.w, right: 16.w),
                              child: Container(
                                height: 30.h,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xffEFA921),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(11))),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          if (!mounted) return;
                                          setState(() {
                                            thisWeek = true;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: thisWeek
                                                  ? Color(0xffEFA921)
                                                  : Colors.transparent,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Center(
                                              child: Text(
                                            'Текущая Неделя',
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              color: thisWeek
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          )),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          if (!mounted) return;
                                          setState(() {
                                            thisWeek = false;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: !thisWeek
                                                  ? Color(0xffEFA921)
                                                  : Colors.transparent,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Center(
                                              child: Text(
                                            'Следующая Неделя',
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              color: !thisWeek
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 3.w, vertical: 4.h),
                                height: 76.h,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: widgetBuilder(weekDates),
                                )),
                            Container(
                              height: 110.h,
                              child: FutureBuilder<List<Meal>>(
                                future: futureMenuTypesList,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        if (!pressedMenuTypeIds.containsKey(
                                            snapshot.data.reversed
                                                .toList()[index]
                                                .id)) {
                                          pressedMenuTypeIds[snapshot
                                              .data.reversed
                                              .toList()[index]
                                              .id] = false;
                                        }
                                        return MenuCard(
                                          id: snapshot.data.reversed
                                              .toList()[index]
                                              .id,
                                          title: snapshot.data.reversed
                                              .toList()[index]
                                              .name
                                              .toString(),
                                          subtitle: snapshot.data.reversed
                                              .toList()[index]
                                              .description
                                              .toString(),
                                          foodTypeSelector: foodTypeSelector,
                                          changePressedTableId:
                                              changePressedTableId,
                                        );
                                      },
                                      itemCount: snapshot.data.length,
                                    );
                                  } else if (snapshot.hasError) {
                                    // tableId = 0;
                                    // if (mounted)
                                    //   setState(() {
                                    //     tableId = 0;
                                    //   });
                                    return Center(
                                        child: Text(
                                      "Список меню пуст".toUpperCase(),
                                      style: TextStyle(
                                          color: Color(0xff222222),
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w700),
                                    ));
                                  }
                                  // By default, show a loading spinner.

                                  // if (mounted)
                                  //   setState(() {
                                  //     tableId = 0;
                                  //   });
                                  // tableId = 0;
                                  return Center(
                                      child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Color(0xffEFA921))));
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 5.w, right: 5.w, top: 7.h),
                              child: hasMeals
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        FoodTypeCard(
                                            id: 1,
                                            imageUrl: 'images/Group 175.png',
                                            foodTypeSelector: foodTypeSelector),
                                        FoodTypeCard(
                                            id: 2,
                                            imageUrl: 'images/Group 176.png',
                                            foodTypeSelector: foodTypeSelector),
                                        FoodTypeCard(
                                            id: 3,
                                            imageUrl: 'images/Group 177.png',
                                            foodTypeSelector: foodTypeSelector),
                                        FoodTypeCard(
                                            id: 4,
                                            imageUrl: 'images/Group 178.png',
                                            foodTypeSelector: foodTypeSelector),
                                      ],
                                    )
                                  : Container(),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 108,
                        child: checkFoodTypeSelected()
                            ? ListView.builder(
                                itemCount: foodsByType[selectedFoodType].length,
                                itemBuilder: (context, index) {
                                  return CustomCard(
                                    id: foodsByType[selectedFoodType][index].id,
                                    description: foodsByType[selectedFoodType]
                                            [index]
                                        .description,
                                    imageUrl: foodsByType[selectedFoodType]
                                            [index]
                                        .imageUrl,
                                    num:
                                        foodsByType[selectedFoodType][index].id,
                                    title: foodsByType[selectedFoodType][index]
                                        .name,
                                    price: foodsByType[selectedFoodType][index]
                                        .price,
                                    isCertified: foodsByType[selectedFoodType]
                                            [index]
                                        .hasCertificate,
                                    callBack: loader,
                                  );
                                },
                              )
                            : FutureBuilder<List<Meal>>(
                                future: futureFoodsList,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data.length > 0) {
                                    return ListView.builder(
                                      itemBuilder: (context, index) {
                                        return CustomCard(
                                          id: snapshot.data[index].id,
                                          description:
                                              snapshot.data[index].description,
                                          imageUrl:
                                              snapshot.data[index].imageUrl,
                                          num: snapshot.data[index].id,
                                          title: snapshot.data[index].name,
                                          price: snapshot.data[index].price,
                                          isCertified: snapshot
                                              .data[index].hasCertificate,
                                          callBack: loader,
                                        );
                                      },
                                      itemCount: snapshot.data.length,
                                    );
                                  } else if (snapshot.hasError || !hasMeals) {
                                    return Center(
                                        child: Text(
                                      "Список блюд пуст".toUpperCase(),
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
                                              AlwaysStoppedAnimation<Color>(
                                                  Color(0xffEFA921))));
                                },
                              ),
                      ),
                    ],
                  ),
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
              ))
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
