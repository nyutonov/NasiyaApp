import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nasiya_app/data/model/sale_model.dart';
import 'package:nasiya_app/utils/constants.dart';

import '../../../../utils/status.dart';

part 'sales_event.dart';
part 'sales_state.dart';

class SalesBloc extends Bloc<SalesEvent, SalesState> {
  final _appRepository = Constants.appRepository;

  SalesBloc() : super(SalesState()) {
    on<Init>((event, emit) async {
      try {
        emit(state.copyWith(status: Status.LOADING));

        // var sales = state.sales;

        var sales = await _appRepository.getAllSales();

        emit(state.copyWith(sales: sales, status: Status.SUCCESS));
      } catch (e) {
        emit(state.copyWith(status: Status.ERROR));
      }
    });
  }
}