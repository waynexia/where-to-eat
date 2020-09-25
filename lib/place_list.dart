import 'package:flutter/material.dart';

const double placeTagRadius = 5.0;

// `PlaceList` widget
// Holds a list of `PlaceCell`
class PlaceList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Place List")),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          placeCell(context),
          placeCell(context),
          placeCell(context)
        ],
      )),
    );
  }
}

// `PlaceCell` contains details of a place
final placeCell = (context) => Container(
    color: Colors.transparent,
    margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
    child: Container(
        decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: new BorderRadius.all(
              Radius.circular(30.0),
            )),
        child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
            child: Column(
              children: [
                // title
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(MockPlaceData.title,
                      style: Theme.of(context).textTheme.headline3),
                ),
                // info
                Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.only(right: 50.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.place),
                            Text(MockPlaceData.place),
                          ],
                        )),
                    Container(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.store),
                            Text(MockPlaceData.deliciousNumber.toString()),
                          ],
                        ))
                  ],
                ),
                // tags
                Row(
                  children: [
                    Icon(Icons.local_offer),
                    placeTag("tag12"),
                    placeTag("tag2"),
                  ],
                )
              ],
            ))));

// One tag
final placeTag = (tagText) => Container(
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border: new Border.all(),
        borderRadius: new BorderRadius.only(
          topRight: Radius.zero,
          topLeft: Radius.circular(placeTagRadius),
          bottomLeft: Radius.circular(placeTagRadius),
          bottomRight: Radius.circular(placeTagRadius),
        ),
      ),
      child: Text(tagText),
    );

class PlaceTags extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView();
  }
}

// Mock data
class MockPlaceData {
  static String title = "穗石";
  static String place = "School";
  static int deliciousNumber = 23;
  static List tags = ["tag1", "tag2"];
}

const int NumTags = 3;
