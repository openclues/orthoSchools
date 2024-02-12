import 'package:equatable/equatable.dart';

import '../home_screen/data/models/latest_updated_posts_model.dart';

class Comment extends Equatable {
  final int id;
  final String text;
  final String created_at;
  final int? parentLikes;
  final int? commentLikes;
  final PostCommentUser user;
  final List<Comment> comments;

  const Comment(
      {required this.id,
      required this.parentLikes,
      required this.commentLikes,
      required this.text,
      required this.created_at,
      required this.user,
      required this.comments});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      parentLikes: json['object_likes_count'],
      commentLikes: json['likesCount'],
      text: json['text'],
      created_at: json['created_at'],
      user: PostCommentUser.fromJson(json['user']),
      comments: json['comments'] == null
          ? []
          : List<Comment>.from(
              json['comments'].map((x) => Comment.fromJson(x))),
    );
  }

  Comment copyWith({
    int? id,
    String? text,
    String? created_at,
    int? parentLikes,
    int? commentLikes,
    PostCommentUser? user,
    List<Comment>? comments,
  }) {
    print("${commentLikes}psdkfp[ksd]");
    return Comment(
      id: id ?? this.id,
      text: text ?? this.text,
      created_at: created_at ?? this.created_at,
      parentLikes: parentLikes ?? this.parentLikes,
      commentLikes: commentLikes ?? this.commentLikes,
      user: user ?? this.user,
      comments: comments ?? this.comments,
    );
  }

  @override
  List<Object?> get props => [
        id,
        text,
        created_at,
        parentLikes,
        commentLikes,
        user,
        comments,
      ];
}

// [
//     {
//         "id": 4,
//         "text": "sdfsdfsdf",
//         "created_at": "2023-12-20T21:02:04.306265Z",
//         "user": {
//             "id": 12,
//             "first_name": "yfyyfy",
//             "last_name": "jvhcg t",
//             "profileImage": null
//         },
//         "comments": [
//             {
//                 "id": 8,
//                 "text": "dfsdfsdfsdfsdfsdfsd",
//                 "created_at": "2023-12-21T07:51:55.910481Z",
//                 "user": {
//                     "id": 8,
//                     "first_name": "islam",
//                     "last_name": "ahmed",
//                     "profileImage": null
//                 },
//                 "comments": []
//             }
//         ]
//     },
//     {
//         "id": 6,
//         "text": "sdfsdfsdf",
//         "created_at": "2023-12-20T21:25:57.419315Z",
//         "user": {
//             "id": 6,
//             "first_name": "sara",
//             "last_name": "kaya",
//             "profileImage": null
//         },
//         "comments": []
//     },
//     {
//         "id": 7,
//         "text": "werwerwerewrwerwerwe",
//         "created_at": "2023-12-20T21:48:59.130411Z",
//         "user": {
//             "id": 2,
//             "first_name": "string",
//             "last_name": "string",
//             "profileImage": null
//         },
//         "comments": []
//     }
// ]