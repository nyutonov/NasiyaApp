class SaleModel {
  String? id;
  String? name;
  String? client;
  String? clientId;
  String? guarantor;
  String? guarantorId;
  String? moneyType;
  int? price;
  int? nasiyaPrice;
  int? startingPrice;
  int? countSale;
  int? monthlyPrice;
  String? startingDate;
  String? endingDate;
  String? creatingDate;
  String? employee;
  String? comment;

  SaleModel({
    required this.id,
    required this.name,
    required this.client,
    required this.clientId,
    required this.guarantor,
    required this.guarantorId,
    required this.moneyType,
    required this.price,
    required this.nasiyaPrice,
    required this.startingPrice,
    required this.countSale,
    required this.monthlyPrice,
    required this.startingDate,
    required this.endingDate,
    required this.creatingDate,
    required this.employee,
    required this.comment
  });

  SaleModel.fromJson(dynamic json, String key) {
    id = key;
    name = json['name'];
    client = json['client'];
    clientId = json['client_id'];
    guarantor = json['guarantor'];
    guarantorId = json['guarantor_id'];
    moneyType = json['money_type'];
    price = json['price'];
    nasiyaPrice = json['nasiya_price'];
    startingPrice = json['starting_price'];
    countSale = json['count_sale'];
    monthlyPrice = json['monthly_price'];
    startingDate = json['starting_date'];
    endingDate = json['ending_date'];
    creatingDate = json['creating_date'];
    employee = json['employee'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['name'] = name;
    map['client'] = client;
    map['client_id'] = clientId;
    map['guarantor'] = guarantor;
    map['guarantor_id'] = guarantorId;
    map['money_type'] = moneyType;
    map['price'] = price;
    map['nasiya_price'] = nasiyaPrice;
    map['starting_price'] = startingPrice;
    map['count_sale'] = countSale;
    map['monthly_price'] = monthlyPrice;
    map['starting_date'] = startingDate;
    map['ending_date'] = endingDate;
    map['creating_date'] = creatingDate;
    map['employee'] = employee;
    map['comment'] = comment;

    return map;
  }
}