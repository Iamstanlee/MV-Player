import 'dart:async';
import 'dart:io';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:videoplayer/data/video_file.dart';
import 'package:videoplayer/helpers/common.dart';
import 'package:videoplayer/helpers/functions.dart';
import 'package:videoplayer/widgets/loading.dart';
import 'package:videoplayer/widgets/my_icons.dart';

class VideoPlayerWidget extends StatefulWidget {
  final int videoIndex;
  final VideoFile videoFile;
  final List<VideoFile> videoFiles;
  VideoPlayerWidget({this.videoIndex, this.videoFiles, this.videoFile});
  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget>
    with AfterLayoutMixin<VideoPlayerWidget> {
  VideoPlayerController _controller;
  bool _disposeWidget = false;
  bool _lockWidget = false;
  int _currentIndex = 0;
  double _currentPosition = 0.0;
  List<VideoFile> _videoFiles = List();
  VideoFile _videoFile = VideoFile.empty();

  @override
  void afterFirstLayout(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    setSystemInterface(
        sbc: Color(0xFF1B1E23),
        snbc: Color(0xFF1B1E23),
        brightness: Brightness.light);
    _videoFiles = widget.videoFiles;
    _videoFile = widget.videoFile;
    _currentIndex = widget.videoIndex;
    init(_currentIndex);
  }

  void toggleLock() {
    setState(() {
      _lockWidget = !_lockWidget;
    });
  }

  void init(int index) {
    _controller = new VideoPlayerController.file(File(_videoFiles[index].path))
      ..initialize().then((init) {
        setState(() {
          _disposeWidget = false;
        });
      })
      ..addListener(() {
        if (_controller != null) {
          if (_currentPosition ==
              _controller.value.duration.inMilliseconds.toDouble()) {
            pop(context);
          }
          setState(() {
            _currentPosition =
                _controller.value.position.inMilliseconds.toDouble();
          });
        }
      })
      ..play();
  }

  void play(int index) {
    _videoFile = _videoFiles[index];
    // since we can't stop the player, pause the player
    //  to unable us play another video
    setState(() {
      _disposeWidget = true;
    });
    _controller.pause().then((pause) {
      new Timer(Duration(milliseconds: 100), () {
        _controller.dispose().then((dispose) {
          init(index);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double controllerHeight = getHeight(context, height: 9);

    return WillPopScope(
      onWillPop: () async {
        setSystemInterface();
        return true;
      },
      child: Scaffold(
          backgroundColor: blackColor,
          appBar: _lockWidget
              ? PreferredSize(
                  preferredSize: Size(getWidth(context), 56),
                  child: Container(height: 56),
                )
              : AppBar(
                  elevation: 0.0,
                  automaticallyImplyLeading: true,
                  leading: IconButton(
                    onPressed: () {
                      pop(context);
                    },
                    icon: Icon(MyIcons.icon_arrow_left),
                  ),
                  title: Text(
                    "${_videoFile.displayName}",
                    style: textStyle.copyWith(
                        fontFamily: secondaryFont,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  backgroundColor: blackColor,
                ),
          body: _controller != null
              ? Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Center(
                          child: !_disposeWidget
                              ? _controller.value.initialized
                                  ? AspectRatio(
                                      aspectRatio:
                                          _controller.value.aspectRatio,
                                      child: VideoPlayer(_controller),
                                    )
                                  : Loading()
                              : Loading()),
                    ),
                    _lockWidget
                        ? Container()
                        : _controller.value.initialized
                            ? Positioned(
                                bottom: controllerHeight + 12,
                                left: 12.0,
                                right: 12.0,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                        getFormattedDuration(_controller
                                            .value.position.inMilliseconds
                                            .toString()),
                                        style: textStyleWhite),
                                    Expanded(
                                        child: Slider(
                                      value: _currentPosition,
                                      max: _controller
                                          .value.duration.inMilliseconds
                                          .toDouble(),
                                      onChanged: (value) {
                                        _controller.seekTo(Duration(
                                            milliseconds: value.toInt()));
                                      },
                                    )),
                                    Text(
                                        getFormattedDuration(
                                            _videoFile.duration),
                                        style: textStyleWhite),
                                  ],
                                ),
                              )
                            : Container(),
                    Positioned(
                      bottom: 9,
                      right: 0,
                      left: 0,
                      child: Container(
                        height: controllerHeight,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: _lockWidget
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(5),
                              margin: _lockWidget
                                  ? EdgeInsets.only(left: 20.0)
                                  : EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      _lockWidget ? Colors.blue : Colors.black,
                                  border: Border.all(
                                      color: Colors.black12, width: 0.5)),
                              child: InkWell(
                                onTap: toggleLock,
                                child: Icon(
                                  _lockWidget
                                      ? Icons.lock
                                      : MyIcons.icon_lock_open,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            _lockWidget
                                ? Container()
                                : IconButton(
                                    color: Colors.white,
                                    iconSize: 30,
                                    icon: Icon(Icons.skip_previous),
                                    onPressed: () {
                                      setState(() {
                                        if (_currentIndex != 0) {
                                          _currentIndex = _currentIndex - 1;
                                          play(_currentIndex);
                                        }
                                      });
                                    },
                                  ),
                            _lockWidget
                                ? Container()
                                : Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Color(0xffdedede),
                                            width: 1.5)),
                                    child: InkWell(
                                      onTap: () async {
                                        setState(() {
                                          _controller.value.isPlaying
                                              ? _controller.pause()
                                              : _controller.play();
                                        });
                                      },
                                      child: Icon(
                                          _controller.value.isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          color: Colors.white,
                                          size: 32),
                                    ),
                                  ),
                            _lockWidget
                                ? Container()
                                : IconButton(
                                    iconSize: 30,
                                    color: Colors.white,
                                    icon: Icon(Icons.skip_next),
                                    onPressed: () {
                                      setState(() {
                                        if (_currentIndex !=
                                            (_videoFiles.length - 1)) {
                                          _currentIndex = _currentIndex + 1;
                                          play(_currentIndex);
                                        }
                                      });
                                    },
                                  ),
                            _lockWidget
                                ? Container()
                                : IconButton(
                                    icon: Icon(Icons.crop_free),
                                    color: Colors.white,
                                    onPressed: () {},
                                  )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              : Loading()),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
