import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  static const String baseURL = "http://192.168.43.23:8000/api";
  static Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json"
  };

  static Future<Map<String, dynamic>> get(
      {required String endPoint, String? token}) async {
    try {
      if (token != null) {
        headers.addAll({'Authorization': 'Bearer $token'});
      }
      Uri url = Uri.parse('$baseURL$endPoint');
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed to get data. Status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during GET request : $e');
    }
  }

  static Future<Map<String, dynamic>> pots(
      {required String endPoint,
      required Map<String, dynamic> data,
      @required String? token}) async {
    try {
      final Uri url = Uri.parse('$baseURL$endPoint');

      if (token != null) {
        headers.addAll({'Authorization': 'Bearer $token'});
      }

      final response =
          await http.post(url, headers: headers, body: jsonEncode(data));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed to create data. status code ${response.statusCode} with body ${jsonDecode(response.body)}');
      }
    } catch (e) {
      throw Exception('Error during the POST request : $e');
    }
  }

  static Future<Map<String, dynamic>> put(
      {required endPoint,
      required Map<String, dynamic> data,
      @required String? token}) async {
    try {
      final Uri url = Uri.parse('$baseURL$endPoint');

      if (token != null) {
        headers.addAll({'authorization': 'Bearer $token'});
      }

      final response =
          await http.post(url, headers: headers, body: jsonEncode(data));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed to update data. status code ${response.statusCode} with body ${jsonDecode(response.body)}');
      }
    } catch (e) {
      throw Exception('Error during PUT request $e');
    }
  }

  static Future<Map<String, dynamic>> delete(
      {required String endPoint, @required token}) async {
    try {
      final Uri url = Uri.parse('$baseURL$endPoint');

      if (token != null) {
        headers.addAll({'authorization': 'Bearer $token'});
      }
      final response = await http.delete(url, headers: headers);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed to delete data. status code ${response.statusCode} with body ${jsonDecode(response.body)}');
      }
    } catch (e) {
      throw Exception('Error during DELETE request $e');
    }
  }

  static Future<List<dynamic>> getList({
    required String endPoint,
    String? token,
  }) async {
    try {
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
      Uri url = Uri.parse('$baseURL$endPoint');
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        // Directly decode the list response
        return jsonDecode(response.body) as List<dynamic>;
      } else {
        throw Exception(
          'Failed to get data. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error during GET request: $e');
    }
  }

}
