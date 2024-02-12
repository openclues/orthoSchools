//abstract spacepost class
import 'package:azsoon/features/blog/data/models/articles_model.dart';
import 'package:equatable/equatable.dart';

import '../../../blog/data/models/blog_model.dart';
import 'recommended_spaces_model.dart';

class LatestUpdatedPost extends Equatable {
  final int? id;
  final String? title;
  final bool? isAllowedToJoin;
  final String? content;
  final String? spacenName;
  final RecommendedSpace? space;
  final bool? isJoined;
  // final List<NewPostComment>? newComments;
  int? likesCount;
  final PostCommentUser? user;
  final ArticlesModel? blogPost;
  final int? commentsCount;
  bool? isLiked;
  final String? video;
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
    required this.likesCount,
    required this.blogPost,
    required this.isLiked,
    required this.video,
    required this.space,
    required this.user,
    required this.isAllowedToJoin,
    required this.commentsCount,
    // required this.newComments,
    required this.postFiles,
    required this.postImages,
    required this.createdAt,
  });

  factory LatestUpdatedPost.fromJson(Map<String, dynamic> json) {
    // print(List<NewPostComment>.from(
    //     json['newComments'].map((x) => NewPostComment.fromJson(x))));

    return LatestUpdatedPost(
      id: json['id'],
      likesCount: json['likes_count'],
      spacenName: json['space_name'],
      video: json['video'],
      isLiked: json['is_liked'],
      blogPost: json['blogPost'] == null
          ? null
          : ArticlesModel.fromJson(json['blogPost']),
      title: json['title'],
      // newComments: json['newComments'] == null ? [] : [],
      content: json['content'],
      isJoined: json['is_joined'],
      isAllowedToJoin: json['is_allowed_to_join'],
      space: RecommendedSpace.fromJson(json['space']),
      user: PostCommentUser.fromJson(json['user']),
      commentsCount: json['comments_count'],
      postFiles: json['post_files'],
      postImages: json['post_images'] == null
          ? []
          : List<PostImage>.from(
              json['post_images'].map((x) => PostImage.fromJson(x))),
      createdAt: json['created_at'],
    );
  }

  LatestUpdatedPost copyWith({
    int? id,
    String? title,
    bool? isAllowedToJoin,
    String? content,
    String? spacenName,
    RecommendedSpace? space,
    List<NewPostComment>? newComments,
    bool? isJoined,
    int? likesCount,
    PostCommentUser? user,
    String? video,
    ArticlesModel? blogPost,
    int? commentsCount,
    bool? isLiked,
    //? postFiles,
    //? postImages,
    String? createdAt,
  }) {
    return LatestUpdatedPost(
      // newComments: newComments ?? this.newComments,
      id: id ?? this.id,
      title: title ?? this.title,
      isAllowedToJoin: isAllowedToJoin ?? this.isAllowedToJoin,
      content: content ?? this.content,
      spacenName: spacenName ?? this.spacenName,
      video: video ?? this.video,
      space: space ?? this.space,
      isJoined: isJoined ?? this.isJoined,
      likesCount: likesCount ?? this.likesCount,
      user: user ?? this.user,
      blogPost: blogPost ?? this.blogPost,
      commentsCount: commentsCount ?? this.commentsCount,
      isLiked: isLiked ?? this.isLiked,
      postFiles: postFiles ?? this.postFiles,
      postImages: postImages ?? this.postImages,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        isAllowedToJoin,
        content,
        spacenName,
        space,
        isJoined,
        likesCount,
        user,
        blogPost,
        commentsCount,
        isLiked,
        postFiles,
        postImages,
        createdAt,
      ];
}

class PostCommentUser {
  int? id;
  String? firstName;
  String? lastName;
  String? profileImage;
  bool? isVeriedPro;
  bool? isVerified;
  bool? isPremium;
  int? userRole;

  PostCommentUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.isVeriedPro,
    required this.isVerified,
    required this.profileImage,
    required this.userRole,
    required this.isPremium,
  });

  factory PostCommentUser.fromJson(Map<String, dynamic> json) {
    // print(json['userRole'] + "userRole" + json['last_name'] + "last_name");

    return PostCommentUser(
      id: json['id'],
      userRole: json['userRole'],
      isVeriedPro: json['is_verified_pro'],
      isVerified: json['is_verified'],
      isPremium: json['userRole'] == 1 ? false : true,
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

// "newComments": [
//   {
//     "id": 1,
//     "user": {
//       "id": 1,
//       "first_name": "hvhvhvh",
//       "last_name": "uvycy",
//       "profileImage": null
//     },
//     "replies": [
//       {
//         "id": 1,
//         "user": {
//           "id": 1,
//           "first_name": "hvhvhvh",
//           "last_name": "uvycy",
//           "profileImage": null
//         },
//         "likes": [],
//         "comment_id": 1,
//         "commet_user": {
//           "id": 1,
//           "first_name": "hvhvhvh",
//           "last_name": "uvycy",
//           "profileImage": null
//         },
//         "comment_text": "This is a comment",
//         "content": "fsdfsdfsdfsdf",
//         "created_at": "2024-01-03T08:19:26.733542Z",
//         "updated_at": "2024-01-03T08:19:26.733542Z",
//         "comment": 1
//       }
//     ],

class NewPostComment extends Equatable {
  int? id;
  PostCommentUser? user;
  List<PostReply>? replies;
  int? commentId;
  PostCommentUser? commetUser;
  String? commentText;
  String? content;
  String? createdAt;
  bool? isLiked;
  String? updatedAt;
  int? comment;

  NewPostComment({
    required this.id,
    required this.user,
    required this.replies,
    required this.commentId,
    required this.commetUser,
    required this.commentText,
    required this.content,
    required this.createdAt,
    required this.isLiked,
    required this.updatedAt,
    required this.comment,
  });

  factory NewPostComment.fromJson(Map<String, dynamic> json) {
    return NewPostComment(
      id: json['id'],
      user: PostCommentUser.fromJson(json['user']),
      replies: json['replies'] == null
          ? []
          : List<PostReply>.from(
              json['replies'].map((x) => PostReply.fromJson(x))),
      commentId: json['comment_id'],
      commetUser: PostCommentUser.fromJson(json['user']),
      commentText: json['comment_text'],
      content: json['content'],
      createdAt: json['created_at'],
      isLiked: json['is_liked'],
      updatedAt: json['updated_at'],
      comment: json['comment'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        user,
        // // replies,
        commentId,
        commetUser,
        commentText,
        content,
        createdAt,
        updatedAt,
        comment,
      ];
}

class PostReply {
  int? id;
  PostCommentUser? user;
  List<dynamic>? likes;
  bool? isLiked;
  int? commentId;
  PostCommentUser? commetUser;
  String? commentText;
  String? content;
  String? createdAt;
  String? updatedAt;
  int? comment;

  PostReply({
    required this.id,
    required this.user,
    required this.likes,
    required this.commentId,
    required this.commetUser,
    required this.commentText,
    required this.content,
    required this.createdAt,
    required this.isLiked,
    required this.updatedAt,
    required this.comment,
  });

  factory PostReply.fromJson(Map<String, dynamic> json) {
    return PostReply(
      id: json['id'],
      user: PostCommentUser.fromJson(json['user']),
      likes: json['likes'],
      isLiked: json['is_liked'],
      commentId: json['comment_id'],
      commetUser: PostCommentUser.fromJson(json['commet_user']),
      commentText: json['comment_text'],
      content: json['content'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      comment: json['comment'],
    );
  }
}

class SimpleSpace {
  final int? id;
  final String? name;
  final String? description;
  final String? createdAt;
  final String? cover;
  final int? membersCount;
  // final String? postsCount;
  final bool? isAllowedToJoin;

  // final List<Category>? categories;
  final String? updatedAt;
  bool? isJoined;
  SimpleSpace({
    required this.id,
    required this.name,
    required this.description,
    required this.isJoined,
    required this.cover,
    required this.membersCount,
    // required this.postsCount,
    required this.isAllowedToJoin,

    // required this.categories,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SimpleSpace.fromJson(Map<String, dynamic> json) {
    return SimpleSpace(
      id: json['id'],
      name: json['name'],
      isJoined: json['isJoined'],
      cover: json['cover'],
      membersCount: json['members_count'],
      // postsCount: json['posts_count'],
      isAllowedToJoin: json['is_allowed_to_join'],

      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
