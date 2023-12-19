import 'dart:convert';

import 'package:azsoon/Core/local_storage.dart';
import 'package:azsoon/Core/network/endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestHelper {
  static const String _baseUrl = ApiEndpoints.baseUrl;
  static String? _token;
  static setAuthTokenToNull() {
    _token = null;
  }

  static removeAuthToken() async {
    _token = null;
  }

  static Future<String?> getAuthToken() async {
    if (_token != null) {
      return _token;
    }
    // get token from shared preferences
    SharedPreferences prefs = LocalStorage.getInstance();

    _token = prefs.getString("authToken");
    return _token;
  }

// ...

  static Future<http.Response> get(
    String endpoint,
  ) async {
    String url = _baseUrl + endpoint;
    print(url);
    String? authToken = await getAuthToken();

    if (authToken != null) {
      // Authenticated request with header
      //add data to the body

      var response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "Token $authToken"},
      );

      return response;
    } else {
      // Unauthenticated request without header

      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // If the request is successful, cache the response with a validity of 3 hours
      }
      return response;
    }
  }

  static Future<http.Response> post(String endpoint, Map<String, dynamic> data,
      {bool? signup, List<XFile>? files, String? filesKey}) async {
    String url = _baseUrl + endpoint;

    Map<String, String> headers = {"Content-Type": "application/json"};
    if (signup == true) {
      return http.post(Uri.parse(url), body: data);
    } else {
      String? authToken = await getAuthToken();
      if (authToken != null) {
        // authenticated request with header
        headers["Authorization"] = "Token $authToken";

        if (files != null && files.isNotEmpty) {
          var request = http.MultipartRequest('POST', Uri.parse(url));
          files.forEach((file) async {
            var multipartFile = await http.MultipartFile.fromPath(
              filesKey ?? 'profile_pic',
              file.path,
            );
            request.files.add(multipartFile);
          });
          request.headers.addAll(headers);
          request.fields.addAll(
              data.map((key, value) => MapEntry(key, value.toString())));
          var response = await request.send();
          return http.Response.fromStream(response);
        }

        return http.post(Uri.parse(url),
            headers: headers, body: jsonEncode(data));
      } else {
        try {
          return http.post(Uri.parse(url), body: data);
        } catch (e) {}
        return http.post(Uri.parse(url), body: data);
      }
    }
  }

  static Future<http.Response> put(
    String endpoint,
    dynamic data, {
    Map<String, XFile?>? files,
  }) async {
    String url = _baseUrl + endpoint;

    String? authToken = await getAuthToken();

    if (authToken != null) {
      if (files != null && files.isNotEmpty) {
        // var request = http.MultipartRequest('PATCH', Uri.parse(url));
        files.forEach((key, file) async {
          if (file != null) {
            Map<String, String> headers = {"Content-Type": "application/json"};
            headers["Authorization"] = "Token $authToken";
            var request = http.MultipartRequest('PATCH', Uri.parse(url));

            var multipartFile = await http.MultipartFile.fromPath(
              key,
              file.path,
            );
            data[key] = multipartFile;
            request.headers.addAll(headers);
            print(data.toString() + "data");
            request.fields.addAll(
                data.map((key, value) => MapEntry(key, value.toString())));
            request.files.add(multipartFile);
            var response = await request.send();
            print(data.toString() + "data");
            print(response.toString());
            // request.files.add(multipartFile);
          }
        });
      }
      print(data.toString() + "data");
      return http.patch(Uri.parse(url),
          headers: {"Authorization": "Token $authToken"}, body: data);
    } else {
      // unauthenticated request without header
      return http.put(Uri.parse(url), body: json.encode(data));
    }
  }

  static Future<http.Response> putMultipart(
      String endpoint, XFile file, Map<String, String> dynamicFields) async {
    String url = _baseUrl + endpoint;
    String? authToken = await getAuthToken();

    var request = http.MultipartRequest('PUT', Uri.parse(url));

    // Determine the file's MIME type

    // Create a multipart file from the XFile
    var multipartFile = await http.MultipartFile.fromPath(
      'profile_pic',
      file.path,
    );

    // Add the file to the request
    request.files.add(multipartFile);
    dynamicFields.forEach((key, value) {
      request.fields[key] = value;
    });

    if (authToken != null) {
      // Add authorization header
      request.headers['Authorization'] = 'Token $authToken';
    }

    // Send the request and receive the response
    http.StreamedResponse streamedResponse = await request.send();
    http.Response response = await http.Response.fromStream(streamedResponse);
    return response;
  }

  static Future<http.Response> delete(String endpoint, dynamic data) async {
    String url = _baseUrl + endpoint;
    String? authToken = await getAuthToken();

    if (authToken != null) {
      // authenticated request with header

      return http.delete(Uri.parse(url),
          headers: {"Authorization": "Token $authToken"}, body: data);
    } else {
      // unauthenticated request without header
      return http.delete(Uri.parse(url), body: data);
    }
  }
}
