part of 'verification_bloc.dart';

sealed class VerificationState extends Equatable {
  const VerificationState();
  
  @override
  List<Object> get props => [];
}

final class VerificationInitial extends VerificationState {}
