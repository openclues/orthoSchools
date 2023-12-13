//abstract spacepost class
class LatestUpdatedPost {
  final int? id;
  final String? title;
  final bool? isAllowedToJoin;
  final String? content;
  final String? spacenName;
  final int? space;
  final bool? isJoined;
  final PostUser? user;
  final List<dynamic>?
      comments; // You might want to create a class for comments if needed
  final List<dynamic>?
      postFiles; // You might want to create a class for post files if needed
  final List<PostImage>?
      postImages; // You might want to create a class for post images if needed
  final String? createdAt;

  LatestUpdatedPost({
    required this.id,
    required this.title,
    required this.content,
    required this.isJoined,
    required this.spacenName,
    required this.space,
    required this.user,
    required this.isAllowedToJoin,
    required this.comments,
    required this.postFiles,
    required this.postImages,
    required this.createdAt,
  });

  factory LatestUpdatedPost.fromJson(Map<String, dynamic> json) {
    print(json['comments'].toString() + "spdkfmposdfjopsdpsdofsd");
    return LatestUpdatedPost(
      id: json['id'],
      spacenName: json['space_name'],
      title: json['title'],
      content: json['content'],
      isJoined: json['is_joined'],
      isAllowedToJoin: json['is_allowed_to_join'],
      space: json['space'],
      user: PostUser.fromJson(json['user']),
      comments: json['comments'],
      postFiles: json['post_files'],
      postImages: json['post_images'] == null
          ? []
          : List<PostImage>.from(
              json['post_images'].map((x) => PostImage.fromJson(x))),
      createdAt: json['created_at'],
    );
  }
}

class PostUser {
  int? id;
  String? firstName;
  String? lastName;
  String? profileImage;

  PostUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
  });

  factory PostUser.fromJson(Map<String, dynamic> json) {
    return PostUser(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      profileImage: json['profileImage'],
    );
  }
}

class PostImage {
  int? id;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? post;

  PostImage({
    required this.id,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.post,
  });

  factory PostImage.fromJson(Map<String, dynamic> json) {
    return PostImage(
      id: json['id'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      post: json['post'],
    );
  }
}

        // {
        //   "id": 1,
        //   "image": "http://192.168.1.48:8000/media/images/Screenshot_1697960087.png",
        //   "created_at": "2023-12-05T01:05:08.138814Z",
        //   "updated_at": "2023-12-05T01:05:08.138814Z",
        //   "post": 1
        // }