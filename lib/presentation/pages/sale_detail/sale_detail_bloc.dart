import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nasiya_app/data/model/payment_model.dart';
import 'package:nasiya_app/utils/constants.dart';

import '../../../utils/status.dart';

part 'sale_detail_event.dart';
part 'sale_detail_state.dart';

class SaleDetailBloc extends Bloc<SaleDetailEvent, SaleDetailState> {
  final _appRepository = Constants.appRepository;

  SaleDetailBloc() : super(SaleDetailState()) {
    on<Init>((event, emit) async {
      try {
        emit(state.copyWith(status: Status.LOADING));

        final payments = await _appRepository.getAllPaymentsBySale(event.id);

        emit(state.copyWith(payments: payments, status: Status.SUCCESS));
      } catch (e) {
        emit(state.copyWith(status: Status.ERROR));
      }
    });
  }
}