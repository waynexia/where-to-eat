import 'package:flutter/material.dart';

import 'components.dart';

class PlaceDetail extends StatelessWidget {
  final Place place;

  PlaceDetail({Key key, @required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Place Detail"),
        centerTitle: true,
      ),
      body: Column(children: [
        Text(place.title,
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.left),
        Divider(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.all(10.0),
            child: Text(
              "口味",
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(child: Text("想吃...")),
                  VerticalDivider(),
                  RaisedButton(child: Text("不要...")),
                ],
              )),
        ]),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          decoration: BoxDecoration(
            border: new Border.all(),
            borderRadius: new BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Wrap(
            children: [
              TagContainer(tag: "11231"),
              TagContainer(tag: "1123asdfsdfsd1"),
              TagContainer(tag: "11231"),
              TagContainer(tag: "11231"),
              TagContainer(tag: "11231"),
              TagContainer(tag: "11231"),
              TagContainer(tag: "1123asdasd1"),
              TagContainer(tag: "11231"),
              TagContainer(tag: "11231"),
              TagContainer(tag: "11231"),
              TagContainer(tag: "11231sdd"),
              TagContainer(tag: "11231"),
            ],
          ),
        )
      ]),
    );
  }
}

class Place {
  final String title;

  Place({@required this.title});
}
