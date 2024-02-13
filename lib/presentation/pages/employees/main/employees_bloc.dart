import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nasiya_app/data/model/employee_model.dart';
import 'package:nasiya_app/utils/constants.dart';

import '../../../../utils/status.dart';

part 'employees_event.dart';
part 'employees_state.dart';

class EmployeesBloc extends Bloc<EmployeesEvent, EmployeesState> {
  final _appRepository = Constants.appRepository;

  EmployeesBloc() : super(EmployeesState()) {
    on<Init>((event, emit) async {
      try {
        emit(state.copyWith(status: Status.LOADING));

        // var employees = state.employees;

        var employees = await _appRepository.getAllEmployees();

        emit(state.copyWith(employees: employees, status: Status.SUCCESS));
      } catch (e) {
        emit(state.copyWith(status: Status.ERROR));
      }
    });
  }
}
