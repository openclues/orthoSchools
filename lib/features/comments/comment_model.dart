import '../home_screen/data/models/latest_updated_posts_model.dart';

class Comment {
  final int id;
  final String text;
  final String created_at;
  final PostCommentUser user;
  final List<Comment> comments;

  Comment(
      {required this.id,
      required this.text,
      required this.created_at,
      required this.user,
      required this.comments});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      text: json['text'],
      created_at: json['created_at'],
      user: PostCommentUser.fromJson(json['user']),
      comments: json['comments'] == null
          ? []
          : List<Comment>.from(
              json['comments'].map((x) => Comment.fromJson(x))),
    );
  }
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