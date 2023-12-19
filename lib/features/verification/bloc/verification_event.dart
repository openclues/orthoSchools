part of 'verification_bloc.dart';

sealed class VerificationEvent extends Equatable {
  const VerificationEvent();

  @override
  List<Object> get props => [];
}

class UpdateProfileEvent extends VerificationEvent {
  final XFile? cardId;
  final XFile? selfie;
  final String? firstName;
  final String? lastName;
  final String? speciality;

  const UpdateProfileEvent(
      { this.cardId,
       this.selfie,
       this.firstName,
       this.lastName,
       this.speciality});
}

class LoadProfileData extends VerificationEvent {
  const LoadProfileData();

  @override
  List<Object> get props => [];
}
