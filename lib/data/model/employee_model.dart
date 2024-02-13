class EmployeeModel {
  String? id;
  String? name;
  String? emailOrPhoneNumber;

  EmployeeModel({
    required this.id,
    required this.name,
    required this.emailOrPhoneNumber
  });

  EmployeeModel.fromJson(dynamic json, String key) {
    id = key;
    name = json['name'];
    emailOrPhoneNumber = json['emailOrPhoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['name'] = name;
    map['emailOrPhoneNumber'] = emailOrPhoneNumber;

    return map;
  }
}