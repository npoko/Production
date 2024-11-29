import 'package:engineer/screens/checklist/selectJobMachine_screen.dart';
import 'package:flutter/material.dart';
import 'package:engineer/models/fatchgetlistmachine_model.dart';
import 'package:engineer/themes/colors.dart';
import 'package:intl/intl.dart';

class MachineCard extends StatelessWidget {
  final Machine machine;
  final List<Machine> machines;
  Map<String, bool> checkStatus = {};

  MachineCard(
      {super.key,
      required this.machine,
      required this.machines,
      required initialData});

  bool _allItemsChecked() {
    // Check if all items in checkStatus have the value true
    return checkStatus.values.where((isChecked) => isChecked).length ==
        checkStatus.length;
  }

  int calculateMachineAge() {
    final currentDate = DateTime.now();
    final startDate = machine.mcProStartDate;

    if (startDate == null) {
      return 0; // Return 0 if startDate is null
    }

    int age = currentDate.year - startDate.year;

    if (currentDate.month < startDate.month ||
        (currentDate.month == startDate.month &&
            currentDate.day < startDate.day)) {
      age--;
    }

    return age;
  }

  void _navigateToSelectJobMachine(BuildContext context) async {
    if (machines == null || machines.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Machine data is not available")),
      );
      return;
    }

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectJobMachineScreen(
          machines: machines,
          machine: machine,
          lineName: machine.lineName ?? 'N/A',
          initialData: {},
        ),
      ),
    );

    if (result != null) {
      print('Data returned: $result'); // Handle result as needed
    }
  }

  Widget _buildMachineHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          machine.mcName ?? 'Unknown Machine',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildMachineInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow('McID', machine.mcID ?? 'N/A'),
        _buildInfoRow('Line', machine.lineName ?? 'N/A'),
        _buildInfoRow('Machine Age', '${calculateMachineAge()} years'),
        _buildInfoRow('Checked By', machine.actualCheckedBy ?? 'N/A'),
        _buildStatusRow(),
        _buildDateRow(),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        '$label: $value',
        style: const TextStyle(
          color: Colors.white,
          height: 1.2,
        ),
      ),
    );
  }

  Widget _buildStatusRow() {
    return Text(
      'Status Check: ${machine.statusText ?? 'N/A'}',
      style: TextStyle(
        color: machine.statusColor is Color ? machine.statusColor : Colors.grey,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildDateRow() {
    return Text(
      'Actual Checked Date: ${machine.actualCheckedDate != null ? DateFormat('dd MMMM yyyy').format(machine.actualCheckedDate!) : 'N/A'}',
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 13,
      ),
    );
  }

  Widget _nextButton() {
    return Row(
      children: [
        const Icon(
          Icons.navigate_next_sharp,
          color: Colors.blue,
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: bgcard,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => _navigateToSelectJobMachine(context),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMachineHeader(),
              const SizedBox(height: 8),
              _buildMachineInfo(),
            ],
          ),
        ),
      ),
    );
  }
}
