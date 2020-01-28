import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videoplayer/bloc/music_bloc.dart';
import 'package:videoplayer/data/music_file.dart';
import 'package:videoplayer/helpers/common.dart';
import 'package:videoplayer/helpers/functions.dart';
import 'package:videoplayer/pages/music/music_item.dart';
import 'package:videoplayer/widgets/loading.dart';
import 'package:videoplayer/widgets/my_icons.dart';

class Songs extends StatefulWidget {
  final List<MusicFile> musicFiles;
  Songs({this.musicFiles});
  @override
  _SongsState createState() => _SongsState();
}

class _SongsState extends State<Songs> {
  @override
  Widget build(BuildContext context) {
    setSystemInterface();
    List<MusicFile> musicFiles = Provider.of<MusicBloc>(context).musicFiles;
    return widget.musicFiles == null
        ? musicFiles.isEmpty
            ? Loading()
            : ListView(
                children: <Widget>[
                  // Container(
                  //   height: getHeight(context, height: 7),
                  //   padding: EdgeInsets.only(left: 12),
                  //   child: Row(
                  //     children: <Widget>[
                  //       // Icon(, color: Colors.blue),
                  //       Text(
                  //         'Shuffle All ${musicFiles.length} Songs',
                  //         style: textStyle.copyWith(
                  //             fontFamily: secondaryFont,
                  //             color: Colors.grey[800],
                  //             fontSize: 15),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  for (int i = 0; i < musicFiles.length; i++)
                    if (musicFiles[i].artist != null)
                      MusicItem(
                        displayName: musicFiles[i].displayName,
                        artist: musicFiles[i].artist,
                        color:
                            Provider.of<MusicBloc>(context).currentlyPlaying ==
                                    musicFiles[i]
                                ? Colors.blue
                                : Colors.grey[800],
                        callback: () {
                          // playMusic
                          Provider.of<MusicBloc>(context, listen: false)
                              .startPlayer(musicFiles.indexOf(musicFiles[i]));
                        },
                      )
                ],
              )
        : ListView(
            children: <Widget>[
              for (int i = 0; i < widget.musicFiles.length; i++)
                if (widget.musicFiles[i].artist != null)
                  MusicItem(
                    displayName: widget.musicFiles[i].displayName,
                    artist: widget.musicFiles[i].artist,
                    color: Provider.of<MusicBloc>(context).currentlyPlaying ==
                            widget.musicFiles[i]
                        ? Colors.blue
                        : Colors.grey[800],
                    callback: () {
                      // playMusic
                      Provider.of<MusicBloc>(context, listen: false)
                          .startPlayer(
                              widget.musicFiles.indexOf(widget.musicFiles[i]));
                    },
                  )
            ],
          );
  }
}
