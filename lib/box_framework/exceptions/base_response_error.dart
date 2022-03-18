class BaseResponseError {
  BaseResponseError({
    this.error,
    this.status,
  });

  factory BaseResponseError.fromJson(
      Map<String, dynamic> json)=> BaseResponseError(
    error: ResponseError.fromJson(json['error']),
    status: json['status'],
  );

  ResponseError? error;
  int? status;

  Map<String, dynamic> toJson() => {
    'error': error!.toJson(),
    'status': status,
  };
}

class ResponseError {
  ResponseError({
    this.message,
  });

  factory ResponseError.fromJson(Map<String, dynamic> json) => ResponseError(
    message: json['message'],
  );

  String? message;

  Map<String, dynamic> toJson() => {
    'message': message,
  };
}
