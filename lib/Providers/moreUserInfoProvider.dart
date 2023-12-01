import 'package:azsoon/Core/common-methods.dart';
import 'package:azsoon/model/user-info.dart';
import 'package:flutter/material.dart';

class MoreInfoUserProvider with ChangeNotifier {
  late MoreInfo _moreInfo;
  String? selectedProfileImage;
  String? selectedBannnerCover;
  User? theuser;

  setSelectedProfileImage(String newImage) {
    selectedProfileImage = newImage;
    notifyListeners();
  }

  setSelectedBannerImage(String newCover) {
    selectedBannnerCover = newCover;
    notifyListeners();
  }

  MoreInfo get user => _moreInfo;

  void setMoreInfoUser(MoreInfo moreInfo) {
    _moreInfo = moreInfo;
    selectedProfileImage = moreInfo.profileImage;
    selectedBannnerCover = moreInfo.cover;

    // notifyListeners();
  }

  Future<void> refreshMoreInfoUser(String authToken) async {
    try {
      final MoreInfo refreshedUser = await CommonMethods.getMoreInfo(authToken);

      // Update the user data
      _moreInfo = refreshedUser;

      // Notify listeners that the data has changed
      selectedProfileImage = _moreInfo.profileImage;
      selectedBannnerCover = _moreInfo.cover;
      notifyListeners();
    } catch (e) {
      // Handle errors
      print('Error refreshing user info: $e');
    }
  }
}
