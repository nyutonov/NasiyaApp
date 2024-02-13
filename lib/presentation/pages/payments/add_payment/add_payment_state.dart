part of 'add_payment_bloc.dart';

class AddPaymentState {
  List<ClientModel>? clients;
  List<SaleModel>? sales;
  SaleModel? selectedProduct;
  ClientModel? selectedClient;
  int? quantity;
  String? selectedPaymentType;
  Status? status;
  Status? statusData;

  AddPaymentState({
    this.clients,
    this.sales,
    this.selectedProduct,
    this.selectedClient,
    this.quantity,
    this.selectedPaymentType,
    this.status,
    this.statusData
  });

  AddPaymentState copyWith({
    List<ClientModel>? clients,
    List<SaleModel>? sales,
    SaleModel? selectedProduct,
    ClientModel? selectedClient,
    int? quantity,
    String? selectedPaymentType,
    Status? status,
    Status? statusData
  }) => AddPaymentState(
      clients: clients ?? this.clients,
      sales: sales ?? this.sales,
      selectedProduct: selectedProduct ?? this.selectedProduct,
      selectedClient: selectedClient ?? this.selectedClient,
      quantity: quantity ?? this.quantity,
      selectedPaymentType: selectedPaymentType ?? this.selectedPaymentType,
      status: status ?? this.status,
      statusData: statusData ?? this.statusData
  );
}