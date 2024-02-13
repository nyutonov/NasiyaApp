part of 'add_employee_bloc.dart';

@immutable
abstract class AddEmployeeEvent {}

class AddEmployee extends AddEmployeeEvent {
  final EmployeeModel employeeModel;

  AddEmployee(this.employeeModel);
}