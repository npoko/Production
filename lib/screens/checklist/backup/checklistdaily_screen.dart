// import 'dart:async';
// import 'package:engineer/app_router.dart';
// import 'package:engineer/models/productiondaily_model.dart';
// import 'package:engineer/models/user_model.dart';
// import 'package:engineer/screens/components/custom_menu.dart';
// import 'package:engineer/screens/navigatorpage/home_screen.dart';
// import 'package:engineer/services/authenticate_api.dart';
// import 'package:engineer/services/productiondaily_api.dart';
// import 'package:engineer/themes/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:engineer/screens/components/custom_menu.dart';

// class ChecklistdailyScreen extends StatefulWidget {
//   const ChecklistdailyScreen({super.key});

//   @override
//   State<ChecklistdailyScreen> createState() => _ChecklistdailyScreenState();
// }

// class _ChecklistdailyScreenState extends State<ChecklistdailyScreen> {
//   // สร้างตัวแปรเก็บ title ของแต่ละหน้า
//   String _title = 'Checklist';
//   // สร้างตัวแปรเก็บ index ของแต่ละหน้า
//   int _currentIndex = 0;

//   // สร้าง List ของแต่ละหน้า
//   final List<Widget> _children = [
//     const HomeScreen(),
   
//   ];
// //
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           leading: IconButton(
//             icon: const Icon(
//               Icons.arrow_back_ios,
//               color: bluedark,
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           title: Text(_title),
//           titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
//           backgroundColor: primaryDark,
//           actions: <Widget>[
//             IconButton(
//               color: bluedark,
//               icon: const Icon(Icons.search),
//               onPressed: () {
//                 Navigator.pushNamedAndRemoveUntil(
//                     context, AppRouter.home, (route) => false);
//               },
//             ),
//             IconButton(
//               color: pinkdark,
//               icon: const Icon(Icons.logout),
//               onPressed: () async {
//                 SharedPreferences prefs = await SharedPreferences.getInstance();
//                 prefs.remove('token');
//                 Navigator.pushNamedAndRemoveUntil(
//                     context, AppRouter.login, (route) => false);
//               },
//             ),
//           ]),
 
//     );
//   }
// }
