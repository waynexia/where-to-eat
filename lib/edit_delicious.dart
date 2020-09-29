import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:where_to_eat/components.dart';

import 'model.dart';
import 'add_place.dart';

class EditDelicious extends StatefulWidget {
  final Place place;
  Delicious delicious;

  EditDelicious({Key key, this.delicious, this.place}) : super(key: key);

  _EditDeliciousState createState() => _EditDeliciousState();
}

class _EditDeliciousState extends State<EditDelicious> {
  TextEditingController tagFieldController = TextEditingController();
  TextEditingController nameFieldController = TextEditingController();
  Set<String> selectedExistingTags = new Set();

  addTag() {
    String newTag = tagFieldController.text;
    if (newTag == "") {
      return;
    }
    widget.delicious.tags.addAll({newTag: 1});
    tagFieldController.clear();
    setState(() {});
  }

  removeTag() {
    String tag = tagFieldController.text;
    widget.delicious.tags.remove(tag);
    tagFieldController.clear();
    setState(() {});
  }

  onSelectExistingTag(String tag) {
    if (selectedExistingTags.contains(tag)) {
      selectedExistingTags.remove(tag);
    } else {
      selectedExistingTags.add(tag);
    }
  }

  onSelectNewTag(String tag) {
    tagFieldController.text = tag;
  }

  finishEditing() {
    widget.delicious.name = nameFieldController.text;
    for (var tag in selectedExistingTags) {
      widget.delicious.tags.addAll({tag: 1});
    }
    Navigator.pop(context, widget.delicious);
  }

  @override
  Widget build(BuildContext context) {

    tagFieldController = TextEditingController(text: widget.delicious.name);
    nameFieldController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Delicious"),
          actions: [
            InkWell(
              onTap: finishEditing,
              child: Icon(Icons.check),
            )
          ],
        ),
        body: Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                TextWithIcon(
                  icon: Icons.restaurant,
                  label: "Name",
                  controller: nameFieldController,
                ),
                Divider(),
                Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.playlist_add_check),
                      VerticalDivider(),
                      TagContainer(
                        tags: widget.place.tags,
                        onTap: onSelectExistingTag,
                      ),
                    ],
                  ),
                ),
                Divider(),
                Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.playlist_add),
                      VerticalDivider(),
                      TagContainer(
                        tags: widget.delicious.tags,
                        onTap: onSelectNewTag,
                      ),
                    ],
                  ),
                ),
                TextWithIcon(
                  icon: Icons.local_offer,
                  label: "Tag",
                  controller: tagFieldController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RaisedButton(onPressed: addTag, child: Icon(Icons.check)),
                    RaisedButton(onPressed: removeTag, child: Icon(Icons.clear))
                  ],
                )
              ],
            )));
  }
}
