// import 'package:flutter/material.dart';
// import 'package:plyushka/classes/date.dart';
// import 'package:plyushka/classes/meal.dart';
// import 'package:plyushka/components/customCard.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'dart:ui';
// import 'package:plyushka/components/weekdayCard.dart';
// import 'package:plyushka/screens/menuPage.dart';
//
// List<Meal> mealsInScreen = [];
//
// class MealsScreen extends StatefulWidget {
//   static const String id = 'meals_screen';
//
//   @override
//   _MealsScreenState createState() => _MealsScreenState();
// }
//
// class _MealsScreenState extends State<MealsScreen> {
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
//   void dispose() {
//     super.dispose();
//     if (mealsInScreen != null) mealsInScreen.clear();
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
//       if (map['meals'] != null)
//         mealsInScreen = map['meals'];
//       else
//         mealsInScreen = [];
//     }
//     if (mealsInScreen.length < 1) _hasData = false;
//     return Scaffold(
//       backgroundColor: Color(0xffFDFDFD),
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Color(0xffFDFDFD),
//         automaticallyImplyLeading: false,
//         toolbarHeight: 110.h,
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
//                     'Стол №' + map['tableNum'].toString(),
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
//               child: FittedBox(
//                 fit: BoxFit.fitWidth,
//                 child: Text(
//                   'Высококалорийные блюда',
//                   style: TextStyle(
//                     fontSize: 28.sp,
//                     fontWeight: FontWeight.w700,
//                     color: Color(0xff2C2E5E),
//                   ),
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
//                       Container(
//                           margin: EdgeInsets.symmetric(horizontal: 3.w),
//                           height: 120.h,
//                           child: ListView(
//                             scrollDirection: Axis.horizontal,
//                             children: <Widget>[
//                               for (Date date in weekDates)
//                                 WeekdayCard(
//                                   fromMeals: true,
//                                   id: date.id,
//                                   name: date.name,
//                                   week: date.week,
//                                   date: date.date,
//                                   today: date.today,
//                                   callBack: loader,
//                                 ),
//                             ],
//                           )),
//                       for (Meal m in mealsInScreen)
//                         CustomCard(
//                           isTable: false,
//                           id: m.id,
//                           description: m.description,
//                           imageUrl: m.imageUrl,
//                           num: m.id,
//                           title: m.name,
//                           price: m.price,
//                           isCertified: m.hasCertificate,
//                           callBack: loader,
//                         )
// //            CustomCard(isTable: false),
// //            CustomCard(isTable: false),
// //            CustomCard(isTable: false),
// //            CustomCard(isTable: false),
// //            CustomCard(isTable: false),
// //            CustomCard(isTable: false),
// //            CustomCard(isTable: false),
// //            CustomCard(isTable: false),
//                     ],
//                   ),
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
//               "Список блюд пуст".toUpperCase(),
//               style: TextStyle(
//                   color: Color(0xff2C2E5E),
//                   fontSize: 20.sp,
//                   fontWeight: FontWeight.w700),
//             )),
//     );
//   }
// }
