// Flutter imports:
import 'package:flutter_box/box_framework/presentation/boxes/stateless_box.dart';
import 'package:flutter_box/box_ui_kit/box_screen.dart';
import 'package:flutter_box/box_ui_kit/helpers/box_enums.dart';
import 'package:flutter_box/network_connectivity/lib/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_box/res/string_resources.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../connectivity_wrapper.dart';

enum PositionOnScreen {
  TOP,
  BOTTOM,
}

class ConnectivityScreenWrapper extends StatelessBox {
  /// The [child] contained by the ConnectivityScreenWrapper.
  final Widget? child;

  /// The decoration to paint behind the [child].
  final Decoration? decoration;

  /// The color to paint behind the [child].
  final Color? color;

  /// Disconnected message.
  final String? message;

  /// If non-null, the style to use for this text.
  final TextStyle? messageStyle;

  /// widget height.
  final double? height;

  /// How to align the offline widget.
  final PositionOnScreen positionOnScreen;

  /// How to align the offline widget.
  final Duration? duration;

  /// Disable the user interaction with child widget
  final bool disableInteraction;

  /// Disable the user interaction with child widget
  final Widget? disableWidget;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;
  final OnConnectivityChanged? onConnectivityChanged;
  OFFLINEDISPLAYMETHOD offlineDisplayMethod;
  Widget _offlineWidget = const SizedBox();

  ConnectivityScreenWrapper({
    Key? key,
    this.child,
    this.color,
    this.decoration,
    this.message,
    this.messageStyle,
    this.height,
    this.textAlign,
    this.duration,
    this.positionOnScreen = PositionOnScreen.BOTTOM,
    this.offlineDisplayMethod = OFFLINEDISPLAYMETHOD.SNACKBAR,
    this.disableInteraction = false,
    this.disableWidget,
    this.onConnectivityChanged,
  })  : assert(
            color == null || decoration == null,
            'Cannot provide both a color and a decoration\n'
            'The color argument is just a shorthand for "decoration: new BoxDecoration(color: color)".'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isOffline = Provider.of<ConnectivityStatus>(context) != ConnectivityStatus.CONNECTED;
    onConnectivityChanged?.call(isOffline);
    double _height = height ?? defaultHeight;
    if(isOffline) {
      switch (offlineDisplayMethod) {
        case OFFLINEDISPLAYMETHOD.TOAST:
          showShorterToast(message ?? "");
          break;
        case OFFLINEDISPLAYMETHOD.SNACKBAR:
          _offlineWidget = AnimatedPositioned(
            top: positionOnScreen.top(_height, isOffline),
            bottom: positionOnScreen.bottom(_height, isOffline),
            child: AnimatedContainer(
              height: _height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              decoration: decoration ?? BoxDecoration(color: color ?? Colors.red.shade500),
              child: Center(
                child: Text(
                  message ?? disconnectedMessage,
                  style: messageStyle ?? defaultMessageStyle,
                  textAlign: textAlign,
                ),
              ),
              duration: duration ?? const Duration(milliseconds: 300),
            ),
            duration: duration ?? const Duration(milliseconds: 300),
          );
          break;
      }
    }else{
      _offlineWidget = const SizedBox();
    }

    return AbsorbPointer(
      absorbing: (disableInteraction && isOffline),
      child: Stack(
        children: (<Widget>[
          // Remove ?
          child!, // Add ! or maybe a test (if child != null) child!
          if (disableInteraction && isOffline)
            if (disableWidget != null) disableWidget!, // Add !
          _offlineWidget
        ]),
      ),
    );
  }
}
