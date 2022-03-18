import 'package:flutter_box/box_framework/utils.dart';
import 'package:flutter/cupertino.dart';

import '../../shared_preferences.dart';

abstract class StateFulBox extends StatefulWidget with Utils, SharedPreferencesBox {
  const StateFulBox({Key? key}) : super(key: key);
}