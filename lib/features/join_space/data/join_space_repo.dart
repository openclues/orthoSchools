import 'package:azsoon/Core/network/request_helper.dart';
import 'package:http/http.dart';

class JoinSpaceRepo {
  Future<Response> joinSpace(int spaceId) async {
    var response = await RequestHelper.put(
        'joinspace/$spaceId', {"id": spaceId.toString()});
    return response;
  }
}
