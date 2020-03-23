// 提供五套可选主题色
import 'dart:collection';
import 'dart:convert';
import 'dart:html';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterlogin/models/cacheConfig.dart';
import 'package:flutterlogin/models/profile.dart';
import 'package:flutterlogin/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];

class Global {
  static SharedPreferences _prefs;
  static Profile profile = Profile();

  // 网络缓存对象
  static NetCache netCache = NetCache();

  //可选主题颜色
  static List<MaterialColor> get themes => _themes;

  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("profile");
    if (_profile != null) {
      try {
        Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    }

    profile.cache =
        profile.cache ?? CacheConfig(enable: true, maxAge: 3600, maxCount: 100);

    Git.init();
  }

  static saveProfile() =>
      _prefs.setString("profile", jsonEncode(profile.toJson()));
}

class ProfileChangeNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile();
    super.notifyListeners();
  }
}

class UserModel extends ProfileChangeNotifier {
  User get user => _profile.user;

  bool get isLogin => user != null;

  set user(User user) {
    if (user?.login != _profile.user?.login) {
      _profile.lastLogin = _profile.user?.login;
      _profile.user = user;
      notifyListeners();
    }
  }
}

class LocalModel extends ProfileChangeNotifier {
  Locale getLocal() {
    if (_profile.locale == null) return null;
    var t = _profile.locale.split("_");
    return Locale(t[0],t[1]);
  }

  String get locale => _profile.locale;

  set locale(String locale) {
    if (locale != _profile.locale) {
      _profile.locale = locale;
      notifyListeners();
    }
  }
}


class CacheObject{
  CacheObject(this.response) : timeStamp = DateTime.now().millisecondsSinceEpoch;
  Response response;
  int timeStamp; // 缓存创建时间

  @override
  bool operator ==(other) {
    return response.hashCode == other.hashCode;
  }

  //将请求uri作为缓存的key
  @override
  int get hashCode => response.realUri.hashCode;
}

class NetCache  extends Interceptor{
  // 为确保迭代器顺序和对象插入时间一致顺序一致，我们使用LinkedHashMap
  var cache = LinkedHashMap<String, CacheObject>();

  @override
  Future onRequest(RequestOptions options) async {
    if(!Global.profile.cache.enable) return options;
    // refresh标记是否是"下拉刷新"
    bool refresh = options.extra["refresh"] == true;

    if(refresh){
      if(options.extra["list"] ==true){

      }
    }
  }
}
