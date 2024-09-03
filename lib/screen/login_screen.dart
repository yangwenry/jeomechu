import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../const/login_platform.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAuthorized = false;
  LoginPlatform _loginPlatform = LoginPlatform.none;
  bool _loading = false;
  //flutter_secure_storage 사용을 위한 초기화 작업
  static const storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleMemberJoin = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(color: const Color(0xff4285F4), fontWeight: FontWeight.w700);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // images
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/jeomechu_icon1.png', width: 50),
              Image.asset('assets/images/jeomechu_icon2.png', width: 50),
              Image.asset('assets/images/jeomechu_icon3.png', width: 50),
              Image.asset('assets/images/jeomechu_icon4.png', width: 50),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '로그인',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            '점메추는 구글메일로 로그인이 가능해요.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 40,
          ),
          if (_isAuthorized) ...<Widget>[
            const Text('로그인되었습니다.'),
            if (_loading) const CircularProgressIndicator(),
            if (!_loading)
              ElevatedButton(
                child: const Text('Logout'),
                onPressed: () => signOut(),
              ),
          ],
          if (!_isAuthorized) ...<Widget>[
            SignInButton(
              Buttons.googleDark,
              text: "Continue with Google",
              onPressed: signInWithGoogle,
              padding: const EdgeInsets.all(5.0),
              elevation: 3,
            ),
          ],
          const SizedBox(
            height: 50,
          ),
          Divider(
            thickness: 1,
            height: 1,
            color: Colors.blueGrey.shade400,
            indent: 30.0,
            endIndent: 30.0,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '점메추는 처음이신가요?',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          if (!_isAuthorized)
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextButton(
                onPressed: signInWithGoogle,
                child: Text('회원가입', style: styleMemberJoin),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '@Bkwinners',
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
      ),
    );
  }

  void signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      print('name = ${googleUser.displayName}');
      print('email = ${googleUser.email}');
      print('id = ${googleUser.id}');

      saveStorage(googleUser);

      setState(() {
        _loginPlatform = LoginPlatform.google;
        _isAuthorized = true;
      });

      moveToHomeScreen();
    }
  }

  void moveToHomeScreen() {
    Navigator.pushNamed(context, '/home');
  }

  void signOut() async {
    print('logout 실행');

    setState(() {
      _loading = true;
    });
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

    storage.delete(key: "login");

    setState(() {
      _loginPlatform = LoginPlatform.none;
      _isAuthorized = false;
      _loading = false;
    });
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
    await storage.write(key: "userId", value: googleUser.id);
    await storage.write(key: "userEmail", value: googleUser.email);
    await storage.write(key: "userName", value: googleUser.displayName);
  }
}
