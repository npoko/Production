// import 'package:engineer/app_router.dart';
// import 'package:engineer/models/user_model.dart';
// import 'package:engineer/pm_check/utility/app_controller.dart';
// import 'package:engineer/pm_check/utility/app_service.dart';
// import 'package:engineer/pm_check/widgets/widget_button.dart';
// import 'package:engineer/services/authenticate_api.dart';
// import 'package:engineer/themes/colors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:getwidget/getwidget.dart';

// class CheckListScreenPim extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Click Color Card',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   UserModel user = UserModel();
//   AuthenticateApi authenticateApi = AuthenticateApi();
//   AppController appController = Get.put(AppController());

//   @override
//   void initState() {
//     super.initState();
//     GetStorage().erase();
//     getUser();
//     appController.showErrorValidate.value = false;
//     appController.checkValidate.value = true;
//     AppService().readGetMachineName().then((value) {
//       print(
//           '##---------------------body ${appController.machineModels.length}');
//     });

//     AppService().readStandardsModel();
//   }

//   void getUser() async {
//     user = await authenticateApi.getUser();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               alignment: Alignment.bottomLeft,
//               padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
//               height: 170,
//               decoration: const BoxDecoration(color: primary),
//               child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Welcome',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20.0,
//                               color: background),
//                         ),
//                         Padding(
//                           padding:
//                               const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
//                           child: Text(
//                             '${user.firstname} ${user.lastname}',
//                             style: const TextStyle(
//                                 fontSize: 20.0, color: background),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15.0),
//                               color: primaryLight),
//                           child: IconButton(
//                               icon: const Icon(
//                                 Icons.notifications,
//                                 size: 28,
//                                 color: background,
//                               ),
//                               onPressed: () {}),
//                         ),
//                         const SizedBox(width: 10),
//                         Container(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15.0),
//                               color: primaryLight),
//                           child: IconButton(
//                               icon: const Icon(
//                                 Icons.logout_outlined,
//                                 size: 28,
//                                 color: background,
//                               ),
//                               onPressed: () async {
//                                 Navigator.pushReplacementNamed(
//                                     context, AppRouter.login);
//                               }),
//                         ),
//                       ],
//                     )
//                   ]),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             const Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Text(
//                   "   PM Check List",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             // const SizedBox(
//             //   height: 15,
//             // ),
//             Obx(
//               () => appController.machineModels.isEmpty
//                   ? const SizedBox()
//                   : ListView(
//                       physics: const ScrollPhysics(),
//                       shrinkWrap: true,
//                       children: [
//                         Text(
//                           appController
//                               .machineModels[appController.indexBody.value]
//                               .McName,
//                           style: const TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.w700),
//                         ),
//                         GetStorage().read('listOnes') == null
//                             ? const SizedBox(
//                                 child: Text('Have Null'),
//                               )
//                             : ListView.builder(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 8),
//                                 itemCount: appController
//                                     .listStandardsModels[
//                                         appController.indexBody.value]
//                                     .length,
//                                 physics: const ScrollPhysics(),
//                                 shrinkWrap: true,
//                                 itemBuilder: (context, index) {
//                                   final standard =
//                                       appController.listStandardsModels[
//                                           appController.indexBody.value][index];
//                                   final msMin = standard.MsMin;
//                                   final msMax = standard.MsMax;
//                                   bool isMsMinMaxNotNull;
//                                   Card(
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Text(appController
//                                               .listStandardsModels[appController
//                                                   .indexBody.value][index]
//                                               .MsDetail
//                                               .trim()),
//                                           //funtion if msmin && msmax == null show  Obx(() => WidgetButton else != Obx(() => TextField

//                                           if (isMsMinMaxNotNull =
//                                               msMin == null && msMax == null)
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceAround,
//                                               children: [
//                                                 Obx(
//                                                   () => WidgetButton(
//                                                     textStyle: const TextStyle(
//                                                         color: Colors.black),
//                                                     color: GetStorage().read(
//                                                                 'listOnes')[
//                                                             appController
//                                                                 .indexBody
//                                                                 .value][index]
//                                                         ? Colors.green
//                                                         : Colors.grey.shade300,
//                                                     text: 'ปกติ',
//                                                     onPressed: () {
//                                                       var newListOnes =
//                                                           GetStorage()
//                                                               .read('listOnes');

//                                                       var result = newListOnes[
//                                                           appController
//                                                               .indexBody.value];

//                                                       result[index] =
//                                                           !result[index];

//                                                       newListOnes[appController
//                                                           .indexBody
//                                                           .value] = result;

//                                                       //ส่วนของ Two
//                                                       var newListTwos =
//                                                           GetStorage()
//                                                               .read('listTwos');

//                                                       var blank = newListTwos[
//                                                           appController
//                                                               .indexBody.value];

//                                                       blank[index] = false;

//                                                       //ส่วนของ Three
//                                                       var newListThrees =
//                                                           GetStorage().read(
//                                                               'listThrees');

//                                                       var blankThree =
//                                                           newListThrees[
//                                                               appController
//                                                                   .indexBody
//                                                                   .value];

//                                                       blankThree[index] = false;

//                                                       // saveListOneTwoThree();

//                                                       // processSaveChoose(
//                                                       //     index: index);

//                                                       setState(() {});
//                                                     },
//                                                   ),
//                                                 ),
//                                                 WidgetButton(
//                                                   textStyle: const TextStyle(
//                                                       color: Colors.black),
//                                                   color: GetStorage()
//                                                               .read('listTwos')[
//                                                           appController
//                                                               .indexBody
//                                                               .value][index]
//                                                       ? Colors.red
//                                                       : Colors.grey.shade300,
//                                                   text: 'ไม่ปกติ',
//                                                   onPressed: () {
//                                                     var newListTwos =
//                                                         GetStorage()
//                                                             .read('listTwos');

//                                                     var result = newListTwos[
//                                                         appController
//                                                             .indexBody.value];

//                                                     result[index] =
//                                                         !result[index];

//                                                     //ส่วนของ One
//                                                     var newListOnes =
//                                                         GetStorage()
//                                                             .read('listOnes');

//                                                     var blankTwo = newListOnes[
//                                                         appController
//                                                             .indexBody.value];

//                                                     blankTwo[index] = false;

//                                                     //ส่วนของ Three
//                                                     var newListThrees =
//                                                         GetStorage()
//                                                             .read('listThrees');

//                                                     var blankThree =
//                                                         newListThrees[
//                                                             appController
//                                                                 .indexBody
//                                                                 .value];

//                                                     blankThree[index] = false;

//                                                     // saveListOneTwoThree();

//                                                     // processSaveChoose(index: index);

//                                                     setState(() {});
//                                                   },
//                                                 ),
//                                                 WidgetButton(
//                                                   textStyle: const TextStyle(
//                                                       color: Colors.black),
//                                                   color: GetStorage().read(
//                                                               'listThrees')[
//                                                           appController
//                                                               .indexBody
//                                                               .value][index]
//                                                       ? Colors.amber
//                                                       : Colors.grey.shade300,
//                                                   text: 'N/A',
//                                                   onPressed: () {
//                                                     var newListThrees =
//                                                         GetStorage()
//                                                             .read('listThrees');

//                                                     var result = newListThrees[
//                                                         appController
//                                                             .indexBody.value];

//                                                     result[index] =
//                                                         !result[index];

//                                                     //ส่วนของ One
//                                                     var newListOnes =
//                                                         GetStorage()
//                                                             .read('listOnes');

//                                                     var blankOne = newListOnes[
//                                                         appController
//                                                             .indexBody.value];

//                                                     blankOne[index] = false;

//                                                     //ส่วนของ Two
//                                                     var newListTwos =
//                                                         GetStorage()
//                                                             .read('listTwos');

//                                                     var blankTwo = newListTwos[
//                                                         appController
//                                                             .indexBody.value];

//                                                     blankTwo[index] = false;

//                                                     // saveListOneTwoThree();

//                                                     // processSaveChoose(index: index);

//                                                     setState(() {});
//                                                   },
//                                                 ),
//                                               ],
//                                             ),

//                                           Obx(
//                                             () => const TextField(
//                                               decoration: InputDecoration(
//                                                   border: InputBorder.none,
//                                                   labelText: 'Enter Name',
//                                                   hintText: 'Enter Your Name'),
//                                             ),
//                                           ),

//                                           Obx(() => appController
//                                                   .showErrorValidate.value
//                                               ? GetStorage().read(
//                                                           'displayValidate')[
//                                                       appController.indexBody
//                                                           .value][index]
//                                                   ? const SizedBox()
//                                                   : const Text(
//                                                       'Please Choose Item',
//                                                       style: TextStyle(
//                                                           color:
//                                                               GFColors.DANGER),
//                                                     )
//                                               : const SizedBox()),
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                       ],
//                     ),
//             ),

//             ///
//           ],
//         ),
//       ),
//     );
//   }
// }
