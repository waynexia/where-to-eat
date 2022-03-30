import 'dart:math';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:where_to_eat/add_place.dart';

import 'place_detail.dart';
import 'components.dart';
import 'place_operation.dart';
import 'model.dart' as model;
import 'add_place.dart';

class Index extends StatefulWidget {
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  onTapAdd() async {
    final model.Place newPlace = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                EditPlace(place: model.Place.defaultValue())));
    if (newPlace != null) {
      setState(() {});
    }
  }

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
                  child: InkWell(
                    onTap: () {
                      onTapAdd();
                    },
                    child: Transform.rotate(
                        // contra-rotate 45°
                        angle: -0.25 * pi,
                        child: Icon(Icons.local_dining, size: 100)),
                  )),
              Expanded(
                child: Icon(Icons.settings, size: 50),
              )
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: onTapAdd,
        tooltip: 'Add new place',
        backgroundColor: Theme.of(context).buttonColor,
        child: Transform.rotate(
            angle: -0.25 * pi,
            child: Icon(
              Icons.local_dining,
              color: Colors.white,
            )),
      ),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlaceOperation(
                            place: model.places[index],
                          ),
                        ),
                      ).then((_) =>{
                        setState(() { })
                      });
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
                    TagContainer(
                      tags: place.tags,
                    ),
                  ],
                )
              ],
            ))));

final onTapCell = (context, index) => {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlaceDetail(place: model.places[index]),
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
// todo: rename this
class PlaceAbstract {
  final String title;
  final String location;
  final int numDelicious;
  final Map<String, int> tags;

  PlaceAbstract({this.title, this.location, this.numDelicious, this.tags});

  static Future<List<PlaceAbstract>> constructFromPlaces() async {
    await model.Place.initFromStorage();
    List<PlaceAbstract> abstracts = [];

    for (final place in model.places) {
      PlaceAbstract abstract = new PlaceAbstract(
          title: place.title,
          location: place.location,
          numDelicious: place.delicious.length,
          tags: place.tags);
      abstracts.add(abstract);
    }

    developer.log("Places reloaded");
    return abstracts;
  }

  static PlaceAbstract from(model.Place place) {
    return PlaceAbstract(
        title: place.title,
        location: place.location,
        numDelicious: place.delicious.length,
        tags: place.tags);
  }
}
