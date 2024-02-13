import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nasiya_app/utils/constants.dart';

import '../../../data/model/client_model.dart';
import '../../../utils/status.dart';

part 'clients_event.dart';
part 'clients_state.dart';

class ClientsBloc extends Bloc<ClientsEvent, ClientsState> {
  final _appRepository = Constants.appRepository;

  ClientsBloc() : super(ClientsState()) {
    on<Init>((event, emit) async {
      try {
        emit(state.copyWith(status: Status.LOADING));

        // var clients = state.sales;

        var clients = await _appRepository.getAllClients();

        emit(state.copyWith(clients: clients, status: Status.SUCCESS));
      } catch (e) {
        emit(state.copyWith(status: Status.ERROR));
      }
    });
  }
}
