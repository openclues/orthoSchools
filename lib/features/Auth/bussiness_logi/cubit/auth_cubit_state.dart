part of 'auth_cubit_cubit.dart';

sealed class AuthCubitState extends Equatable {
  const AuthCubitState();

  @override
  List<Object> get props => [];
}

final class AuthCubitInitial extends AuthCubitState {}

class AuthLoading extends AuthCubitState {}

class AuthLoaded extends AuthCubitState {}

class AuthSignedUp extends AuthCubitState {}

class AuthLoggedIn extends AuthCubitState {
  final String token;

  const AuthLoggedIn(this.token);

  @override
  List<Object> get props => [token];
}

class AuthError extends AuthCubitState {
  final String errorMessage;

  const AuthError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
