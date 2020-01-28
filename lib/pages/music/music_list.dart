import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videoplayer/bloc/music_bloc.dart';
import 'package:videoplayer/data/music_directory.dart';
import 'package:videoplayer/helpers/common.dart';
import 'package:videoplayer/helpers/functions.dart';
import 'package:videoplayer/pages/music/music_player.dart';
import 'package:videoplayer/pages/music/songs.dart';
import 'package:videoplayer/widgets/my_icons.dart';

class MusicList extends StatefulWidget {
  final MusicDirectoryModel musicPath;
  MusicList({this.musicPath});
  @override
  _MusicListState createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  @override
  Widget build(BuildContext context) {
    setSystemInterface();

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
            "${widget.musicPath.folderName}",
            style: textStyle.copyWith(
                fontFamily: secondaryFont,
                fontWeight: FontWeight.w500,
                fontSize: 16),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
        body: Stack(
          children: <Widget>[
            Songs(musicFiles: widget.musicPath.files),
            Provider.of<MusicBloc>(context).currentlyPlaying == null
                ? Container()
                : Positioned(
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: MusicPlayer(),
                  )
          ],
        ));
  }
}
