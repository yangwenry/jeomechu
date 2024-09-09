import 'package:flutter/material.dart';
import 'package:jeomechu/widget/image_slider.dart';

import '../service/login_service.dart';
import '../widget/home_drawer.dart';

class TodayMenuScreen extends StatefulWidget {
  const TodayMenuScreen({super.key});

  @override
  State<TodayMenuScreen> createState() => _TodayMenuScreenState();
}

class _TodayMenuScreenState extends State<TodayMenuScreen> {
  bool _loading = false;
  bool likedVisit = false;
  bool likedMenu = false;
  // image slider용
  final images = [
    'assets/images/dish01.png',
    'assets/images/dish02.jpg',
    'assets/images/dish03.jpg',
    'assets/images/dish04.jpg'
  ];

  void showLoadingBar(bool loading) {
    setState(() {
      _loading = loading;
    });
  }

  // 좋아요 버튼
  void onPressedLike() {
    // 로그인 여부 체크
    LoginService().isLoginCheck().then((isLogin) {
      if (!isLogin) {
        // 로그인 여부 팝업 띄우기
        showLoginDialog();
      } else {
        // 메뉴추천 팝업 띄우기
        showLikedBottomSheet();
      }
    });
  }

  void showLoginDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.secondary,
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
                Navigator.pop(context);
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
  }

  onPressedSave() {
    // api로 좋아하는 메뉴 저장

    // 팝업 닫기
    Navigator.pop(context);

    showRecommendDialog();
  }

  void showRecommendDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "다른 메뉴를\n추천해\n드릴까요?",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 100,
              )
            ],
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: const Color(0xffF2F2F2),
                ),
                child: const Text('괜찮아요',
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('다시 추천 받기'),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const gap = 5.0;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
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
              alignment: Alignment.centerLeft,
              child: Text(
                '오늘은 이 메뉴\n어때요?',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            ImageSlider(images: images),
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
                      foregroundColor: const Color(0xfffe6b00),
                      backgroundColor: const Color(0xffF2F2F2),
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

  void showLikedBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter bottomState) {
            return Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.white,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text('좋아요를 누르셨네요!',
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('오늘 방문할 계획이신가요?',
                                style: Theme.of(context).textTheme.bodyMedium),
                            IconButton(
                              onPressed: () {
                                bottomState(() {
                                  setState(() {
                                    likedVisit = !likedVisit;
                                  });
                                });
                              },
                              icon: likedVisit
                                  ? const Icon(Icons.favorite)
                                  : const Icon(Icons.favorite_border),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text('이전에 내가 방문한 맛집에서 확인 가능해요.',
                              style: Theme.of(context).textTheme.bodySmall),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('선호하는 메뉴인가요?',
                                style: Theme.of(context).textTheme.bodyMedium),
                            IconButton(
                              onPressed: () {
                                bottomState(() {
                                  setState(() {
                                    likedMenu = !likedMenu;
                                  });
                                });
                              },
                              icon: likedMenu
                                  ? const Icon(Icons.favorite)
                                  : const Icon(Icons.favorite_border),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text('다음번 메뉴 추천에 이 메뉴가 추천될 수 있어요.',
                              style: Theme.of(context).textTheme.bodySmall),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: onPressedSave,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(147, 31),
                      ),
                      child: const Text('저장하기'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      constraints: const BoxConstraints(
        minWidth: double.infinity,
        maxHeight: 300,
      ),
    );
  }
}
