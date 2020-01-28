import 'dart:typed_data';

class MusicFile {
  String album, displayName, path, duration, size, date, artist;
  Uint8List thumbnail;
  MusicFile(
      {this.displayName,
      this.path,
      this.artist,
      this.album,
      this.duration,
      this.date,
      this.size,
      this.thumbnail});
  MusicFile.empty() {
    this.displayName = '';
    this.artist = '';
    this.date = '';
    this.size = '';
    this.album = '';
    this.path = '';
    this.duration = '';
  }
  MusicFile.fromMap(Map map) {
    // generateThumbnail(map['path']).then((thumbnail) {
    //   this.thumbnail = thumbnail;
    // });
    this.displayName = map['displayName'];
    this.artist = map['artist'];
    this.date = map['dateAdded'];
    this.size = map['size'];
    this.album = map['album'];
    this.path = map['path'];
    this.duration = map['duration'];
  }
}
