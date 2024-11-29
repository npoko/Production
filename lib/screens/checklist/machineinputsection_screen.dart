import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MachineInputSection extends StatefulWidget {
  final String mcID;
  final String? unitID;
  final String? typeofValue;
  final TextEditingController textController;
  final String? radioValue;
  final ValueChanged<String?> onTextChanged;
  final ValueChanged<String?> onRadioChanged;
  final List<String> radioOptions;
  final int? item;

  MachineInputSection({
    required this.mcID,
    required this.unitID,
    required this.typeofValue,
    required this.textController,
    required this.radioValue,
    required this.onTextChanged,
    required this.onRadioChanged,
    required this.radioOptions,
    required this.item,
  });

  @override
  State<MachineInputSection> createState() => _MachineInputSectionState();
}

class _MachineInputSectionState extends State<MachineInputSection> {
  @override
  Widget build(BuildContext context) {
    if (widget.typeofValue == 'value') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: widget.textController,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              labelText: 'Input Value (${widget.unitID})',
              hintText: 'Enter a value',
              labelStyle: TextStyle(color: Colors.white),
              suffixText: widget.unitID,
              suffixStyle: TextStyle(color: Colors.white, fontSize: 18),
            ),
            style: TextStyle(color: Colors.white),
            onChanged: widget.onTextChanged,
          ),
        ],
      );
    } else if (widget.typeofValue == 'radio') {
      return Row(
        children: [
          Expanded(
            child: RadioListTile<String>(
              activeColor: Colors.green,
              title: Text('Normal',
                  style: TextStyle(fontSize: 14, color: Colors.white)),
              value: 'Normal',
              groupValue: widget.radioValue,
              onChanged: widget.onRadioChanged,
            ),
          ),
          Expanded(
            child: RadioListTile<String>(
              activeColor: Colors.red,
              title: Text('Not Normal',
                  style: TextStyle(fontSize: 14, color: Colors.white)),
              value: 'Not Normal',
              groupValue: widget.radioValue,
              onChanged: widget.onRadioChanged,
            ),
          ),
        ],
      );
    }
    return SizedBox.shrink();
  }
}

class SharedPreferencesHelper {
  static Future<void> saveData(
      String mcID, String value, String radioValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('mcID_$mcID', value);
    await prefs.setString('radio_$mcID', radioValue);
  }

  static Future<Map<String, String?>> loadSavedData(String mcID) async {
    final prefs = await SharedPreferences.getInstance();
    final savedValue = prefs.getString('mcID_$mcID');
    final savedRadio = prefs.getString('radio_$mcID');
    return {
      'value': savedValue,
      'radio': savedRadio,
    };
  }
}
