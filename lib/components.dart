import 'package:flutter/material.dart';

import 'model.dart';

const double tagRadius = 10.0;

class TagBox extends StatefulWidget {
  final void Function(String) onTap;
  @required
  final Tag tag;

  TagBox({Key key, this.onTap, this.tag});

  _TagBoxState createState() => _TagBoxState();
}

class _TagBoxState extends State<TagBox> {
//  final bool isTouchable;
  bool isSelected = false;

//  _TagBoxState({Key key, this.isSelected, @required this.isTouchable}): super();

  onTap() {
    widget.onTap(widget.tag.text);

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
        child: Text(widget.tag.text),
      ),
    );
  }
}

class TagContainer extends StatelessWidget {
  @required
  final List<Tag> tags;
  void Function(String) onTap;

  TagContainer({Key key, this.tags, this.onTap})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (Tag tag in tags) {
      children.add(TagBox(
        tag: tag,
        onTap: this.onTap,
      ));
    }

    return Wrap(
      children: children,
    );
  }
}
