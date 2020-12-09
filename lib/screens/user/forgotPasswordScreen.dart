import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plyushka/data/data.dart';
import 'package:plyushka/screens/user/forgotPassCodeScreen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String id = 'forgotPassword_screen';

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailTextController = TextEditingController();
  bool checkedValue = false;
  String _email;
  bool _isButtonDisabled;
  bool _isLoading;
  bool _showError;

  showAlertDialog(
      BuildContext context, String detail, bool success, String _email) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        Navigator.pop(context);
        if (success) {
          Navigator.pushNamed(context, ForgotPassCodeScreen.id,
              arguments: {'email': _email});
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
    _isLoading = false;
    _isButtonDisabled = false;
    _showError = false;
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
                              'Забыли Пароль?',
                              style: TextStyle(
                                  fontSize: 36.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff222222)),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
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
                                  errorText:
                                      _showError ? 'wrong email or code' : null,
                                  hintStyle: TextStyle(fontSize: 14.sp),
                                  fillColor: Colors.white70,
                                  prefixIcon:
                                      Icon(Icons.mail_outline_outlined)),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
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
                                            .text.isNotEmpty) {
                                          try {
                                            final response =
                                                await EmailValidate(
                                              email: _email,
                                            ).validate();
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
                                              _emailTextController.clear();
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
                                  'ОТПРАВИТЬ',
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
                              child: Container(),
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
