import 'package:flutter/material.dart';

const double tagRadius = 5.0;

class TagContainer extends Container{
  TagContainer({Key key, @required String tag}) : super(
    padding: const EdgeInsets.all(5.0),
    margin: const EdgeInsets.all(5.0),
    decoration: BoxDecoration(
      border: new Border.all(),
      borderRadius: new BorderRadius.only(
        topRight: Radius.zero,
        topLeft: Radius.circular(tagRadius),
        bottomLeft: Radius.circular(tagRadius),
        bottomRight: Radius.circular(tagRadius),
      ),
    ),
    child: Text(tag),
  );
}