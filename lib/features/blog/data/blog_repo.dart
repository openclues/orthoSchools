import 'package:azsoon/Core/network/request_helper.dart';
import 'package:http/http.dart';

class BlogRepo {
  Future<Response> getBlogList(int? page,
      {String? category, bool? following}) async {
    page ??= 1;
    var response = await RequestHelper.get(
        'blogs?page=$page${category != null ? '&category__name=$category' : ''}${following != null ? '&followed=$following' : ''}');
    return response;
  }
}
