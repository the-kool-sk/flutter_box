import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_box/box_framework/presentation/boxes/state_box.dart';
import 'package:flutter_box/box_framework/presentation/boxes/stateful_box.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../network_connectivity/lib/src/widgets/connectivity_app_wrapper_widget.dart';

class BoxApp extends StateFulBox {
  final Translations? translations;
  final Map<Pattern, VxPageBuilder> routes;
  final MaterialPage? notFoundPage;
  final String? appName;

  const BoxApp({required this.routes, this.appName, this.translations, Key? key, this.notFoundPage}) : super(key: key);

  @override
  _BoxAppState createState() => _BoxAppState();
}

class _BoxAppState extends StateBox<BoxApp> {
  late VxNavigator myNavigator;

  @override
  void initState() {
    super.initState();
    myNavigator = VxNavigator(
      notFoundPage: (uri, params) =>
      widget.notFoundPage ??
          MaterialPage(
            key: const ValueKey('not-found-page'),
            child: Builder(
              builder: (context) =>
                  Scaffold(
                    body: Center(
                      child: Text('Page ${uri.path} not found'),
                    ),
                  ),
            ),
          ),
      routes: widget.routes,
    );
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) =>
          ConnectivityAppWrapper(
              app: GetMaterialApp.router(
                debugShowCheckedModeBanner: false,
                routerDelegate: myNavigator,
                routeInformationParser: VxInformationParser(),
                title: widget.appName ?? "BoxApp",
                locale: Locale(Platform.localeName),
                fallbackLocale: const Locale('en', 'US'),
                translations: widget.translations,
                builder: EasyLoading.init(),
              )
          ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
