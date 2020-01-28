import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'common.dart';

/// return a random a from range 0 to [max] params
int getRandomInt(int max) {
  return new Random().nextInt(max);
}

String getImage(String uri) {
  return 'assets/$uri';
}

void setSystemInterface(
    {Color sbc = const Color(0xFF1B1E23),
    snbc = Colors.white,
    brightness = Brightness.dark}) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: sbc,
      systemNavigationBarColor: snbc,
      systemNavigationBarIconBrightness: brightness));
}

String getFormattedDuration(String string, {Duration duration}) {
  String formattedDuration;
  if (duration == null) {
    var tmp = Duration(milliseconds: int.parse(string));
    if (tmp.inHours >= 1) {
      formattedDuration =
          "${tmp.inHours.toString().padLeft(2, '0')}:${tmp.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(tmp.inSeconds.remainder(60).toString().padLeft(2, '0'))}";
    } else {
      formattedDuration =
          "${tmp.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(tmp.inSeconds.remainder(60).toString().padLeft(2, '0'))}";
    }
  } else {
    var tmp = duration;
    if (tmp.inHours >= 1) {
      formattedDuration =
          "${tmp.inHours.toString().padLeft(2, '0')}:${tmp.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(tmp.inSeconds.remainder(60).toString().padLeft(2, '0'))}";
    } else {
      formattedDuration =
          "${tmp.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(tmp.inSeconds.remainder(60).toString().padLeft(2, '0'))}";
    }
  }
  return formattedDuration;
}

String getReference() {
  String timestamp = DateTime.now().toString().split('.').last;
  return '#' + timestamp;
}

/// takes a percentage of the screens width and return a double of current width
double getWidth(context, {width}) {
  if (width == null) return MediaQuery.of(context).size.width;
  return ((width / 100) * MediaQuery.of(context).size.width);
}

/// takes a percentage of the screens height and return a double of screen height.
double getHeight(context, {height}) {
  if (height == null) return MediaQuery.of(context).size.height;
  return ((height / 100) * MediaQuery.of(context).size.height);
}

/// Navigate to a new route by passing a route widget with a fade animation
/// default animation duration is a second

/// Navigate to a new route by passing a route widget
void navigate(context, Widget to) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return to;
  }));
}

/// replace the current widget by passing a route widget
void replaceWidget(context, Widget to) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    return to;
  }));
}

/// pop the current route
void pop(BuildContext context) {
  Navigator.pop(context);
}

/// generate thumbnail for each video using the video path
Future<Uint8List> generateThumbnail(String videoFile) async {
  final uint8List = await VideoThumbnail.thumbnailData(
    video: videoFile,
    imageFormat: ImageFormat.PNG,
    maxWidth: 128,
    quality: 25,
  );
  return uint8List;
}

///returns ads unit for admob
String getBannerAdUnitId() {
  return 'ca-app-pub-3940256099942544/6300978111';
}

/// Navigate to a new route by passing a route widget
///  and dispose the previous routes
void navigateAndClearHistory(context, to) {
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
    return to;
  }), (_) => false);
}

/// Show snack bar from anywhere in the by passing a global key of type scffold state and the string to be displayed
showSnackBar(GlobalKey<ScaffoldState> _scaffoldState, String content) {
  if (content == null) return;
  if (_scaffoldState.currentState == null) return;
  _scaffoldState.currentState.showSnackBar(SnackBar(
    content: Text(
      content,
      style:
          textStyle.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
    ),
    backgroundColor: Colors.black,
    behavior: SnackBarBehavior.floating,
    duration: Duration(seconds: 1),
  ));
}

/// Hide snack bar from anywhere in the by passing a global key of type scaffold state
hideSnackBar(GlobalKey<ScaffoldState> _scaffoldState) {
  _scaffoldState.currentState.hideCurrentSnackBar();
}
