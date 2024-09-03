import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const storage = FlutterSecureStorage();
  bool isLogin = false;
  String userEmail = "";
  String userId = "";

  Future<String> getUser() async {
    final loginUser = await storage.read(key: 'loginUser');
    if (loginUser == null) return "";
    return loginUser;
  }

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
      ),
      endDrawer: FutureBuilder<String>(
        future: getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('data: ${snapshot.data}');
            final loginUser = jsonDecode(snapshot.data!);
            userEmail = loginUser['email'];
            userId = loginUser['id'];
          }
          return renderLoginDrawer();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              '원하는 옵션\n선택하기',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton(
                onPressed: () => (),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Text(
                        '메뉴를\n추천 받기',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        '근처에 있는 식당들 메뉴 중\n하나를 추천해드려요.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }

  Widget renderLoginDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/avator.png'),
              backgroundColor: Colors.white,
            ),
            accountName: Text(userId),
            accountEmail: Text(userEmail),
            onDetailsPressed: () {
              print('arrow is clicked');
            },
            otherAccountsPictures: const [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/captin_talyor.jpg'),
                backgroundColor: Colors.white,
              ),
            ],
            decoration: BoxDecoration(
                color: Colors.red[400],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                )),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.grey[850],
            ),
            title: const Text('Home'),
            onTap: () {
              print('Home is clicked !');
            },
            trailing: const Icon(Icons.add),
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.grey[850],
            ),
            title: const Text('Setting'),
            onTap: () {
              print('Setting is clicked !');
            },
            trailing: const Icon(Icons.add),
          ),
          ListTile(
            leading: Icon(
              Icons.question_answer,
              color: Colors.grey[850],
            ),
            title: const Text('Q&A'),
            onTap: () {
              print('Q&A is clicked !');
            },
            trailing: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
