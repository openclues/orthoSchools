import 'package:azsoon/Core/network/request_helper.dart';
import 'package:http/http.dart';

class JoinSpaceRepo {
  Future<Response> joinSpace(int spaceId) async {
    var response = await RequestHelper.post(
        'joinspace/?space_id=$spaceId', {"id": spaceId.toString()});
    return response;
  }
}
