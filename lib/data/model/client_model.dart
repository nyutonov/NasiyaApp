class ClientModel {
  String? id;
  String? name;
  String? phoneNumber;

  ClientModel({
    required this.id,
    required this.name,
    required this.phoneNumber
  });

  ClientModel.fromJson(dynamic json, String key) {
    id = key;
    name = json['name'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['name'] = name;
    map['phone_number'] = phoneNumber;

    return map;
  }
}