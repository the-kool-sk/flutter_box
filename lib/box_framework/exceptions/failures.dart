import 'package:flutter_box/box_framework/utils.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable with Utils {
  @override
  List<Object> get props => [];
}

class CacheFailure extends Failure {}

// General failures
class ServerFailure extends Failure {
  final Exception? exception;

  ServerFailure({this.exception}) {
    boxLog(exception.toString());
  }
}

class NoInternetFailure extends Failure {}
