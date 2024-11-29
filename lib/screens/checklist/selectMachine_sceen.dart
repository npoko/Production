import 'package:engineer/app_router.dart';
import 'package:engineer/models/fatchgetlistmachine_model.dart';
import 'package:engineer/screens/checklist/lineproduction_screen.dart';
import 'package:engineer/screens/drawerpage/drawer_menu.dart';
import 'package:engineer/services/productiondaily_api.dart';
import 'package:engineer/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectMachineScreen extends StatelessWidget {
  final ProductionDropdownApi api = ProductionDropdownApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryDark,
      appBar: AppBar(
        backgroundColor: primary,
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.menu_home),
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        actions: <Widget>[logout(context)],
      ),
      drawer: Drawer(
        backgroundColor:
            Colors.white, // Directly apply the background color here
        child: DrawerMenu(), // Your drawer content
      ),
      body: FutureBuilder<List<Machine>>(
        future: api.fetchgetlistline(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 48),
                  Text(
                    'Failed to load data',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      // Add refresh logic here if needed
                    },
                    child: Text('Retry', style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No machines available',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          final machines = snapshot.data!;
          final uniqueMachines = <String, Machine>{};
          for (var machine in machines) {
            if (!uniqueMachines.containsKey(machine.lineID)) {
              uniqueMachines[machine.lineID] = machine;
            }
          }

          final uniqueMachineList = uniqueMachines.values.toList();

          return ListView.builder(
            itemCount: uniqueMachineList.length,
            itemBuilder: (context, index) {
              final machine = uniqueMachineList[index];
              return _buildCard(machine, context);
            },
          );
        },
      ),
    );
  }

  Widget _buildCard(Machine machine, BuildContext context) {
    // Mapping gradients
    const gradientMap = {
      '1001': greenGradient,
      '1002': greenGradient,
      '1003': yellowGradient,
      '1004': redGradient,
      '1005': redGradient,
    };

    final gradient = gradientMap[machine.lineID] ?? blueGradient;

    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          // Removed the leading CircleAvatar with Icon
          title: Text(
            'Line ID: ${machine.lineID}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            'Line Name: ${machine.lineName}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: icons),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LineProductionScreen(
                  lineID: machine.lineID,
                  lineName: machine.lineName,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget logout(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.logout,
        color: Colors.red,
      ),
      onPressed: () {
        Navigator.of(context).pushReplacementNamed(AppRouter.login);
      },
    );
  }
}
