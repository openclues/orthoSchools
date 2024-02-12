// import 'package:azsoon/Core/common-methods.dart';
// import 'package:azsoon/model/user-info.dart';
// import 'package:flutter/material.dart';

// class UserProvider with ChangeNotifier {
//   late User _user;
//   String? firstname;

//   setFirstName(String fName) {
//     firstname = fName;
//     notifyListeners();
//   }

//   User get user => _user;

//   void setUser(User user) {
//     _user = user;
//     notifyListeners();
//   }

//   Future<void> refreshUser(String authToken) async {
//     try {
//       final User refreshedUser = await CommonMethods.getUserInfo(authToken);

//       // Update the user data
//       _user = refreshedUser;

//       // Notify listeners that the data has changed
//       firstname = _user.firstName;
//       notifyListeners();
//     } catch (e) {
//       // Handle errors
//       print('Error refreshing user info: $e');
//     }
//   }
// }
