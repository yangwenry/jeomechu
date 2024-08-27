import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  final isLogin = false;

  void init() {
    if (isLogin) {
      // 로그인 되어 있다면 위치정보제공 확인
    } else {
      // 로그인 되어 있지않다면 로그인 페이지로 이동
    }
  }

  @override
  Widget build(BuildContext context) {
    init();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                '점\n메\n추',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            Image.asset('assets/images/white_line.jpg', width: 100),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                '심\n뉴\n천',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
