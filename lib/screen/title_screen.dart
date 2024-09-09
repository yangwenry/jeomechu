import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class TitleScreen extends StatefulWidget {
  const TitleScreen({super.key});

  @override
  State<TitleScreen> createState() => _TitleScreenState();
}

class _TitleScreenState extends State<TitleScreen> {
  bool _loading = false;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    setState(() {
      _loading = true;
    });

    bool isPermission = await checkPermissionGeolocator();
    await Future.delayed(const Duration(seconds: 2), () {
      if (isPermission) {
        if (context.mounted) Navigator.pushNamed(context, '/home');
      } else {
        if (context.mounted) Navigator.pushNamed(context, '/locator_agree');
      }
    });

    setState(() {
      _loading = false;
    });
  }

  Future<bool> checkPermissionGeolocator() async {
    // 위치 정보 획득 가능한지 확인
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // 위치 추적 퍼미션 확인
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      //print('permission: ${permission.name}');
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        // 위치동의 페이지로 이동
        return false;
      }
    }
    return true;
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
