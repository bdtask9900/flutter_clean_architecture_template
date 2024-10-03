import 'package:shared_preferences/shared_preferences.dart';
abstract class ISharedPreferencesService {
  Future<void> saveString(String key, String value);
  Future<String?> getString(String key);
  Future<void> saveInt(String key, int value);
  Future<int?> getInt(String key);
  Future<void> saveBool(String key, bool value);
  Future<bool?> getBool(String key);
  Future<void> remove(String key);
  Future<void> clear();
}
class StorageService  implements ISharedPreferencesService{
 static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();
//  static StorageService getInstance() {
//     return _instance;
//   }
  static StorageService get instance => _instance;
  // Future<SharedPreferences> get _prefs async => await SharedPreferences.getInstance();
 
 late SharedPreferences prefs;
 Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

// static Future<void> saveMultiple(Map<String, dynamic> values) async {
//     final prefs = await SharedPreferences.getInstance();
//     for (var entry in values.entries) {
//       if (entry.value is String) {
//         await prefs.setString(entry.key, entry.value);
//       } else if (entry.value is int) {
//         await prefs.setInt(entry.key, entry.value);
//       } else if (entry.value is bool) {
//         await prefs.setBool(entry.key, entry.value);
//       } else if (entry.value is double) {
//         await prefs.setDouble(entry.key, entry.value);
//       } else if (entry.value is List<String>) {
//         await prefs.setStringList(entry.key, entry.value);
//       }
//     }
//   }
  //  Future<void> saveData(String key, String value) async {
  //  final prefs = await _prefs;
  //   await prefs.setString(key, value);
  // }

  // Future<String?> getData(String key) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(key);
  // }
   

  // Future<void> save<T>(String key, T value) async {
  //    final _prefs = await SharedPreferences.getInstance();
  //   if (value is String) {
  //     await _prefs.setString(key, value);
  //   } else if (value is int) {
  //     await _prefs.setInt(key, value);
  //   } else if (value is bool) {
  //     await _prefs.setBool(key, value);
  //   } else if (value is double) {
  //     await _prefs.setDouble(key, value);
  //   } else if (value is List<String>) {
  //     await _prefs.setStringList(key, value);
  //   } else {
  //     throw Exception("Unsupported type");
  //   }
  // }

  // Future<T?> get<T>(String key)async {
  //   final _prefs = await SharedPreferences.getInstance();
  //   if (T == String) {
  //     return _prefs.getString(key) as T?;
  //   } else if (T == int) {
  //     return _prefs.getInt(key) as T?;
  //   } else if (T == bool) {
  //     return _prefs.getBool(key) as T?;
  //   } else if (T == double) {
  //     return _prefs.getDouble(key) as T?;
  //   } else if (T == List<String>) {
  //     return _prefs.getStringList(key) as T?;
  //   } else {
  //     throw Exception("Unsupported type");
  //   }
  // }
  @override
  Future<void> saveString(String key, String value) async {
    // final prefs = await _prefs;
    await prefs.setString(key, value);
  }

  @override
  Future<String?> getString(String key) async {
    // final prefs = await _prefs;
    return prefs.getString(key);
  }

  @override
  Future<void> saveInt(String key, int value) async {
    // final prefs = await _prefs;
    await prefs.setInt(key, value);
  }

  @override
  Future<int?> getInt(String key) async {
    // final prefs = await _prefs;
    return prefs.getInt(key);
  }

  @override
  Future<void> saveBool(String key, bool value) async {
    // final prefs = await _prefs;
    await prefs.setBool(key, value);
  }

  @override
  Future<bool?> getBool(String key) async {
    // final prefs = await _prefs;
    return prefs.getBool(key);
  }

  @override
  Future<void> remove(String key) async {
    // final prefs = await _prefs;
    await prefs.remove(key);
  }

  @override
  Future<void> clear() async {
    // final prefs = await _prefs;
    await prefs.clear();
  }
}
