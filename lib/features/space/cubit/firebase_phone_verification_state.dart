part of 'firebase_phone_verification_cubit.dart';

sealed class FirebasePhoneVerificationState extends Equatable {
  const FirebasePhoneVerificationState();

  @override
  List<Object> get props => [];
}

final class FirebasePhoneVerificationInitial extends FirebasePhoneVerificationState {}



class FirebasePhoneVerificationLoading extends FirebasePhoneVerificationState {}

class FirebasePhoneVerificationCodeSent extends FirebasePhoneVerificationState {
  final String verificationId;

  const FirebasePhoneVerificationCodeSent({required this.verificationId});

  @override
  List<Object> get props => [verificationId];
}


class FirebasePhoneVerificationError extends FirebasePhoneVerificationState {
  final String message;

  const FirebasePhoneVerificationError({required this.message});

  @override
  List<Object> get props => [message];
}


class FirebasePhoneVerificationSuccess extends FirebasePhoneVerificationState {
  final String message;

  const FirebasePhoneVerificationSuccess({required this.message});

  @override
  List<Object> get props => [message];
}


class FirebasePhoneVerificationCodeResent extends FirebasePhoneVerificationState {
  final String verificationId;

  const FirebasePhoneVerificationCodeResent({required this.verificationId});

  @override
  List<Object> get props => [verificationId];
}



