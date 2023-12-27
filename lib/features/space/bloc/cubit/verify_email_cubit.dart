import 'package:azsoon/features/space/bloc/cubit/repo/verify_email_cupit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'verify_email_state.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  VerifyEmailCubit() : super(VerifyEmailInitial());
  VerifyEmailRepo verifyEmailRepo = VerifyEmailRepo();

  void sendCodeToEmail() async {
    emit(const EmailVerificationLoading());
    try {
      var response = await verifyEmailRepo.sendCodeToEmail();
      if (response.statusCode == 200) {
        emit(const EmialCodeSent());
      } else {
        emit(const EmailVerificationFailed());
      }
    } catch (e) {
      emit(const EmailVerificationFailed());
    }
  }

  void verifyEmail(String code) async {
    emit(const EmailVerificationLoading());
    try {
      var response = await verifyEmailRepo.verifyEmail(code);
      if (response.statusCode == 200) {
        emit(const EmailVerified());
      } else {
        emit(const EmailVerificationFailed());
      }
    } catch (e) {
      emit(const EmailVerificationFailed());
    }
  }
}
