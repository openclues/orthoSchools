import 'package:azsoon/Core/network/request_helper.dart';
import 'package:http/http.dart';

class BlogRepo {
  Future<Response> getBlogList(int? page) async {
    page ??= 1;
    var response = await RequestHelper.get('blogs?page=$page');
    return response;
  }
}
