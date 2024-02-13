part of 'add_employee_bloc.dart';

class AddEmployeeState {
  Status? status;

  AddEmployeeState({
    this.status
  });

  AddEmployeeState copyWith({
    Status? status
  }) => AddEmployeeState(
      status: status ?? this.status
  );
}