import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        const Text('원하는 옵션 선택하기'),
        Column(
          children: [
            TextButton(onPressed: () => (), child: const Text('메뉴를 추천 받기')),
          ],
        )
      ]),
    );
  }
}
