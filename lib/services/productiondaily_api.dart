import 'dart:convert';
import 'package:engineer/models/fatchgetlistmachine_model.dart';
import 'package:engineer/models/fatchlineproduction_model.dart';
import 'package:engineer/models/productiondaily_model.dart';
import 'package:engineer/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductionDropdownApi with ChangeNotifier {
  _setHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  Future<List<LineProductionModel>> fetchLineProductions() async {
    final response = await http.get(Uri.parse(
        'https://iot.pinepacific.com/WebApi/api/ProductionDaily/GetLineProduction'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData
          .map((json) => LineProductionModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load line productions');
    }
  }

  Future<List<Machine>> fetchgetlistline() async {
    final response = await http.get(Uri.parse(
        'https://iot.pinepacific.com/WebApi/api/ProductionDaily/GetListmc'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      print("Fetched data: $jsonData"); // เพิ่มการพิมพ์ข้อมูลที่ได้รับ
      return jsonData.map((json) => Machine.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load line productions');
    }
  }

  Future<List<Machine>> fetchMachines() async {
    final response = await http.get(Uri.parse('YOUR_API_URL'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      print("Fetched data: $data"); // เพิ่มบรรทัดนี้เพื่อดูข้อมูลที่ดึงมา
      return data.map((machineData) => Machine.fromJson(machineData)).toList();
    } else {
      throw Exception('Failed to load machines');
    }
  }
}

class SharedPreferencesHelper {
  // Save data to SharedPreferences (with mcID and Item)
  static Future<void> saveData(
      String mcID, String item, String value, String radioValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'mcID_$mcID$item', value); // Save value by mcID and Item
    await prefs.setString(
        'radio_$mcID$item', radioValue); // Save radio value by mcID and Item
  }

  // Load saved data from SharedPreferences (with mcID and Item)
  static Future<Map<String, String?>> loadSavedData(
      String mcID, String item) async {
    final prefs = await SharedPreferences.getInstance();
    final savedValue = prefs.getString('mcID_$mcID$item');
    final savedRadio = prefs.getString('radio_$mcID$item');
    return {
      'value': savedValue,
      'radio': savedRadio,
    };
  }
}
