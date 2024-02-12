class MemberModel {
  int? id;
  String? firstName;
  String? lastName;
  String? profileImage;
  MemberModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'profileImage': profileImage,
    };
  }
}


    // profileImage = serializers.SerializerMethodField()
    // first_name = serializers.SerializerMethodField()
    // id = serializers.SerializerMethodField()
    // last_name = serializers.SerializerMethodField()
