import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_box/box_framework/presentation/boxes/stateless_box.dart';
import 'package:flutter_box/box_ui_kit/helpers/box_enums.dart';
import 'package:flutter_box/box_ui_kit/helpers/box_refresh_controller.dart';
import 'package:flutter_box/network_connectivity/lib/src/widgets/connectivity_screen_wrapper.dart';
import 'package:flutter_box/res/color_resources.dart';
import 'package:flutter_box/res/string_resources.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'no_internet_connection.dart';

typedef OnRefresh = Function();
typedef OnConnectivityChanged = Function(bool status);

class BoxWidget extends StatelessBox {
  final Widget child;
  final bool handleInternetConnectivityChange;
  final bool disableWhenNoInternet;
  final Widget disabledWidget;
  final bool enablePullToRefresh;
  final OnRefresh? onRefresh;
  final BoxRefreshController? boxRefreshController;
  final OnConnectivityChanged? onConnectivityChanged;
  final String noInternetMessage;
  final OFFLINEDISPLAYMETHOD offlineDisplayMethod;
  final TextStyle messageStyle;

  BoxWidget(
      {this.child = const SizedBox(),
      this.onConnectivityChanged,
      this.handleInternetConnectivityChange = true,
      this.disableWhenNoInternet = true,
      this.enablePullToRefresh = false,
      this.offlineDisplayMethod = OFFLINEDISPLAYMETHOD.SNACKBAR,
      this.messageStyle = const TextStyle(color: BoxColors.white),
      this.onRefresh,
      this.boxRefreshController,
      this.disabledWidget = const NoInterConnectionWidget(),
      this.noInternetMessage = BoxStringResources.noInternetConnection,
      Key? key})
      : super(key: key) {
    if (enablePullToRefresh) {
      assert(onRefresh != null || (throw ArgumentError("If enablePullToRefresh is true onRefresh is required")));
      assert(boxRefreshController != null || (throw ArgumentError("If enablePullToRefresh is true boxRefreshController is required")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: handleInternetConnectivityChange
            ? ConnectivityScreenWrapper(
                child: _pullToRefreshWidget(),
                disableInteraction: disableWhenNoInternet,
                disableWidget: disabledWidget,
                message: noInternetMessage,
                messageStyle: messageStyle,
                offlineDisplayMethod: offlineDisplayMethod,
                onConnectivityChanged: onConnectivityChanged,
              )
            : _pullToRefreshWidget());
  }

  Widget _pullToRefreshWidget() {
    return enablePullToRefresh
        ? SmartRefresher(
            controller: boxRefreshController!,
            child: child,
            enablePullDown: true,
            enablePullUp: false,
            header: const MaterialClassicHeader(
              color: BoxColors.white,
              backgroundColor: BoxColors.blue,
            ),
            onRefresh: onRefresh,
          )
        : child;
  }
}
