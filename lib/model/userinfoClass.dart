class UserInfo {
  final int id;
  final User user;
  final String? bio;
  // Add other fields as needed

  UserInfo({
    required this.id,
    required this.user,
    this.bio,
    // Initialize other fields here
  });
}

class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String phone;
  final String address;
  final bool isActive;
  final String lastLogin;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
    required this.isActive,
    required this.lastLogin,
  });
}
