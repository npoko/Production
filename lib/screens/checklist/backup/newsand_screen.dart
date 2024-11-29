// import 'dart:async';
// import 'package:engineer/models/user_model.dart';
// import 'package:engineer/screens/checklist/checklist_screen.dart';
// import 'package:engineer/themes/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:engineer/models/productiondaily_model.dart';
// import 'package:engineer/services/authenticate_api.dart';
// import 'package:engineer/services/productiondaily_api.dart';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';

// class NewsandScreen extends StatefulWidget {
//   const NewsandScreen({Key? key}) : super(key: key);

//   @override
//   _NewsandScreenState createState() => _NewsandScreenState();
// }

// class _NewsandScreenState extends State<NewsandScreen> {
//   UserModel user = UserModel();
//   AuthenticateApi authenticateApi = AuthenticateApi();
//   int _currentIndex = 0;
//   ProductionDropdownApi productionApi = ProductionDropdownApi();
//   late Future<List<ItemModel>> productionData;
//   Map<String, bool> checkStatus = {}; // To track checked status
//   String? lineID;

//   @override
//   void initState() {
//     super.initState();
//     productionData = productionApi.getProductionDaily();
//     _loadCheckStatus();

//     // Fetch data
//     productionApi.getProductionDaily().then((value) {
//       setState(() {
//         // Initialize check status for each item if not already stored
//         for (var item in value) {
//           if (!checkStatus.containsKey(item.mcID)) {
//             checkStatus[item.mcID] = false; // All items initially unchecked
//           }
//         }
//       });
//       print('Fetched data: $value');
//     }).catchError((error) {
//       print('Error fetching production data: $error');
//     });
//   }

//   // Function to load saved check status from SharedPreferences
//   Future<void> _loadCheckStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? savedCheckStatus = prefs.getString('checkStatus');
//     if (savedCheckStatus != null) {
//       setState(() {
//         checkStatus = Map<String, bool>.from(json.decode(savedCheckStatus));
//       });
//     }
//   }

//   // Function to save check status to SharedPreferences
//   Future<void> _saveCheckStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('checkStatus', json.encode(checkStatus));
//   }

//   bool _allItemsChecked() {
//     // Check if all items in checkStatus have the value true
//     return checkStatus.values.where((isChecked) => isChecked).length ==
//         checkStatus.length;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final args =
//         ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

//     if (args != null) {
//       lineID = args['LineID'].toString();
//     }

//     return Scaffold(
//       backgroundColor: primaryDark,
//       appBar: AppBar(
//         backgroundColor: primary,
//         leading: IconButton(
//           icon:
//               const Icon(Icons.arrow_back_ios_sharp, color: Color(0xff0090df)),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         title: const Text(
//           'Select Checklist',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//       ),
//       body: FutureBuilder<List<ItemModel>>(
//         future: productionData,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No data available'));
//           } else {
//             // Filter the data based on LineID
//             final filteredData =
//                 snapshot.data!.where((item) => item.lineID == lineID).toList();

//             if (filteredData.isEmpty) {
//               return const Center(
//                   child: Text('No items found for this LineID'));
//             }

//             // Group items by McName
//             final groupedByMcName = <String, List<ItemModel>>{};
//             for (var item in filteredData) {
//               groupedByMcName.putIfAbsent(item.mcName, () => []).add(item);
//             }

//             return ListView.builder(
//               itemCount: groupedByMcName.length,
//               itemBuilder: (context, index) {
//                 final mcName = groupedByMcName.keys.elementAt(index);
//                 final items = groupedByMcName[mcName]!;

//                 return GestureDetector(
//                   onTap: () async {
//                     // Navigate to ChecklistScreen and wait for result
//                     final result = await Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ChecklistScreen(
//                           timestamp: DateTime.now(),
//                           mcID: items.first.mcID,
//                           mcName: items.first.mcName,
//                           linename: items.first.linename,
//                           items: items,
//                         ),
//                       ),
//                     );

//                     // Update checkStatus based on the result
//                     if (result != null && result is Map<String, bool>) {
//                       setState(() {
//                         // Update checkStatus based on what was selected in the ChecklistScreen
//                         checkStatus.addAll(result);
//                       });
//                       _saveCheckStatus(); // Save the updated status
//                     }
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 15, horizontal: 16),
//                     margin:
//                         const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF2C2C2C),
//                       borderRadius: BorderRadius.circular(15),
//                       boxShadow: const <BoxShadow>[
//                         BoxShadow(
//                           color: Color(0x3F000000),
//                           blurRadius: 2,
//                           offset: Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             mcName,
//                             style: const TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         Icon(
//                           checkStatus[items.first.mcID] == true
//                               ? Icons.check_circle
//                               : (_allItemsChecked() &&
//                                       checkStatus[items.first.mcID] != null
//                                   ? Icons.check_circle
//                                   : Icons.arrow_forward_ios_outlined),
//                           color: checkStatus[items.first.mcID] == true ||
//                                   _allItemsChecked()
//                               ? Colors.green
//                               : const Color(0xff626164),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//       // Save button
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 backgroundColor: primaryDark,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 title: const Text(
//                   'Confirm Save',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 content: const Text(
//                   'Are you sure you want to save?',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 actions: [
//                   TextButton(
//                     style: TextButton.styleFrom(
//                       foregroundColor: Colors.red,
//                     ),
//                     child: const Text('No'),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                   TextButton(
//                     style: TextButton.styleFrom(
//                       foregroundColor: Colors.green,
//                     ),
//                     child: const Text('Yes'),
//                     onPressed: () {
//                       Navigator.of(context).pop();

//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('Saved successfully!'),
//                           backgroundColor: Colors.green,
//                         ),
//                       );
//                       _saveCheckStatus(); // Save the updated status
//                     },
//                   ),
//                 ],
//               );
//             },
//           );
//         },
//         backgroundColor: bluedark,
//         child: const Icon(Icons.save, color: Colors.white),
//       ),
//     );
//   }
// }
