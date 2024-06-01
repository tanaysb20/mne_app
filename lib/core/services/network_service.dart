import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_logger.dart';

class NetworkService {
  static Future<http.Response> get(
      {required String url, String? authToken}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String token = await prefs.getString("userToken") ?? '';
      //Headers
      Map<String, String> headers = {};
      headers['Accept'] = "application/json";
      headers['Content-Type'] = "application/json";
      headers['Connection'] = "keep-alive";
      headers['Authorization'] = authToken ?? '$token';
      http.Response response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      Logger().i(
        'REQ Headers: $headers\n'
        'RES Headers: ${response.request?.headers}\n'
        'REQUEST\n >> ${response.request}\n'
        'STATUS\n >> ${response.statusCode}\n'
        'BODY\n >> ${response.body}',
      );
      return response;
    } catch (e, stack) {
      AppLogger.e('Error on \n >> $url $e', stackTrace: stack);
      rethrow;
    }
  }

  static Future<http.Response> post(
      {required String url, required Map<String, dynamic> body}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String token = await prefs.getString("userToken") ?? '';
      //Headers
      Map<String, String> headers = {};
      headers['Accept'] = "application/json";
      headers['Content-Type'] = "application/json";
      headers['Connection'] = "keep-alive";
      headers['Authorization'] = '$token';

      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );
      Logger().i(
        'REQ Headers: $headers\n'
        'RES Headers: ${response.request?.headers}\n'
        'REQ BODY: $body\n'
        'REQUEST\n >> ${response.request}\n'
        'STATUS\n >> ${response.statusCode}\n'
        'BODY\n >> ${response.body}',
      );
      // ;
      return response;
    } catch (e, stack) {
      Logger().e('Error on \n >> $url', error: e, stackTrace: stack);
      rethrow;
      // throw Exception('---FAILED TO POST---');
    }
  }

  static Future<http.Response> put(
      {required String url, required Map<String, dynamic> body}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String token = await prefs.getString("userToken") ?? '';
      //Headers
      Map<String, String> headers = {};
      headers['Accept'] = "application/json";
      headers['Content-Type'] = "application/json";
      headers['Connection'] = "keep-alive";
      headers['Authorization'] = '$token';

      http.Response response = await http.put(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );
      Logger().i(
        'REQ Headers: $headers\n'
        'RES Headers: ${response.request?.headers}\n'
        'REQ BODY: $body\n'
        'REQUEST\n >> ${response.request}\n'
        'STATUS\n >> ${response.statusCode}\n'
        'BODY\n >> ${response.body}',
      );
      // ;
      return response;
    } catch (e, stack) {
      Logger().e('Error on \n >> $url', error: e, stackTrace: stack);
      rethrow;
    }
  }

  static Future<http.Response> patch(
      {required String url, required Map<String, dynamic> body}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String token = await prefs.getString("userToken") ?? '';
      //Headers
      Map<String, String> headers = {};
      headers['Accept'] = "application/json";
      headers['Content-Type'] = "application/json";
      headers['Connection'] = "keep-alive";
      headers['Authorization'] = '$token';

      http.Response response = await http.patch(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );
      Logger().i(
        'REQ Headers: $headers\n'
        'RES Headers: ${response.request?.headers}\n'
        'REQ BODY: $body\n'
        'REQUEST\n >> ${response.request}\n'
        'STATUS\n >> ${response.statusCode}\n'
        'BODY\n >> ${response.body}',
      );
      // ;
      return response;
    } catch (e, stack) {
      Logger().e('Error on \n >> $url', error: e, stackTrace: stack);
      rethrow;
    }
  }

  static Future<http.Response> delete({required String url}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String token = await prefs.getString("userToken") ?? '';
      //Headers
      Map<String, String> headers = {};
      headers['Accept'] = "application/json";
      headers['Content-Type'] = "application/json";
      headers['Connection'] = "keep-alive";
      headers['Authorization'] = '$token';

      http.Response response = await http.delete(
        Uri.parse(url),
        headers: headers,
      );
      Logger().i(
        'REQ Headers: $headers\n'
        'RES Headers: ${response.request?.headers}\n'
        'REQUEST\n >> ${response.request}\n'
        'STATUS\n >> ${response.statusCode}\n'
        'BODY\n >> ${response.body}',
      );
      return response;
    } catch (e, stack) {
      Logger().e('Error on \n >> $url', error: e, stackTrace: stack);
      rethrow;
    }
  }

  static Future<http.Response> uploadFile({
    required String url,
    required String filepath,
    String? uploadType,
  }) async {
    dynamic responseJson;
    try {
      final prefs = await SharedPreferences.getInstance();
      final String token = await prefs.getString("userToken") ?? '';
      //Headers
      Map<String, String> headers = {};
      //headers['Accept'] = "application/json";
      //headers['Content-Type'] = "application/json";
      headers['Connection'] = "keep-alive";
      headers['Authorization'] = '$token';

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          filepath,
        ),
      );

      request.fields.addAll({'uploadType': uploadType ?? 'profile'});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var httpResponse = await http.Response.fromStream(response);
      Logger().i(
        'REQ Headers: $headers\n'
        'RES Headers: ${httpResponse.request?.headers}\n'
        'REQ BODY: ${request.fields}\n'
        'REQUEST\n >> ${httpResponse.request}\n'
        'STATUS\n >> ${httpResponse.statusCode}\n'
        'BODY\n >> ${httpResponse.body}',
      );
      return httpResponse;
    } catch (e, stackTrack) {
      Logger().e('Error on \n >> $url', error: e, stackTrace: stackTrack);
      rethrow;
    }
  }

  static final client = http.Client();
}
