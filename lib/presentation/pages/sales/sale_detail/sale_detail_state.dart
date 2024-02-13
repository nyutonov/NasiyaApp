part of 'sale_detail_bloc.dart';

class SaleDetailState {
  List<PaymentModel>? payments;
  Status? status;

  SaleDetailState({
    this.payments,
    this.status
  });

  SaleDetailState copyWith({
    List<PaymentModel>? payments,
    Status? status
  }) => SaleDetailState(
    payments: payments ?? this.payments,
    status: status ?? this.status
  );
}