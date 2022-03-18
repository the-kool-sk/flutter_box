import 'package:flutter_box/box_framework/utils.dart';
import 'package:flutter/cupertino.dart';

import '../../shared_preferences.dart';

abstract class StatelessBox extends StatelessWidget with Utils, SharedPreferencesBox {
  const StatelessBox({Key? key}) : super(key: key);
}
