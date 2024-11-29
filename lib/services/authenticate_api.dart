import 'dart:convert';
import 'package:engineer/models/user_model.dart';
import 'package:engineer/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticateApi with ChangeNotifier {
  _setHeaders() {
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
  }

  Future<UserModel> login(String username, String password) async {
    final response = await http.get(
      Uri.parse(
          '$baseURLAPI/Credit/authen?username=$username&password=$password'),
      headers: _setHeaders(),
    );
    final prefs = await SharedPreferences.getInstance();
    if (response.statusCode == 200) {
      var result = await jsonDecode(response.body);
      prefs.setInt('employeeCode', result['EmployeeCode'] ?? 0);
      prefs.setString('firstname', result['Firstname'] ?? '');
      prefs.setString('lastname', result['LastName'] ?? '');
      prefs.setString('imageUrl', result['ImageUrl'] ?? '');
      //prefs.setString('siteid', result['SiteID'] ?? 0);
      notifyListeners();
      return userModelFromJson(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<UserModel> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return UserModel(
        firstname: prefs.getString('firstname') ?? '',
        lastname: prefs.getString('lastname') ?? '',
        employeeCode: prefs.getInt('employeeCode') ?? 0,
        imageUrl:
            'https://iot.pinepacific.com/picemp/${prefs.getString('imageUrl')}');
  }

  Future<List<Map<String, dynamic>>> getMachines() async {
    // เรียก API ที่เกี่ยวข้องเพื่อดึงข้อมูลเครื่องจักร
    final response = await http.get(Uri.parse(
        'https://iot.pinepacific.com/WebApi/api/PMMachine/GetMachine'));

    if (response.statusCode == 200) {
      // แปลงข้อมูล JSON ให้เป็น List ของ Map
      List<Map<String, dynamic>> machines =
          List<Map<String, dynamic>>.from(json.decode(response.body));
      return machines;
    } else {
      throw Exception('Failed to load machines');
    }
  }

  Future<bool> logout() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }
}
