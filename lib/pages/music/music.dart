import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exoplayer/audioplayer.dart';
import 'package:provider/provider.dart';
import 'package:videoplayer/bloc/music_bloc.dart';
import 'package:videoplayer/helpers/common.dart';
import 'package:videoplayer/pages/music/folders.dart';
import 'package:videoplayer/pages/music/music_player.dart';
import 'package:videoplayer/pages/music/songs.dart';
import 'package:videoplayer/widgets/my_icons.dart';

class Music extends StatefulWidget {
  @override
  _MusicState createState() => _MusicState();
}

class _MusicState extends State<Music>
    with SingleTickerProviderStateMixin<Music>, AfterLayoutMixin<Music> {
  TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<MusicBloc>(context, listen: false).getMusicPath();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Music'.toUpperCase(),
          style: textStyle.copyWith(
              fontFamily: secondaryFont,
              fontWeight: FontWeight.w500,
              fontSize: 15),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 2,
          tabs: <Widget>[
            Tab(
              child: Text(
                'SONGS',
                style: textStyle,
              ),
            ),
            Tab(
                child: Text(
              'FOLDERS',
              style: textStyle,
            ))
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          TabBarView(
            controller: _tabController,
            children: <Widget>[Songs(), Folders()],
          ),
          Provider.of<MusicBloc>(context).currentlyPlaying == null
              ? Container()
              : Positioned(
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: MusicPlayer(),
                )
        ],
      ),
    );
  }
}
