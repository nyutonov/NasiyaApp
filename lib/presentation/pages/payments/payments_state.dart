part of 'payments_bloc.dart';

class PaymentsState {
  List<PaymentModel>? payments;
  Status? status;

  PaymentsState({
    this.payments,
    this.status
  });

  PaymentsState copyWith({
    List<PaymentModel>? payments,
    bool? dialog,
    Status? status
  }) => PaymentsState(
      payments: payments ?? this.payments,
      status: status ?? this.status
  );
}