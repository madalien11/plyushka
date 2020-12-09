import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_back_gesture/cupertino_back_gesture.dart';
import 'package:flutter/services.dart';
import 'package:plyushka/screens/user/newPassScreen.dart';
import 'screens/schoolsScreen.dart';
import 'screens/uselessMeals.dart';
import 'screens/menuPage.dart';
import 'screens/uselessTables.dart';
import 'screens/uselessWelcome.dart';
import 'screens/singleMeal.dart';
import 'screens/user/login.dart';
import 'screens/user/registration.dart';
import 'screens/application/application.dart';
import 'screens/transport.dart';
import 'screens/broadcast.dart';
import 'video.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'classes/authClasses.dart';
import 'package:plyushka/data/data.dart';
import 'screens/user/enterCodeScreen.dart';
import 'screens/user/forgotPasswordScreen.dart';
import 'screens/user/forgotPassCodeScreen.dart';

LogOut signOut;
AddTokenClass addTokenIns;

class SecItem {
  SecItem(this.key, this.value);

  final String key;
  final String value;

  String get tokenKey => key;
  String get tokenValue => value;
}

void main() {
//  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return BackGestureWidthTheme(
      backGestureWidth: BackGestureWidth.fraction(1 / 2),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Плюшка',
        routes: {
          // MealsScreen.id: (context) => MealsScreen(),
          SchoolsScreen.id: (context) => SchoolsScreen(),
          // TablesScreen.id: (context) => TablesScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          MenuPage.id: (context) => MenuPage(),
          NewPassScreen.id: (context) => NewPassScreen(),
          ForgotPassCodeScreen.id: (context) => ForgotPassCodeScreen(),
          ForgotPasswordScreen.id: (context) => ForgotPasswordScreen(),
          EnterCodeScreen.id: (context) => EnterCodeScreen(),
          BroadcastScreen.id: (context) => BroadcastScreen(),
          TransportScreen.id: (context) => TransportScreen(),
          ApplicationScreen.id: (context) => ApplicationScreen(),
          SingleMealScreen.id: (context) => SingleMealScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          MyAppScaffold.id: (context) => MyAppScaffold(),
          UselessWelcomeScreen.id: (context) => UselessWelcomeScreen(),
          WelcomeScreen.id: (context) => WelcomeScreen(),
        },
        theme: ThemeData(
          primarySwatch: Colors.amber,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.iOS:
                  CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
            },
          ),
        ),
        home: WelcomeScreen(),
      ),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _storage = FlutterSecureStorage();
  var tokenItems = [];
  final _pageViewController = new PageController();

  delayer(context) async {
    try {
      for (var i in tokenItems) {
        if (i.tokenKey == 'token') {
          for (var j in tokenItems) {
            if (j.tokenKey == 'name') nameInData = j.tokenValue;
          }
          Navigator.pushReplacementNamed(context, SchoolsScreen.id,
              arguments: {'addToken': addNewItem, 'deleteAll': deleteAll});
          return;
        }
      }
      Navigator.pushReplacementNamed(context, LoginScreen.id,
          arguments: {'addToken': addNewItem, 'deleteAll': deleteAll});
    } catch (e) {
      print(e);
    }
  }

  Future<Null> _readAll() async {
    final all = await _storage.readAll();
    if (mounted) {
      setState(() {
        tokenItems = all.keys
            .map((key) => SecItem(key, all[key]))
            .toList(growable: false);
        if (tokenItems.length > 0) {
          for (var item in tokenItems) {
            if (item.tokenKey == 'token') {
              tokenString = item.tokenValue;
            }
            if (item.tokenKey == 'refresh') {
              refreshTokenString = item.tokenValue;
            }
          }
        }
        return tokenItems;
      });
    }
  }

  void deleteAll() async {
    await _storage.deleteAll();
    _readAll();
  }

  void addNewItem(key1, value1) async {
    final String key = key1;
    final String value = value1;

    await _storage.write(key: key, value: value);
    _readAll();
  }

  @override
  void initState() {
    super.initState();
    signOut = LogOut(deleteAll: deleteAll);
    addTokenIns = AddTokenClass(addTokenClass: addNewItem);
    logOutInData = signOut.deleteAll;
    addTokenInData = addTokenIns.addTokenClass;
    _readAll();
    Timer(Duration(milliseconds: 2500), () {
      delayer(context);
    });
//    _readLaunch();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: _pageViewController,
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: Color(0xffffffff),
                  padding: EdgeInsets.symmetric(horizontal: 85.w),
                  child: Image.asset(
                    "images/icon.png",
                    fit: BoxFit.scaleDown,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
