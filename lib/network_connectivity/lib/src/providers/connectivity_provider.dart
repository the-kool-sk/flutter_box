// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

import '../../connectivity_wrapper.dart';

// Project imports:


/// [ConnectivityProvider] event ChangeNotifier class for ConnectivityStatus .
/// which extends [ChangeNotifier].

class ConnectivityProvider extends ChangeNotifier {
  StreamController<ConnectivityStatus> connectivityController =
      StreamController<ConnectivityStatus>();

  Stream<ConnectivityStatus> get connectivityStream =>
      connectivityController.stream;

  ConnectivityProvider() {
    connectivityController.add(ConnectivityStatus.CONNECTED);
    _updateConnectivityStatus();
  }

  _updateConnectivityStatus() async {
    ConnectivityWrapper.instance.onStatusChange
        .listen((ConnectivityStatus connectivityStatus) {
      connectivityController.add(connectivityStatus);
    });
  }
}
