import 'package:flutter/material.dart';

import '../service/login_service.dart';
import '../widget/home_drawer.dart';

class TodayMenuScreen extends StatefulWidget {
  const TodayMenuScreen({super.key});

  @override
  State<TodayMenuScreen> createState() => _TodayMenuScreenState();
}

class _TodayMenuScreenState extends State<TodayMenuScreen> {
  bool _loading = false;

  void showLoadingBar(bool loading) {
    setState(() {
      _loading = loading;
    });
  }

  // 좋아용 버튼
  void onPressedLike() {
    // 로그인 여부 체크
    LoginService().isLoginCheck().then((isLogin) {
      if (!isLogin) {
        // 로그인 여부 팝업 띄우기
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.info),
                  Text(
                    "로그인이 필요합니다.\n로그인 하시겠습니까?",
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text('로그인'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('닫기'),
                ),
              ],
              actionsAlignment: MainAxisAlignment.spaceEvenly,
            );
          },
        );
      } else {
        print('로그인 되어있습니다');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const gap = 5.0;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
        elevation: 0,
        title: const Text(
          '메뉴 보기',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      endDrawer: HomeDrawer(showLoadingBar: showLoadingBar),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                '오늘은 이 메뉴\n어때요?',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(2, 3),
                  )
                ],
              ),
              child: Image.asset(
                'assets/images/dish01.png',
                width: MediaQuery.sizeOf(context).width,
                height: 280,
                fit: BoxFit.cover,
              ),
            ),
            if (_loading) const CircularProgressIndicator(),
            if (!_loading)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('언양닭칼국수 센텀점',
                          style: Theme.of(context).textTheme.titleMedium),
                      Tooltip(
                        message: '도로명 부산 해운대구 센텀통로 99\n벽산E센텀 클래스원 113호',
                        verticalOffset: 10,
                        triggerMode: TooltipTriggerMode.tap,
                        decoration: BoxDecoration(
                          color: Colors.grey[500],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        child: Text('주소 보기',
                            style: Theme.of(context).textTheme.bodySmall),
                      )
                    ],
                  ),
                  const SizedBox(height: gap),
                  Text('내 위치와의 거리 120m',
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: gap),
                  Text('구글 평점 4.5',
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: gap),
                  Row(
                    children: [
                      Text('매장 내 식사 가능',
                          style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(width: 20.0),
                      Text('배달 및 포장 가능',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: ElevatedButton.icon(
                    onPressed: onPressedLike,
                    icon: const Icon(Icons.info_outline_rounded),
                    label: const Text('좋아요'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(147, 31),
                    ),
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: ElevatedButton.icon(
                    onPressed: () => (),
                    icon: const Icon(Icons.info_outline_rounded),
                    label: const Text('별로에요'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffF2F2F2),
                      foregroundColor: const Color(0xfffe6b00),
                      minimumSize: const Size(147, 31),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
