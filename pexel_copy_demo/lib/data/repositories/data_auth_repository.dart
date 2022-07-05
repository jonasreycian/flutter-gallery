import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:faker/faker.dart';

import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../utils/constants.dart';

class DataAuthRepository implements AuthRepository {
  static DataAuthRepository _instance = DataAuthRepository._();
  late Logger _logger;
  late Future<SharedPreferences> _sharedPreferences;
  late Faker _faker;

  late AuthUser _authUser;
  AuthUser get authUser => _authUser;

  DataAuthRepository._() {
    _logger = Logger('DataAuthRepository');
    _sharedPreferences = SharedPreferences.getInstance();
    _faker = Faker();
  }

  factory DataAuthRepository() => _instance;

  @override
  Future<AuthUser?> getAuthUser() async {
    try {
      final pref = await _sharedPreferences;
      final userJson = pref.getString(PrefConstants.authUser);

      if (userJson == null) {
        _logger.severe('getAuthUser: No user found in the database.');
        return null;
      }

      final user = AuthUser.fromJson(jsonDecode(userJson));
      _logger.finest('getAuthUser: User found in the database.');
      return Future.value(user);
    } catch (e) {
      _logger.severe('getAuthUser: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<void> login(String email, String password) async {
    try {
      List<AuthUser> users = await _getCurrentUsers();
      AuthUser user = users.firstWhere((u) => u.email == email && u.password == password, orElse: () => const AuthUser.empty());
      if (user == const AuthUser.empty()) {
        _logger.severe('login: No user found in the database.');
        throw Exception('No user found in the database.');
      }
      _authUser = user;

      _saveCredentials(PrefConstants.authUser, jsonEncode(user.toJson()), PreferenceType.string);
    } catch (e) {
      _logger.severe('login: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      final pref = await _sharedPreferences;
      pref.remove(PrefConstants.authUser);
    } catch (e) {
      _logger.severe('logout: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<void> register(String email, String password, String? name) async {
    try {
      List<AuthUser> currentUsers = await _getCurrentUsers();

      if (currentUsers.isNotEmpty) {
        AuthUser user = currentUsers.singleWhere(
          (e) => e.email == email && e.password == password && e.name == name,
          orElse: () => const AuthUser.empty(),
        );
        if (user != const AuthUser.empty()) {
          throw Exception('User already exists');
        }
      }

      _authUser = AuthUser(_faker.guid.guid(), email, password, name: name);
      currentUsers.add(_authUser);
      _saveCredentials(PrefConstants.authUsers, jsonEncode(currentUsers.map((e) => e.toJson()).toList()), PreferenceType.string);
      _logger.finest('register: User registered.');
    } catch (e) {
      _logger.severe('register: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> _saveCredentials(String key, String value, PreferenceType type) async {
    try {
      final pref = await _sharedPreferences;
      switch (type) {
        case PreferenceType.string:
          pref.setString(key, jsonEncode(value));
          break;
        case PreferenceType.bool:
          pref.setBool(key, value == 'true');
          break;
        default:
          throw Exception('Unknown preference type');
      }
      _logger.finest('Saved $key: ${jsonEncode(value)}');
    } catch (e) {
      _logger.severe('Error saving credentials: $e');
      rethrow;
    }
  }

  Future<List<AuthUser>> _getCurrentUsers() async {
    try {
      final pref = await _sharedPreferences;
      final usersJson = pref.getString(PrefConstants.authUsers);

      if (usersJson == null) return [];

      final users = (jsonDecode(usersJson) as List<dynamic>).map((e) => AuthUser.fromJson(e)).toList();
      return users;
    } catch (e) {
      _logger.severe('getCurrentUsers: ${e.toString()}');
      rethrow;
    }
  }
}

enum PreferenceType {
  string,
  bool,
}
