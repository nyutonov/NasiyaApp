part of 'add_client_bloc.dart';

class AddClientState {
  Status? status;

  AddClientState({
    this.status
  });

  AddClientState copyWith({
    Status? status
  }) => AddClientState(
      status: status ?? this.status
  );
}