part of 'sales_bloc.dart';

class SalesState {
  List<SaleModel>? sales;
  Status? status;

  SalesState({
    this.sales,
    this.status
  });

  SalesState copyWith({
    List<SaleModel>? sales,
    bool? dialog,
    Status? status
  }) => SalesState(
      sales: sales ?? this.sales,
      status: status ?? this.status
  );
}