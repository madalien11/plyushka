import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plyushka/data/data.dart';
import 'package:plyushka/components/schoolCard.dart';

//TODO: refactoring

class SecondForm extends StatefulWidget {
  final Function validateMobile;
  final Function showAlertDialog;
  final Function transition;
  final bool firstForm;
  SecondForm(
      {this.validateMobile,
      this.showAlertDialog,
      this.firstForm,
      this.transition});
  @override
  _SecondFormState createState() => _SecondFormState();
}

class _SecondFormState extends State<SecondForm> {
  bool _isButtonDisabled;
  final _fio1Controller = TextEditingController();
  final _fio2Controller = TextEditingController();
  final _phoneController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _fio1;
  String _fio2;
  String _phone;
  String _description;

  @override
  void dispose() {
    super.dispose();
    _isButtonDisabled = false;
  }

  @override
  void initState() {
    super.initState();
    _isButtonDisabled = false;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding:
              EdgeInsets.only(left: 16.w, right: 16.w, bottom: 40.h, top: 15.h),
          child: Container(
            height: 30.h,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xffEFA921),
                ),
                borderRadius: BorderRadius.all(Radius.circular(11))),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      widget.transition(true);
                      // if (!mounted) return;
                      // setState(() {
                      //   firstForm = true;
                      // });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: widget.firstForm
                              ? Color(0xffEFA921)
                              : Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                          child: Text(
                        'Форма 1',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: widget.firstForm ? Colors.white : Colors.black,
                        ),
                      )),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      widget.transition(false);
                      // if (!mounted) return;
                      // setState(() {
                      //   firstForm = false;
                      // });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: !widget.firstForm
                              ? Color(0xffEFA921)
                              : Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                          child: Text(
                        'Форма 2',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color:
                              !widget.firstForm ? Colors.white : Colors.black,
                        ),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: TextFormField(
              controller: _fio1Controller,
              onChanged: (str) {
                _fio1 = str;
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8.0),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xffEFA921).withOpacity(0.75)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xffEFA921).withOpacity(0.75)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: "ФИО Заполнителя 2",
                  labelStyle: TextStyle(
                      color: Color(0xff222222).withOpacity(0.7),
                      fontSize: 15.sp)),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: TextFormField(
              controller: _phoneController,
              onChanged: (str) {
                _phone = str;
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8.0),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xffEFA921).withOpacity(0.75)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xffEFA921).withOpacity(0.75)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: "Контакты Заполнителя 2",
                  labelStyle: TextStyle(
                      color: Color(0xff222222).withOpacity(0.7),
                      fontSize: 15.sp)),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: TextFormField(
              controller: _fio2Controller,
              onChanged: (str) {
                _fio2 = str;
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8.0),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xffEFA921).withOpacity(0.75)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xffEFA921).withOpacity(0.75)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: "ФИО Нуждающего 2",
                  labelStyle: TextStyle(
                      color: Color(0xff222222).withOpacity(0.7),
                      fontSize: 15.sp)),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: TextFormField(
              controller: _descriptionController,
              onChanged: (str) {
                _description = str;
              },
              minLines: 5,
              maxLines: 7,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8.0),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xffEFA921).withOpacity(0.75)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xffEFA921).withOpacity(0.75)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: "Полное описание случая 2",
                  labelStyle: TextStyle(
                      color: Color(0xff222222).withOpacity(0.7),
                      fontSize: 15.sp)),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: FlatButton(
              onPressed: _isButtonDisabled
                  ? () => {print('Sign In')}
                  : () async {
                      if (!mounted) return;
                      setState(() {
                        _isButtonDisabled = true;
                      });
                      FocusScope.of(context).requestFocus(new FocusNode());
                      if (_fio1Controller.text.isNotEmpty &&
                          _phoneController.text.isNotEmpty &&
                          _fio2Controller.text.isNotEmpty &&
                          _descriptionController.text.isNotEmpty &&
                          schoolId != null) {
                        if (widget.validateMobile(
                                _phone.replaceAll(new RegExp(r"\s+"), "")) ==
                            null) {
                          dynamic outcome = await CreateForm(
                                  fio_1: _fio1,
                                  phoneNumber:
                                      _phone.replaceAll(new RegExp(r"\s+"), ""),
                                  fio_2: _fio2,
                                  description: _description,
                                  schoolId: schoolId)
                              .create();
                          String source =
                              Utf8Decoder().convert(outcome.bodyBytes);
                          if (outcome.statusCode == 401) {
                            if (!mounted) return;
                            setState(() {
                              widget.showAlertDialog(
                                  context, jsonDecode(source)['detail']);
                              _isButtonDisabled = false;
                            });
                          } else if (outcome.statusCode == 200) {
                            if (!mounted) return;
                            setState(() {
                              widget.showAlertDialog(
                                  context, jsonDecode(source)['detail']);
                              _isButtonDisabled = false;
                            });
                            _fio1Controller.clear();
                            _phoneController.clear();
                            _fio2Controller.clear();
                            _descriptionController.clear();
                          }
                        } else {
                          if (!mounted) return;
                          setState(() {
                            widget.showAlertDialog(
                                context,
                                widget.validateMobile(
                                    _phone.replaceAll(new RegExp(r"\s+"), "")));
                            _isButtonDisabled = false;
                          });
                        }
                      } else {
                        if (!mounted) return;
                        setState(() {
                          widget.showAlertDialog(
                              context, 'Fields cannot be empty');
                          _isButtonDisabled = false;
                        });
                      }
                    },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Color(0xffEFA921),
              child: Text(
                'Отправить',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffffffff),
                ),
              )),
        ),
      ],
    );
  }
}
