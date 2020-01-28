import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:videoplayer/helpers/common.dart';
import 'package:videoplayer/helpers/functions.dart';

class MusicItem extends StatelessWidget {
  final VoidCallback callback;
  final String artist, displayName;
  final Color color;
  const MusicItem(
      {Key key, this.callback, this.color, this.displayName, this.artist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        height: getHeight(context, height: 8),
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '$displayName',
                    overflow: TextOverflow.ellipsis,
                    style: textStyle.copyWith(
                        fontFamily: secondaryFont, color: color, fontSize: 15),
                  ),
                  Text(
                    '$artist',
                    overflow: TextOverflow.ellipsis,
                    style: textStyle.copyWith(
                        fontFamily: secondaryFont,
                        color: Colors.grey[600],
                        fontSize: 13),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 6.0),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert,
                  size: 21,
                  color: Colors.grey[400],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MusicDirectory extends StatelessWidget {
  final String directory, numberFiles;
  final VoidCallback callback;
  MusicDirectory(
      {Key key,
      this.directory = 'Unknown',
      this.numberFiles = '',
      this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        height: getHeight(context, height: 9),
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.folder, color: Colors.grey[400]),
                  Padding(
                    padding: EdgeInsets.only(left: 12.0, top: 2.0),
                    child: Text(
                      '$directory',
                      style: textStyle.copyWith(
                          fontFamily: secondaryFont,
                          color: Colors.grey[800],
                          fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 6.0),
                    child: Text('$numberFiles',
                        style: textStyle.copyWith(color: Colors.grey[400])),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 6.0),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    size: 21,
                    color: Colors.grey[400],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
