import 'package:flutter_box/box_framework/utils.dart';
import 'package:equatable/equatable.dart';

abstract class BoxModel<T> extends Equatable with Utils {

  Map<String, dynamic> toJson();
  T fromJson(Map<String,dynamic> response);
  @override
  List<Object?> get props;
  @override
  bool get stringify => false;
}