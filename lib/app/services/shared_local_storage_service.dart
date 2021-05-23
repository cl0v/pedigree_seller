import 'package:pedigree_seller/app/interfaces/local_storage_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedLocalStorageService implements ILocalStorage {
  @override
  Future delete(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  @override
  Future get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  @override
  Future put(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (value.runtimeType) {
      case String:
        print("é string po, bota aq sem dó");
        break;
      case bool:
        print("é bool po, bota aq sem dó");
        break;
    }
    if (value.runtimeType is String) return prefs.setString(key, value);
    if (value.runtimeType is int) return prefs.setInt(key, value);
    if (value.runtimeType is bool) return prefs.setBool(key, value);
    if (value.runtimeType is double) return prefs.setDouble(key, value);
    if (value.runtimeType is List<String>)
      return prefs.setStringList(key, value);
  }
}

class Prefs {
  static Future delete(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  static Future get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  static Future put(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (value.runtimeType) {
      case String:
        return prefs.setString(key, value);
      case bool:
        return prefs.setBool(key, value);
      case int:
        return prefs.setInt(key, value);
      case double:
        return prefs.setDouble(key, value);
      case List:
        return prefs.setStringList(key, value);
    }
    return null;
  }
}
