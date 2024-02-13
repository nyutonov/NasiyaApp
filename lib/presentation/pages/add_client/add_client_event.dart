part of 'add_client_bloc.dart';

@immutable
abstract class AddClientEvent {}

class AddClient extends AddClientEvent {
  ClientModel clientModel;

  AddClient(this.clientModel);
}