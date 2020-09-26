import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'place_detail.dart';
import 'components.dart';
import 'place_operation.dart';
import 'model.dart' as model;

class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      headerHeight: MediaQuery.of(context).size.height * 0.7,
      inactiveOverlayColor: Theme.of(context).backgroundColor,
      inactiveOverlayOpacity: 0.5,
      frontLayerBorderRadius: BorderRadius.zero,
      appBar: BackdropAppBar(
        title: Text("Place List"),
        centerTitle: true,
      ),
      frontLayer: PlaceList(),
      backLayer: Container(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          color: Theme.of(context).primaryColor,
          alignment: Alignment.topCenter,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Icon(Icons.info_outline, size: 50),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Transform.rotate(
                    // contra-rotate 45°
                    angle: -0.25 * 3.14,
                    child: Icon(Icons.local_dining, size: 100)),
              ),
              Expanded(
                child: Icon(Icons.settings, size: 50),
              )
            ],
          )),
    );
  }
}

// `PlaceList` widget
// Holds a list of `PlaceCell`
class PlaceList extends StatefulWidget {
  @override
  _PlaceListState createState() => _PlaceListState();
}

class _PlaceListState extends State<PlaceList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: PlaceAbstract.constructFromPlaces(),
        builder: (context, AsyncSnapshot<List<PlaceAbstract>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  var places = snapshot.data;
                  return ListTile(
                    title: placeCell(context, places[index]),
                    onLongPress: () {
                      onLongPressCell(context, places[index]);
                    },
                    onTap: () {
                      onTapCell(context, index);
                    },
                  );
                });
          } else {
            return Container(
              alignment: Alignment.center,
              child: SpinKitThreeBounce(
                  color: Theme.of(context).backgroundColor,
                  size: MediaQuery.of(context).size.width * 0.2),
            );
          }
        });
  }
}

// `PlaceCell` contains details of a place
final placeCell = (context, PlaceAbstract place) => Container(
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
                  child: Text(place.title,
                      style: Theme.of(context).textTheme.headline3),
                ),
                // info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
//                        padding: const EdgeInsets.only(right: 50.0),
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.place),
                        Text(place.location),
                      ],
                    )),
                    Container(
//                        padding: const EdgeInsets.only(right: 20.0),
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.store),
                        Text(place.numDelicious.toString()),
                      ],
                    )),
                    Container(),
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
              PlaceDetail(place: MockPlace(title: index.toString())),
        ),
      )
    };

final onLongPressCell = (context, PlaceAbstract place) => {
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
          builder: (context) => PlaceOperation(
            place: place,
          ),
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

// Utils
class PlaceAbstract {
  final String title;
  final String location;
  final int numDelicious;
  final List<String> tags;

  PlaceAbstract({this.title, this.location, this.numDelicious, this.tags});

  static Future<List<PlaceAbstract>> constructFromPlaces() async {
    await model.Place.initFromStorage();
    List<PlaceAbstract> abstracts = [];

    for (final place in model.places) {
      List<String> tags = [];
      for (final complexTag in place.tags) {
        tags.add(complexTag.text);
      }
      PlaceAbstract abstract = new PlaceAbstract(
          title: place.title,
          location: place.location,
          numDelicious: place.delicious.length,
          tags: tags);
      abstracts.add(abstract);
    }

    return abstracts;
  }
}
