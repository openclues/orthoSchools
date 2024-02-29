import 'package:azsoon/features/home_screen/data/models/latest_updated_posts_model.dart';

class NewPostCommentNotification {
  int? commentId;
  int? postId;
  String? comment;
  // String? postContent;
  String? commentorName;
  NewPostCommentNotification({
    this.commentId,
    this.postId,
    this.comment,
    // this.postContent,
    this.commentorName,
  });

  //from map
  NewPostCommentNotification.fromMap(Map<String, dynamic> map) {
    commentId = map['commentId'];
    postId = map['postId'];
    comment = map['comment'];
    // postContent = map['postContent'];
    commentorName = map['commentorName'];
  }
}
