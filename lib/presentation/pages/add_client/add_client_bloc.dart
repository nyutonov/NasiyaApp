import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nasiya_app/data/model/client_model.dart';
import 'package:nasiya_app/utils/constants.dart';

import '../../../utils/status.dart';

part 'add_client_event.dart';
part 'add_client_state.dart';

class AddClientBloc extends Bloc<AddClientEvent, AddClientState> {
  final _appRepository = Constants.appRepository;

  AddClientBloc() : super(AddClientState()) {
    on<AddClient>((event, emit) async {
      try {
        emit(state.copyWith(status: Status.LOADING));

        await _appRepository.addClient(event.clientModel);

        emit(state.copyWith(status: Status.SUCCESS));
      } catch (e) {
        emit(state.copyWith(status: Status.ERROR));
      }
    });
  }
}
