import 'dart:convert';

import 'package:azsoon/Core/local_storage.dart';
import 'package:azsoon/Core/network/endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
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
    String? authToken = await getAuthToken();

    if (authToken != null) {
      // Authenticated request with header
      //add data to the body

      var response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Token $authToken",
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
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
      {bool? signup,
      List<XFile>? files,
      String? filesKey,
      List<XFile>? extrafiles,
      String? extraFilesKey}) async {
    String url = _baseUrl + endpoint;

    Map<String, String> headers = {
      "Content-Type": "application/json; charset=utf-8"
    };
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
          if (extrafiles != null && extrafiles.isNotEmpty) {
            extrafiles.forEach((file) async {
              var multipartFile = await http.MultipartFile.fromPath(
                extraFilesKey ?? 'profile_pic',
                file.path,
              );
              request.files.add(multipartFile);
            });
          }
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

  static Future<http.Response> postDataWithFiles({
    required String apiUrl,
    required Map<String, String> data,
    List<XFile>? imageFiles,
    XFile? videoFile,
  }) async {
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

    // Add data fields to the request
    request.fields.addAll(data);

    // Add image files if available
    if (imageFiles != null) {
      for (var i = 0; i < imageFiles.length; i++) {
        var image = imageFiles[i];
        var stream = http.ByteStream(image.openRead());
        var length = await image.length();

        var multipartFile = http.MultipartFile(
          'post_images', // The name of the attribute in the request
          stream,
          length,
          filename: 'image$i.jpg', // Customize the filename if needed
        );

        request.files.add(multipartFile);
      }
    }

    // Add video file if available
    if (videoFile != null) {
      var videoStream = http.ByteStream(videoFile.openRead());
      var videoLength = await videoFile.length();

      var videoMultipartFile = http.MultipartFile(
        'video', // The name of the attribute in the request
        videoStream,
        videoLength,
        filename: 'video.mp4', // Customize the filename if needed
      );

      request.files.add(videoMultipartFile);
    }
    String? authToken = await getAuthToken();
    if (authToken != null) {
      // Add authorization header
      request.headers['Authorization'] = 'Token $authToken';
    }

    // Send the request
    var response = await request.send();

    // Handle response
    if (response.statusCode == 200) {
      print('Data posted successfully');
    } else {
      print('Failed to post data. Status code: ${response.statusCode}');
    }
    return Response.fromStream(response);
  }

  static Future<Response> put(
    String endpoint,
    dynamic data, {
    Map<String, XFile?>? files,
  }) async {
    String url = _baseUrl + endpoint;

    String? authToken = await getAuthToken();

    if (authToken != null) {
      if (files != null && files.isNotEmpty) {
        var request = http.MultipartRequest('PATCH', Uri.parse(url));
        request.headers["Authorization"] = "Token $authToken";

        files.forEach((key, file) async {
          if (file != null) {
            var multipartFile = await http.MultipartFile.fromPath(
              key,
              file.path,
            );
            request.files.add(multipartFile);
          }
        });

        if (data != null) {
          request.fields.addAll(data.map((key, value) =>
              MapEntry(key, value is String ? value : json.encode(value))));
        }

        try {
          var response = await request.send();
          return await http.Response.fromStream(response);
        } catch (e) {
          throw Exception('Failed to send request with files and data');
        }
      } else {
        // No files, send data only
        return http.patch(Uri.parse(url),
            headers: {"Authorization": "Token $authToken"}, body: data);
      }
    } else {
      // Unauthenticated request without header
      return http.put(Uri.parse(url),
          body: data != null ? json.encode(data) : null);
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
