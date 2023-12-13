import 'package:azsoon/Utils/Constants.dart';
import 'package:dio/dio.dart';

class AuthWebServices {
  late Dio dio;

  AuthWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: loginUrl,
    );
  }
}
