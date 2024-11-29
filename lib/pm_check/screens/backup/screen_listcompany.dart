// import 'package:engineer/app_router.dart';
// import 'package:engineer/models/user_model.dart';
// import 'package:engineer/pm_check/screens/backup/pim_screen%20copy%202.dart';
// import 'package:engineer/pm_check/screens/screen_selectjobmachin.dart';
// import 'package:engineer/pm_check/screens/screen_typepm.dart';
// import 'package:engineer/services/authenticate_api.dart';
// import 'package:engineer/themes/colors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class listcompany extends StatelessWidget {
//   // const listcompany({super.key});
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
//   UserModel user = UserModel();
//   AuthenticateApi authenticateApi = AuthenticateApi();
//   final List<String> companies = [
//     "Pine-Pacific Corp.,Ltd.",
//     "Pine Industrial Materials Corp.,LTD."
//   ];
//   final Map<String, int> companyValues = {
//     "Pine-Pacific Corp.,Ltd.": 1,
//     "Pine Industrial Materials Corp.,LTD.": 3,
//   };

//   @override
//   void initState() {
//     super.initState();
//     getUser();
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
//               padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
//               height: 170,
//               decoration: BoxDecoration(color: primary),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Welcome ',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20.0,
//                             color: background),
//                       ),
//                       Padding(
//                         padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
//                         child: Text(
//                           '${user.firstname} ${user.lastname}',
//                           style: TextStyle(fontSize: 20.0, color: background),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15.0),
//                             color: primaryLight),
//                         child: IconButton(
//                             icon: const Icon(
//                               Icons.notifications,
//                               size: 28,
//                               color: background,
//                             ),
//                             onPressed: () {}),
//                       ),
//                       const SizedBox(width: 10),
//                       Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15.0),
//                             color: primaryLight),
//                         child: IconButton(
//                           icon: const Icon(
//                             Icons.logout_outlined,
//                             size: 28,
//                             color: background,
//                           ),
//                           onPressed: () async {
//                             Navigator.pushReplacementNamed(
//                                 context, AppRouter.login);
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             const Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Text(
//                   "    Company List",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(1),
//               child: ListView.builder(
//                 // padding: EdgeInsets.all(100),
//                 ///itemCount: truck.length,
//                 itemCount: companies.length,
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.fromLTRB(20, 5, 25, 10),
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         //primary: const Color(0xFFEF444C),
//                         backgroundColor:
//                             const Color.fromARGB(255, 245, 245, 245),
//                         //onPrimary: Colors.white,
//                         shadowColor: const Color.fromARGB(255, 41, 43, 42),
//                         elevation: 5,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(1.0)),
//                         minimumSize: const Size(80, 80), //////// HERE
//                       ),
//                       onPressed: () {
//                         int? companyid = companyValues[companies[index]];
//                         // Navigator.push(
//                         //   context,
//                         //   MaterialPageRoute(
//                         //       builder: (context) =>
//                         //           //  typepm(companyid: companyid!)),
//                         //           ()),
//                         // );
//                       },
//                       child: Column(
//                         children: [
//                           ListTile(
//                             contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 1.0, vertical: 10.0),
//                             leading: Container(
//                               padding: const EdgeInsets.only(right: 12.0),
//                               decoration: const BoxDecoration(
//                                   border: Border(
//                                       right: BorderSide(
//                                           width: 1.0, color: Colors.grey))),
//                               child: const Icon(Icons.comment_sharp,
//                                   size: 32.0, color: Colors.red),
//                             ),
//                             title: Text(
//                               companies[index],
//                               style: const TextStyle(
//                                   fontSize: 20, color: Colors.black),
//                             ),
//                             trailing: const Icon(
//                               Icons.keyboard_arrow_right,
//                               color: Colors.blue,
//                               size: 30.0,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // class TypePMPage extends StatelessWidget {
// //   final int value;

// //   TypePMPage({required this.value});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(value == 3
// //             ? 'Pine Industrial Materials Corp.,LTD.'
// //             : 'Pine-Pacific Corp.,Ltd.'),
// //       ),
// //       body: Center(
// //         child: Text('You selected: $value'),
// //       ),
// //     );
// //   }
// // }
