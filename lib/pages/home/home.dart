import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videoplayer/bloc/video_bloc.dart';
import 'package:videoplayer/helpers/functions.dart';
import 'package:videoplayer/pages/music/music.dart';
import 'package:videoplayer/pages/video/video.dart';
import 'package:videoplayer/widgets/my_icons.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  List<Widget> widgets = [Video(), Music()];

  @override
  void initState() {
    super.initState();
    Provider.of<VideoBloc>(context, listen: false).getVideoPath();
  }

  void doToggle(int i) {
    setState(() {
      currentIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgets.elementAt(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: doToggle,
        currentIndex: currentIndex,
        backgroundColor: Colors.white,
        iconSize: 21,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(getImage('tv.png')), size: 32),
              title: Text('Video')),
          BottomNavigationBarItem(
              icon: Icon(Icons.music_note, size: 32), title: Text('Music')),
        ],
      ),
    );
  }
}
