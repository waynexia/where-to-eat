import 'package:flutter/material.dart';
import 'package:where_to_eat/components.dart';
import 'package:where_to_eat/edit_delicious.dart';

import 'model.dart';

class EditPlace extends StatefulWidget {
  Place place;

  EditPlace({Key key, this.place}) : super(key: key);

  _EditPlaceState createState() => _EditPlaceState();
}

class _EditPlaceState extends State<EditPlace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Place"),
          actions: [
            InkWell(
              // todo: finish save() method
              onTap: () {},
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
                content: widget.place.title,
              ),
              TextWithIcon(
                icon: Icons.place,
                label: "Location",
                content: widget.place.location,
              ),
              Row(
                children: [
                  Icon(Icons.local_offer),
                  VerticalDivider(),
                  TagContainer(
//                    tags: place.tags,
                    tags: {},
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
                      onTapDelicious(context, delicious, widget.place)
                          .then((value) {
                        widget.place.delicious.add(delicious);
                        setState(() {});
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
  final String content;
  final TextEditingController controller;

  TextWithIcon({Key key, this.icon, this.label, this.content, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Theme.of(context).cursorColor,
      // todo: fix continueAction
//      textInputAction: TextInputAction.continueAction,
      textInputAction: TextInputAction.done,
      initialValue: content,
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

Future<Delicious> onTapDelicious(
    context, Delicious delicious, Place place) async {
  Delicious newDelicious = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditDelicious(
                delicious: delicious,
                place: place,
              )));

  return newDelicious;
}
