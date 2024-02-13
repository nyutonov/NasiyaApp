part of 'add_sale_bloc.dart';

class AddSaleState {
  List<ClientModel>? clients;
  ClientModel? selectedClient;
  ClientModel? selectedGuarantor;
  String? selectedMoneyType;
  String? name;
  int? price;
  int? nasiyaPrice;
  int? startingPrice;
  int? monthlyPrice;
  int? countSale;
  int? percent;
  String? startingDate;
  String? endingDate;
  String? comment;
  bool? isSendSms;
  Status? status;

  AddSaleState({
    this.clients,
    this.selectedClient,
    this.selectedGuarantor,
    this.selectedMoneyType,
    this.name,
    this.price,
    this.nasiyaPrice,
    this.startingPrice,
    this.monthlyPrice,
    this.countSale,
    this.percent,
    this.startingDate,
    this.endingDate,
    this.comment,
    this.isSendSms,
    this.status
  });

  AddSaleState copyWith({
    List<ClientModel>? clients,
    ClientModel? selectedClient,
    ClientModel? selectedGuarantor,
    String? selectedMoneyType,
    String? name,
    int? price,
    int? nasiyaPrice,
    int? startingPrice,
    int? monthlyPrice,
    int? countSale,
    int? percent,
    String? startingDate,
    String? endingDate,
    String? comment,
    bool? isSendSms,
    Status? status
  }) => AddSaleState(
    clients: clients ?? this.clients,
    selectedClient: selectedClient ?? this.selectedClient,
    selectedGuarantor: selectedGuarantor ?? this.selectedGuarantor,
    selectedMoneyType: selectedMoneyType ?? this.selectedMoneyType,
    name: name ?? this.name,
    price: price ?? this.price,
    nasiyaPrice: nasiyaPrice ?? this.nasiyaPrice,
    startingPrice: startingPrice ?? this.startingPrice,
    monthlyPrice: monthlyPrice ?? this.monthlyPrice,
    countSale: countSale ?? this.countSale,
    percent: percent ?? this.percent,
    startingDate: startingDate ?? this.startingDate,
    endingDate: endingDate ?? this.endingDate,
    comment: comment ?? this.comment,
    isSendSms: isSendSms ?? this.isSendSms,
    status: status ?? this.status
  );
}