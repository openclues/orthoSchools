import 'dart:io';

import 'package:azsoon/Core/network/endpoints.dart';
import 'package:azsoon/Core/network/request_helper.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class VerificationRepo {
  Future<Response> loadProfileData() async {
    var response = await RequestHelper.put(ApiEndpoints.updateProfile, {});
    return response;
  }

  Future<Response> updateProfile(
      {String? firstName,
      String? lastName,
      XFile? selfie,
      XFile? cardId,
      String? speciality,
      String? studyIn}) async {
    var response = await RequestHelper.put(ApiEndpoints.updateProfile, {
      // 'first_name': firstName,
      // 'last_name': lastName,
      // 'speciality': speciality,
      // 'study_in': studyIn,
      // 'selfie': selfie
    }, files: {
      'id_card': cardId,
      'selfie': selfie
    });
    return response;
  }
}
