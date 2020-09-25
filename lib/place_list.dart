import 'package:flutter/material.dart';

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
          PlaceCell,
          PlaceCell,
          PlaceCell
        ],
      )),
    );
  }
}

// `PlaceCell` contains details of a place
final PlaceCell = Column(
  children: [
    Text(MockPlaceData.title),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(Icons.place),
        Text(MockPlaceData.place),
        Icon(Icons.store),
        Text(MockPlaceData.delicious_number.toString()),
      ],
    ),
    Row(
      children: [
        Icon(Icons.local_offer),
        PlaceTag,
        PlaceTag,
      ],
    )
  ],
);

final PlaceTag = Container(
  padding: const EdgeInsets.all(3.0),
  decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
  child: Text("Border"),
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
  static int delicious_number = 23;
  static List tags = ["tag1", "tag2"];
}

const int NumTags = 3;
