import 'package:flutter_box/box_framework/data/box_endpoint.dart';
import 'package:flutter_box/box_framework/data/box_model.dart';
import 'package:flutter_box/box_framework/exceptions/failures.dart';
import 'package:flutter_box/box_framework/utils.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<Type> with Utils {
  Future<Either<Failure, Type>> call(BoxEndpoint endpoint);
}

abstract class UseCaseWithoutEndPoint<Type> with Utils {
  Future<Either<Failure, Type>> call();
}

class NoParams extends BoxModel {

  @override
  List<Object> get props => [];

  @override
  Map<String, Object?> toJson() {
    throw UnimplementedError();
  }

  @override
  fromJson(Map<String, dynamic> response) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }
}
