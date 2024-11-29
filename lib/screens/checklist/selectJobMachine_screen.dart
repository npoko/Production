import 'dart:io';
import 'package:engineer/themes/colors.dart';
import 'package:engineer/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:engineer/models/fatchgetlistmachine_model.dart';

class SelectJobMachineScreen extends StatefulWidget {
  final List<Machine> machines;
  final Machine? machine;
  final String lineName;
  final Map<int, Map<String, String>> initialData;

  SelectJobMachineScreen({
    super.key,
    required this.machines,
    required this.lineName,
    required this.machine,
    required this.initialData,
  });

  @override
  _SelectJobMachineScreenState createState() => _SelectJobMachineScreenState();
}

class _SelectJobMachineScreenState extends State<SelectJobMachineScreen> {
  Map<int, int> selectedButtonIndexMap = {};
  final Map<int, TextEditingController> valueControllers = {};
  final Map<int, TextEditingController> maxControllers = {};
  final Map<int, TextEditingController> minControllers = {};
  final Map<int, TextEditingController> remarkControllers = {};
  final Map<String, String?> radioValues = {};
  final Map<String, bool> showErrors = {};
  bool hasError = false; // Tracks if any errors exist
  final ImagePicker _picker = ImagePicker();
  final Map<String, XFile?> images = {};
  Map<int, Map<String, String>> savedData = {};

  bool isDataValid = true;
  bool isSaving = false;
  @override
  void initState() {
    super.initState();
    // โหลดข้อมูลจาก initialData
    for (int i = 0; i < widget.machines.length; i++) {
      savedData[i] = widget.initialData[i] ?? {};
      valueControllers[i] = TextEditingController(
        text: savedData[i]?['value'] ?? '',
      );
      maxControllers[i] = TextEditingController(
        text: savedData[i]?['max'] ?? '',
      );
      minControllers[i] = TextEditingController(
        text: savedData[i]?['min'] ?? '',
      );
      remarkControllers[i] = TextEditingController(
        text: savedData[i]?['remark'] ?? '',
      );

      // โหลดค่า selectedButtonIndexMap จาก savedData ถ้ามี
      if (savedData[i]?['status'] != null) {
        selectedButtonIndexMap[i] = int.parse(savedData[i]!['status']!);
      }
    }
  }

  @override
  void dispose() {
    valueControllers.values.forEach((controller) => controller.dispose());
    maxControllers.values.forEach((controller) => controller.dispose());
    minControllers.values.forEach((controller) => controller.dispose());
    remarkControllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  Future<void> _loadSavedData(String mcID) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      valueControllers[mcID]?.text = prefs.getString('value_$mcID') ?? '';
      maxControllers[mcID]?.text = prefs.getString('max_$mcID') ?? '';
      minControllers[mcID]?.text = prefs.getString('min_$mcID') ?? '';
      remarkControllers[mcID]?.text = prefs.getString('remark_$mcID') ?? '';
      radioValues[mcID] = prefs.getString('radio_$mcID');
    });
  }

  Future<void> _saveFieldValue(String mcID, String field, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('${field}_$mcID', value);
  }

  Future<void> _pickImage(String mcID) async {
    final image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      images[mcID] = image;
    });
  }

  bool _validateNumericInput(String value) {
    if (value.isEmpty) return false;
    return double.tryParse(value) != null;
  }

  bool _isValueInRange(String mcID) {
    // ตรวจสอบว่าค่าที่กรอกอยู่ในช่วงที่กำหนด
    final double? value = double.tryParse(valueControllers[mcID]?.text ?? '');
    final double? min = double.tryParse(minControllers[mcID]?.text ?? '');
    final double? max = double.tryParse(maxControllers[mcID]?.text ?? '');

    if (value == null || min == null || max == null) {
      return false; // หากมีค่าที่ไม่ใช่ตัวเลข
    }
    return value >= min && value <= max; // อยู่ในช่วง
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Machine Details',
            style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: primaryDark,
      ),
      backgroundColor: primaryDark,
      body: ListView.builder(
        itemCount: widget.machines.length,
        itemBuilder: (context, index) {
          final machine = widget.machines[index];
          final mcID = machine.mcID ?? '';
          final showError = showErrors[mcID] ?? false;
          final typeofValue = machine.typeofValue ?? '';

          return Card(
            elevation: 5,
            color: bgsecondary,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${machine.mcName}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      )),
                  Text('Item: ${machine.item}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      )),
                  Text('Line: ${machine.lineNameShort}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      )),
                  const SizedBox(height: 8),
                  Divider(color: Colors.white, thickness: 0.5),
                  if (machine.typeofValue == 'value') ...[
                    TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: valueControllers[mcID],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Input Value ${machine.unitID}',
                        hintText: 'Enter a value',
                        labelStyle: TextStyle(
                          color: showErrors[mcID] == true
                              ? Colors.red
                              : Colors.white,
                        ),
                        errorText: showErrors[mcID] == true ? 'Required' : null,
                        suffixText: machine.unitID,
                        suffixStyle:
                            TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            style: const TextStyle(color: Colors.white),
                            controller: maxControllers[mcID],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Max',
                              labelStyle: TextStyle(
                                color: showError ? Colors.red : Colors.white,
                              ),
                              errorText: showError ? 'Required' : null,
                            ),
                            onChanged: (value) {
                              setState(() {
                                showErrors[mcID] = value.isEmpty;
                                var isDataValid =
                                    !showErrors.containsValue(true);
                                if (isDataValid) {
                                  selectedButtonIndexMap[index] = 1;
                                  showErrors[mcID] = false;
                                }
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            style: const TextStyle(color: Colors.white),
                            controller: minControllers[mcID],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Min',
                              labelStyle: TextStyle(
                                color: showError ? Colors.red : Colors.white,
                              ),
                              errorText: showError ? 'Required' : null,
                            ),
                            onChanged: (value) {
                              setState(() {
                                showErrors[mcID] = value.isEmpty;
                                var isDataValid =
                                    !showErrors.containsValue(true);
                                if (isDataValid) {
                                  selectedButtonIndexMap[index] = 1;
                                  showErrors[mcID] = false;
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: remarkControllers[mcID],
                      decoration: const InputDecoration(
                        labelText: 'Remark',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () => _pickImage(mcID),
                          icon: const Icon(Icons.camera_alt),
                          label: const Text('Take Picture'),
                        ),
                        if (images[mcID] != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Image.file(
                              File(images[mcID]!.path),
                              height: 100,
                            ),
                          ),
                      ],
                    ),
                  ],
                  if (machine.typeofValue == 'radio') ...[
                    Text('Description: ${machine.description}',
                        style: const TextStyle(color: Colors.white)),
                    const SizedBox(height: 8),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  selectedButtonIndexMap[index] = 0;
                                  showErrors[mcID] = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                iconColor: Colors.blue,
                                backgroundColor:
                                    selectedButtonIndexMap[index] == 0
                                        ? Colors.green
                                        : Colors.grey[300],
                              ),
                              icon: const Icon(Icons.thumb_up),
                              label: const Text('ปกติ',
                                  style: TextStyle(color: Colors.black)),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  selectedButtonIndexMap[index] = 1;
                                  showErrors[mcID] = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                iconColor: Colors.blue,
                                backgroundColor:
                                    selectedButtonIndexMap[index] == 1
                                        ? Colors.red[900]
                                        : Colors.grey[300],
                              ),
                              icon: const Icon(Icons.thumb_down),
                              label: const Text('ไม่ปกติ',
                                  style: TextStyle(color: Colors.black)),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  selectedButtonIndexMap[index] = 2;
                                  showErrors[mcID] = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                iconColor: Colors.blue,
                                backgroundColor:
                                    selectedButtonIndexMap[index] == 2
                                        ? Colors.yellow
                                        : Colors.grey[300],
                              ),
                              icon: const Icon(Icons.help_outline),
                              label: const Text('N/A',
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ],
                        ),
                        if (selectedButtonIndexMap[index] == 1)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextField(
                              style: const TextStyle(color: Colors.white),
                              controller: remarkControllers[mcID],
                              decoration: InputDecoration(
                                labelText: 'Enter reason for abnormality',
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorText:
                                    showError ? 'Reason is required' : null,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  showErrors[mcID] = value.isEmpty;
                                  var isDataValid =
                                      !showErrors.containsValue(true);
                                  if (isDataValid) {
                                    selectedButtonIndexMap[index] = 1;
                                    showErrors[mcID] = false;
                                  }
                                });
                              },
                            ),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isSaving
            ? const CircularProgressIndicator() // แสดงตัวโหลดระหว่างบันทึก
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Save'),
                onPressed: () async {
                  // เริ่มกระบวนการบันทึก
                  // setState(() {
                  //   isSaving = true;
                  // });

                  List<String> errorMessages = [];
                  bool localIsDataValid = true;

                  // ล้างข้อผิดพลาดก่อนตรวจสอบ
                  setState(() {
                    showErrors.clear();
                  });

                  for (int index = 0; index < widget.machines.length; index++) {
                    final machine = widget.machines[index];
                    final mcID = machine.mcID ?? '';
                    final typeofValue = machine.typeofValue ?? '';

                    if (typeofValue == 'value') {
                      // Validate value, max, and min
                      final value = valueControllers[mcID]?.text ?? '';
                      final max = maxControllers[mcID]?.text ?? '';
                      final min = minControllers[mcID]?.text ?? '';
                      final remark = remarkControllers[mcID]?.text ?? '';

                      bool isValid = _validateNumericInput(value) &&
                          (max.isEmpty || _validateNumericInput(max)) &&
                          (min.isEmpty || _validateNumericInput(min));

                      if (isValid && max.isNotEmpty && min.isNotEmpty) {
                        final double? numValue = double.tryParse(value);
                        final double? numMax = double.tryParse(max);
                        final double? numMin = double.tryParse(min);

                        if (numValue != null &&
                            numMax != null &&
                            numMin != null &&
                            (numValue < numMin || numValue > numMax)) {
                          isValid = false;
                        }
                        localIsDataValid = true;
                      } else {
                        localIsDataValid = false;
                      }

                      debugPrint(
                          'Saving value for mcID: $mcID, field: value, value: ${valueControllers[mcID]?.text}');
                      setState(() {
                        showErrors[mcID] = !isValid;
                      });
                      if (!selectedButtonIndexMap.containsKey(index)) {
                        debugPrint('Error: No status selected for mcID: $mcID');
                        // continue; // ข้าม index นี้
                      }
                      if (!isValid) {
                        errorMessages
                            .add('Invalid value for ${machine.mcName}');
                        //localIsDataValid = false;
                      }
                    } else if (typeofValue == 'radio') {
                      // Validate radio and remark
                      if (!selectedButtonIndexMap.containsKey(index)) {
                        errorMessages.add(
                            'Please select a status for ${machine.mcName}');
                        setState(() {
                          showErrors[mcID] = true;
                        });
                        localIsDataValid = false;
                      } else if (selectedButtonIndexMap[index] == 1) {
                        final remark = remarkControllers[mcID]?.text ?? '';
                        if (remark.isEmpty) {
                          errorMessages.add(
                              'Please enter a remark for ${machine.mcName}');
                          setState(() {
                            showErrors[mcID] = true;
                          });
                          localIsDataValid = false;
                        } else {
                          setState(() {
                            showErrors[mcID] = false;
                          });
                        }
                      }
                    }
                  }

                  print(localIsDataValid.toString());

                  if (!localIsDataValid) {
                    // แสดงข้อความข้อผิดพลาด
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('กรุณากรอกข้อมูลให้ครบถ้วน'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  // กระบวนการบันทึกข้อมูล
                  for (int index = 0; index < widget.machines.length; index++) {
                    final mcID = widget.machines[index].mcID;

                    if (mcID == null || mcID.isEmpty) {
                      debugPrint(
                          'Error: mcID is null or empty for index $index');
                      continue; // ข้าม index นี้
                    }

                    try {
                      // ตรวจสอบหรือกำหนดสถานะเริ่มต้น
                      if (!selectedButtonIndexMap.containsKey(index)) {
                        selectedButtonIndexMap[index] = 0; // ค่าเริ่มต้น เช่น 0
                      }

                      // บันทึกค่า value
                      final value = valueControllers[mcID]?.text ?? '';
                      debugPrint(
                          'Saving value for mcID: $mcID, field: value, value: $value');
                      await _saveFieldValue(mcID, 'value', value);

                      // บันทึกค่า max
                      final max = maxControllers[mcID]?.text ?? '';
                      debugPrint(
                          'Saving max for mcID: $mcID, field: max, value: $max');
                      await _saveFieldValue(mcID, 'max', max);

                      // บันทึกค่า min
                      final min = minControllers[mcID]?.text ?? '';
                      debugPrint(
                          'Saving min for mcID: $mcID, field: min, value: $min');
                      await _saveFieldValue(mcID, 'min', min);

                      // บันทึกค่า remark
                      final remark = remarkControllers[mcID]?.text ?? '';
                      debugPrint(
                          'Saving remark for mcID: $mcID, field: remark, value: $remark');
                      await _saveFieldValue(mcID, 'remark', remark);

                      // บันทึก status
                      final status =
                          selectedButtonIndexMap[index]?.toString() ?? '';
                      debugPrint(
                          'Saving status for mcID: $mcID, field: status, value: $status');
                      await _saveFieldValue(mcID, 'status', status);
                    } catch (e) {
                      debugPrint(
                          'Selected status for mcID: ${widget.machines[index].mcID} is ${selectedButtonIndexMap[index]}');

                      debugPrint('Error saving data: $e');
                      // แสดงข้อความข้อผิดพลาด
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('เกิดข้อผิดพลาดในการบันทึกข้อมูล'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      action: SnackBarAction(
                        label: 'เสร็จสิ้น',
                        onPressed: () {},
                      ),
                      content: const Text('บันทึกสําเร็จ!'),
                      duration: const Duration(milliseconds: 1500),
                      width: 280.0, // Width of the SnackBar.
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, // Inner padding for SnackBar content.
                      ),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  );
                  // กลับไปหน้าก่อนหน้า
                  Navigator.pop(context);
                },
              ),
      ),
    );
  }
}
