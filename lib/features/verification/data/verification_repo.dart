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
    Map<String, String>? data;
    if (firstName != null) {
      data = {'first_name': firstName};
    }
    if (lastName != null) {
      data = {'last_name': lastName};
    }
    if (speciality != null) {
      data = {'speciality': speciality};
    }
    if (studyIn != null) {
      data = {'study_in': studyIn};
    }

    var response = await RequestHelper.put(ApiEndpoints.updateProfile, data,
        files: {'id_card': cardId, 'selfie': selfie});
    return response;
  }
}
