import 'package:videoplayer/data/video_file.dart';

class VideoDirectoryModel {
  List<VideoFile> files;
  String folderName, count;
  VideoDirectoryModel.fromMap(Map map) {
    List<VideoFile> tmp = List();
    for (int i = 0; i < map['files'].length; i++) {
      tmp.add(VideoFile.fromMap(map['files'][i]));
    }
    this.files = tmp;
    this.count = tmp.length.toString();
    this.folderName = map['folderName'];
  }
}
