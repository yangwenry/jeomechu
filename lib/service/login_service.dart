import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../const/login_platform.dart';

class LoginService {
  static const storage = FlutterSecureStorage();
  LoginPlatform _loginPlatform = LoginPlatform.none;

  Future<String> getUser() async {
    final loginUser = await storage.read(key: 'loginUser');
    if (loginUser == null) return "";
    return loginUser;
  }

  Future<bool> isLoginCheck() async {
    final loginUserStr = await getUser();
    return loginUserStr != '';
  }

  Future<void> signOutWithGoogle() async {
    print('logout 실행');

    await Future.delayed(const Duration(seconds: 1));

    switch (_loginPlatform) {
      case LoginPlatform.facebook:
        // await FacebookAuth.instance.logOut();
        break;
      case LoginPlatform.google:
        // 추가
        await GoogleSignIn().signOut();
        break;
      case LoginPlatform.kakao:
        break;
      case LoginPlatform.naver:
        break;
      case LoginPlatform.apple:
        break;
      case LoginPlatform.none:
        break;
    }

    _loginPlatform = LoginPlatform.none;
    await storage.delete(key: "loginUser");
  }

  Future<GoogleSignInAccount?> signInWithGoggle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      print('name = ${googleUser.displayName}');
      print('email = ${googleUser.email}');
      print('id = ${googleUser.id}');

      saveStorage(googleUser);

      _loginPlatform = LoginPlatform.google;
    }
    return googleUser;
  }

  void saveStorage(GoogleSignInAccount googleUser) async {
    // json string
    final googleUserMap = {};
    googleUserMap["id"] = googleUser.id;
    googleUserMap["email"] = googleUser.email;
    googleUserMap["displayName"] = googleUser.displayName;
    final googleUserJsonStr = jsonEncode(googleUserMap);
    //print('googleUserJsonStr : $googleUserJsonStr');

    await storage.write(key: "loginUser", value: googleUserJsonStr);
    // await storage.write(key: "userId", value: googleUser.id);
    // await storage.write(key: "userEmail", value: googleUser.email);
    // await storage.write(key: "userName", value: googleUser.displayName);
  }
}
