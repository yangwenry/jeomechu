import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '점\n메\n추',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Container(child: const Text('-------------------------')),
            Text(
              '심\n뉴\n천',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ],
        ),
      ]),
    );
  }
}
