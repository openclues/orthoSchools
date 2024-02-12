// import 'package:flutter_quill/flutter_quill.dart';
// import 'package:flutter_quill/quill_delta.dart';

class BlogModel {
  int id;
  // List<PostModel> posts;
  UserModel user;
  List<CategoryModel>? category;
  String? title;
  String? description;
  String? cover;
  int? articlesCount;

  int? followersCount;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isPublished;
  String? slug;
  List<dynamic>? followers;

  BlogModel({
    required this.id,
    // required this.posts,
    required this.articlesCount,
    required this.followersCount,
    required this.user,
    required this.category,
    required this.title,
    required this.description,
    required this.cover,
    required this.createdAt,
    required this.updatedAt,
    required this.isPublished,
    required this.slug,
    required this.followers,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    // print(json['is_followed'] + "spdkfp[sdkfps[dkfpsd[pf[sdk]]]]");
    return BlogModel(
      id: json['id'],
      articlesCount: json['articles_count'],
      followersCount: json['followers_count'],
      // posts: List<PostModel>.from(
      //     json['posts'].map((post) => PostModel.fromJson(post))),
      user: UserModel.fromJson(json['user']),
      category: List<CategoryModel>.from(
          json['category'].map((cat) => CategoryModel.fromJson(cat))),
      title: json['title'],
      description: json['description'],
      cover: json['cover'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      isPublished: json['is_published'],
      slug: json['slug'],
      followers: List<dynamic>.from(json['followers']),
    );
  }
}

class PostModel {
  int? id;
  // Delta content;
  String? title;
  bool? isBanned;
  String? cover;
  DateTime? createdAt;
  bool? isFollowed;
  DateTime? updatedAt;
  int? blog;
  // String? plainText;

  PostModel({
    required this.id,
    // required this.content,
    required this.title,
    required this.isBanned,
    required this.isFollowed,
    required this.cover,
    required this.createdAt,
    required this.updatedAt,
    required this.blog,
    // required this.plainText,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      isFollowed: json['is_followed'],
      // content: Delta.fromJson(jsonDecode(json['content'])['ops']),
      title: json['title'],
      isBanned: json['is_banned'],
      cover: json['cover'],
      // plainText: json['content'] != null
      //     ? QuillController(
      //         document: Document.fromDelta(
      //           Delta.fromJson(jsonDecode(json['content'])['ops']),
      // //         ),
      //         selection: const TextSelection.collapsed(offset: 0),
      //       ).document.toPlainText()
      //     : "",
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      blog: json['blog'],
    );
  }
}

class UserModel {
  int? id;
  String? title;
  String? bio;
  String? studyIn;
  String? cover;
  String? birthDate;
  String? placeOfWork;
  String? speciality;
  String? profileImage;

  UserAccountModel userAccount;

  UserModel({
    this.title,
    this.bio,
    this.studyIn,
    this.cover,
    this.profileImage,
    this.birthDate,
    this.placeOfWork,
    this.id,
    this.speciality,
    required this.userAccount,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    print(json['user_account']);
    return UserModel(
      id: json['id'],
      title: json['title'],
      bio: json['bio'],
      profileImage: json['profileImage'],
      studyIn: json['study_in'],
      cover: json['cover'],
      birthDate: json['birth_date'],
      placeOfWork: json['place_of_work'],
      speciality: json['speciality'],
      userAccount: UserAccountModel.fromJson(json['user_account']),
    );
  }
}

class UserAccountModel {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  int? userRole;
  String? phone;
  String? address;
  bool? isBanned;
  bool? isSuspend;
  bool? isVerified;
  bool? isVerifiedPro;

  UserAccountModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.userRole,
    required this.phone,
    required this.address,
    required this.isBanned,
    required this.isSuspend,
    required this.isVerified,
    required this.isVerifiedPro,
  });

  factory UserAccountModel.fromJson(Map<String, dynamic> json) {
    return UserAccountModel(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      userRole: json['userRole'],
      phone: json['phone'],
      address: json['address'],
      isBanned: json['is_banned'],
      isSuspend: json['is_suspend'],
      isVerified: json['is_verified'],
      isVerifiedPro: json['is_verified_pro'],
    );
  }
}

class CategoryModel {
  int? id;
  bool? isSelected;
  String? name;
  String? image;

  CategoryModel({
    required this.id,
    required this.isSelected,
    required this.name,
    required this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      isSelected: json['is_selected'],
      name: json['name'],
      image: json['image'],
    );
  }
}

//pagination reusable model
class PaginationBlogListModel {
  int? count;
  String? next;
  String? previous;
  List<BlogModel>? results;
  List<PostModel>? latest_updated_posts_model;

  PaginationBlogListModel({
    required this.count,
    required this.next,
    required this.previous,
    this.latest_updated_posts_model,
    required this.results,
  });

  factory PaginationBlogListModel.fromJson(Map<String, dynamic> json) {
    return PaginationBlogListModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: List<BlogModel>.from(
          json['results'].map((blog) => BlogModel.fromJson(blog))),
    );
  }
}

//get Delta from String
// Delta getDeltaFromString(String content) {
//   return Delta.fromJson(jsonDecode(jsonEncode(content)));
// }
