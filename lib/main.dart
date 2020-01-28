import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:videoplayer/bloc/music_bloc.dart';
import 'package:videoplayer/bloc/video_bloc.dart';
import 'package:videoplayer/helpers/common.dart';
import 'package:videoplayer/helpers/functions.dart';
import 'package:videoplayer/pages/home/home.dart';

void main() {
  runApp(VidPlayer());
}

class VidPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    setSystemInterface();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => VideoBloc(),
        ),
        ChangeNotifierProvider(
          create: (context) => MusicBloc(),
        )
      ],
      child: MaterialApp(
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        title: 'MVPlayer',
        home: Home(),
      ),
    );
  }
}
