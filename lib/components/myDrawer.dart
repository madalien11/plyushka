import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plyushka/screens/application/application.dart';
import 'package:plyushka/screens/broadcast.dart';
import 'package:plyushka/screens/transport.dart';
import 'package:plyushka/data/data.dart';

class MyDrawer extends StatefulWidget {
  final bool inMenu;
  final bool inBroadcasts;
  final bool inApplications;
  final bool inTransport;
  MyDrawer(
      {this.inMenu, this.inBroadcasts, this.inApplications, this.inTransport});
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.only(top: 10.h),
        children: <Widget>[
          Container(
            height: 125.h,
            child: DrawerHeader(
                padding: EdgeInsets.fromLTRB(0, 16.h, 10.w, 8.h),
                child: Center(
                  child: ListTile(
                    leading: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Icon(
                        Icons.account_circle,
                        size: 55,
                        color: Color(0xffEFA921),
                      ),
                    ),
                    title: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        nameInData ?? 'Madi Karsybekov',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                )),
          ),
          ListTile(
            onTap: () {
              if (widget.inMenu != null && widget.inMenu) {
                Navigator.pop(context);
                Navigator.pop(context);
              } else if (widget.inMenu == null || !widget.inMenu) {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            leading: Icon(
              Icons.school_outlined,
              color: Color(0xffEFA921),
            ),
            title: Text('Школы'),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.restaurant_menu_outlined,
              color: Color(0xffEFA921),
            ),
            title: Text('Меню'),
//            trailing: Icon(
//              firstItemPressed
//                  ? Icons.keyboard_arrow_down_outlined
//                  : Icons.keyboard_arrow_right_outlined,
//              color: Color(0xffEFA921),
//            ),
            onTap: () {
              if (widget.inMenu != null && widget.inMenu) {
                Navigator.pop(context);
              } else if (widget.inMenu == null || !widget.inMenu) {
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
          ),
//          firstItemPressed
//              ? Row(
//                  children: [
//                    Expanded(
//                      child: Container(),
//                      flex: 2,
//                    ),
//                    Expanded(
//                      flex: 5,
//                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.stretch,
//                        children: [
//                          Text('Комплексные блюда'),
//                          Text('Блюда по отдельности')
//                        ],
//                      ),
//                    ),
//                  ],
//                )
//              : Container(),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.live_tv_outlined,
              color: Color(0xffEFA921),
            ),
            title: Text('Трансляция'),
            onTap: () {
              Navigator.pop(context);
              if (widget.inMenu != null && widget.inMenu) {
                Navigator.pushNamed(context, BroadcastScreen.id);
              } else if (widget.inBroadcasts == null || !widget.inBroadcasts) {
                Navigator.pushReplacementNamed(context, BroadcastScreen.id);
              }
            },
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              if (widget.inMenu != null && widget.inMenu) {
                Navigator.pushNamed(context, ApplicationScreen.id);
              } else if (widget.inApplications == null ||
                  !widget.inApplications) {
                Navigator.pushReplacementNamed(context, ApplicationScreen.id);
              }
            },
            leading: Icon(
              Icons.article_outlined,
              color: Color(0xffEFA921),
            ),
            title: Text('Подача заявок'),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              if (widget.inMenu != null && widget.inMenu) {
                Navigator.pushNamed(context, TransportScreen.id);
              } else if (widget.inTransport == null || !widget.inTransport) {
                Navigator.pushReplacementNamed(context, TransportScreen.id);
              }
            },
            leading: Icon(
              Icons.directions_car_outlined,
              color: Color(0xffEFA921),
            ),
            title: Text('Развозка'),
          ),
        ],
      ),
    );
  }
}
