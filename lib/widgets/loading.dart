import 'package:flutter/material.dart';
import 'package:videoplayer/helpers/functions.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(getImage('ajax-loader.gif')),
    );
  }
}
