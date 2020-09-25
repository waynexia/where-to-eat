import 'package:flutter/material.dart';

import 'place_detail.dart';
import 'components.dart';
import 'place_operation.dart';

// `PlaceList` widget
// Holds a list of `PlaceCell`
class PlaceList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Place List"),
        centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
            itemCount: NumTags,
            itemBuilder: (context, index) {
              return ListTile(
                title: placeCell(context),
                onLongPress: () {
                  onLongPressCell(context);
                },
                onTap: () {
                  onTapCell(context, index);
                },
              );
            }),
      ),
    );
  }
}

// `PlaceCell` contains details of a place
final placeCell = (context) => Container(
    color: Colors.transparent,
    margin: EdgeInsets.symmetric(
      vertical: 5.0,
    ),
    child: Container(
        decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: new BorderRadius.all(
              Radius.circular(30.0),
            )),
        child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
                    TagContainer(tag: "tag12"),
                    TagContainer(tag: "tag2"),
                  ],
                )
              ],
            ))));

final onTapCell = (context, index) => {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PlaceDetail(place: Place(title: index.toString())),
        ),
      )
    };

final onLongPressCell = (context) => {
//      showDialog(
//        context: context,
//        builder: (_) => Column(
//          children: [
//            PlaceOperation(),
//          ],
//        ),
//      )

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlaceOperation(),
        ),
      )
    };

// Mock data
class MockPlaceData {
  static String title = "穗石";
  static String place = "School";
  static int deliciousNumber = 23;
  static List tags = ["tag1", "tag2"];
}

const int NumTags = 5;
