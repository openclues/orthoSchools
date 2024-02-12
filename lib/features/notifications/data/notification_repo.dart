import 'package:http/http.dart';

import '../../../Core/network/request_helper.dart';

class NotificationsRepo {
  Future<Response> getNotifications() async {
    var response = await RequestHelper.get('notifications/');
    return response;
  }
}
