import 'package:engineer/app_router.dart';
import 'package:engineer/pm_check/screens/screen_selectjobmachin.dart';

import 'package:flutter/material.dart';
import 'package:engineer/models/fatchgetlistmachine_model.dart';
import 'package:engineer/screens/components/custom_menu.dart';
import 'package:engineer/screens/components/machinecard.dart';
import 'package:engineer/screens/navigatorpage/qrcode_screen.dart';
import 'package:engineer/services/productiondaily_api.dart';
import 'package:engineer/themes/colors.dart';

class LineProductionScreen extends StatefulWidget {
  final String lineID;
  final String lineName;

  const LineProductionScreen({
    Key? key,
    required this.lineID,
    required this.lineName,
  }) : super(key: key);

  @override
  _LineProductionScreenState createState() => _LineProductionScreenState();
}

List<Machine> _getUniqueLineIDs(List<Machine> machines) {
  final seenLineIDs = <String>{};
  return machines.where((machine) {
    if (seenLineIDs.contains(machine.lineID)) {
      return false;
    }
    seenLineIDs.add(machine.lineID!);
    return true;
  }).toList();
}

class _LineProductionScreenState extends State<LineProductionScreen> {
  final ProductionDropdownApi _api = ProductionDropdownApi();

  String? _scannedMcID;
  int? _selectedCategoryIndex;
  List<Machine> _allMachines = [];
  List<Machine> _filteredMachines = [];
  Set<String> _displayedMachineIDs = {};
  Map<int, Map<String, String>> allSavedData = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          CustomMenuWidget(
            onToggle: _handleCategoryChange,
          ),
          Expanded(
            child: _buildMachineList(),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: primary,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_ios_sharp, color: Color(0xff0090df)),
      ),
      title: Center(
        child: Text(
          widget.lineName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      // actions: [
      //   IconButton(
      //     onPressed: _navigateToQRScanner,
      //     icon: const Icon(
      //       Icons.qr_code_scanner_outlined,
      //       color: Colors.white,
      //     ),
      //   ),
      // ],
    );
  }

  Widget _buildMachineList() {
    return FutureBuilder<List<Machine>>(
      future: _api.fetchgetlistline(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        }
        final uniqueLines = _getUniqueLineIDs(_filteredMachines);
        _allMachines = snapshot.data!
            .where((machine) => machine.lineID == widget.lineID)
            .toList();

        if (_selectedCategoryIndex == null) {
          _filteredMachines = List.from(_allMachines);
        }

        return _buildMachineListView();
      },
    );
  }

  Widget _buildMachineListView() {
    final groupedByMcID = _filteredMachines
        .where((machine) => machine.mcID != null)
        .fold<Map<String, List<Machine>>>({}, (map, machine) {
      map.putIfAbsent(machine.mcID!, () => []).add(machine);
      return map;
    });

    return ListView.builder(
      itemCount: groupedByMcID.keys.length,
      itemBuilder: (context, index) {
        final mcID = groupedByMcID.keys.elementAt(index);
        final machinesForMcID = groupedByMcID[mcID]!;

        return Column(
          children: [
            MachineCard(
              machine: machinesForMcID.first,
              machines: machinesForMcID,
              initialData: allSavedData,
            ),
          ],
        );
      },
    );
  }

  Map<int, List<Machine>> _groupMachinesByItem(List<Machine> machines) {
    final grouped = <int, List<Machine>>{};
    for (var machine in machines) {
      if (machine.item != null) {
        grouped.putIfAbsent(machine.item!, () => []).add(machine);
      }
    }
    return grouped;
  }

  void _handleCategoryChange(int categoryIndex) {
    setState(() {
      _selectedCategoryIndex = categoryIndex;
      _filterMachinesByCategory(categoryIndex);
    });
  }

  void _filterMachinesByCategory(int categoryIndex) {
    if (categoryIndex >= 0 && categoryIndex <= 5) {
      _filteredMachines = _allMachines
          .where((groupMc) => groupMc.groupMc == (categoryIndex + 1))
          .toList();

      _filteredMachines = _filteredMachines.toSet().toList();
    } else {
      _filteredMachines = List.from(_allMachines);
    }
  }

  Future<void> _navigateToQRScanner() async {
    final scannedData = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => QRViewExample(),
      ),
    );

    if (scannedData != null) {
      setState(() {
        _scannedMcID = scannedData;
      });
    }
  }
}
