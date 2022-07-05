import 'dart:convert';

import 'package:dotenv/dotenv.dart';
import 'package:flutter/material.dart';

class DataConstants {
  late final DotEnv _dotEnv;
  DotEnv get dotEnv => _dotEnv;

  late Map<String, String> _coreHeader;
  Map<String, String> get coreHeader => _coreHeader;

  static final DataConstants _instance = DataConstants._internal();
  factory DataConstants() => _instance;

  DataConstants._internal() {
    _dotEnv = DotEnv(includePlatformEnvironment: true)..load();
    _coreHeader = {
      'Content-Type': 'application/json',
      'Authorization': _dotEnv['PEXEL_API_KEY']!,
    };
    debugPrint('DataConstants: PEXEL_API_KEY ${_dotEnv['PEXEL_API_KEY']}');
    debugPrint('DataConstants: _coreHeader: ${jsonEncode(_coreHeader)}');
  }

  // API Endpoints
  static const String _baseUrl = 'https://api.pexels.com/v1';
  static const String _videoBaseUrl = 'https://www.pexels.com/videos/';

  // Photos endpoint
  static String get curatedPhotosUrl => '$_baseUrl/curated/';
  static String get getPhotoUrl => '$_baseUrl/photos/';
  static String get searchPhotoUrl => '$_baseUrl/search/';

  // Videos endpoint
  static String get curatedVideosUrl => '$_videoBaseUrl/videos';
}

class PrefConstants {
  static const String authUser = 'auth_user';
  static const String authUsers = 'auth_users';
}

class UIConstants {
  static const TextStyle fieldHintStyle = TextStyle(fontWeight: FontWeight.w300, color: Colors.black);
  static const String appName = "Pexel API - Demo";
  static const double progressBarOpacity = 0.6;
  static const Color progressBarColor = Colors.black;
}
