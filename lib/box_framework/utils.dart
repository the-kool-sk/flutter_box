import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_box/box_framework/extensions/extensions.dart';
import 'package:flutter_box/box_ui_kit/box_text.dart';
import 'package:flutter_box/network_connectivity/lib/connectivity_wrapper.dart';
import 'package:flutter_box/res/color_resources.dart';
import 'package:flutter_box/res/font_resources.dart';
import 'package:flutter_box/res/font_weights.dart';
import 'package:flutter_box/res/string_resources.dart';
import 'package:collapsible/collapsible.dart';
import 'package:date_format/date_format.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_compress/video_compress.dart';
import 'package:ntp/ntp.dart';
import 'package:velocity_x/velocity_x.dart';
import 'box_enums.dart';
import 'exceptions/exceptions.dart';

typedef OnCancelTap = Function();
typedef OnOkTap = Function();

mixin Utils {
  Future<bool> isInternetAvailable() async {
    if (await ConnectivityWrapper.instance.isConnected) {
      return Future<bool>.value(true);
    } else {
      return Future<bool>.value(false);
    }
  }

  String capitalize(String s) {
    if (s != null) {
      if (s.length == 0) return s;
      s = s.substring(0, 1).toUpperCase() + s.substring(1).toLowerCase();
      return s.trim();
    }
    return s;
  }

  String ensureProtocol(final String url) {
    if (!url.startsWith("http://")) {
      if (url.startsWith("https://")) {
        return url;
      }
      return "http://" + url;
    }
    return url;
  }

  bool isDebugMode() => kDebugMode;

  Future<void> showShorterToast(String message, {TOASTPOSITION toastPosition = TOASTPOSITION.TOP}) {
    return EasyLoading.showToast(
      message,
      maskType: EasyLoadingMaskType.none,
      duration: Duration(seconds: 2),
      toastPosition: toastPosition == TOASTPOSITION.TOP ? EasyLoadingToastPosition.top : EasyLoadingToastPosition.bottom,
    );
  }

  Future<void> showLongerToast(String message) {
    return EasyLoading.showToast(
      message,
      maskType: EasyLoadingMaskType.black,
      duration: Duration(seconds: 5),
      toastPosition: EasyLoadingToastPosition.bottom,
    );
  }

  void animationExpandCollapse(Widget _widget, bool _animationFlag) {
    // will expand when  _animationFlag false,
    // will collapse when _animationFlag `true`.
    if (_widget != null) {
      Collapsible(
        collapsed: _animationFlag,
        axis: CollapsibleAxis.both,
        duration: Duration(milliseconds: _animationFlag ? 240 : 360),
        // takes 240ms to collapse and 360ms to expand.
        child: _widget,
      );
    }
  }

  bool isKeyboardVisible(BuildContext context) {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }

  void hideSoftKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  //  void setProgressDialog(BuildContext context, String message) {
  //   ProgressDialog dialog = new ProgressDialog(context);
  //   dialog.style(
  //       message: message,
  //       borderRadius: 10.0,
  //       backgroundColor: Colors.white,
  //       progressWidget: CircularProgressIndicator(),
  //       elevation: 10.0,
  //       insetAnimCurve: Curves.easeInOut,
  //       progress: 0.0,
  //       maxProgress: 100.0,
  //       progressTextStyle: TextStyle(color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
  //       messageTextStyle: TextStyle(color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
  //   dialog.show();
  // }

  void showAlertDialog(BuildContext context, String title, String details, String yesBtnText, String? noBtnText,
      {AssetImage? assetImage,
      required OnCancelTap? onCancelTap,
      required OnOkTap onOkTap,
      bool barrierDismissible = true,
      bool isGuestUser = false}) {
    var cancelButton;
    if (noBtnText != null && onCancelTap != null) {
      cancelButton = TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(BoxColors.grey1),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 5.w)),
        ),
        child: BoxText(
          text: noBtnText,
          fontWeight: BoxFontWeights.regular,
          fontSize: BoxFontSize.ten,
          color: BoxColors.white,
          alignment: TextAlign.center,
        ),
        onPressed: onCancelTap,
      );
    }
    Widget continueButton = TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(BoxColors.blue),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 8.w)),
      ),
      child: BoxText(
        text: yesBtnText,
        fontWeight: BoxFontWeights.regular,
        fontSize: BoxFontSize.ten,
        color: BoxColors.white,
        alignment: TextAlign.center,
      ),
      onPressed: onOkTap,
    );

    AlertDialog alert = AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      alignment: Alignment.center,
      title: BoxText(
        text: title,
        fontWeight: BoxFontWeights.medium,
        fontSize: BoxFontSize.twelve,
        color: BoxColors.black,
        alignment: TextAlign.center,
        maxLines: 1,
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          assetImage != null
              ? Container(
                  child: Image(
                    image: assetImage,
                  ),
                )
              : Container(),
          SizedBox(
            height: 2.h,
          ),
          BoxText(
            text: details,
            fontWeight: BoxFontWeights.regular,
            fontSize: BoxFontSize.ten,
            color: BoxColors.grey1,
            alignment: TextAlign.justify,
            maxLines: 5,
          ),
        ],
      ),
      actions: [
        noBtnText != null && onCancelTap != null ? cancelButton : SizedBox(),
        continueButton,
      ],
      actionsPadding: EdgeInsets.symmetric(horizontal: 10.w),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(onWillPop: () async => false, child: alert);
      },
      barrierDismissible: barrierDismissible,
    );
  }

  void circularProgressIndicator() {
    Container(child: CircularProgressIndicator(), width: 32, height: 32);
  }

  //Format - yyyy-MM-dd HH:mm:ss
  DateTime getTodaysDate() {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    return date;
  }

  String convertDateToStringTime(DateTime date) {
    return formatDate(date, [yyyy, '-', mm, '-', dd, ' ', hh, ':', nn, ':', ss]);
  }

  String convertDateToStringDate(DateTime date) {
    return formatDate(date, [yyyy, '-', mm, '-', dd]);
  }

  String convertDateToStringDate2(DateTime date) {
    return DateFormat.yMMMMEEEEd().format(date);
  }

  String convertTo12hrsFormat(DateTime date) {
    return DateFormat('jm').format(date);
  }

  String convertToddmmyyDateFormat(DateTime date) {
    return formatDate(date, [dd, '-', mm, '-', yy]);
  }

  String convertToddmmmyyDateFormat(DateTime date) {
    return formatDate(date, [dd, '-', M, '-', yy]);
  }

  String convertToddmmyyyyDateFormat(DateTime date) {
    return formatDate(date, [dd, '-', mm, '-', yyyy]);
  }

  DateTime? convertStringToDate(String strDate) {
    return DateTime.tryParse(strDate);
    //print(todayDate);
    //print(formatDate(todayDate, [yyyy, '-', mm, '-', dd, ' ', hh, ':', nn, ':', ss, ' ', am]));
  }

  DateTime? convertUtcStringToDate(String strDate) {
    return DateTime.tryParse(strDate)?.toLocal();
  }

  DateTime? convertChatDateStringToDate(String strDate) {
    //strDate = '18-Dec-2021 1:3:34 PM';
    //           Dec 18, 2021 2:38:07 PM
    strDate = "${strDate.split(" ")[0] + " " + strDate.split(" ")[1] + " " + strDate.split(" ").last.toUpperCase()}";
    //return DateFormat('dd-MMM-yyyy hh:mm:ss aaa').parse(strDate);
    return DateTime.parse(strDate);
  }

  Future<String> millisecondsToDateConversion(int timeInMillis) async {
    var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    var formattedDate = DateFormat.yMMMd().format(date); // Apr 8, 2020
    return formattedDate;
  }

  String getUrlSpaceString(String string) {
    try {
      return string.replaceAll(" ", "%20");
    } catch (Exception) {
      return string;
    }
  }

  createDirectory(String _dirName) async {
    final docDir = await getApplicationDocumentsDirectory();
    final myDir = Directory('${docDir.path}/$_dirName');
    if (await myDir.exists()) {
      print(myDir.path);
    }
    final dir = await myDir.create(recursive: true);
    print(dir.path);
  }

  int getLastDayOfMonth(int year, int month) {
    var lastDayDateTime = (month < 12) ? new DateTime(year, month + 1, 0) : new DateTime(year + 1, 1, 0);
    return lastDayDateTime.day;
  }

  String getNumericStringValue(String input) {
    String output = input;
    if (input.isEmpty) {
      output = "0";
    } else if (input.endsWith(".")) {
      output = input + "0";
    }
    return output;
  }

  Future<String> getAppDetails() async {
    var result = await PackageInfo.fromPlatform();
    return result.version;
  }

  //  Future<String> getExternalStorageDirectory() async {
  //   var path = await ExtStorage.getExternalStorageDirectory();
  //   return path; // /storage/emulated/0
  // }
  //
  //  Future<String> getExternalStoragePictureDir() async {
  //   var path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_PICTURES);
  //   return path; // /storage/emulated/0/Pictures
  // }

  bool isYoutubeUrl(String youTubeURl) {
    bool success;
    String pattern = "^(http(s)?://)?((w){3}.)?youtu(be|.be)?(\\.com)?/.+";
    success = youTubeURl.isNotEmpty && youTubeURl == pattern;
    return success;
  }

  String formatValueUptoTwoDecimal(var value) {
    value = value.toStringAsFixed(2);
    return value;
  }

  Future<PlatformFile> pickFile(
    int sizeLimit,
    String limitErrorText, {
    FileType type = FileType.image,
    bool isCustomType = false,
    List<String> customTypes = const ['pdf'],
  }) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: type,
      allowedExtensions: isCustomType ? customTypes : null,
    );
    if (result != null) {
      if (result.files.single.size < sizeLimit) {
        return result.files.single;
      } else {
        throw FileSizeLimitExceedException();
      }
    }
    throw NoFileSelectedException();
  }

  Future<MediaInfo> compressVideo(File? file) async {
    MediaInfo? mediaInfo = await VideoCompress.compressVideo(
      file?.path ?? "",
      quality: VideoQuality.Res640x480Quality,
      deleteOrigin: false, // It's false by default
    );
    return Future.value(mediaInfo);
  }

  String getFileNameFromPath(File file) => file.path.split('/').last;

  String convertTimeOfDayToString(DateTime timeOfDay) => timeOfDay.toIso8601String();

  List<String> convertDateTimeListToStringList(List<DateTime> list) {
    List<String> _list = List.empty(growable: true);
    list.forEach((element) {
      _list.add(element.toUtc().toString());
    });
    return _list;
  }

  String getNameFromFile(File file) => file.path.split('/').last;

  bool isWideDevice() => SizerUtil.height / SizerUtil.width < 1.8;

  showLoader() => EasyLoading.show(status: BoxStringResources.loading, maskType: EasyLoadingMaskType.black);

  showLoaderWithMessage(String message) => EasyLoading.show(status: message, maskType: EasyLoadingMaskType.black);

  hideLoader() => EasyLoading.dismiss();

  List<DateTime> getDateTimeListFromStringList(List<String> mFrequency) {
    var list = List<DateTime>.empty(growable: true);
    mFrequency.forEach((element) {
      list.add(DateTime.parse(element).toLocal());
    });
    return list;
  }

  TimeOfDay getTimeOfDayFromInt(int? startTime) {
    if (startTime != null) {
      return TimeOfDay(hour: int.parse(startTime.toString().substring(0, 2)), minute: int.parse(startTime.toString().substring(2, 4)));
    } else {
      return TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
    }
  }

  String getUTCTimeFromDateTime(DateTime dateTime) => dateTime.toUtc().toString();

  void launchURL(String url) async => await canLaunch(url) ? await launch(url) : showShorterToast(BoxStringResources.urlLaunchFailMessage);

  void boxLog(
    String message, {
    DateTime? time,
    int? sequenceNumber,
    int level = 0,
    String name = '',
    Zone? zone,
    Object? error,
    StackTrace? stackTrace,
    Exception? exception,
    bool logInFirebase = false,
    bool isFatal = false,
    String module = "app",
  }) {
    if (isDebugMode()) {
      log(message, time: time, sequenceNumber: sequenceNumber, level: level, name: name, zone: zone, error: error);
    }
    if (logInFirebase) {
      logFirebaseError(exception, StackTrace.fromString(message), isFatal: isFatal, module: module);
    }
  }

  void logFirebaseError(Object? exception, StackTrace trace, {bool isFatal = false, String module = "app"}) {
    FirebaseCrashlytics.instance.recordError(exception, trace, reason: module, fatal: isFatal);
  }

  // void verifyDeviceClockSettings(BuildContext context) {
  //   isInternetAvailable().then((value) {
  //     if (value) {
  //       NTP.now().then((value) {
  //         var deviceDate =
  //             DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute, 0, 0, 0);
  //         var networkDate = DateTime(value.year, value.month, value.day, value.hour, value.minute, 0, 0, 0);
  //         if (!deviceDate.difference(networkDate).inMinutes.isBetween(-6, 6)) {
  //           showLongerToast(BoxStringResources.mismatchDateTime.tr);
  //           Future.delayed(const Duration(seconds: 3), () {
  //             try {
  //               context.vxNav.push(Uri.parse(Routes.R_CLOCK_SYNC_PAGE));
  //             } catch (e) {
  //               e.printError();
  //               SystemNavigator.pop();
  //             }
  //           });
  //         }
  //       });
  //     } else {
  //       showShorterToast(BoxStringResources.noInternetConnection.tr);
  //     }
  //   });
  // }
//
// Future<bool> isClockSettingOk(BuildContext context) async {
//   if (await isInternetAvailable()) {
//     var value = await NTP.now();
//     var deviceDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute, 0, 0, 0);
//     var networkDate = DateTime(value.year, value.month, value.day, value.hour, value.minute, 0, 0, 0);
//     if (deviceDate.difference(networkDate).inMinutes.isBetween(-6, 6)) {
//       return true;
//     } else {
//       showLongerToast(BoxStringResources.mismatchDateTime.tr);
//       return false;
//     }
//   } else {
//     showShorterToast(BoxStringResources.noInternetConnection.tr);
//     return false;
//   }
// }
}
