class NotificationModel {
  final String? title;
  final dynamic data;
  final bool? isRead;
  final String? message;
  // final bool? isRead;

  NotificationModel(
    this.title,
    this.data,
    this.isRead,
    this.message,
    // this.isRead,
  );

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    print(json['is_read']);
    return NotificationModel(
      json['title'],
      json['data'],
      json['is_read'],
      json['message'],
      // json['url'],
    );
  }
}
