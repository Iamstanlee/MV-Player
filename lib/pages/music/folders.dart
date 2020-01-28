import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videoplayer/bloc/music_bloc.dart';
import 'package:videoplayer/bloc/video_bloc.dart';
import 'package:videoplayer/data/music_directory.dart';
import 'package:videoplayer/helpers/functions.dart';
import 'package:videoplayer/pages/music/music_item.dart';
import 'package:videoplayer/pages/music/music_list.dart';
import 'package:videoplayer/widgets/loading.dart';

class Folders extends StatefulWidget {
  @override
  _FoldersState createState() => _FoldersState();
}

class _FoldersState extends State<Folders> {
  @override
  Widget build(BuildContext context) {
    setSystemInterface();
    List<MusicDirectoryModel> musicPath =
        Provider.of<MusicBloc>(context).musicDirectory;
    return musicPath.isEmpty
        ? Loading()
        : ListView(
            children: <Widget>[
              for (int i = 0; i < musicPath.length; i++)
                MusicDirectory(
                  directory: musicPath[i].folderName,
                  numberFiles: musicPath[i].count,
                  callback: () {
                    navigate(context, MusicList(musicPath: musicPath[i]));
                  },
                )
            ],
          );
  }
}
