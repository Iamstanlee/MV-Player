import 'package:videoplayer/data/music_file.dart';

class MusicDirectoryModel {
  List<MusicFile> files;
  String folderName, count;
  MusicDirectoryModel.fromMap(Map map) {
    List<MusicFile> tmp = List();
    for (int i = 0; i < map['files'].length; i++) {
      tmp.add(MusicFile.fromMap(map['files'][i]));
    }
    this.files = tmp;
    this.count = tmp.length.toString();
    this.folderName = map['folderName'];
  }
}
