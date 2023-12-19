part of 'verification_bloc.dart';

sealed class VerificationState extends Equatable {
  const VerificationState();

  @override
  List<Object> get props => [];
}

final class VerificationInitial extends VerificationState {}

class VerificationLoading extends VerificationState {}

class VerificationLoaded extends VerificationState {
  final Profile profile;

  const VerificationLoaded({required this.profile});

  @override
  List<Object> get props => [profile];

  VerificationLoaded copyWith({
    Profile? profile,
  }) {
    return VerificationLoaded(
      profile: profile ?? this.profile,
    );
  }
}
