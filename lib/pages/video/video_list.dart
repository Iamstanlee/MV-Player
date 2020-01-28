import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_exoplayer/audioplayer.dart';
import 'package:provider/provider.dart';
import 'package:videoplayer/bloc/music_bloc.dart';
import 'package:videoplayer/bloc/video_bloc.dart';
import 'package:videoplayer/data/video_directory.dart';
import 'package:videoplayer/data/video_file.dart';
import 'package:videoplayer/helpers/common.dart';
import 'package:videoplayer/helpers/functions.dart';
import 'package:videoplayer/pages/video/video_item.dart';
import 'package:videoplayer/pages/video/video_player.dart';
import 'package:videoplayer/widgets/my_icons.dart';

class VideoList extends StatefulWidget {
  final VideoDirectoryModel videoPath;
  VideoList({this.videoPath});
  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  bool isGigabyte = false;

  @override
  Widget build(BuildContext context) {
    var music = Provider.of<MusicBloc>(context, listen: false);
    setSystemInterface();
    List<VideoFile> videos = widget.videoPath.files;
    int videoCount = widget.videoPath.files.length;
    double totalSize = 0;
    widget.videoPath.files.forEach((i) {
      totalSize += double.parse(i.size);
    });
    if ((totalSize * 0.000001) > 1024) {
      totalSize =
          double.parse(((totalSize * 0.000001) / 1024).toStringAsFixed(2));
      isGigabyte = true;
    } else {
      totalSize = double.parse((totalSize * 0.000001).toStringAsFixed(2));
    }

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
            onPressed: () {
              pop(context);
            },
            icon: Icon(MyIcons.icon_arrow_left),
          ),
          title: Text(
            "${widget.videoPath.folderName}",
            style: textStyle.copyWith(
                fontFamily: secondaryFont,
                fontWeight: FontWeight.w500,
                fontSize: 16),
          )),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 16, top: 10.0, bottom: 10.0),
            child: Text.rich(TextSpan(children: [
              TextSpan(
                text: videoCount > 1 ? '$videoCount VIDEOS  ' : '1 VIDEO  ',
              ),
              TextSpan(text: isGigabyte ? '$totalSize GB' : '$totalSize MB'),
            ])),
          ),
          for (int i = 0; i < videos.length; i++)
            VideoItem(
                displayName: videos[i].displayName,
                duration: videos[i].duration,
                thumbnail: videos[i].thumbnail,
                callback: () {
                  int index = videos.indexOf(videos[i]);
                  List<VideoFile> videoFiles = videos;
                  if (music.playerState == PlayerState.PLAYING) {
                    music.audioPlayer.release().then((res) {
                      navigate(
                          context,
                          VideoPlayerWidget(
                            videoFiles: videoFiles,
                            videoIndex: index,
                            videoFile: videos[i],
                          ));
                    });
                  } else {
                    navigate(
                        context,
                        VideoPlayerWidget(
                          videoFiles: videoFiles,
                          videoIndex: videos.indexOf(videos[i]),
                          videoFile: videos[i],
                        ));
                  }
                }),
        ],
      ),
    );
  }
}
