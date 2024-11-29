import 'package:flutter/material.dart';
import 'package:engineer/models/fatchgetlistmachine_model.dart';
import 'package:engineer/services/productiondaily_api.dart';
import 'package:engineer/themes/colors.dart';

class CustomList extends StatefulWidget {
  final String lineID;
  final String lineName;

  const CustomList({
    Key? key,
    required this.lineID,
    required this.lineName,
  }) : super(key: key);

  @override
  State<CustomList> createState() => _CustomListState();
}

class _CustomListState extends State<CustomList> {
  List<Machine> machineList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMachines();
  }

  Future<void> fetchMachines() async {
    try {
      List<Machine> data = await ProductionDropdownApi().fetchgetlistline();
      setState(() {
        machineList = data;
        isLoading = false;
      });
    } catch (e) {
      print('Failed to load machines: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          primary, // Assuming primary is a defined color in your themes
      appBar: AppBar(
        title: Text("Machine List - ${widget.lineName}"),
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: machineList.length,
              itemBuilder: (context, index) {
                final machine = machineList[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("McID: ${machine.mcID}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text("Item: ${machine.item}",
                            style: TextStyle(fontSize: 14)),
                        Text("GroupMc: ${machine.groupMc}",
                            style: TextStyle(fontSize: 14)),
                        Text("Line Name: ${machine.lineName}",
                            style: TextStyle(fontSize: 14)),
                        Text("Description: ${machine.description}",
                            style: TextStyle(fontSize: 14)),
                        Text("McName: ${machine.mcName}",
                            style: TextStyle(fontSize: 14)),
                        Text("Checked By: ${machine.actualCheckedBy}",
                            style: TextStyle(fontSize: 14)),
                        Text("Checked Date: ${machine.actualCheckedDate}",
                            style: TextStyle(fontSize: 14)),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Standard: ${machine.standard}',
                                style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
