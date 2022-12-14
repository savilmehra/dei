import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class NetworkUtils {
  static NetworkUtils _instance = new NetworkUtils.internal();
  BuildContext? context;

  NetworkUtils.internal();

  factory NetworkUtils() => _instance;

  // final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> upload(
      BuildContext context,
      String url,
      String? token,
      String filePath,

      Function()? networkCallBack) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        this.context = context;

        final httpClient = HttpClient();

        final req = await httpClient.postUrl(Uri.parse(url));

        int byteCount = 0;

        var request = http.MultipartRequest('POST', Uri.parse(url));


        print("reached---------------------------------------------------multipart");
        request.files.add(await http.MultipartFile.fromPath(
            'file', filePath,
          ));


        var msStream = request.finalize();

        var totalByteLength = request.contentLength;

        req.contentLength = totalByteLength;

        req.headers.set(HttpHeaders.contentTypeHeader,
            request.headers[HttpHeaders.contentTypeHeader]!);
        req.headers.add('X-FileSpin-Api-Key', ('852c3af777b3481eb6b22a0e99d15c6c'));

        Stream<List<int>> streamUpload = msStream.transform(
          StreamTransformer.fromHandlers(
            handleData: (data, sink) {
              sink.add(data);
              byteCount += data.length;
              },
            handleError: (error, stack, sink) {
              throw error;
            },
            handleDone: (sink) {
              sink.close();
              // UPLOAD DONE;
            },
          ),
        );
        await req.addStream(streamUpload);
        final httpResponse = await req.close();

        return await readResponseAsString(httpResponse);

      }
     else{
        if (networkCallBack != null) {
          networkCallBack();
        }
      }
    } on SocketException catch (_) {
      if (networkCallBack != null) {
        networkCallBack();
      }
      Fluttertoast.showToast(
          msg: "No Internet",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.lightGreen,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<dynamic> uploadF(
      BuildContext context,
      String url,
      String token,
      String filePath,
      String ownerType,
      String ownerId,
      String? id,
      String contentType,
      Function(int progress)? onProgressCallback,
      String mimeType,
      Function(String bytes)? onByteUpload,
      Function()? networkCallBack) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Map<String, String> headers = Map();
        final request = MultipartRequest(
          'POST',
          Uri.parse(url),
          onProgress: (int bytes, int total) {
            final progress = bytes / total;
            if (onProgressCallback != null) {
              onProgressCallback((progress * 100).toInt());
            }

            if (onByteUpload != null) {
              onByteUpload('uploaded - $bytes-->total -$total');
            }

            var per = (progress * 100).toInt();
            print(
                'progress-------= $per-----------------bytes uploaded $bytes------------------------total bytes -------$total');
          },
        );

        headers.putIfAbsent('X-FileSpin-Api-Key', () => (""));
        headers.putIfAbsent('Content-type', () => 'application/json');
        request.headers.addAll(headers);
        if (id != null) {
          request.fields["id"] = id;
        }
        request.files.add(
          await http.MultipartFile.fromPath('attachment', filePath,
              contentType: MediaType(contentType, mimeType)),
        );
        final streamedResponse = await request.send();
        final res = await http.Response.fromStream(streamedResponse);
        log(jsonEncode(jsonDecode(res.body)));
        return jsonEncode(jsonDecode(res.body));
      }
      else
        {

          print("no network callback1------------------------------------------");
          if (networkCallBack != null) {
            networkCallBack();
          }
        }
    } on SocketException catch (_) {
      print("no network callback2------------------------------------------");
      if (networkCallBack != null) {
        networkCallBack();
      }
      Fluttertoast.showToast(
          msg: "No Internet",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.lightGreen,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<dynamic> uploadFolderFile(
      BuildContext context,
      String url,
      String token,
      String filePath,
      String ownerType,
      String ownerId,
      String? id,
      String contentType,
      Function(int progress)? onProgressCallback,
      String mimeType) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        this.context = context;

        final httpClient = HttpClient();

        final req = await httpClient.postUrl(Uri.parse(url));

        int byteCount = 0;
        var request = http.MultipartRequest('POST', Uri.parse(url));
        request.files.add(await http.MultipartFile.fromPath(
            'attachment', filePath,
            contentType: MediaType(contentType, mimeType)));
        print("content Type -" + contentType + "  mimeType - " + mimeType);
        print(token);
        print("MediaUpload - Url -" + url);

        request.fields["owner_type"] = ownerType;
        request.fields["owner_id"] = ownerId;
        if (id != null) {
          request.fields["id"] = id;
        }
        print("MediaUpload - files -" + request.fields.toString());

        var msStream = request.finalize();

        var totalByteLength = request.contentLength;

        req.contentLength = totalByteLength;

        // var headers = {"Authorization": ('Token' + " " + token)};
        // request.headers.addAll(headers);
        // request.headers.addAll(headers);

        req.headers.set(HttpHeaders.contentTypeHeader,
            request.headers[HttpHeaders.contentTypeHeader]!);
        req.headers.add('Authorization', ('Token' + " " + token));

        Stream<List<int>> streamUpload = msStream.transform(
          StreamTransformer.fromHandlers(
            handleData: (data, sink) {
              sink.add(data);

              byteCount += data.length;

              var pr = byteCount / totalByteLength;
              print("progress -- ${(pr * 100).toInt()}%------------test");
              if (onProgressCallback != null) {
                onProgressCallback((pr * 100).toInt());
              }
            },
            handleError: (error, stack, sink) {
              throw error;
            },
            handleDone: (sink) {
              sink.close();
              // UPLOAD DONE;
            },
          ),
        );
        await req.addStream(streamUpload);
        final httpResponse = await req.close();
        return await readResponseAsString(httpResponse);
      } else {
        Fluttertoast.showToast(
            msg: "No Internet",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.lightGreen,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(
          msg: "No Internet",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.lightGreen,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  static Future<String> readResponseAsString(HttpClientResponse response) {
    var completer = new Completer<String>();
    var contents = new StringBuffer();
    response.transform(utf8.decoder).listen((String data) {
      contents.write(data);
    }, onDone: () => completer.complete(contents.toString()));
    return completer.future;
  }
}

class MultipartRequest extends http.MultipartRequest {
  /// Creates a new [MultipartRequest].
  MultipartRequest(
    String method,
    Uri url, {
    required this.onProgress,
  }) : super(method, url);

  final void Function(int bytes, int totalBytes)? onProgress;

  /// Freezes all mutable fields and returns a single-subscription [ByteStream]
  /// that will emit the request body.
  http.ByteStream finalize() {
    final byteStream = super.finalize();
    if (onProgress == null) return byteStream;

    final total = this.contentLength;
    int bytes = 0;

    final t = StreamTransformer.fromHandlers(
      handleData: (List<int> data, EventSink<List<int>> sink) {
        bytes += data.length;
        onProgress!(bytes, total);
        sink.add(data);
      },
    );
    final stream = byteStream.transform(t);
    return http.ByteStream(stream);
  }
}
