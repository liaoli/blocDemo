// user_state.dart
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final String name;
  final String email;
  UserLoaded({required this.name, required this.email});
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}
