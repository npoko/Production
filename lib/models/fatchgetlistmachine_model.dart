import 'dart:ui';

import 'package:flutter/material.dart';

class Machine {
  final String mcID;
  final int? item;
  final int? groupMc;
  final double? stdMax;
  final double? stdMin;
  final String lineID;
  final int? mcOrder;
  final String lineName;
  final String lineNameShort;
  final String? description;
  final String? unitID;
  final String? typeofValue;
  final bool? standard;
  final bool? active;
  final bool? active1;
  final String mcName;
  final DateTime mcProStartDate;
  final String actualCheckedBy;
  final DateTime actualCheckedDate;
  final List<ValueField>? valuesList; // Added property for list of value fields
  final List<RadioOption>? radioOptions;
  final String? statusText;
  final Color? statusColor; // Added property for radio options

  Machine({
    required this.mcID,
    this.item,
    this.groupMc,
    this.stdMax,
    this.stdMin,
    required this.lineID,
    this.mcOrder,
    required this.lineName,
    required this.lineNameShort,
    this.description,
    this.unitID,
    this.typeofValue,
    this.standard,
    this.active,
    this.active1,
    required this.mcName,
    required this.mcProStartDate,
    required this.actualCheckedBy,
    required this.actualCheckedDate,
    this.valuesList, // Include in constructor
    this.radioOptions, // Include in constructor
    this.statusText,
    this.statusColor,
    required bool isSelected,
  });

  factory Machine.fromJson(Map<String, dynamic> json) {
    return Machine(
      mcID: json['McID'] ?? '',
      item: json['Item'],
      groupMc: json['GroupMc'],
      stdMax: json['STDMax'] != null ? json['STDMax'].toDouble() : null,
      stdMin: json['STDMin'] != null ? json['STDMin'].toDouble() : null,
      lineID: json['LineID'] ?? '',
      mcOrder: json['McOrder'],
      lineName: json['LineName'] ?? '',
      lineNameShort: json['LineNameShort'] ?? '',
      description: json['Description'],
      unitID: json['UnitID'],
      typeofValue: json['TypeofValue'],
      standard: json['Standard'],
      active: json['Active'],
      active1: json['Active1'],
      mcName: json['McName'] ?? '',
      mcProStartDate: json['McProStartDate'] != null
          ? DateTime.tryParse(json['McProStartDate']) ?? DateTime(2000)
          : DateTime(2000),
      actualCheckedBy: json['ActualCheckedBy'] ?? '',
      actualCheckedDate: json['ActualCheckedDate'] != null
          ? DateTime.tryParse(json['ActualCheckedDate']) ?? DateTime(2000)
          : DateTime(2000),
      valuesList: json['ValuesList'] != null
          ? (json['ValuesList'] as List)
              .map((item) => ValueField.fromJson(item))
              .toList()
          : null,
      radioOptions: json['RadioOptions'] != null
          ? (json['RadioOptions'] as List)
              .map((item) => RadioOption.fromJson(item))
              .toList()
          : null,
      statusText: json['statusText'],
      statusColor: json['statusColor'] != null
          ? Color(int.parse(json['statusColor']))
          : Colors.grey,
      isSelected: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'McID': mcID,
      'Item': item,
      'GroupMc': groupMc,
      'STDMax': stdMax,
      'STDMin': stdMin,
      'LineID': lineID,
      'McOrder': mcOrder,
      'LineName': lineName,
      'LineNameShort': lineNameShort,
      'Description': description,
      'UnitID': unitID,
      'TypeofValue': typeofValue,
      'Standard': standard,
      'Active': active,
      'Active1': active1,
      'McName': mcName,
      'McProStartDate': mcProStartDate.toIso8601String(),
      'ActualCheckedBy': actualCheckedBy,
      'ActualCheckedDate': actualCheckedDate.toIso8601String(),
      'ValuesList': valuesList?.map((item) => item.toJson()).toList(),
      'RadioOptions': radioOptions?.map((item) => item.toJson()).toList(),
    };
  }
}

class ValueField {
  final String label;
  final String? value;

  ValueField({required this.label, this.value});

  factory ValueField.fromJson(Map<String, dynamic> json) {
    return ValueField(
      label: json['Label'] ?? '',
      value: json['Value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Label': label,
      'Value': value,
    };
  }
}

class RadioOption {
  final String label;
  final String value;
  final int id;

  RadioOption({required this.label, required this.value, required this.id});

  factory RadioOption.fromJson(Map<String, dynamic> json) {
    return RadioOption(
      label: json['Label'] ?? '',
      value: json['Value'] ?? '',
      id: json['Id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Label': label,
      'Value': value,
      'Id': id,
    };
  }
}
