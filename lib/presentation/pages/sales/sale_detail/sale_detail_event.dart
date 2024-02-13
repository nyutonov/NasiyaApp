part of 'sale_detail_bloc.dart';

@immutable
abstract class SaleDetailEvent {}

class Init extends SaleDetailEvent {
  final String id;

  Init(this.id);
}