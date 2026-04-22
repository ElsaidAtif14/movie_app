import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

Future<String> getCountryCode() async {
  try {
    // تحديد timeout عشان لو النت ضعيف الـ App ما يعلقش
    final response = await http
        .get(Uri.parse('http://ip-api.com/json'))
        .timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['countryCode'] ?? 'US'; // 
    }
  } catch (e) {
    debugPrint("IP-API Error: $e");
  }


  return Platform.localeName.split('_').last; 
}