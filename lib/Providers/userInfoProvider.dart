import 'package:azsoon/model/user-info.dart';
import 'package:flutter/material.dart';

// class UserProvider with ChangeNotifier {
//   late Map<String, dynamic> _userInfo;

//   Map<String, dynamic> get userInfo => _userInfo;

//   void setUserInfo(Map<String, dynamic> userInfo) {
//     _userInfo = userInfo;
//     notifyListeners();
//   }
// }

class UserProvider with ChangeNotifier {
  late User _user;

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
