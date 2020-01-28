import 'dart:typed_data';

import 'package:videoplayer/helpers/functions.dart';

class VideoFile {
  String album, displayName, path, duration, size, date, artist;
  Uint8List thumbnail;
  VideoFile(
      {this.displayName,
      this.path,
      this.artist,
      this.album,
      this.duration,
      this.date,
      this.size,
      this.thumbnail});
  VideoFile.empty() {
    this.displayName = '';
    this.artist = '';
    this.date = '';
    this.size = '';
    this.album = '';
    this.path = '';
    this.duration = '';
  }
  VideoFile.fromMap(Map map) {
    generateThumbnail(map['path']).then((thumbnail) {
      this.thumbnail = thumbnail;
    });
    this.displayName = map['displayName'];
    this.artist = map['artist'];
    this.date = map['dateAdded'];
    this.size = map['size'];
    this.album = map['album'];
    this.path = map['path'];
    this.duration = map['duration'];
  }
}
