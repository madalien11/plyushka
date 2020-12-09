import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plyushka/components/myDrawer.dart';
import 'dart:ui';
import 'firstForm.dart';
import 'secondForm.dart';

//TODO: errors

class ApplicationScreen extends StatefulWidget {
  static const String id = 'application_screen';
  @override
  _ApplicationScreenState createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  bool firstForm = true;
  bool loading = false;
  bool _hasData = true;
  // bool firstItemPressed = false;
  int initialLabelIndex = 0;
  // double minWidth = 150.w;

  showAlertDialog(BuildContext context, String detail) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
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

  String validateMobile(String value) {
    // +7777 777 77 77 or 8777 777 77 77
    String pattern = r'(^([+7][7][0-9]{10}|[8][7][0-9]{9})$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  void loader() {
    if (!mounted) return;
    setState(() {
      loading = !loading;
    });
  }

  @override
  void dispose() {
    super.dispose();
    loading = false;
    _hasData = true;
    // firstItemPressed = false;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    return Scaffold(
      drawer: MyDrawer(inApplications: true),
      backgroundColor: Color(0xffFDFDFD),
      appBar: AppBar(
        title: Text(
          'Подать заявку',
          style: TextStyle(
              color: Color(0xff222222),
              fontSize: 18.sp,
              fontWeight: FontWeight.w400),
        ),
        elevation: 0,
        backgroundColor: Color(0xffFDFDFD),
      ),
      body: _hasData
          ? GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Dismissible(
                  resizeDuration: null,
                  // ignore: missing_return
                  confirmDismiss: (direction) {
                    if (!mounted) return;
                    setState(() {
                      firstForm = direction == DismissDirection.endToStart
                          ? false
                          : true;
                      setState(() => initialLabelIndex = firstForm ? 0 : 1);
                    });
                  },
                  key: ValueKey(firstForm),
                  child: Stack(
                    children: [
                      ListView(
                        children: firstForm
                            ? [
                                FirstForm(
                                    validateMobile: validateMobile,
                                    showAlertDialog: showAlertDialog,
                                    firstForm: firstForm,
                                    transition: (bool newVal) {
                                      if (!mounted) return;
                                      setState(() {
                                        firstForm = newVal;
                                      });
                                    })
                              ]
                            : [
                                SecondForm(
                                    validateMobile: validateMobile,
                                    showAlertDialog: showAlertDialog,
                                    firstForm: firstForm,
                                    transition: (bool newVal) {
                                      if (!mounted) return;
                                      setState(() {
                                        firstForm = newVal;
                                      });
                                    })
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
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Color(0xffEFA921))))))
                          : Container()
                    ],
                  )),
            )
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
