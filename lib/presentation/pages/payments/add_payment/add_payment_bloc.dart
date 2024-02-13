import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:nasiya_app/data/model/payment_model.dart';
import 'package:nasiya_app/utils/constants.dart';

import '../../../../data/model/client_model.dart';
import '../../../../data/model/sale_model.dart';
import '../../../../utils/status.dart';

part 'add_payment_event.dart';
part 'add_payment_state.dart';

class AddPaymentBloc extends Bloc<AddPaymentEvent, AddPaymentState> {
  final _appRepository = Constants.appRepository;

  AddPaymentBloc() : super(AddPaymentState(selectedPaymentType: Constants.paymentTypes[0])) {
    on<Init>((event, emit) async {
      try {
        emit(state.copyWith(statusData: Status.LOADING));

        var clients = await _appRepository.getAllClients();

        emit(state.copyWith(clients: clients, statusData: Status.SUCCESS));
      } catch (e) {
        emit(state.copyWith(statusData: Status.ERROR));
      }
    });

    on<SelectClient>((event, emit) async {
      try {
        emit(state.copyWith(statusData: Status.LOADING));

        var sales = await _appRepository.getAllSalesByClient(event.clientModel.id ?? '');

        emit(AddPaymentState(
          clients: state.clients,
          sales: sales,
          selectedClient: event.clientModel,
          quantity: state.quantity,
          selectedPaymentType: state.selectedPaymentType,
          statusData: Status.SUCCESS
        ));
      } catch (e) {
        emit(state.copyWith(statusData: Status.ERROR));
      }
    });

    on<SelectProduct>((event, emit) async {
      emit(state.copyWith(selectedProduct: event.saleModel));
    });

    on<SelectPaymentType>((event, emit) async {
      emit(state.copyWith(selectedPaymentType: event.paymentType));
    });

    on<ChangeQuantity>((event, emit) async {
      emit(state.copyWith(quantity: event.quantity));
    });

    on<AddPayment>((event, emit) async {
      try {
        emit(state.copyWith(status: Status.LOADING));

        await _appRepository.addPayment(PaymentModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            client: state.selectedClient?.name,
            clientId: state.selectedClient?.id,
            saleName: state.selectedProduct?.name,
            saleId: state.selectedProduct?.id,
            quantity: state.quantity,
            moneyType: state.selectedProduct?.moneyType,
            paymentType: state.selectedPaymentType,
            date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
            employee: 'Shahriyor'
        ));

        emit(state.copyWith(status: Status.SUCCESS));
      } catch (e) {
        emit(state.copyWith(status: Status.ERROR));
      }
    });
  }
}