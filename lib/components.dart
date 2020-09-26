import 'package:flutter/material.dart';

import 'model.dart';

const double tagRadius = 10.0;

class TagBox extends Container {
  TagBox({Key key, @required Tag tag})
      : super(
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
          child: Text(tag.text),
        );
}

class TagContainer extends StatelessWidget {
  @required
  final List<Tag> tags;

  TagContainer({Key key, this.tags})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (Tag tag in tags) {
      children.add(TagBox(tag: tag));
    }

    return Wrap(
      children: children,
    );
  }
}
