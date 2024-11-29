import 'package:engineer/app_router.dart';
import 'package:engineer/models/user_model.dart';
import 'package:engineer/pm_check/utility/app_service.dart';
import 'package:engineer/pm_check/screens/pim_sceenchecklist.dart';
import 'package:engineer/services/authenticate_api.dart';
import 'package:engineer/themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Column(
        children: [
          Container(
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
            height: 170,
            decoration: const BoxDecoration(color: primary),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: background),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          '${user.firstname} ${user.lastname}',
                          style: const TextStyle(
                              fontSize: 20.0, color: background),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: primaryLight),
                        child: IconButton(
                            icon: const Icon(
                              Icons.notifications,
                              size: 28,
                              color: background,
                            ),
                            onPressed: () {}),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: primaryLight),
                        child: IconButton(
                            icon: const Icon(
                              Icons.logout_outlined,
                              size: 28,
                              color: background,
                            ),
                            onPressed: () async {
                              Navigator.pushReplacementNamed(
                                  context, AppRouter.login);
                            }),
                      ),
                    ],
                  )
                ]),
          ),
          Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                width: 400,
                height: 100,
                decoration: BoxDecoration(
                    color: background,
                    boxShadow: (const [
                      BoxShadow(
                        color: divider,
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ]),
                    borderRadius: BorderRadius.circular(24.0),
                    shape: BoxShape.rectangle),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                              child: FaIcon(
                            FontAwesomeIcons.userClock,
                            size: 35,
                            color: primary,
                          )),
                          SizedBox(
                            //width: 10.0,
                            height: 40.0,
                          ),
                          Text(
                            'Time',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    const Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                              child: FaIcon(
                            FontAwesomeIcons.fileExport,
                            size: 35,
                            color: primary,
                          )),
                          SizedBox(
                            //width: 10.0,
                            height: 40.0,
                          ),
                          Text(
                            'Report',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => Navigator.pushNamed(
                          context, AppRouter.typm,
                          //arguments: {user.siteid}
                        ),
                        child: const Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: FaIcon(
                                FontAwesomeIcons.solidCalendarCheck,
                                size: 35,
                                color: primary,
                              ),
                            ),
                            SizedBox(
                              height: 40.0,
                            ),
                            Text(
                              'PM Check',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                              child: FaIcon(
                            FontAwesomeIcons.userCog,
                            size: 35,
                            color: primary,
                          )),
                          SizedBox(
                            //width: 10.0,
                            height: 40.0,
                          ),
                          Text(
                            'Profile',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_2), label: 'Scan'),
          BottomNavigationBarItem(
              icon: Icon(Icons.construction), label: 'Corrective'),
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'App'),
        ],
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        // backgroundColor: divider,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (value) {
          switch (value) {
            case 0:
              // Navigator.pushReplacementNamed(context, AppRouter.home);
              break;
            case 1:
              // Navigator.pushNamed(context, AppRouter.scanner);
              break;
            case 2:
              //Navigator.pushNamed(context, app);
              break;
            case 3:
              // Navigator.pushReplacementNamed(context, AppRouter.home);
              break;
          }
        },
      ),
    );
  }
}
