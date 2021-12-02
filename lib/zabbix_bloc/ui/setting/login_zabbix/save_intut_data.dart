import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _preferences;
  static const _keyUsername = 'login';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  static Future setUsername(String username) async =>
      await _preferences.setString(_keyUsername, username);

  static String? getUsername() => _preferences.getString(_keyUsername);

}


class UrlApiPreferences {
  static late SharedPreferences _preferences;
  static const _keyUrlApi = 'url';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  static Future setUrlApi(String urlApi) async =>
      await _preferences.setString(_keyUrlApi, urlApi);

  static String? getUrlApi() => _preferences.getString(_keyUrlApi);

}


class PasswordPreferences {
  static late SharedPreferences _preferences;
  static const _keyPassword = 'password';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  static Future setPassword(String password) async =>
      await _preferences.setString(_keyPassword, password);

  static String? getPassword() => _preferences.getString(_keyPassword);

}


class SelectPriorityProblemsPreferences {
  static late SharedPreferences _preferences;
  static const _keySelectPriorityProblems = 'selectPriorityProblem';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  static Future setSelectPriorityProblems(String selectPriorityProblems) async =>
      await _preferences.setString(_keySelectPriorityProblems, selectPriorityProblems);
  static String? getSelectPriorityProblems() => _preferences.getString(_keySelectPriorityProblems);

}


class SelectPrioritySystemStatusPreferences {
  static late SharedPreferences _preferences;
  static const _keySelectPrioritySystemStatus = 'selectPrioritySystemStatus';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  static Future setSelectPrioritySystemStatus(String selectPrioritySystemStatus) async =>
      await _preferences.setString(_keySelectPrioritySystemStatus, selectPrioritySystemStatus);
  static String? getSelectPrioritySystemStatus() => _preferences.getString(_keySelectPrioritySystemStatus);

}


class AutoRefreshPreferences {
  static late SharedPreferences _preferences;
  static const _keyAutoRefresh = 'autoRefresh';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  static Future setAutoRefresh(String autoRefresh) async =>
      await _preferences.setString(_keyAutoRefresh, autoRefresh);
  static String? getAutoRefresh() => _preferences.getString(_keyAutoRefresh);

}


class IsCheckedAutoRefreshPreferences {
  static late SharedPreferences _preferences;
  static const _keyIsCheckedAutoRefresh = 'isCheckedAutoRefresh';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  static Future setIsCheckedAutoRefresh(bool isCheckedAutoRefresh) async =>
      await _preferences.setBool(_keyIsCheckedAutoRefresh, isCheckedAutoRefresh);
  static bool? getIsCheckedAutoRefresh() => _preferences.getBool(_keyIsCheckedAutoRefresh);

}


class LanguagePreferences {
  static late SharedPreferences _preferences;
  static const _keyLanguage = 'language';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  static Future setLanguage(String language) async =>
      await _preferences.setString(_keyLanguage, language);
  static String? getLanguage() => _preferences.getString(_keyLanguage);

}


class ListUserPreferences {
  static late SharedPreferences _preferences;
  static const _keyListUsername = 'listLogin';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  static Future setListUsername(String listUsername) async =>
      await _preferences.setString(_keyListUsername, listUsername);

  static String? getListUsername() => _preferences.getString(_keyListUsername);

}


class ListUrlApiPreferences {
  static late SharedPreferences _preferences;
  static const _keyListUrlApi = 'listUrls';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  static Future setListUrlApi(String listUrlApi) async =>
      await _preferences.setString(_keyListUrlApi, listUrlApi);

  static String? getListUrlApi() => _preferences.getString(_keyListUrlApi);

}


class ListPasswordPreferences {
  static late SharedPreferences _preferences;
  static const _keyListPassword = 'listPassword';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  static Future setListPassword(String listPassword) async =>
      await _preferences.setString(_keyListPassword, listPassword);

  static String? getListPassword() => _preferences.getString(_keyListPassword);

}


class ListServerZabbixPreferences {
  static late SharedPreferences _preferences;
  static const _keyListServerZabbix = 'listServerZabbix';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  static Future setListServer(int listServer) async =>
      await _preferences.setInt(_keyListServerZabbix, listServer);

  static int? getListServer() => _preferences.getInt(_keyListServerZabbix);

}


class ListPriorityProblemsPreferences {
  static late SharedPreferences _preferences;
  static const _keyListPriorityProblems = 'listPriorityProblem';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  static Future setListPriorityProblems(String listPriorityProblems) async =>
      await _preferences.setString(_keyListPriorityProblems, listPriorityProblems);
  static String? getListPriorityProblems() => _preferences.getString(_keyListPriorityProblems);

}


class ListPrioritySystemStatusPreferences {
  static late SharedPreferences _preferences;
  static const _keyListPrioritySystemStatus = 'listPrioritySystemStatus';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  static Future setListPrioritySystemStatus(String listPrioritySystemStatus) async =>
      await _preferences.setString(_keyListPrioritySystemStatus, listPrioritySystemStatus);
  static String? getListPrioritySystemStatus() => _preferences.getString(_keyListPrioritySystemStatus);

}

