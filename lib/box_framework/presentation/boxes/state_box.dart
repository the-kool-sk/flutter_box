import 'package:flutter_box/box_framework/presentation/boxes/stateful_box.dart';
import 'package:flutter_box/box_framework/shared_preferences.dart';
import 'package:flutter_box/box_framework/utils.dart';
import 'package:flutter/cupertino.dart';

abstract class StateBox<T extends StatefulWidget> extends State<T> with Utils, SharedPreferencesBox {}
