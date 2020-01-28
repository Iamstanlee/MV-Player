import 'package:flutter/material.dart';
import 'package:videoplayer/helpers/common.dart';

class PlayList extends StatefulWidget {
  @override
  _PlayListState createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Playlist'.toUpperCase(),
        style: textStyle.copyWith(
            fontFamily: secondaryFont,
            fontWeight: FontWeight.w500,
            fontSize: 15),
      )),
      body: Center(
        child: Text('PLAYLIST COMING SOON'),
      ),
    );
  }
}
