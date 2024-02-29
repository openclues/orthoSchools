import 'package:azsoon/features/home_screen/data/models/latest_updated_posts_model.dart';

class ArticleCommentModel {
  int? id;
  String? content;
  PostCommentUser? user;
  String? createdAt;
  String? updatedAt;
  bool? isArticleLiked;
  int? postLikesCount;

  ArticleCommentModel(
      {this.id,
      this.content,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.isArticleLiked = false,
      this.postLikesCount = 0});

  ArticleCommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isArticleLiked = json['isArticleLiked'];
    postLikesCount = json['likes_count'];
    content = json['content'];
    user = json['user'] != null
        ? PostCommentUser.fromJson(json['user'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  //COPY WITH
  ArticleCommentModel copyWith({
    int? id,
    String? content,
    PostCommentUser? user,
    String? createdAt,
    String? updatedAt,
  }) {
    return ArticleCommentModel(
      id: id ?? this.id,
      content: content ?? this.content,
      user: user ?? this.user,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}


// [{"id":1,"content":"dsfsdfsdfsdfsd","user":{"title":null,"bio":null,"study_in":null,"cover":null,"birth_date":null,"place_of_work":null,"speciality":null,"user_account":{"id":11,"email":"a@c.com","first_name":"islam","last_name":"ibrahim","userRole":1,"phone":"","address":"","is_banned":false,"is_suspend":false,"is_verified":false,"is_verified_pro":false},"id":11},"created_at":"2024-02-16T16:14:44.866630Z","updated_at":"2024-02-16T16:14:44.866630Z"}]