part of 'add_payment_bloc.dart';

@immutable
abstract class AddPaymentEvent {}

class Init extends AddPaymentEvent {}

class AddPayment extends AddPaymentEvent {}

class SelectClient extends AddPaymentEvent {
  final ClientModel clientModel;

  SelectClient(this.clientModel);
}

class SelectProduct extends AddPaymentEvent {
  final SaleModel saleModel;

  SelectProduct(this.saleModel);
}

class ChangeQuantity extends AddPaymentEvent {
  final int quantity;

  ChangeQuantity(this.quantity);
}

class SelectPaymentType extends AddPaymentEvent {
  final String paymentType;

  SelectPaymentType(this.paymentType);
}