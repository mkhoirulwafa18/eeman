import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// [LocalDataService] is a service to set data to local storage
/// and get the data from local storage
///
/// We can use [LocalDataService] to set the data to local storage like this:
/// ```
/// LocalDataService().setString('tokenKey', 'asd123');
/// ```
///
/// We can use [LocalDataService] to get the data from local storage like this:
/// ```
/// LocalDataService().getString('tokenKey');
/// ```
/// We can use [LocalDataService] to remove the data from local storage
/// like this:
/// ```
/// LocalDataService().remove('tokenKey');
/// ```
abstract class LocalDataService {
  Future<void> setString(String key, String value);

  Future<void> setStringList(String key, List<String> value);

  Future<List<dynamic>?> getStringList(String key);

  Future<String?> getString(String key);

  Future<void> remove(String key);
}

class LocalDataServiceImpl implements LocalDataService {
  LocalDataServiceImpl({required this.storage});

  final FlutterSecureStorage storage;

  @override
  Future<String?> getString(String key) async {
    return storage.read(key: key);
  }

  @override
  Future<void> setString(String key, String value) async {
    return storage.write(key: key, value: value);
  }

  @override
  Future<void> remove(String key) async {
    await storage.delete(key: key);

    return;
  }

  @override
  Future<void> setStringList(String key, List<String> value) {
    return storage.write(key: key, value: jsonEncode(value));
  }

  @override
  Future<List<dynamic>?> getStringList(String key) async {
    final result = await storage.read(key: key);
    return result != null ? jsonDecode(result) as List<dynamic> : [];
  }
}
