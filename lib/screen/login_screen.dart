import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle fontStyleJoin = Theme.of(context)
        .textTheme
        .bodySmall!
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
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(
            height: 40,
          ),
          SignInButton(
            Buttons.googleDark,
            text: "Continue with Google",
            onPressed: signInWithGoogle,
            padding: const EdgeInsets.all(5.0),
            elevation: 3,
          ),
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
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              '회원가입',
              style: fontStyleJoin,
            ),
          ),
        ],
      ),
    );
  }

  void signInWithGoogle() {}
}
