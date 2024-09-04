import 'package:flutter/material.dart';
import 'package:jeomechu/widget/home_button.dart';
import 'package:jeomechu/widget/home_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _loading = false;

  @override
  void initState() {
    // Future.delayed(Duration.zero, () async {
    //   final loginUserStr = await getUser();
    //   if (loginUserStr != "") {
    //     final loginUser = jsonDecode(loginUserStr);
    //     userEmail = loginUser["email"];
    //     userName = loginUser["displayName"];
    //     isLogin = true;
    //   } else {
    //     isLogin = false;
    //   }
    //   print('userEmail: $userEmail');
    // });
    super.initState();
  }

  void showLoadingBar(bool loading) {
    setState(() {
      _loading = loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
        elevation: 0,
      ),
      endDrawer: HomeDrawer(showLoadingBar: showLoadingBar),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              '원하는 옵션\n선택하기',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          if (_loading)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          if (!_loading)
            const Column(
              children: [
                HomeButton(
                    title: '메뉴를\n추천 받기', body: '근처에 있는 식당들 메뉴 중\n하나를 추천해드려요.'),
                HomeButton(
                    title: '새로 생긴 곳\n알아보기',
                    body: '근처에 있는 식당들 중 새로 오픈한 곳을\n알려드려요.'),
                HomeButton(
                    title: '지도로\n근처 맛집 찾기', body: '지도를 보며 맛집을 고를 수 있어요.'),
              ],
            )
        ]),
      ),
    );
  }
}
