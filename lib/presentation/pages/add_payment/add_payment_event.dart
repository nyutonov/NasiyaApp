part of 'add_payment_bloc.dart';

@immutable
abstract class AddPaymentEvent {}

class Init extends AddPaymentEvent {}

class AddPayment extends AddPaymentEvent {}

class SelectClient extends AddPaymentEvent {
  ClientModel clientModel;

  SelectClient(this.clientModel);
}

class SelectProduct extends AddPaymentEvent {
  SaleModel saleModel;

  SelectProduct(this.saleModel);
}

class ChangeQuantity extends AddPaymentEvent {
  int quantity;

  ChangeQuantity(this.quantity);
}

class SelectPaymentType extends AddPaymentEvent {
  String paymentType;

  SelectPaymentType(this.paymentType);
}