import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));
String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? firstname;
  String? lastname;
  int? employeeCode;
  String? imageUrl;
  int? siteid;

  UserModel(
      {this.firstname,
      this.lastname,
      this.employeeCode,
      this.imageUrl,
      this.siteid});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstname: json['Firstname'] ?? '',
      lastname: json['LastName'] ?? '',
      employeeCode: json['EmployeeCode'] ?? 0,
      imageUrl: 'https://iot.pinepacific.com/picemp/${json['ImageUrl']}',
      siteid: json['SiteID'] ?? 0,
    );
  }
  Map<String, dynamic> toJson() => {
        'firstname': firstname,
        'lastname': lastname,
        'employeeCode': employeeCode,
        'imageUrl': imageUrl,
        'siteid': siteid,
      };
}
