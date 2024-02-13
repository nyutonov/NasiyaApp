part of 'add_sale_bloc.dart';

@immutable
abstract class AddSaleEvent {}

class Init extends AddSaleEvent {}

class SelectClient extends AddSaleEvent {
  final ClientModel clientModel;

  SelectClient(this.clientModel);
}

class SelectGuarantor extends AddSaleEvent {
  final ClientModel clientModel;

  SelectGuarantor(this.clientModel);
}

class SelectMoneyType extends AddSaleEvent {
  final String moneyType;

  SelectMoneyType(this.moneyType);
}

class ChangeName extends AddSaleEvent {
  final String name;

  ChangeName(this.name);
}

class ChangePrice extends AddSaleEvent {
  final int price;

  ChangePrice(this.price);
}

class ChangePercent extends AddSaleEvent {
  final int percent;

  ChangePercent(this.percent);
}

class ChangeStartingPrice extends AddSaleEvent {
  final int startingPrice;

  ChangeStartingPrice(this.startingPrice);
}

class ChangeCountSale extends AddSaleEvent {
  final int countSale;

  ChangeCountSale(this.countSale);
}

class ChangeComment extends AddSaleEvent {
  final String comment;

  ChangeComment(this.comment);
}

class ChangeStartingDate extends AddSaleEvent {
  final DateTime startingDate;

  ChangeStartingDate(this.startingDate);
}

class ChangeSmsSend extends AddSaleEvent {
  final bool isSend;

  ChangeSmsSend(this.isSend);
}

class AddSale extends AddSaleEvent {}