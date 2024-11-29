// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   Future<Map<String, dynamic>> fetchData() async {
//     final response = await http.get(Uri.parse('https://api.example.com/data'));

//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('API Data Checker'),
//       ),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: fetchData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             var data = snapshot.data!;
//             if (data['key'] != null) {
//               return Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Text('Data: ${data['key']}'),
//                 ),
//               );
//             } else {
//               return Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     labelText: 'Enter your data',
//                   ),
//                 ),
//               );
//             }
//           } else {
//             return Center(child: Text('No data'));
//           }
//         },
//       ),
//     );
//   }
// }

// //  child: TextField(
// //                                         decoration: InputDecoration(
// //                                             border: InputBorder.none,
// //                                             labelText: 'Enter Name',
// //                                             hintText: 'Enter Your Name'),
// //                                       ),

// import 'package:engineer/app_router.dart';
// import 'package:engineer/models/user_model.dart';
// import 'package:engineer/pm_check/utility/app_controller.dart';
// import 'package:engineer/pm_check/utility/app_service.dart';
// import 'package:engineer/pm_check/widgets/widget_button.dart';
// import 'package:engineer/services/authenticate_api.dart';
// import 'package:engineer/themes/colors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
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
//   final UserModel user = UserModel();
//   final AuthenticateApi authenticateApi = AuthenticateApi();
//   final AppController appController = Get.put(AppController());

//   @override
//   void initState() {
//     super.initState();
//     initializeData();
//   }

//   Future<void> initializeData() async {
//     await GetStorage().erase();
//     await getUser();
//     appController.showErrorValidate.value = false;
//     appController.checkValidate.value = true;
//     await AppService().readGetMachineName();
//     await AppService().readStandardsModel();
//   }

//   Future<void> getUser() async {
//     final user = await authenticateApi.getUser();
//     setState(() {
//       this.user.firstname = user.firstname;
//       this.user.lastname = user.lastname;
//     });
//   }

//   void toggleSelection(int index, String key) {
//     final storage = GetStorage();
//     final updatedList = storage.read(key);
//     updatedList[appController.indexBody.value][index] =
//         !updatedList[appController.indexBody.value][index];
//     storage.write(key, updatedList);
//     updateOtherSelections(index, key);
//     setState(() {});
//   }

//   void updateOtherSelections(int index, String selectedKey) {
//     const keys = ['listOnes', 'listTwos', 'listThrees'];
//     final storage = GetStorage();
//     for (final key in keys) {
//       if (key != selectedKey) {
//         final list = storage.read(key);
//         list[appController.indexBody.value][index] = false;
//         storage.write(key, list);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             buildHeader(),
//             const SizedBox(height: 15),
//             buildTitle(),
//             buildCheckList(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildHeader() {
//     return Container(
//       alignment: Alignment.bottomLeft,
//       padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
//       height: 170,
//       decoration: const BoxDecoration(color: primary),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           buildUserInfo(),
//           buildHeaderIcons(),
//         ],
//       ),
//     );
//   }

//   Widget buildUserInfo() {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Welcome',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 20.0,
//             color: background,
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
//           child: Text(
//             '${user.firstname} ${user.lastname}',
//             style: const TextStyle(fontSize: 20.0, color: background),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildHeaderIcons() {
//     return Row(
//       children: [
//         buildHeaderIconButton(Icons.notifications, () {}),
//         const SizedBox(width: 10),
//         buildHeaderIconButton(Icons.logout_outlined, () async {
//           Navigator.pushReplacementNamed(context, AppRouter.login);
//         }),
//       ],
//     );
//   }

//   Widget buildHeaderIconButton(IconData icon, VoidCallback onPressed) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15.0),
//         color: primaryLight,
//       ),
//       child: IconButton(
//         icon: Icon(
//           icon,
//           size: 28,
//           color: background,
//         ),
//         onPressed: onPressed,
//       ),
//     );
//   }

//   Widget buildTitle() {
//     return const Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: <Widget>[
//         Text(
//           "   PM Check List",
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//       ],
//     );
//   }

//   Widget buildCheckList() {
//     return Obx(
//       () => appController.machineModels.isEmpty
//           ? const SizedBox()
//           : ListView(
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               children: [
//                 buildMachineName(),
//                 buildStandardList(),
//               ],
//             ),
//     );
//   }

//   Widget buildMachineName() {
//     return Text(
//       appController
//           .machineModels[appController.indexBody.value].McName,
//       style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
//     );
//   }

//   Widget buildStandardList() {
//     final listOnes = GetStorage().read('listOnes');
//     return listOnes == null
//         ? const SizedBox(child: Text('Have Null'))
//         : ListView.builder(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             itemCount: appController
//                 .listStandardsModels[appController.indexBody.value].length,
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//               final standard = appController.listStandardsModels[appController.indexBody.value][index];
//               return buildStandardCard(index, standard.MsMin, standard.MsMax);
//             },
//           );
//   }

//   Widget buildStandardCard(int index, double? msMin, double? msMax) {
//     final isMsMinMaxNotNull = msMin != null && msMax != null;
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             buildStandardDetail(index),
//             buildActionButtons(index),
//             if (isMsMinMaxNotNull)
//               buildButton(index)
//             else
//               buildTextField(),
//             buildValidationError(index),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildStandardDetail(int index) {
//     return Text(
//       appController
//           .listStandardsModels[appController.indexBody.value][index]
//           .MsDetail
//           .trim(),
//     );
//   }

//   Widget buildActionButtons(int index) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         buildActionButton(index, 'listOnes', Colors.green, 'ปกติ'),
//         buildActionButton(index, 'listTwos', Colors.red, 'ไม่ปกติ'),
//         buildActionButton(index, 'listThrees', Colors.amber, 'N/A'),
//       ],
//     );
//   }

//   Widget buildActionButton(
//       int index, String key, Color activeColor, String text) {
//     final isActive = GetStorage().read(key)[appController.indexBody.value][index];
//     return Obx(
//       () => WidgetButton(
//         textStyle: const TextStyle(color: Colors.black),
//         color: isActive ? activeColor : Colors.grey.shade300,
//         text: text,
//         onPressed: () => toggleSelection(index, key),
//       ),
//     );
//   }

//   Widget buildButton(int index) {
//     return Obx(() => WidgetButton(
//           textStyle: const TextStyle(color: Colors.black),
//           color: Colors.blue,
//           text: 'Button',
//           onPressed: () {},
//         ));
//   }

//   Widget buildTextField() {
//     return Obx(
//       () => TextField(
//         decoration: InputDecoration(
//           border: InputBorder.none,
//           labelText: 'Enter Name',
//           hintText: 'Enter Your Name',
//         ),
//       ),
//     );
//   }

//   Widget buildValidationError(int index) {
//     return Obx(
//       () => appController.showErrorValidate.value
//           ? GetStorage().read('displayValidate')[appController.indexBody.value]
//               [index]
//               ? const SizedBox()
//               : const Text(
//                   'Please Choose Item',
//                   style: TextStyle(color: GFColors.DANGER),
//                 )
//           : const SizedBox(),
//     );
//   }
// }
