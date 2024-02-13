class PaymentModel {
  String? id;
  String? client;
  String? clientId;
  String? saleName;
  String? saleId;
  int? quantity;
  String? moneyType;
  String? paymentType;
  String? date;
  String? employee;

  PaymentModel({
    required this.id,
    required this.client,
    required this.clientId,
    required this.saleName,
    required this.saleId,
    required this.quantity,
    required this.moneyType,
    required this.paymentType,
    required this.date,
    required this.employee
  });

  PaymentModel.fromJson(dynamic json, String key) {
    id = key;

    client = json['client'];
    clientId = json['client_id'];
    saleName = json['sale_name'];
    saleId = json['sale_id'];
    quantity = json['quantity'];
    moneyType = json['money_type'];
    paymentType = json['payment_type'];
    date = json['date'];
    employee = json['employee'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['client'] = client;
    map['client_id'] = clientId;
    map['sale_name'] = saleName;
    map['sale_id'] = saleId;
    map['quantity'] = quantity;
    map['money_type'] = moneyType;
    map['payment_type'] = paymentType;
    map['date'] = date;
    map['employee'] = employee;

    return map;
  }
}