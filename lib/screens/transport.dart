import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plyushka/classes/transportMen.dart';
import 'package:plyushka/components/myDrawer.dart';
import 'package:plyushka/components/transportManCard.dart';
import 'dart:ui';
import 'package:plyushka/data/data.dart';

class TransportScreen extends StatefulWidget {
  static const String id = 'transport_screen';
  @override
  _TransportScreenState createState() => _TransportScreenState();
}

class _TransportScreenState extends State<TransportScreen> {
  Future<List<TransportMen>> futureTransportMenList;
  bool loading = false;
  bool _hasData = true;

  @override
  void dispose() {
    super.dispose();
    loading = false;
    _hasData = true;
  }

  @override
  void initState() {
    super.initState();
    futureTransportMenList = fetchTransportMen(context);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    return Scaffold(
      drawer: MyDrawer(inTransport: true),
      backgroundColor: Color(0xffFDFDFD),
      appBar: AppBar(
        title: Text(
          'Развозка',
          style: TextStyle(
              color: Color(0xff222222),
              fontSize: 18.sp,
              fontWeight: FontWeight.w400),
        ),
        elevation: 0,
        backgroundColor: Color(0xffFDFDFD),
      ),
      body: _hasData
          ? Stack(
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 6.h.toInt(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex: 20,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    'Данная услуга для тех родителей, которые хотят быть уверенными в том, что ребенок безопасно доберется до места назначения. Мы ежедневно будем отвозить детей на занятия и забирать из школы.',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color:
                                            Color(0xff222222).withOpacity(0.9),
                                        fontSize: 14.sp),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 9,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      Text(
                                        'Цена: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14.sp),
                                      ),
                                      Text(
                                        'от 10000тг/месяц',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 9,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Text(
                                    'Наши Водители',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color:
                                            Color(0xff222222).withOpacity(0.9),
                                        fontSize: 16.sp),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 15.h.toInt(),
                        child: FutureBuilder<List<TransportMen>>(
                          future: futureTransportMenList,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                itemBuilder: (context, index) {
                                  return TransportManCard(
                                    id: snapshot.data[index].id,
                                    fio: snapshot.data[index].fio,
                                    img: snapshot.data[index].img,
                                    experience: snapshot.data[index].experience,
                                    description:
                                        snapshot.data[index].description,
                                  );
                                },
                                itemCount: snapshot.data.length,
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text(
                                "Список водителей пуст".toUpperCase(),
                                style: TextStyle(
                                    color: Color(0xff222222),
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700),
                              ));
                            }
                            // By default, show a loading spinner.
                            return Center(
                                child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xffEFA921))));
                          },
                        ),
                      )
                    ]),
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
