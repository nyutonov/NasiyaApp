part of 'add_sale_bloc.dart';

@immutable
abstract class AddSaleEvent {}

class Init extends AddSaleEvent {}

class SelectClient extends AddSaleEvent {
  ClientModel clientModel;

  SelectClient(this.clientModel);
}

class SelectGuarantor extends AddSaleEvent {
  ClientModel clientModel;

  SelectGuarantor(this.clientModel);
}

class SelectMoneyType extends AddSaleEvent {
  String moneyType;

  SelectMoneyType(this.moneyType);
}

class ChangeName extends AddSaleEvent {
  String name;

  ChangeName(this.name);
}

class ChangePrice extends AddSaleEvent {
  int price;

  ChangePrice(this.price);
}

class ChangePercent extends AddSaleEvent {
  int percent;

  ChangePercent(this.percent);
}

class ChangeStartingPrice extends AddSaleEvent {
  int startingPrice;

  ChangeStartingPrice(this.startingPrice);
}

class ChangeCountSale extends AddSaleEvent {
  int countSale;

  ChangeCountSale(this.countSale);
}

class ChangeComment extends AddSaleEvent {
  String comment;

  ChangeComment(this.comment);
}

class ChangeStartingDate extends AddSaleEvent {
  DateTime startingDate;

  ChangeStartingDate(this.startingDate);
}

class ChangeSmsSend extends AddSaleEvent {
  bool isSend;

  ChangeSmsSend(this.isSend);
}

class AddSale extends AddSaleEvent {}