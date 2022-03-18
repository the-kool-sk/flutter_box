import 'package:flutter_box/res/string_resources.dart';

import 'base_exception.dart';
import 'base_response_error.dart';

class ServerException implements Exception {
  ServerException(this.error);

  final BaseResponseError error;
}

class CacheException implements Exception {}

class UnknownException implements Exception {}

class MediaUploadFailed implements Exception {
  String message;
  String stackTrace;

  MediaUploadFailed(this.message, this.stackTrace);
}

class NoFileSelectedException implements BaseException {
  @override
  String get message => BoxStringResources.noFileSelected;
}

class FileSizeLimitExceedException implements BaseException {
  @override
  String get message => BoxStringResources.fileSizeLimitExceeded;
}
