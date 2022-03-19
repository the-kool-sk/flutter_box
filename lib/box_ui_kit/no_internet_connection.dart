import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../res/color_resources.dart';

class NoInterConnectionWidget extends StatefulWidget {
  const NoInterConnectionWidget({Key? key}) : super(key: key);

  @override
  State<NoInterConnectionWidget> createState() => _NoInterConnectionWidgetState();
}

class _NoInterConnectionWidgetState extends State<NoInterConnectionWidget> {
  bool _isVisible = true;
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _isVisible = !_isVisible;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black54),
      height: 100.h,
      width: 100.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: _isVisible ? 1.0 : 0.0,
            child: const Icon(
              CupertinoIcons.wifi_exclamationmark,
              size: 50,
              color: BoxColors.white,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          const Text("No internet connection"),
        ],
      ),
    );
  }
}
