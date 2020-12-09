// import 'package:flutter/material.dart';
// import 'package:plyushka/classes/meal.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'dart:ui';
// import 'package:flutter/rendering.dart';
// import 'package:plyushka/components/customCard.dart';
// import 'schoolsScreen.dart';
//
// List<Meal> tablesInScreen = [];
//
// class TablesScreen extends StatefulWidget {
//   static const String id = 'tables_screen';
//
//   @override
//   _TablesScreenState createState() => _TablesScreenState();
// }
//
// class _TablesScreenState extends State<TablesScreen> {
//   ScrollController _hideButtonController;
//   var _isVisible;
//   bool _loading = false;
//   bool _hasData = true;
//
//   void loader() {
//     if (!mounted) return;
//     setState(() {
//       _loading = !_loading;
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _isVisible = true;
//     _hideButtonController = new ScrollController();
//     _hideButtonController.addListener(() {
//       if (_hideButtonController.position.userScrollDirection ==
//           ScrollDirection.reverse) {
//         if (_isVisible == true) {
//           if (!mounted) return;
//           setState(() {
//             _isVisible = false;
//           });
//         }
//       } else {
//         if (_hideButtonController.position.userScrollDirection ==
//             ScrollDirection.forward) {
//           if (_isVisible == false) {
//             if (!mounted) return;
//             setState(() {
//               _isVisible = true;
//             });
//           }
//         }
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     if (tablesInScreen != null) tablesInScreen.clear();
//     _loading = false;
//     _hasData = true;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.init(context,
//         designSize: Size(360, 706), allowFontScaling: false);
//     Map map = ModalRoute.of(context).settings.arguments;
//     if (map != null) {
//       if (map['tables'] != null)
//         tablesInScreen = map['tables'];
//       else
//         tablesInScreen = [];
//     }
//     if (tablesInScreen.length < 1) _hasData = false;
//     return Scaffold(
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: Visibility(
//         visible: _isVisible,
//         child: FloatingActionButton.extended(
//             label: IconButton(
//               onPressed: () {
//                 Navigator.pushNamedAndRemoveUntil(
//                     context, SchoolsScreen.id, (route) => false);
//               },
//               icon: Icon(
//                 Icons.home_outlined,
//                 size: 30,
//               ),
//             ),
//             elevation: 5,
//             backgroundColor: Color(0xff4B62AA),
//             onPressed: () {}),
//       ),
//       backgroundColor: Color(0xffFDFDFD),
//       appBar: AppBar(
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         backgroundColor: Color(0xffFDFDFD),
//         toolbarHeight: 120.h,
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Row(
//                 children: [
//                   Icon(
//                     Icons.arrow_back_ios_rounded,
//                     size: 20.w,
//                     color: Color(0xff2C2E5E),
//                   ),
//                   Text(
//                     map != null
//                         ? map['weekday'] != null
//                             ? ' ${map['weekday'].toString()[0].toUpperCase()}${map['weekday'].toString().toLowerCase().substring(1)}'
//                             : ''
//                         : '',
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff2C2E5E),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 18.h),
//             Center(
//               child: Text(
//                 'Столы',
//                 style: TextStyle(
//                   fontSize: 28.sp,
//                   fontWeight: FontWeight.w700,
//                   color: Color(0xff2C2E5E),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: _hasData
//           ? NotificationListener<OverscrollIndicatorNotification>(
//               onNotification: (OverscrollIndicatorNotification overScroll) {
//                 overScroll.disallowGlow();
//                 return true;
//               },
//               child: Stack(
//                 children: [
//                   ListView(
//                     children: [
//                       for (Meal m in tablesInScreen)
//                         CustomCard(
//                           id: m.id,
//                           // isTable: true,
//                           subtitle: m.subtitle,
//                           title: m.name,
//                           description: m.description,
//                           imageUrl: m.imageUrl,
//                           num: m.id,
//                           callBack: loader,
//                         )
//                     ],
//                   ),
// //        ListView(
// //          controller: _hideButtonController,
// //          children: [
// ////            Container(
// ////                margin: EdgeInsets.symmetric(horizontal: 3.w),
// ////                height: 120.h,
// ////                child: ListView(
// ////                  scrollDirection: Axis.horizontal,
// ////                  children: <Widget>[
// ////                    for (Date date in dates)
// ////                      WeekdayCard(
// ////                        fromMeals: true,
// ////                        id: date.id,
// ////                        name: date.name,
// ////                        week: date.week,
// ////                        date: date.date,
// ////                        today: date.today,
// ////                      ),
// ////                  ],
// ////                )),
// //            CustomCard(id: 1, isTable: true, num: 1),
// //            CustomCard(id: 2, isTable: true, num: 2),
// //            CustomCard(id: 3, isTable: true, num: 3),
// //            CustomCard(id: 4, isTable: true, num: 4),
// //            CustomCard(id: 5, isTable: true, num: 5),
// //            CustomCard(id: 6, isTable: true, num: 6),
// //            CustomCard(id: 7, isTable: true, num: 7),
// //            CustomCard(id: 8, isTable: true, num: 8),
// //            CustomCard(id: 9, isTable: true, num: 9),
// //            CustomCard(id: 10, isTable: true, num: 10),
// //            CustomCard(id: 11, isTable: true, num: 11),
// //            CustomCard(id: 12, isTable: true, num: incrementer()),
// //            CustomCard(id: 13, isTable: true, num: incrementer()),
// //            CustomCard(id: 14, isTable: true, num: incrementer()),
// //            CustomCard(id: 15, isTable: true, num: incrementer()),
// //            CustomCard(id: 16, isTable: true, num: incrementer()),
// //          ],
// //        ),
//                   _loading
//                       ? Container(
//                           height: double.infinity,
//                           width: double.infinity,
//                           child: GestureDetector(
//                               onTap: () => print('smth'),
//                               child: Center(
//                                   child: CircularProgressIndicator(
//                                       valueColor: AlwaysStoppedAnimation<Color>(
//                                           Color(0xff4A62AA))))))
//                       : Container()
//                 ],
//               ))
//           : Center(
//               child: Text(
//               "Список столов пуст".toUpperCase(),
//               style: TextStyle(
//                   color: Color(0xff2C2E5E),
//                   fontSize: 20.sp,
//                   fontWeight: FontWeight.w700),
//             )),
//     );
//   }
// }
