import 'package:flutter/material.dart';

import 'models/place.dart';

const double tagRadius = 10.0;

class TagBox extends StatefulWidget {
  final void Function(String) onTap;
  @required
  final String tag;
  @required
  final int count;
  final bool shouldDisplayCount;

  TagBox({Key key, this.onTap, this.tag, this.count, this.shouldDisplayCount});

  _TagBoxState createState() => _TagBoxState();
}

class _TagBoxState extends State<TagBox> {
//  final bool isTouchable;
  bool isSelected = false;

//  _TagBoxState({Key key, this.isSelected, @required this.isTouchable}): super();

  onTap() {
    widget.onTap(widget.tag);

    setState(() {
      this.isSelected = !this.isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (widget.onTap == null) ? null : this.onTap,
      child: Container(
        padding: const EdgeInsets.all(5.0),
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          border: new Border.all(),
          color:
              this.isSelected ? Colors.orange : Theme.of(context).primaryColor,
          borderRadius: new BorderRadius.only(
            topRight: Radius.zero,
            topLeft: Radius.circular(tagRadius),
            bottomLeft: Radius.circular(tagRadius),
            bottomRight: Radius.circular(tagRadius),
          ),
        ),
        child: Text(widget.tag),
      ),
    );
  }
}

class TagContainer extends StatelessWidget {
  @required
  final Map<String, int> tags;
  void Function(String) onTap;
  final bool shouldDisplayCount;

  TagContainer(
      {Key key, this.tags, this.onTap, this.shouldDisplayCount = false})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    tags.forEach((tag, count) {
      children.add(TagBox(
        onTap: onTap,
        tag: tag,
        count: count,
        shouldDisplayCount: shouldDisplayCount,
      ));
    });

    return Wrap(
      children: children,
    );
  }
}
