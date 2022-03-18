import 'package:flutter_box/network_connectivity/lib/src/widgets/connectivity_screen_wrapper.dart';
import 'package:flutter_box/res/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

typedef OnRefresh = Function();

class BoxWidget extends StatelessWidget {
  final Widget? child;
  final bool shouldHandleInternetConnectivityChanges;
  final bool shouldDisableInteractionWhenOffline;
  final Widget disabledWidget;
  final bool enablePullToRefresh;
  final OnRefresh? onRefresh;
  final RefreshController? refreshController;

  const BoxWidget(
      {this.child,
      this.shouldHandleInternetConnectivityChanges = true,
      this.shouldDisableInteractionWhenOffline = true,
      this.enablePullToRefresh = false,
      this.onRefresh,
      this.refreshController,
      this.disabledWidget = const SizedBox(
        //TODO: Add Default disable widget when no widget is provided by developer. Take from UI/UX team.
        child: Center(
            child: Text(
          "Provide disabled widget here",
          style: TextStyle(
            fontSize: 30,
            color: Colors.red,
            fontStyle: FontStyle.italic,
          ),
        )),
      ),
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: shouldHandleInternetConnectivityChanges
            ? ConnectivityScreenWrapper(
                //TODO: Provide other attributes when the UI/UX is provided.
                child: _pullToRefreshWidget(),
                disableInteraction: shouldDisableInteractionWhenOffline,
                disableWidget: disabledWidget,
              )
            : _pullToRefreshWidget());
  }

  Widget _pullToRefreshWidget() {
    return enablePullToRefresh
        ? SmartRefresher(
            controller: refreshController!,
            child: child!,
            enablePullDown: true,
            enablePullUp: false,
            header: const WaterDropMaterialHeader(
              color: BoxColors.white,
              backgroundColor: BoxColors.blue,
            ),
            onRefresh: onRefresh,
          )
        : child!;
  }
}
