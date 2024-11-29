// import 'dart:async';
// import 'package:engineer/models/user_model.dart';
// import 'package:engineer/themes/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:engineer/models/productiondaily_model.dart';
// import 'package:engineer/services/authenticate_api.dart';
// import 'package:engineer/services/productiondaily_api.dart';
// import 'package:intl/intl.dart';
// import 'dart:ui';
// import 'package:shared_preferences/shared_preferences.dart';

// class ChecklistScreen extends StatefulWidget {
//   final DateTime timestamp;
//   final String mcID;
//   final String mcName; // mcName
//   final String linename; // linename

//   const ChecklistScreen({
//     Key? key,
//     required this.timestamp,
//     required this.mcID,
//     this.mcName = '',
//     this.linename = '',
//     this.items,
//   }) : super(key: key);

//   @override
//   State<ChecklistScreen> createState() => _ChecklistscreenState();
// }

// class _ChecklistscreenState extends State<ChecklistScreen> {
//   UserModel user = UserModel();
//   AuthenticateApi authenticateApi = AuthenticateApi();
//   int _currentIndex = 0;
//   ProductionDropdownApi productionApi = ProductionDropdownApi();
//   late Future<List<ItemModel>> productionData;
//   late Timer _timer;
//   String _currentTime = '';
//   String? selectedMcName;
//   String? linename;
//   Map<int, bool> _selectedItems = {};
//   Map<int, String> selectedOptions = {};
//   List<String> options = ['Good', 'No Good', 'N/A'];
//   int currentIndex = 0;
//   List<ItemModel>? selectedItems;
//   String? mcName;
//   late TextEditingController timeStartController;

//   @override
//   void initState() {
//     super.initState();
//     productionData = productionApi.getProductionDaily();
//     _updateTime();
//     timeStartController = TextEditingController();

//     // Load selected options from SharedPreferences
//     _loadSelectedOptions();

//     // Retrieve arguments from ModalRoute
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final args =
//           ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

//       if (args != null) {
//         mcName = args['mcName'];
//         selectedItems = args['items'];
//         linename = args['linename'];
//         selectedMcName = args['mcName'];
//       }

//       selectedMcName = mcName;
//     });
//   }

//   // Load selected options from SharedPreferences based on mcName
//   Future<void> _loadSelectedOptions() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       for (int i = 0; i < widget.items!.length; i++) {
//         selectedOptions[i] = prefs.getString('${widget.mcName}_item_$i') ??
//             'Not Selected'; // Use mcName as key
//       }
//     });
//   }

//   void _saveSelectionsAndGoBack() {
//     // Prepare the result to send back
//     Map<String, bool> result = {};
//     for (int i = 0; i < widget.items!.length; i++) {
//       if (selectedOptions[i] == 'Good') {
//         result[widget.items![i].mcID] = true; // Mark as selected
//       }
//     }

//     Navigator.pop(context, result); // Return the selected options
//   }

//   // Save selected options to SharedPreferences based on mcName
//   Future<void> _saveSelectedOptions() async {
//     final prefs = await SharedPreferences.getInstance();
//     for (int i = 0; i < widget.items!.length; i++) {
//       await prefs.setString('${widget.mcName}_item_$i',
//           selectedOptions[i] ?? 'Not Selected'); // Use mcName as key
//     }
//   }

//   // Update timer every second
//   void _updateTime() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (mounted) {
//         setState(() {
//           _currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     timeStartController.dispose();
//     super.dispose();
//   }

//   void _updateSelectedMcName() {
//     if (selectedItems != null &&
//         currentIndex >= 0 &&
//         currentIndex < selectedItems!.length) {
//       selectedMcName = selectedItems![currentIndex].description;
//     } else {
//       selectedMcName = null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primaryDark,
//       appBar: AppBar(
//         backgroundColor: primary,
//         leading: IconButton(
//           icon:
//               const Icon(Icons.arrow_back_ios_sharp, color: Color(0xff0090df)),
//           onPressed: () {
//             _saveSelectionsAndGoBack();
//           },
//         ),
//         title: const Text(
//           'Checklist Details',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//       ),
//       body: Stack(
//         fit: StackFit.expand,
//         alignment: Alignment.center,
//         children: [
//           BackdropFilter(
//             filter: ImageFilter.blur(
//               sigmaX: 30.0,
//               sigmaY: 30.0,
//             ),
//           ),
//           FutureBuilder<List<ItemModel>>(
//             future: productionData,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                 return const Center(child: Text('No data available'));
//               } else {
//                 final data = snapshot.data!;
//                 return Padding(
//                   padding: const EdgeInsets.all(13.0),
//                   child: ListView(
//                     children: [
//                       const SizedBox(height: 5),
//                       Text(
//                         'Line: ${widget.linename ?? 'linename'}',
//                         style: const TextStyle(
//                           fontSize: 16,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         'Time Start: ${DateFormat('HH:mm:ss').format(widget.timestamp)}',
//                         style: const TextStyle(
//                           fontSize: 16,
//                           color: Colors.white,
//                         ),
//                       ),
//                       const Divider(color: Colors.grey, thickness: 0.8),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Flexible(
//                             child: Text(
//                               'MC: ${widget.mcName ?? 'mcName'}',
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       ...?widget.items?.asMap().entries.map((entry) {
//                         int index = entry.key;
//                         ItemModel item = entry.value;
//                         if (item.typeofValue == 'radio') {
//                           return Card(
//                             margin: const EdgeInsets.symmetric(
//                                 vertical: 5, horizontal: 1),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 gradient: () {
//                                   if (selectedOptions[index] == 'Good') {
//                                     return greenGradient;
//                                   } else if (selectedOptions[index] ==
//                                       'No Good') {
//                                     return redGradient;
//                                   } else if (selectedOptions[index] == 'N/A') {
//                                     return yellowGradient;
//                                   }
//                                   return null; // No gradient if not selected
//                                 }(),
//                                 color: selectedOptions[index] == 'Good' ||
//                                         selectedOptions[index] == 'No Good' ||
//                                         selectedOptions[index] == 'N/A'
//                                     ? null
//                                     : divider, // Default color if not selected
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(16.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       '${index + 1}. ${item.description}',
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 8),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       children: options.map((option) {
//                                         Color buttonColor;

//                                         switch (option) {
//                                           case 'Good':
//                                             buttonColor = Colors.black;
//                                             break;
//                                           case 'No Good':
//                                             buttonColor = Colors.black;
//                                             break;
//                                           case 'N/A':
//                                             buttonColor = Colors.black;
//                                             break;
//                                           default:
//                                             buttonColor = Colors.grey;
//                                             break;
//                                         }

//                                         Color textColor =
//                                             selectedOptions[index] == option
//                                                 ? Colors.white
//                                                 : Colors.black;

//                                         return ElevatedButton(
//                                           style: ElevatedButton.styleFrom(
//                                             backgroundColor:
//                                                 selectedOptions[index] == option
//                                                     ? buttonColor
//                                                     : Colors.white,
//                                           ),
//                                           onPressed: () async {
//                                             setState(() {
//                                               selectedOptions[index] =
//                                                   option; // Update selected option
//                                             });
//                                             await _saveSelectedOptions(); // Save the updated option
//                                           },
//                                           child: Text(
//                                             option,
//                                             style: TextStyle(color: textColor),
//                                           ),
//                                         );
//                                       }).toList(),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         }
//                         return const SizedBox(); // For non-radio items, return an empty widget
//                       }),
//                     ],
//                   ),
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
