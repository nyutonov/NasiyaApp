import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nasiya_app/data/model/payment_model.dart';
import 'package:nasiya_app/utils/constants.dart';

import '../../../../utils/status.dart';

part 'payments_event.dart';
part 'payments_state.dart';

class PaymentsBloc extends Bloc<PaymentsEvent, PaymentsState> {
  final _appRepository = Constants.appRepository;

  PaymentsBloc() : super(PaymentsState()) {
    on<Init>((event, emit) async {
      try {
        emit(state.copyWith(status: Status.LOADING));

        // var payments = state.payments;

        var payments = await _appRepository.getAllPayments();

        emit(state.copyWith(payments: payments, status: Status.SUCCESS));
      } catch (e) {
        emit(state.copyWith(status: Status.ERROR));
      }
    });
  }
}
