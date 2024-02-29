import 'new_post_comment.dart';

class PushNotificationModel {
  final String? title;
  final String? body;
  final Map<String, dynamic>? data;
  final Type? type;

  PushNotificationModel({this.title, this.body, this.data, this.type});

  factory PushNotificationModel.fromMap(Map<String, dynamic> map) {
    return PushNotificationModel(
      title: map['title'],
      body: map['body'],
      data: map['payload'],
      type: getType(map['type']),
    );
  }

  static Type? getType(String? type) {
    if (type == 'new_comments') {
      return NewPostCommentNotification;
    }
    return null;
  }
}
