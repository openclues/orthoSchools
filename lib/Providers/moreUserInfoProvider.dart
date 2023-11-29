import 'package:azsoon/Core/common-methods.dart';
import 'package:azsoon/model/user-info.dart';
import 'package:flutter/material.dart';

class MoreInfoUserProvider with ChangeNotifier {
  late MoreInfo _moreInfo;

  MoreInfo get user => _moreInfo;

  void setMoreInfoUser(MoreInfo moreInfo) {
    _moreInfo = moreInfo;
    notifyListeners();
  }

  Future<void> refreshUser(String authToken) async {
    try {
      final MoreInfo refreshedUser = await CommonMethods.getMoreInfo(authToken);

      // Update the user data
      _moreInfo = refreshedUser;

      // Notify listeners that the data has changed
      notifyListeners();
    } catch (e) {
      // Handle errors
      print('Error refreshing user info: $e');
    }
  }
}
