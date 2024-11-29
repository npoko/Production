import 'package:engineer/app_router.dart';
import 'package:engineer/models/user_model.dart';
import 'package:engineer/pm_check/screens/pim_sceenchecklist.dart';
import 'package:engineer/pm_check/utility/app_controller.dart';
import 'package:engineer/pm_check/utility/app_service.dart';
import 'package:engineer/services/authenticate_api.dart';
import 'package:engineer/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectMachine extends StatelessWidget {
  const SelectMachine({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  UserModel user = UserModel();
  final AuthenticateApi authenticateApi = AuthenticateApi();
  final AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    getUser();
    AppService().readGetJobRepairPM().then((value) {
      print(
          '##---test  test-------body-----1111----- ${appController.getRepairPim.length}');
    });
  }

  Future<void> getUser() async {
    user = await authenticateApi.getUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                        'Welcome ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: background,
                        ),
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
                          color: primaryLight,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.notifications,
                            size: 28,
                            color: background,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: primaryLight,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.logout_outlined,
                            size: 28,
                            color: background,
                          ),
                          onPressed: () async {
                            Navigator.pushReplacementNamed(
                                context, AppRouter.login);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "    Select Machine",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(1),
              child: Obx(
                () => appController.getRepairPim.isEmpty
                    ? SizedBox()
                    : SizedBox(
                        height: 400, // Set a fixed height for the list
                        child: ListView.builder(
                          itemCount: appController.getRepairPim.length,
                          itemBuilder: (context, index) {
                            final machine = appController.getRepairPim[index];
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 25, 10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 245, 245, 245),
                                  shadowColor:
                                      const Color.fromARGB(255, 41, 43, 42),
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(1.0),
                                  ),
                                  minimumSize: const Size(80, 80),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CheckListScreenPim(),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 0.0, vertical: 1.0),
                                      leading: Container(
                                        padding:
                                            const EdgeInsets.only(right: 4.0),
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
                                                width: 1.0, color: Colors.grey),
                                          ),
                                        ),
                                        child: const Icon(Icons.comment_sharp,
                                            size: 25.0, color: Colors.red),
                                      ),
                                      title: Text(
                                        'McID: ${machine.McID}',
                                        style: const TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('McName: ${machine.McName}'),
                                          Text('Location: ......'),
                                          Text('Detail: ${machine.MT_Detail}'),
                                        ],
                                      ),
                                      trailing: const Icon(
                                        Icons.keyboard_arrow_right,
                                        color: Colors.blue,
                                        size: 35.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
