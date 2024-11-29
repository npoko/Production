import 'package:flutter/material.dart';
import 'package:engineer/themes/colors.dart';
import 'package:engineer/models/fatchlineproduction_model.dart';
import 'package:engineer/services/productiondaily_api.dart';

class CustomMenuWidget extends StatefulWidget {
  final Function(int index)? onToggle; // callback function

  const CustomMenuWidget({Key? key, this.onToggle}) : super(key: key);

  @override
  _CustomMenuWidgetState createState() => _CustomMenuWidgetState();
}

class _CustomMenuWidgetState extends State<CustomMenuWidget> {
  int? selectedIndex; // Keep track of the selected index
  List<String> groupMcNames = [
    'Dust Collector',
    'Rotary Reclaimer',
    'Supper Sander',
    'Air Separator',
    'HSM',
    'Other Equipment',
  ];

  void _onButtonPressed(int index) {
    setState(() {
      selectedIndex = index; // Set the selected index
    });
    if (widget.onToggle != null) {
      widget.onToggle!(index); // Execute the callback function, if defined
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection:
            Axis.horizontal, // Set scrolling direction to horizontal
        child: Row(
          children: List.generate(groupMcNames.length, (index) {
            final isSelected = selectedIndex == index;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isSelected ? bluedark : bgcard, // Background color
                  foregroundColor: Colors.white, // Text color
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () => _onButtonPressed(index),
                child: Text(
                  groupMcNames[index],
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
