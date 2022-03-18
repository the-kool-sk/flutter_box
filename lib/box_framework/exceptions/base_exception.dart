class BaseException implements Exception  {
  final String _message = "This is an exception";
  String get message => _message;
}