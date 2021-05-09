import 'dart:convert';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/foundation.dart';
import 'package:kaylee/models/models.dart';

const _SHARE_REF_AUTHENTICATE = 'SHARE_REF_LOGIN_INFO';

abstract class UserModule {
  factory UserModule.init() = _UserModuleImpl._;

  UserModule._();

  LoginResult getUserInfo();

  void forceGetUserInfo({ValueSetter<LoginResult>? callback});

  void updateUserInfo(LoginResult auth);

  void removeUserInfo();
}

class _UserModuleImpl extends UserModule {
  late LoginResult loginResult;

  _UserModuleImpl._() : super._() {
    forceGetUserInfo();
  }

  @override
  LoginResult getUserInfo() {
    return loginResult;
  }

  @override
  void updateUserInfo(LoginResult auth) {
    loginResult = auth;
    final json = jsonEncode(auth);
    SharedRef.putString(_SHARE_REF_AUTHENTICATE, json);
  }

  @override
  void removeUserInfo() {
    loginResult = LoginResult();
    SharedRef.putString(_SHARE_REF_AUTHENTICATE, jsonEncode({}));
  }

  @override
  void forceGetUserInfo({ValueSetter<LoginResult>? callback}) {
    final json = SharedRef.getString(_SHARE_REF_AUTHENTICATE);
    loginResult = LoginResult.fromJson(jsonDecode(json ?? '{}'));
    if (callback != null) {
      callback(loginResult);
    }
  }
}
