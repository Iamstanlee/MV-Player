import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:videoplayer/helpers/common.dart';
import 'package:videoplayer/helpers/functions.dart';
import 'package:videoplayer/widgets/loading.dart';

class VideoItem extends StatelessWidget {
  final VoidCallback callback;
  final String duration, displayName;
  final Uint8List thumbnail;
  const VideoItem(
      {Key key, this.callback, this.displayName, this.duration, this.thumbnail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String videoDuration = getFormattedDuration(duration);
    return InkWell(
      onTap: callback,
      child: Container(
        height: getHeight(context, height: 12),
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  fit: StackFit.loose,
                  children: <Widget>[
                    thumbnail == null
                        ? Container(
                            width: getWidth(context, width: 27),
                            child: Center(
                              child: Loading(),
                            ),
                          )
                        : Image.memory(
                            thumbnail,
                            fit: BoxFit.cover,
                            width: getWidth(context, width: 27),
                          ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        child: Text(
                          '$videoDuration',
                          style: textStyleWhite,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: getWidth(context, width: 50),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                    child: Text(
                      '$displayName',
                      style: textStyle.copyWith(
                          fontFamily: secondaryFont,
                          color: Colors.grey[700],
                          fontSize: 15),
                    ),
                  ),
                )
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
    );
  }
}

class VideoDirectory extends StatelessWidget {
  final String directory, numberFiles;
  final VoidCallback callback;
  VideoDirectory(
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
            ],
          ),
        ),
      ),
    );
  }
}
