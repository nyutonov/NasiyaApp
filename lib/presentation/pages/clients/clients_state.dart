part of 'clients_bloc.dart';

class ClientsState {
  List<ClientModel>? clients;
  Status? status;

  ClientsState({
    this.clients,
    this.status
  });

  ClientsState copyWith({
    List<ClientModel>? clients,
    bool? dialog,
    Status? status
  }) => ClientsState(
      clients: clients ?? this.clients,
      status: status ?? this.status
  );
}