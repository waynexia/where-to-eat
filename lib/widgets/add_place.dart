import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:where_to_eat/components.dart';
import 'package:where_to_eat/widgets/edit_delicious.dart';

import 'package:where_to_eat/models/place.dart';

class EditPlace extends StatefulWidget {
  Place place;

  EditPlace({Key key, this.place}) : super(key: key);

  _EditPlaceState createState() => _EditPlaceState();
}

class _EditPlaceState extends State<EditPlace> {
  TextEditingController placeFieldController;
  TextEditingController locationFieldController;

  finishEditing() async {
    widget.place.title = placeFieldController.text;
    widget.place.location = locationFieldController.text;

    final String json = jsonEncode(widget.place.toJson());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(widget.place.title + widget.place.location, json);

    Navigator.pop(context, widget.place);
  }

  @override
  Widget build(BuildContext context) {
    placeFieldController = new TextEditingController(text: widget.place.title);
    locationFieldController =
        new TextEditingController(text: widget.place.location);

    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Place"),
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
                label: "Place",
                controller: placeFieldController,
              ),
              TextWithIcon(
                icon: Icons.place,
                label: "Location",
                controller: locationFieldController,
              ),
              Row(
                children: [
                  Icon(Icons.local_offer),
                  VerticalDivider(),
                  TagContainer(
//                    tags: place.tags,
                    tags: widget.place.tags,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.store),
                  VerticalDivider(),
                  Text(widget.place.delicious.length.toString()),
                  VerticalDivider(),
                  RaisedButton(
                    onPressed: () {
                      Delicious delicious = Delicious.defaultValue();
                      onEditDelicious(context, delicious, widget.place)
                          .then((value) {
                        if (value != null) {
                          widget.place.delicious.add(delicious);
                          setState(() {});
                        }
                      });
                    },
                    child: Text("Add"),
                  ),
                ],
              ),
              Divider(),
              Expanded(
                  child: ListView.builder(
                itemCount: widget.place.delicious.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(widget.place.delicious[index].name),
                    subtitle: Row(
                      children: [Text("tag1"), Text("Tag2")],
                    ),
                    onTap: () {
                      Delicious delicious = widget.place.delicious[index];
                      onEditDelicious(context, delicious, widget.place)
                          .then((value) {
                        if (value != null) {
                          widget.place.delicious[index] = delicious;
                          setState(() {});
                        }
                      });
                    },
                  );
                },
              ))
            ],
          ),
        ));
  }
}

class TextWithIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextEditingController controller;

  TextWithIcon({Key key, this.icon, this.label, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Theme.of(context).cursorColor,
      // todo: fix continueAction
//      textInputAction: TextInputAction.continueAction,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        icon: Icon(icon),
        labelText: label,
        suffixIcon: IconButton(
          onPressed: () => controller.clear(),
          icon: Icon(Icons.clear),
        ),
      ),
    );
  }
}

Future<Delicious> onEditDelicious(
    context, Delicious delicious, Place place) async {
  Delicious newDelicious = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditDelicious(
                delicious: delicious,
                place: place,
              )));

  if (newDelicious != null) {
    for (var tag in newDelicious.tags.keys) {
      if (place.tags.containsKey(tag)) {
        place.tags.update(tag, (value) => value + 1);
      } else {
        place.tags.addAll({tag: 1});
      }
    }
  }

  return newDelicious;
}
