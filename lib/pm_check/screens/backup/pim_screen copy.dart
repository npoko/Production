// import 'package:engineer/pm_check/utility/app_service.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';

// class CheckListScreen extends StatelessWidget {
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

// class Item {
//   final String Group;
//   final String Type;
//   final String name;

//   Item(this.Group, this.Type, this.name);
// }

// class _MyHomePageState extends State<MyHomePage> {
//   List<Item> itemList = [
//     Item("สภาพการสึก Support Roller No 1-4", "วัดการสึกของ Roller Support ",
//         "1234"),
//     Item("สภาพการสึก Support Roller No 1-4", "วัดการสึกของ Roller Support ",
//         "1234"),
//     Item("สภาพการสึก Support Roller No 1-4", "วัดการสึกของ Roller Support ",
//         "1234"),
//     Item("สภาพการสึก Support Roller No 1-4", "วัดการสึกของ Roller Support ",
//         "1234"),
//     Item("สภาพการสึก Support Roller No 1-4", "วัดการสึกของ Roller Support ",
//         "1234"),
//     Item("สภาพการสึก Support Roller No 1-4", "วัดการสึกของ Roller Support ",
//         "1234"),
//     Item("สภาพการสึก Support Roller No 1-4", "วัดการสึกของ Roller Support ",
//         "1234"),
//     Item("สภาพการสึก Support Roller No 1-4", "วัดการสึกของ Roller Support ",
//         "1234"),
//     Item("สภาพการสึก Support Roller No 1-4", "วัดการสึกของ Roller Support ",
//         "1234"),
//   ];

//   int datavalue = -1;

//   @override
//   void initState() {
//     super.initState();
//   }

//   Map<String, int> quantities = {};
//   void takeNumber(String text, String itemId) {
//     try {
//       int number = int.parse(text);
//       quantities[itemId] = number;
//       print(quantities);
//     } on FormatException {}
//   }

//   final kSecondaryColor = Color(0xFF8B94BC);
//   final kPrimaryColor = Color(0xFF748BF5);
//   final kGreenColor = Color.fromARGB(255, 43, 250, 2);
//   final kRedColor = Color.fromARGB(255, 246, 78, 80);
//   final kYellowColor = Color.fromARGB(255, 239, 235, 2);
//   final kGrayColor = Color(0xFFD8D5D5);
//   final kBlackColor = Color(0xFF101010);

//   List<Color> colorYes = List.filled(15, Color(0xFFD8D5D5));
//   List<Color> colorNo = List.filled(15, Color(0xFFD8D5D5));
//   List<Color> colorNA = List.filled(15, Color(0xFFD8D5D5));

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 20,
//             ),
//             const Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Text(
//                   "   PM Check List",
//                   style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsetsDirectional.fromSTEB(20, 5, 20, 5),
//                   child: ListView.builder(
//                     itemCount: itemList.length,
//                     padding: EdgeInsets.zero,
//                     primary: false,
//                     shrinkWrap: true,
//                     scrollDirection: Axis.vertical,
//                     itemBuilder: (context, index) {
//                       //List<dynamic> det = itemList[index].details;
//                       return Column(
//                         children: [
//                           Align(
//                             alignment: Alignment.topLeft,
//                             child: Text(
//                               itemList[index].Group,
//                               style: const TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color.fromARGB(255, 0, 0, 0),
//                                 fontFamily: 'MN KhaotomMat',
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           ListView.builder(
//                             //controller: controller,
//                             itemCount: 3,
//                             padding: EdgeInsets.zero,
//                             primary: false,
//                             shrinkWrap: true,
//                             scrollDirection: Axis.vertical,
//                             itemBuilder: (context, index) {
//                               datavalue += 1;
//                               if (datavalue == 0 ||
//                                   datavalue == 4 ||
//                                   datavalue == 7 ||
//                                   datavalue == 3) {
//                                 return SingleChildScrollView(
//                                   child: Card(
//                                     //ขอบเงากรอบแถบล่าง'

//                                     elevation: 12.0,
//                                     child: SizedBox(
//                                       width: MediaQuery.of(context).size.width *
//                                           0.95,
//                                       child: Column(
//                                         children: [
//                                           Row(
//                                             children: <Widget>[
//                                               Expanded(
//                                                 child: Column(
//                                                   children: [
//                                                     ListTile(
//                                                       title: Row(
//                                                         children: [
//                                                           Text(
//                                                             'Enter ' +
//                                                                 itemList[index]
//                                                                     .Type,
//                                                             //'$index ${det[index].typeName}',
//                                                             style: TextStyle(
//                                                                 color: Colors
//                                                                     .black
//                                                                     .withOpacity(
//                                                                         0.6),
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       subtitle: Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .center,
//                                                         children: [
//                                                           InkWell(
//                                                             onTap: () {
//                                                               setState(() {
//                                                                 colorYes[
//                                                                         index] =
//                                                                     kGreenColor;
//                                                                 colorNo[index] =
//                                                                     kGrayColor;
//                                                                 colorNA[index] =
//                                                                     kGrayColor;

//                                                                 // det[index]
//                                                                 //     .datavalue = 1;
//                                                               });
//                                                             },
//                                                             child: Container(
//                                                               width: 80,
//                                                               height: 25,
//                                                               decoration:
//                                                                   BoxDecoration(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             15.0),
//                                                                 color: colorYes[
//                                                                     index],
//                                                               ),
//                                                               child:
//                                                                   const Center(
//                                                                 child: Text(
//                                                                   "ปกติ",
//                                                                   style:
//                                                                       TextStyle(
//                                                                     fontSize:
//                                                                         14,
//                                                                     color: Colors
//                                                                         .black,
//                                                                   ),
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .center,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Gap(10),
//                                                           InkWell(
//                                                             onTap: () {
//                                                               setState(() {
//                                                                 colorYes[
//                                                                         index] =
//                                                                     kGrayColor;
//                                                                 colorNo[index] =
//                                                                     kRedColor;
//                                                                 colorNA[index] =
//                                                                     kGrayColor;

//                                                                 // det[index]
//                                                                 //     .datavalue = 2;
//                                                               });
//                                                             },
//                                                             child: Container(
//                                                               width: 80,
//                                                               height: 25,
//                                                               decoration:
//                                                                   BoxDecoration(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             15.0),
//                                                                 color: colorNo[
//                                                                     index],
//                                                               ),
//                                                               child:
//                                                                   const Center(
//                                                                 child: Text(
//                                                                   "ไม่ปกติ",
//                                                                   style:
//                                                                       TextStyle(
//                                                                     fontSize:
//                                                                         14,
//                                                                     color: Colors
//                                                                         .black,
//                                                                   ),
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .center,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Gap(10),
//                                                           InkWell(
//                                                             onTap: () {
//                                                               setState(() {
//                                                                 colorYes[
//                                                                         index] =
//                                                                     kGrayColor;
//                                                                 colorNo[index] =
//                                                                     kGrayColor;
//                                                                 colorNA[index] =
//                                                                     kYellowColor;
//                                                                 // det[index]
//                                                                 //     .datavalue = 3;

//                                                                 debugPrint(colorNA[
//                                                                         index]
//                                                                     .toString());
//                                                               });
//                                                             },
//                                                             child: Container(
//                                                               width: 80,
//                                                               height: 25,
//                                                               decoration:
//                                                                   BoxDecoration(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             15.0),
//                                                                 color: colorNA[
//                                                                     index],
//                                                               ),
//                                                               child:
//                                                                   const Center(
//                                                                 child: Text(
//                                                                   "N/A",
//                                                                   style:
//                                                                       TextStyle(
//                                                                     fontSize:
//                                                                         14,
//                                                                     color: Colors
//                                                                         .black,
//                                                                   ),
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .center,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               } else {
//                                 // return Container(
//                                 //   decoration: const BoxDecoration(
//                                 //     color: Colors.white,
//                                 //   ),
//                                 //   child: Row(
//                                 //     children: [
//                                 //       Expanded(
//                                 //           flex: 1, child: Text("${index + 1}")),
//                                 //       Expanded(
//                                 //         flex: 3,
//                                 //         child: TextField(
//                                 //           keyboardType: TextInputType.number,
//                                 //           onChanged: (text) {
//                                 //             //takeNumber(text, item.id);
//                                 //           },
//                                 //           decoration: const InputDecoration(
//                                 //             labelText: "Value",
//                                 //           ),
//                                 //         ),
//                                 //       ),
//                                 //     ],
//                                 //   ),
//                                 // );
//                                 return Container(
//                                     padding:
//                                         const EdgeInsetsDirectional.fromSTEB(
//                                             15, 5, 20, 5),
//                                     child: TextField(
//                                       // controller:
//                                       //     _controller[editext],
//                                       style: const TextStyle(
//                                         fontSize: 20,
//                                         color: Color.fromARGB(255, 245, 8, 0),
//                                         fontFamily: 'MN KhaotomMat',
//                                       ),
//                                       textAlign: TextAlign.left,
//                                       keyboardType: TextInputType.text,
//                                       decoration: InputDecoration(
//                                           border: const OutlineInputBorder(),
//                                           labelText: itemList[index].Type,
//                                           // ignore: prefer_interpolation_to_compose_strings
//                                           hintText:
//                                               'Enter ' + itemList[index].Type,
//                                           contentPadding:
//                                               const EdgeInsets.fromLTRB(
//                                                   10, 0, 10, 30.0),
//                                           isDense: true),
//                                     ));
//                               }
//                             },
//                           )
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
