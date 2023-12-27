part of 'verify_email_cubit.dart';

sealed class VerifyEmailState extends Equatable {
  const VerifyEmailState();

  @override
  List<Object> get props => [];
}

final class VerifyEmailInitial extends VerifyEmailState {}


class EmialCodeSent extends VerifyEmailState {
  const EmialCodeSent();

  @override
  List<Object> get props => [];
}


class EmailVerified extends VerifyEmailState {
  const EmailVerified();

  @override
  List<Object> get props => [];
}


class EmailVerificationFailed extends VerifyEmailState {
  const EmailVerificationFailed();

  @override
  List<Object> get props => [];
}


class EmailVerificationLoading extends VerifyEmailState {
  const EmailVerificationLoading();

  @override
  List<Object> get props => [];
}



