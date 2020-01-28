import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_exoplayer/audio_notification.dart';
import 'package:flutter_exoplayer/audioplayer.dart';
import 'package:storage_path/storage_path.dart';
import 'package:videoplayer/data/music_directory.dart';
import 'package:videoplayer/data/music_file.dart';
import 'package:videoplayer/helpers/functions.dart';

class MusicBloc with ChangeNotifier {
  AudioPlayer _audioPlayer = AudioPlayer();
  List<MusicDirectoryModel> _musicDirectory = List();
  List<MusicFile> _musicFiles = List();
  List<MusicFile> get musicFiles => _musicFiles;
  AudioPlayer get audioPlayer => _audioPlayer;
  PlayerState _playerState;
  PlayerState get playerState => _playerState;
  List<MusicDirectoryModel> get musicDirectory => _musicDirectory;
  int _currentIndex = 0;
  String _currentPosition;
  String get currentPosition => _currentPosition;
  MusicFile _currentlyPlaying;
  MusicFile get currentlyPlaying => _currentlyPlaying;

  set currentPosition(String position) {
    this._currentPosition = position;
    notifyListeners();
  }

  set playerState(PlayerState state) {
    this._playerState = state;
    notifyListeners();
  }

  int get currentIndex => _currentIndex;
  set currentIndex(int index) {
    this._currentIndex = index;
    notifyListeners();
  }

  set currentlyPlaying(MusicFile newFile) {
    this._currentlyPlaying = newFile;
    notifyListeners();
  }

  set musicFiles(List<MusicFile> musicFiles) {
    this._musicFiles = musicFiles;
    notifyListeners();
  }

  set musicDirectory(List<MusicDirectoryModel> musicDirectory) {
    this._musicDirectory = musicDirectory;
    notifyListeners();
  }

  /// get all paths on the devices that contains a music file
  void getMusicPath() async {
    var musicPath = <MusicDirectoryModel>[];
    var files = <MusicFile>[];
    try {
      musicPath = json
          .decode(await StoragePath.audioPath)
          .map<MusicDirectoryModel>((i) {
        return MusicDirectoryModel.fromMap(i);
      }).toList();
      musicPath.forEach((directory) {
        directory.files.forEach((file) {
          files.add(file);
        });
      });
      musicFiles = files;
      musicDirectory = musicPath;
    } on PlatformException {
      //
    }
  }

  void startPlayer(int index) async {
    // AudioPlayer.logEnabled = true;
    List<String> urls = List();
    List<AudioNotification> audioNotifications = List();
    for (int i = 0; i < musicFiles.length; i++) {
      urls.add(musicFiles[i].path);
      audioNotifications.add(AudioNotification(
          smallIconFileName: 'album',
          title: musicFiles[i].displayName,
          subTitle: musicFiles[i].artist));
    }
    if (_audioPlayer.playerState == PlayerState.PLAYING) {
      _audioPlayer.seekIndex(index);
    } else {
      _audioPlayer
          .playAll(urls,
              playerMode: PlayerMode.FOREGROUND,
              index: index,
              audioNotifications: audioNotifications)
          .then((Result res) {});
    }

    /// listen to streams from from player
    _audioPlayer.onCurrentAudioIndexChanged.listen((value) {
      currentlyPlaying = musicFiles[value];
    });
    _audioPlayer.onAudioPositionChanged.listen((position) {
      currentPosition = getFormattedDuration('', duration: position);
    });
    _audioPlayer.onPlayerStateChanged.listen((newState) {
      playerState = newState;
    });
  }

  void pause() async {
    await _audioPlayer.pause();
  }

  void resume() async {
    await _audioPlayer.resume();
  }
}
