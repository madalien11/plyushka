import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plyushka/data/data.dart';
import 'package:plyushka/screens/user/enterCodeScreen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _emailTextController = TextEditingController();
  final _nameTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _confirmPassTextController = TextEditingController();
  bool checkedValue = false;
  String _email;
  String _name;
  String _password;
  String _confirmPassword;
  bool _hidePass;
  bool _hideConfirmPass;
  bool _isButtonDisabled;
  bool _isLoading;
  bool _showError;

  showAlertDialog(
      BuildContext context, String detail, bool success, String _email) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        if (success) {
          FocusScope.of(context).requestFocus(new FocusNode());
          Navigator.pop(context);
          Navigator.pushNamed(context, EnterCodeScreen.id,
              arguments: {'email': _email});
        } else {
          FocusScope.of(context).requestFocus(new FocusNode());
          Navigator.pop(context);
        }
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
    _hideConfirmPass = true;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    return Scaffold(
      backgroundColor: Color(0xffFDFDFD),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 15.h),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Row(
                children: [
                  Expanded(flex: 1.w.toInt(), child: Container()),
                  Expanded(
                    flex: 9.w.toInt(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 12,
                          child: Center(
                            child: Text(
                              'Регистрация',
                              style: TextStyle(
                                  fontSize: 36.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff222222)),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: TextField(
                              autofocus: false,
                              controller: _nameTextController,
                              onChanged: (value) {
                                _name = value;
                              },
                              decoration: InputDecoration(
                                  hintText: 'Имя Фамилия'.toUpperCase(),
                                  filled: true,
                                  errorText: _showError
                                      ? 'wrong email or password'
                                      : null,
                                  hintStyle: TextStyle(fontSize: 14.sp),
                                  fillColor: Colors.white70,
                                  prefixIcon:
                                      Icon(Icons.person_outline_outlined)),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              autofocus: false,
                              controller: _emailTextController,
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
                        Expanded(
                          flex: 3,
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
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: TextField(
                              autofocus: false,
                              controller: _confirmPassTextController,
                              obscureText: _hideConfirmPass,
                              onChanged: (value) {
                                _confirmPassword = value;
                              },
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      if (!mounted) return;
                                      setState(() {
                                        _hideConfirmPass = !_hideConfirmPass;
                                      });
                                    },
                                    icon: _hideConfirmPass
                                        ? Icon(
                                            Icons.visibility,
                                            color: Color(0xff828282),
                                          )
                                        : Icon(
                                            Icons.visibility_off,
                                            color: Color(0xffEFA921),
                                          ),
                                  ),
                                  hintText: 'ПОДТВЕРДИТЕ ПАРОЛЬ',
                                  filled: true,
                                  errorText: _showError
                                      ? 'wrong email or password'
                                      : null,
                                  hintStyle: TextStyle(fontSize: 12.sp),
                                  fillColor: Colors.white70,
                                  prefixIcon: Icon(Icons.lock_outline)),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 24.h),
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
                                        if (_emailTextController
                                                .text.isNotEmpty &&
                                            _nameTextController
                                                .text.isNotEmpty &&
                                            _passTextController
                                                .text.isNotEmpty &&
                                            _confirmPassTextController
                                                .text.isNotEmpty) {
                                          try {
                                            final response = await Registration(
                                                    email: _email,
                                                    username: _name,
                                                    password1: _password,
                                                    password2: _confirmPassword)
                                                .register();
                                            if (response.statusCode >= 200 &&
                                                response.statusCode < 203) {
                                              String source = Utf8Decoder()
                                                  .convert(response.bodyBytes);
                                              showAlertDialog(
                                                  context,
                                                  jsonDecode(
                                                          source)['detail'] ??
                                                      'null',
                                                  true,
                                                  _email);
                                              _nameTextController.clear();
                                              _emailTextController.clear();
                                              _passTextController.clear();
                                              _confirmPassTextController
                                                  .clear();
                                            } else {
                                              setState(() {
                                                String source = Utf8Decoder()
                                                    .convert(
                                                        response.bodyBytes);
                                                showAlertDialog(
                                                    context,
                                                    jsonDecode(
                                                            source)['detail'] ??
                                                        'Invalid username',
                                                    false,
                                                    '');
                                              });
                                            }
                                          } catch (e) {
                                            showAlertDialog(context,
                                                e.toString(), false, '');
                                          }
                                        } else {
                                          setState(() {
                                            showAlertDialog(
                                                context,
                                                'Please, fill in the fields',
                                                false,
                                                '');
                                          });
                                        }
                                        if (!mounted) return;
                                        setState(() {
                                          _isButtonDisabled = false;
                                          _isLoading = false;
                                        });
                                      },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: Color(0xffEFA921),
                                child: Text(
                                  'ЗАРЕГИСТРИРОВАТЬСЯ',
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff222222),
                                      letterSpacing: -0.3),
                                )),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: FlatButton(
                                  onPressed: () {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Войти',
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
                  Expanded(flex: 1.w.toInt(), child: Container()),
                ],
              ),
            ),
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xff4A62AA))))
              : Container()
        ],
      )),
    );
  }
}
