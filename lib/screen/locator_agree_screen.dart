import 'package:flutter/material.dart';

class LocatorAgreeScreen extends StatelessWidget {
  const LocatorAgreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_off,
              size: 120,
              color: Colors.grey,
            ),
            Text(
              '위치 정보 제공에\n동의하지 않으셨습니다.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(width: MediaQuery.sizeOf(context).width, height: 10),
            Text(
              '위치정보 제공에 동의하시면\n더 정확한 정보를 전달해드릴 수 있어요.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => (),
                child: const Text('설정으로 가기'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => moveToHomeScreen(context),
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xff8E8E93),
                  backgroundColor: const Color(0xffffffff),
                ),
                child: const Text('건너뛰기'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void moveToHomeScreen(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }
}
