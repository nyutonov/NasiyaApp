import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nasiya_app/data/model/employee_model.dart';

import '../../../utils/constants.dart';
import '../../../utils/status.dart';

part 'add_employee_event.dart';
part 'add_employee_state.dart';

class AddEmployeeBloc extends Bloc<AddEmployeeEvent, AddEmployeeState> {
  final _appRepository = Constants.appRepository;

  AddEmployeeBloc() : super(AddEmployeeState()) {
    on<AddEmployee>((event, emit) async {
      try {
        emit(state.copyWith(status: Status.LOADING));

        await _appRepository.addEmployee(event.employeeModel);

        emit(state.copyWith(status: Status.SUCCESS));
      } catch (e) {
        emit(state.copyWith(status: Status.ERROR));
      }
    });
  }
}
