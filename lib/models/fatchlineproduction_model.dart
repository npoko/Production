class LineProductionModel {
  final int companyID;
  final int lineID;
  final List<LineDetail> details;

  var mcID;

  LineProductionModel({
    required this.companyID,
    required this.lineID,
    required this.details,
  });

  factory LineProductionModel.fromJson(Map<String, dynamic> json) {
    return LineProductionModel(
      companyID: json['CompanyID'] ?? 0, // กำหนดค่าเริ่มต้นเป็น 0 หากว่าง
      lineID: json['LineID'] ?? 0, // กำหนดค่าเริ่มต้นเป็น 0 หากว่าง
      details: (json['Details'] as List<dynamic>? ?? [])
          .map((detail) => LineDetail.fromJson(detail))
          .toList(),
    );
  }

  get lineName => null;
}

class LineDetail {
  final int lineID;
  final String lineName;
  final String lineNameShort;
  final bool active;

  LineDetail({
    required this.lineID,
    required this.lineName,
    required this.lineNameShort,
    required this.active,
  });

  factory LineDetail.fromJson(Map<String, dynamic> json) {
    return LineDetail(
      lineID: json['LineID'] ?? 0, // กำหนดค่าเริ่มต้นเป็น 0 หากว่าง
      lineName:
          json['LineName'] ?? '', // กำหนดค่าเริ่มต้นเป็น string ว่าง หากว่าง
      lineNameShort: json['LineNameShort'] ??
          '', // กำหนดค่าเริ่มต้นเป็น string ว่าง หากว่าง
      active: json['Active'] ?? false, // กำหนดค่าเริ่มต้นเป็น false หากว่าง
    );
  }
}
