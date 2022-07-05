import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'api_exception.dart';

class HttpHelper {
  static Future<Map<String, dynamic>> invokeHttp(
    String url,
    RequestType type, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    http.Response response;
    try {
      response = await _invoke(url, type, headers: headers, body: body, encoding: encoding);
    } catch (e) {
      rethrow;
    }
    return jsonDecode(response.body);
  }

  static Future<List<dynamic>> invokeHttp2(
    String url,
    RequestType type, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    http.Response response;
    try {
      response = await _invoke(url, type, headers: headers, body: body, encoding: encoding);
    } catch (e) {
      rethrow;
    }
    return jsonDecode(response.body);
  }

  static Future<http.Response> _invoke(
    dynamic url,
    RequestType type, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    http.Response response;

    try {
      switch (type) {
        case RequestType.get:
          response = await http.get(url, headers: headers);
          break;
        case RequestType.post:
          response = await http.post(url, headers: headers, body: body, encoding: encoding);
          break;
        case RequestType.put:
          response = await http.put(url, headers: headers, body: body, encoding: encoding);
          break;
        case RequestType.patch:
          response = await http.patch(url, headers: headers, body: body, encoding: encoding);
          break;
        case RequestType.delete:
          response = await http.delete(url, headers: headers, encoding: encoding);
          break;
      }

      if (response.statusCode != 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
        throw ApiException(statusCode: response.statusCode, message: jsonEncode(body['data']));
      }
      return response;
    }
    // Handle 404
    on http.ClientException catch (_) {
      rethrow;
    }
    // Handle no internet connection
    on SocketException catch (e) {
      throw Exception(e.osError?.message);
    } catch (e) {
      rethrow;
    }
  }
}

enum RequestType { get, post, put, patch, delete }
