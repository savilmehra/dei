library global_file_upload_pkg;

import 'dart:io';

import 'package:flutter/material.dart';

import '../NetworkFile/apiCall.dart';
import '../Utils/StringUtils.dart';

class UploadFile {
  File? file;
  BuildContext context;

  String baseUrl;
  String? token;

  Function()? networkCallBack;
  UploadFile(
      {required this.baseUrl,
      required this.context,
      required this.file,
        this.networkCallBack

      });

  Future<dynamic> uploadFile() async {
    String url = baseUrl + StringUtils.imageUploadUrl;
    print(url);
    ApiCall apiCall = ApiCall();
    return await apiCall.upload(
        context,
        url,
        file!.path,
        token,
        networkCallBack
    );
  }
}

class UploadFolderFile {
  File file;
  BuildContext context;
  String ownerType;
  String ownerId;
  String? id;
  String baseUrl;
  String token;
  String contentType;
  String mimeType;
  Function(int progress) onProgressCallback;
  Function(String bytes)? onByteUpload;
  Function()? networkCallBack;
  UploadFolderFile(
      {required this.baseUrl,
      required this.context,
      required this.file,
      required this.token,
      required this.ownerType,
      required this.ownerId,
      required this.id,
      required this.contentType,
      required this.mimeType,
      required this.onProgressCallback,
      this.onByteUpload,
      this.networkCallBack});

  Future<dynamic> uploadFolderFile() async {
    String url = baseUrl + StringUtils.folderFileUploadUrl;
    print(url);
    ApiCall apiCall = ApiCall();
    return await apiCall.uploadFolderFile(
        context,
        url,
        file.path,
        token,
        ownerType,
        ownerId,
        id,
        contentType,
        onProgressCallback,
        mimeType,
        onByteUpload,
        networkCallBack);
  }
}
