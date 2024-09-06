import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jeomechu/service/login_service.dart';

class HomeDrawer extends StatefulWidget {
  final Function showLoadingBar;
  const HomeDrawer({super.key, required this.showLoadingBar});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  String userEmail = "";
  String userId = "";

  Future<void> signOut() async {
    widget.showLoadingBar(true);
    await LoginService().signOutWithGoogle();
    widget.showLoadingBar(false);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: LoginService().getUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print('data: ${snapshot.data}');
          if (snapshot.data != '') {
            final loginUser = jsonDecode(snapshot.data!);
            userEmail = loginUser['email'];
            userId = loginUser['id'];
            return renderLoginDrawer();
          } else {
            return renderLogoutDrawer();
          }
        }
        return Container();
      },
    );
  }

  Widget renderLoginDrawer() {
    final stylebody = Theme.of(context).textTheme.bodyMedium;
    final stylebodyBold = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(fontWeight: FontWeight.w800);

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/avator.png'),
              backgroundColor: Colors.white,
            ),
            accountName:
                Text(userId, style: const TextStyle(color: Colors.white)),
            accountEmail:
                Text(userEmail, style: const TextStyle(color: Colors.white)),
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
            title: Text('설정', style: stylebodyBold),
          ),
          Divider(
            thickness: 1,
            color: Colors.grey[600]!.withOpacity(0.5),
          ),
          ListTile(
            leading: Icon(
              Icons.contact_page,
              color: Colors.grey[850],
            ),
            title: Text('마이페이지', style: stylebody),
            onTap: () {
              print('MyPage is clicked !');
            },
            trailing: const Icon(Icons.chevron_right_outlined),
          ),
          ListTile(
            leading: Icon(
              Icons.question_answer,
              color: Colors.grey[850],
            ),
            title: Text('문의하기', style: stylebody),
            onTap: () {
              print('Q&A is clicked !');
            },
            trailing: const Icon(Icons.chevron_right_outlined),
          ),
          Divider(
            thickness: 1,
            color: Colors.grey[600]!.withOpacity(0.5),
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app_outlined,
              color: Colors.grey[850],
            ),
            title: Text('Logout', style: stylebody),
            onTap: () {
              Navigator.pop(context);
              signOut();
            },
          ),
        ],
      ),
    );
  }

  Widget renderLogoutDrawer() {
    final stylebody = Theme.of(context).textTheme.bodyMedium;
    final stylebodyBold = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(fontWeight: FontWeight.w800);

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            title: Text('설정', style: stylebodyBold),
          ),
          Divider(
            thickness: 1,
            color: Colors.grey[600]!.withOpacity(0.5),
          ),
          ListTile(
            leading: Icon(
              Icons.login_sharp,
              color: Colors.grey[850],
            ),
            title: Text('로그인 하기', style: stylebody),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/login');
            },
            trailing: const Icon(Icons.chevron_right_outlined),
          ),
          ListTile(
            leading: Icon(
              Icons.contact_page,
              color: Colors.grey[850],
            ),
            title: Text('마이페이지', style: stylebody),
            onTap: () {
              print('MyPage is clicked !');
            },
            trailing: const Icon(Icons.chevron_right_outlined),
          ),
          ListTile(
            leading: Icon(
              Icons.question_answer,
              color: Colors.grey[850],
            ),
            title: Text('문의하기', style: stylebody),
            onTap: () {
              print('Q&A is clicked !');
            },
            trailing: const Icon(Icons.chevron_right_outlined),
          ),
        ],
      ),
    );
  }
}
