import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plyushka/data/data.dart';
import 'package:plyushka/screens/user/forgotPasswordScreen.dart';
import 'package:plyushka/screens/user/registration.dart';
import 'package:plyushka/screens/schoolsScreen.dart';
import 'package:plyushka/video.dart';
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameTextController = TextEditingController();
  final _passTextController = TextEditingController();
  bool checkedValue = false;
  String _email;
  String _password;
  bool _hidePass;
  bool _isButtonDisabled;
  bool _isLoading;
  bool _showError;

  showAlertDialog(BuildContext context, String detail) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
        if (!mounted) return;
        setState(() {
          _isLoading = false;
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(detail),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _hidePass = true;
    _isLoading = false;
    _isButtonDisabled = false;
    _showError = false;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    final Map map = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Color(0xffFDFDFD),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
              child: Row(
                children: [
                  Expanded(child: Container()),
                  Expanded(
                    flex: 9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 16,
                          child: Center(
                            child: Text(
                              'Вход',
                              style: TextStyle(
                                  fontSize: 36.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff222222)),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                autofocus: false,
                                controller: _usernameTextController,
                                onChanged: (value) {
                                  _email = value;
                                },
                                decoration: InputDecoration(
                                    hintText: 'EMAIL',
                                    filled: true,
                                    errorText: _showError
                                        ? 'wrong email or password'
                                        : null,
                                    hintStyle: TextStyle(fontSize: 14.sp),
                                    fillColor: Colors.white70,
                                    prefixIcon:
                                        Icon(Icons.mail_outline_outlined)),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              child: TextField(
                                autofocus: false,
                                controller: _passTextController,
                                obscureText: _hidePass,
                                onChanged: (value) {
                                  _password = value;
                                },
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        if (!mounted) return;
                                        setState(() {
                                          _hidePass = !_hidePass;
                                        });
                                      },
                                      icon: _hidePass
                                          ? Icon(
                                              Icons.visibility,
                                              color: Color(0xff828282),
                                            )
                                          : Icon(
                                              Icons.visibility_off,
                                              color: Color(0xffEFA921),
                                            ),
                                    ),
                                    hintText: 'ПАРОЛЬ',
                                    filled: true,
                                    errorText: _showError
                                        ? 'wrong email or password'
                                        : null,
                                    hintStyle: TextStyle(fontSize: 14.sp),
                                    fillColor: Colors.white70,
                                    prefixIcon: Icon(Icons.lock_outline)),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 26.h),
                            child: FlatButton(
                                onPressed: _isButtonDisabled
                                    ? () => print('Sign In')
                                    : () async {
                                        if (!mounted) return;
                                        setState(() {
                                          _isLoading = true;
                                          _isButtonDisabled = true;
                                        });
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                        if (_passTextController
                                                .text.isNotEmpty &&
                                            _usernameTextController
                                                .text.isNotEmpty) {
                                          dynamic outcome = await Login(
                                                  email: _email,
                                                  password: _password)
                                              .login();
                                          String source = Utf8Decoder()
                                              .convert(outcome.bodyBytes);
                                          print(source);
                                          if (outcome.statusCode == 401) {
                                            if (!mounted) return;
                                            setState(() {
                                              showAlertDialog(context,
                                                  jsonDecode(source)['detail']);
                                              _isLoading = false;
                                              _isButtonDisabled = false;
                                            });
                                          } else if (outcome.statusCode ==
                                              200) {
                                            dynamic userInfo =
                                                jsonDecode(source);
                                            nameInData =
                                                userInfo['data']['username'];
                                            tokenString = userInfo['access'];
                                            refreshTokenString =
                                                userInfo['refresh'];
                                            if (checkedValue) {
                                              if (addTokenInData != null) {
                                                addTokenInData(
                                                    'token',
                                                    userInfo['access']
                                                        .toString());
                                                addTokenInData(
                                                    'refresh',
                                                    userInfo['refresh']
                                                        .toString());
                                                addTokenInData(
                                                    'name',
                                                    userInfo['data']['username']
                                                        .toString());
                                                Navigator.pushReplacementNamed(
                                                    context, SchoolsScreen.id,
                                                    arguments: {
                                                      'addToken':
                                                          addTokenInData,
                                                      'deleteAll': logOutInData,
                                                      'checkedValue':
                                                          checkedValue
                                                    });
                                              } else if (map != null &&
                                                  map['addToken'] != null) {
                                                map['addToken'](
                                                    'token',
                                                    userInfo['access']
                                                        .toString());
                                                map['addToken'](
                                                    'name',
                                                    userInfo['data']['username']
                                                        .toString());
                                                map['addToken'](
                                                    'refresh',
                                                    userInfo['refresh']
                                                        .toString());
                                                Navigator.pushReplacementNamed(
                                                    context, SchoolsScreen.id,
                                                    arguments: {
                                                      'addToken':
                                                          map['addToken'],
                                                      'deleteAll':
                                                          map['deleteAll'],
                                                      'checkedValue':
                                                          checkedValue
                                                    });
                                              }
                                            } else {
                                              Navigator.pushReplacementNamed(
                                                  context, SchoolsScreen.id,
                                                  arguments: {
                                                    'checkedValue': checkedValue
                                                  });
                                            }
                                            if (!mounted) return;
                                            setState(() {
                                              _isLoading = false;
                                              _isButtonDisabled = false;
                                            });
                                            _usernameTextController.clear();
                                            _passTextController.clear();
                                          }
                                        } else {
                                          if (!mounted) return;
                                          setState(() {
                                            showAlertDialog(context,
                                                'Email and/or password cannot be empty');
                                            _isLoading = false;
                                            _isButtonDisabled = false;
                                          });
                                        }
                                      },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: Color(0xffEFA921),
                                child: Text(
                                  'ВОЙТИ',
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff222222),
                                      letterSpacing: -0.3),
                                )),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 35.w,
                                height: 35.h,
                                child: Transform.scale(
                                  scale: 0.85,
                                  child: Checkbox(
                                    checkColor:
                                        Color(0xffEFA921), // color of tick Mark
                                    activeColor: Color(0xffe5e5e5),
                                    value: checkedValue,
                                    onChanged: (newValue) {
                                      if (!mounted) return;
                                      setState(() {
                                        checkedValue = newValue;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Text(
                                'Запомнить меня',
                                style: TextStyle(
                                  color: Color(0xFFBBBBBB),
                                  fontSize: 12.sp,
                                  letterSpacing: -0.33,
                                ),
                              ),
                              Spacer(),
                              Container(
                                child: FlatButton(
                                    onPressed: () {
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                      Navigator.pushNamed(
                                          context, ForgotPasswordScreen.id);
                                    },
                                    child: Text(
                                      'Забыли Пароль?',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontSize: 12.sp,
                                          color: Color(0xFFBBBBBB)),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 15,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: FlatButton(
                                  onPressed: () {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    Navigator.pushNamed(
                                        context, RegistrationScreen.id);
                                  },
                                  child: Text(
                                    'Зарегистрироваться',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff222222),
                                        letterSpacing: -0.3),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xffEFA921))))
              : Container()
        ],
      )),
    );
  }
}
