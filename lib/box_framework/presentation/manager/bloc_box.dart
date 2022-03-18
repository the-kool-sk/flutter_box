import 'package:bloc/bloc.dart';
import 'package:flutter_box/box_framework/presentation/boxes/state_box.dart';
import 'package:flutter_box/box_framework/presentation/manager/event_box.dart';
import 'package:flutter_box/box_framework/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BlocBox<T extends EventBox, R extends StateBox> extends Bloc with Utils {
  BlocBox(initialState) : super(initialState);
}
