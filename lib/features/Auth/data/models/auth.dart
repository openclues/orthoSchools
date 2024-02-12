class Auth {
  String? password;
  String? email;
  String? firstName;
  String? lastName;

  Auth({this.password, this.email, this.firstName, this.lastName});

  Auth.fromJson(Map<String, dynamic> json) {
    password = json['passowrd'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
  }
}
