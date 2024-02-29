import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:equatable/equatable.dart';

part 'firebase_phone_verification_state.dart';

class FirebasePhoneVerificationCubit
    extends Cubit<FirebasePhoneVerificationState> {
  FirebasePhoneVerificationCubit() : super(FirebasePhoneVerificationInitial());

  // Method to send verification code to phone
  void sendCodeToPhone(String phoneNumber) async {
    // Emit loading state
    emit(FirebasePhoneVerificationLoading());
    try {
      // Request verification code from Firebase
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          emit(const FirebasePhoneVerificationSuccess(
              message: 'Verification completed successfully'));
        },
        verificationFailed: (FirebaseAuthException e) {
          emit(FirebasePhoneVerificationError(
              message: e.message ?? 'Verification failed'));
          // emit(FirebasePhoneVerificationFailed(
          //     message: e.message ?? 'Verification failed'));
        },
        codeSent: (String verificationId, int? resendToken) {
          emit(FirebasePhoneVerificationCodeResent(
              verificationId: verificationId));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // emit(FirebasePhoneVerificationAutoRetrievalTimeout(verificationId));
        },
      );
    } catch (e) {
      emit(const FirebasePhoneVerificationError(
          message: 'Error sending verification code'));
    }
  }

  void resetPhoneVerification() {
    emit(FirebasePhoneVerificationInitial());
  }

  // Method to verify the code entered by user
  void verifyCode(String verificationId, String code) async {
    // Emit loading state
    emit(FirebasePhoneVerificationLoading());
    try {
      // Verify the code entered by user
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: code);
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(const FirebasePhoneVerificationSuccess(
          message: 'Verification completed successfully'));
    } catch (e) {
      emit(const FirebasePhoneVerificationError(
          message: 'Error verifying code'));
    }
  }
}
