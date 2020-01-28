import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:storage_path/storage_path.dart';
import 'package:videoplayer/data/video_directory.dart';

class VideoBloc with ChangeNotifier {
  List<VideoDirectoryModel> _videoDirectory = List();

  List<VideoDirectoryModel> get videoDirectory => _videoDirectory;
  set videoDirectory(List<VideoDirectoryModel> videoDirectory) {
    this._videoDirectory = videoDirectory;
    notifyListeners();
  }

  /// get all paths on the devices that contains a video file
  void getVideoPath() async {
    var videoPath = <VideoDirectoryModel>[];
    try {
      videoPath = json
          .decode(await StoragePath.videoPath)
          .map<VideoDirectoryModel>((i) {
        return VideoDirectoryModel.fromMap(i);
      }).toList();
      videoDirectory = videoPath;
    } on PlatformException {
      //
    }
  }
}
