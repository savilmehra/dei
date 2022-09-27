import 'dart:async';
import 'dart:convert';

import 'package:clean_framework/clean_framework.dart';
import 'package:http/http.dart' as http;

// import 'http_client/cross_client.dart'
//     if (dart.library.io) 'http_client/io_client.dart';

/// A simple rest api where the response is generally obtained in plain string form.
class SimpleRestApi extends RestApi {
  /// The base url.
  final String baseUrl;

  /// Whether to trust self-signed certificates or not.
  ///
  /// Defaults to false.
  final bool trustSelfSigned;

  // Client _httpClient;

  /// Creates a SimpleRestApi.
  SimpleRestApi({
    this.baseUrl = 'http://127.0.0.1:8080/service/',
    this.trustSelfSigned = false,
  });

  @override
  Future<RestResponse<String>> requestBinary({
    required RestMethod method,
    required String path,
    Map<String, dynamic> requestBody = const {},
  }) {
    return request(method: method, path: path, requestBody: requestBody);
  }

  @override
  Future<RestResponse<String>> request({
    required RestMethod method,
    required String path,
    Map<String, dynamic> requestBody = const {},
  }) async {
    assert(path.isNotEmpty);

    http.Response? response;
    Uri uri = Uri.parse(baseUrl + path);
    Map<String, String> headers = {'Content-Type': 'application/json'};
    try {
      switch (method) {
        case RestMethod.get:
          response = await http.get(uri, headers: headers);
          break;
        case RestMethod.post:
          response = await http.post(uri,
              headers: headers, body: json.encode(requestBody));
          break;
        case RestMethod.put:
          response = await http.put(uri,
              headers: headers, body: json.encode(requestBody));
          break;
        case RestMethod.delete:
          response = await http.delete(uri);
          break;
        case RestMethod.patch:
          response = await http.patch(uri, body: json.encode(requestBody));
          break;
      }
      print('response:+${response.body}');

      return RestResponse<String>(
        type: getResponseTypeFromCode(response.statusCode),
        uri: uri,
        content: response.body,
      );
    } on http.ClientException {
      return RestResponse<String>(
        type: getResponseTypeFromCode(response?.statusCode),
        uri: uri,
        content: response?.body ?? '',
      );
    } catch (e) {
      return RestResponse<String>(
        type: RestResponseType.unknown,
        uri: uri,
        content: '',
      );
    }
  }
}
