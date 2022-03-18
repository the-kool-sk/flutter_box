// Flutter imports:
import 'package:flutter_box/network_connectivity/lib/src/providers/connectivity_provider.dart';
import 'package:flutter/material.dart';


// Package imports:
import 'package:provider/provider.dart';

import '../../connectivity_wrapper.dart';

// Project imports:


///[ConnectivityAppWrapper] is a StatelessWidget.

class ConnectivityAppWrapper extends StatelessWidget {
  /// [app] will accept MaterialApp or CupertinoApp must be non-null
  final Widget app;

  const ConnectivityAppWrapper({Key? key, required this.app}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityStatus>(
      initialData: ConnectivityStatus.CONNECTED,
      create: (context) => ConnectivityProvider().connectivityStream,
      child: app,
    );
  }
}
