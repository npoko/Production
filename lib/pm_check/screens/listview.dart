// import 'package:engineer/services/productiondaily_api.dart';
// import 'package:flutter/material.dart';
// import 'package:engineer/models/productiondaily_model.dart';

// class ListviewScreen extends StatefulWidget {
//   const ListviewScreen({super.key});

//   @override
//   State<ListviewScreen> createState() => _ListviewScreenState();
// }

// class _ListviewScreenState extends State<ListviewScreen> {
//   //List<ProductiondailyModel> list = [];
//   void GetList() async {
//     var data = await ProductionDropdownApi().getProductionDaily();
//     setState(() {
//       list = data;
//     });
//   }

//   void initState() {
//     super.initState();
//     GetList();
//   }

// //Todo: implement build
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Listview'),
//       ),
//       body: SizedBox(
//         height: double.infinity,
//         child: ListView.builder(
//           itemCount: list.length,
//           itemBuilder: (BuildContext context, int index) {
//             debugPrint(list.length.toString());
//             return ListTile(
//               title: Text(list[index].item.toString()),
//               subtitle: Text(list[index].description.toString()),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
