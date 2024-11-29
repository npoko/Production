import 'package:engineer/screens/login/login_screen.dart';
import 'package:engineer/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:engineer/models/user_model.dart';
import 'package:engineer/services/authenticate_api.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:engineer/providers/localizations.dart';

class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

//ประกาศค่าตัวแปรเพื่อแสดงผลข้อมูลสวัสดีในหน้าจอ
String getGreeting() {
  final hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good Morning!';
  } else if (hour < 18) {
    return 'Good Afternoon!';
  } else {
    return 'Good Evening!';
  }
}

class _DrawerMenuState extends State<DrawerMenu> {
  int selectedIndex = 0;
  UserModel user = UserModel();
  AuthenticateApi authenticateApi = AuthenticateApi();

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    user = await authenticateApi.getUser();
    setState(() {});
  }

  // ฟังก์ชัน Logout
  void logout() {
    // Clear all route and push to login screen
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login', // เปลี่ยนเป็น route ของหน้า login
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getGreeting(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    '${user.firstname} ${user.lastname}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              accountEmail: null,
              currentAccountPicture: Container(
                width: 125,
                height: 125,
                child: CircleAvatar(
                  backgroundImage: NetworkImage('${user.imageUrl}'),
                  radius: 50,
                ),
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF29B6F6),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(AppLocalizations.of(context)!.menu_changelang ??
                  'Change Language'),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                            AppLocalizations.of(context)!.menu_changelang ??
                                'Change Language'),
                        content: SingleChildScrollView(
                          child: Consumer<LocaleProvider>(
                              builder: (context, provider, child) {
                            return ListBody(
                              children: [
                                InkWell(
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text('English'),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      Navigator.pop(context);
                                      provider.changeLocale(const Locale('en'));
                                    });
                                  },
                                ),
                                const SizedBox(height: 10),
                                InkWell(
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text('ไทย'),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      Navigator.pop(context);
                                      provider.changeLocale(const Locale('th'));
                                    });
                                  },
                                ),
                                const SizedBox(height: 10),
                              ],
                            );
                          }),
                        ),
                      );
                    });
              },
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: Text(AppLocalizations.of(context)!.menu_logout),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const LoginScreen()), // ไปยังหน้า SelectmachineSceen
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
