import 'package:http/http.dart' as http;
import 'package:plyushka/classes/meal.dart';
import 'dart:convert';
import 'package:plyushka/classes/school.dart';
import 'package:plyushka/classes/transportMen.dart';
import 'package:flutter/material.dart';
import 'package:plyushka/screens/menuPage.dart';

String tokenString;
String refreshTokenString;
String nameInData;
int globalSchoolId;
Function logOutInData = () => print('Log Out In Data');
Function addTokenInData = () => print('Add Token In Data');
String root = 'http://papi.trapezza.kz/api/';

Future<List<School>> fetchSchools(BuildContext context) async {
  final response = await http.get(root + '/schools/');

  if (response.statusCode == 200 ||
      response.statusCode == 201 ||
      response.statusCode == 202) {
    String source = Utf8Decoder().convert(response.bodyBytes);
    var jsonData = jsonDecode(source);
    List schoolsList = jsonData['data'];
    List<School> schools = [];
    for (var school in schoolsList) {
      School s = School(
        id: school['id'],
        title: school['name'],
      );
      schools.add(s);
    }
    return schools;
  } else {
    throw Exception('schools ' + response.statusCode.toString());
  }
}

class Dates {
  final int id;
  Dates({@required this.id});
  Future getData() async {
    http.Response response =
        await http.get(root + '/datesByschool/' + id.toString());
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      return jsonDecode(source);
    } else {
      print('dates ' + response.statusCode.toString());
    }
  }
}

//Future<List<Date>> fetchDates(BuildContext context, int id) async {
//  final response = await http.get(root + '/datesByschool/' + id.toString());
//
//  if (response.statusCode == 200 ||
//      response.statusCode == 201 ||
//      response.statusCode == 202) {
//    String source = Utf8Decoder().convert(response.bodyBytes);
//    var jsonData = jsonDecode(source);
//    List datesList = jsonData['data'];
//    List<Date> dates = [];
//    for (var date in datesList) {
//      Date s = Date(
//        id: date['id'],
//        name: date['name'],
//        week: date['week'],
//        date: date['date'],
//        today: date['today'],
//      );
//      dates.add(s);
//    }
//    return dates;
//  } else {
//    throw Exception('schools ' + response.statusCode.toString());
//  }
//}

class IngredientsGetter {
  final int id;
  IngredientsGetter({@required this.id});
  Future getData() async {
    http.Response response =
        await http.get(root + '/getIngredient/' + id.toString());
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      return jsonDecode(source);
    } else {
      print('ingredient ' + response.statusCode.toString());
    }
  }
}

class Login {
  String email;
  String password;
  Login({this.email, @required this.password});
  Future login() async {
    http.Response response =
        await http.post("http://papi.trapezza.kz/user/login/", body: {
      'email': email,
      'password': password,
    });
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      return response;
    } else {
      print(response.statusCode);
      return response;
    }
  }
}

class Refresh {
  Future refresh() async {
    http.Response response = await http.post(
        "http://papi.trapezza.kz/user/token/refresh/",
        body: {'refresh': refreshTokenString});
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      tokenString = jsonDecode(source)['access'];
      return response;
    } else {
      print(response.statusCode);
      return response;
    }
  }
}

class Registration {
  String email;
  String username;
  String password1;
  String password2;
  Registration(
      {@required this.email,
      this.username = '',
      @required this.password1,
      @required this.password2});
  Future register() async {
    http.Response response =
        await http.post("http://papi.trapezza.kz/user/registration/", body: {
      'email': email,
      'username': username,
      'password1': password1,
      'password2': password2,
    });
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      return response;
    } else {
      print(response.statusCode);
      return response;
    }
  }
}

class EmailValidate {
  String email;
  EmailValidate({@required this.email});
  Future validate() async {
    http.Response response = await http
        .post("http://papi.trapezza.kz/user/validate_user_email/", body: {
      'email': email,
      'save': 'True',
    });
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      return response;
    } else {
      print(response.statusCode);
      return response;
    }
  }
}

class ForgotPasswordData {
  String email;
  String newPass;
  String confPass;
  ForgotPasswordData(
      {@required this.email, @required this.newPass, @required this.confPass});
  Future validate() async {
    http.Response response =
        await http.post("http://papi.trapezza.kz/user/forgot_password/", body: {
      'email': email,
      'password1': newPass,
      'password2': confPass,
    });
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      return response;
    } else {
      print(response.statusCode);
      return response;
    }
  }
}

class EmailConfirm {
  String email;
  String code;
  EmailConfirm({@required this.email, @required this.code});
  Future confirm() async {
    http.Response response = await http
        .put("http://papi.trapezza.kz/user/validate_user_email/", body: {
      'email': email,
      'otp': code,
    });
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      return response;
    } else {
      print(response.statusCode);
      return response;
    }
  }
}

class ChangePassword {
  final String password;
  final String password1;
  final String password2;
  BuildContext context;
  ChangePassword({this.password, this.password1, this.password2, this.context});
  Future putData() async {
    http.Response response =
        await http.put("http://papi.trapezza.kz/user/profile/", headers: {
      'Authorization': 'Bearer $tokenString',
    }, body: {
      'password': password,
      'password1': password1,
      'password2': password2,
    });
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      return jsonDecode(source);
    } else if (response.statusCode == 401) {
      await Refresh().refresh();
      http.Response response =
          await http.put("http://papi.trapezza.kz/user/profile/", headers: {
        'Authorization': 'Bearer $tokenString',
      }, body: {
        'password': password,
        'password1': password1,
        'password2': password2,
      });
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        String source = Utf8Decoder().convert(response.bodyBytes);
        return jsonDecode(source);
      }
      print(response.statusCode);
    } else {
      print(response.statusCode);
      String source = Utf8Decoder().convert(response.bodyBytes);
      return jsonDecode(source);
    }
  }
}

class ChangeProfile {
  final String username;
  final String password;
  BuildContext context;
  ChangeProfile({this.username, this.password, this.context});
  Future putData() async {
    http.Response response =
        await http.put("http://papi.trapezza.kz/user/profile/", headers: {
      'Authorization': 'Bearer $tokenString',
    }, body: {
      'username': username,
      'password': password,
    });
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      return jsonDecode(source);
    } else if (response.statusCode == 401) {
      await Refresh().refresh();
      http.Response response =
          await http.put("http://papi.trapezza.kz/user/profile/", headers: {
        'Authorization': 'Bearer $tokenString',
      }, body: {
        'username': username,
        'password': password,
      });

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        String source = Utf8Decoder().convert(response.bodyBytes);
        return jsonDecode(source);
      }
      print(response.statusCode);
    } else {
      print(response.statusCode);
      String source = Utf8Decoder().convert(response.bodyBytes);
      return jsonDecode(source);
    }
  }
}

class CreateForm {
  String fio_1;
  String phoneNumber;
  String fio_2;
  String description;
  int schoolId;
  CreateForm(
      {this.fio_1,
      this.phoneNumber,
      this.fio_2,
      this.description,
      this.schoolId});
  Future create() async {
    http.Response response = await http.post(root + 'forms/create/', body: {
      "fio_1": fio_1,
      "phone_number": phoneNumber,
      "fio_2": fio_2,
      "description": description,
      "school": schoolId.toString()
    });
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      print(source);
      return response;
    } else {
      print(response.statusCode);
      return response;
    }
  }
}

Future<List<TransportMen>> fetchTransportMen(BuildContext context) async {
  final response = await http.get(root + '/getDelivery/');

  if (response.statusCode == 200 ||
      response.statusCode == 201 ||
      response.statusCode == 202) {
    String source = Utf8Decoder().convert(response.bodyBytes);
    var jsonData = jsonDecode(source);
    List transportMenList = jsonData['data'];
    List<TransportMen> transportMen = [];
    for (var TransportMan in transportMenList) {
      TransportMen s = TransportMen(
        id: TransportMan['id'],
        fio: TransportMan['fio'].toString(),
        img: 'http://papi.trapezza.kz/' + TransportMan['img'].toString(),
        experience: TransportMan['experience'].toString(),
        description: TransportMan['description'].toString(),
      );
      transportMen.add(s);
    }
    return transportMen;
  } else {
    throw Exception('transportMen ' + response.statusCode.toString());
  }
}

Future<List<Meal>> fetchTables(
    BuildContext context, int school, int day) async {
  final response = await http
      .get(root + '/getmenu/' + school.toString() + '/' + day.toString());

  if (response.statusCode == 200 ||
      response.statusCode == 201 ||
      response.statusCode == 202) {
    String source = Utf8Decoder().convert(response.bodyBytes);
    var jsonData = jsonDecode(source);
    List mealList = jsonData['data'];
    List<Meal> meals = [];
    for (var meal in mealList) {
      Meal s = Meal(
        id: meal['id'],
        name: meal['name'].toString(),
        imageUrl: 'http://papi.trapezza.kz/' + meal['img'].toString(),
        description: meal['description'].toString(),
      );
      meals.add(s);
    }
    return meals;
  } else {
    throw Exception('fetchTables ' + response.statusCode.toString());
  }
}

Future<List<Meal>> fetchMeals(BuildContext context, int id) async {
  final response = await http.get(root + '/getfoods/' + id.toString());

  if (response.statusCode == 200 ||
      response.statusCode == 201 ||
      response.statusCode == 202) {
    String source = Utf8Decoder().convert(response.bodyBytes);
    var jsonData = jsonDecode(source);
    List mealList = jsonData['data'];
    List<Meal> meals = [];
    foodsByType.forEach((key, value) {
      foodsByType[key].clear();
    });
    for (var meal in mealList) {
      Meal s = Meal(
        id: meal['id'],
        name: meal['name'].toString(),
        description: meal['description'].toString(),
        imageUrl: 'http://papi.trapezza.kz/' + meal['img'].toString(),
        price: meal['price'],
        hasCertificate: meal['certificate'],
        categoryId: meal['category']['id'],
        categoryName: meal['category']['name'],
      );
      foodsByType[meal['category']['id']].add(s);
      meals.add(s);
    }
    return meals;
  } else {
    throw Exception('fetchMeals ' + response.statusCode.toString());
  }
}

class VideoLinkGetter {
  final int id;
  VideoLinkGetter({@required this.id});
  Future getData() async {
    http.Response response =
        await http.get(root + '/getVideoURL/' + id.toString());
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      return jsonDecode(source);
    } else {
      print('VideoLinkGetter ' + response.statusCode.toString());
    }
  }
}
