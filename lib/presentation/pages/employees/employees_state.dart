part of 'employees_bloc.dart';

class EmployeesState {
  List<EmployeeModel>? employees;
  Status? status;

  EmployeesState({
    this.employees,
    this.status
  });

  EmployeesState copyWith({
    List<EmployeeModel>? employees,
    bool? dialog,
    Status? status
  }) => EmployeesState(
      employees: employees ?? this.employees,
      status: status ?? this.status
  );
}