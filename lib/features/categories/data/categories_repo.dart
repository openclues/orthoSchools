import 'package:http/http.dart';

import '../../../Core/network/request_helper.dart';

class CategoriesRepo {
  Future<Response> getCategories() async {
    var response = await RequestHelper.get('categories/');
    return response;
  }
}
