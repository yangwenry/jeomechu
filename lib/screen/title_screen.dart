import 'package:flutter/material.dart';

class TitleScreen extends StatefulWidget {
  const TitleScreen({super.key});

  @override
  State<TitleScreen> createState() => _TitleScreenState();
}

class _TitleScreenState extends State<TitleScreen> {
  bool _loading = false;
  //static const storage = FlutterSecureStorage();

  void init() async {
    setState(() {
      _loading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    if (context.mounted) Navigator.pushNamed(context, '/home');

    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  '점\n메\n추',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              Image.asset('assets/images/white_line.jpg', width: 100),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  '심\n뉴\n천',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ],
          ),
          if (_loading) ...<Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
