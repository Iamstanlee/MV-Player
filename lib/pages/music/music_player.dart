import 'package:flutter/material.dart';
import 'package:flutter_exoplayer/audioplayer.dart';
import 'package:provider/provider.dart';
import 'package:videoplayer/bloc/music_bloc.dart';
import 'package:videoplayer/data/music_file.dart';
import 'package:videoplayer/helpers/common.dart';
import 'package:videoplayer/helpers/functions.dart';
import 'package:videoplayer/widgets/my_icons.dart';

class MusicPlayer extends StatefulWidget {
  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  MusicFile _musicFile;

  @override
  Widget build(BuildContext context) {
    var music = Provider.of<MusicBloc>(context);
    _musicFile = music.currentlyPlaying;

    return Container(
      height: getHeight(context, height: 8),
      padding: EdgeInsets.all(8.0),
      color: Colors.grey[300],
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: () {
              music.currentlyPlaying = null;
              Provider.of<MusicBloc>(context, listen: false)
                  .audioPlayer
                  .release();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Icon(Icons.clear, size: 21),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 4.0, left: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${_musicFile.displayName}',
                    overflow: TextOverflow.ellipsis,
                    style: textStyle.copyWith(
                        fontFamily: secondaryFont,
                        color: Colors.grey[800],
                        fontSize: 15),
                  ),
                  Text(
                    '${music.currentPosition} / ${getFormattedDuration(_musicFile.duration)}',
                    overflow: TextOverflow.ellipsis,
                    style: textStyle.copyWith(
                        fontFamily: secondaryFont,
                        color: Colors.grey[600],
                        fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              music.playerState == PlayerState.PLAYING
                  ? music.pause()
                  : music.resume();
            },
            child: Padding(
                padding: EdgeInsets.only(left: 4.0, right: 4.0),
                child: music.playerState == PlayerState.PLAYING
                    ? Icon(Icons.pause, size: 32)
                    : Icon(MyIcons.play, size: 32)),
          ),
          InkWell(
            onTap: () {
              music.audioPlayer.next();
            },
            child: Padding(
                padding: EdgeInsets.only(left: 4.0, right: 4.0),
                child: Icon(Icons.skip_next, size: 32)),
          ),
        ],
      ),
    );
  }
}
