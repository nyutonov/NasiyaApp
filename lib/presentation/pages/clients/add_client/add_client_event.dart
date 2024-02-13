part of 'add_client_bloc.dart';

@immutable
abstract class AddClientEvent {}

class AddClient extends AddClientEvent {
  final ClientModel clientModel;

  AddClient(this.clientModel);
}