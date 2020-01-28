import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:videoplayer/bloc/video_bloc.dart';
import 'package:videoplayer/data/video_directory.dart';
import 'package:videoplayer/helpers/common.dart';
import 'package:videoplayer/helpers/functions.dart';
import 'package:videoplayer/pages/video/video_item.dart';
import 'package:videoplayer/pages/video/video_list.dart';
import 'package:videoplayer/widgets/loading.dart';
import 'package:videoplayer/widgets/my_icons.dart';

class Video extends StatefulWidget {
  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  @override
  Widget build(BuildContext context) {
    setSystemInterface();
    List<VideoDirectoryModel> videoPath =
        Provider.of<VideoBloc>(context).videoDirectory;
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Video'.toUpperCase(),
        style: textStyle.copyWith(
            fontFamily: secondaryFont,
            fontWeight: FontWeight.w500,
            fontSize: 15),
      )),
      body: videoPath.isEmpty
          ? Loading()
          : ListView(
              children: <Widget>[
                for (int i = 0; i < videoPath.length; i++)
                  VideoDirectory(
                    directory: videoPath[i].folderName,
                    numberFiles: videoPath[i].count,
                    callback: () {
                      navigate(context, VideoList(videoPath: videoPath[i]));
                    },
                  )
              ],
            ),
    );
  }
}
