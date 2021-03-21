import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:where_to_eat/model.dart';
import 'add_place.dart';

import 'place_list.dart';

const double menuRadius = 70;
const double iconSize = 130;

class PlaceOperation extends StatelessWidget {
  @required
  final Place place;
  PlaceAbstract placeAbstract;

  PlaceOperation({Key key, this.place, this.placeAbstract}) : super(key: key) {
    this.placeAbstract = PlaceAbstract.from(place);
  }

  onEditPlace(context) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => EditPlace(place: place)));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Place Operation"),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
              child: placeCell(context, placeAbstract),
            ),
            Container(
//                height: double.infinity,
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        border: new Border.all(),
                        borderRadius: new BorderRadius.only(
                          topRight: Radius.circular(menuRadius),
                          topLeft: Radius.circular(menuRadius),
                          bottomLeft: Radius.circular(menuRadius),
                          bottomRight: Radius.zero,
                        ),
                      ),
                      child: InkWell(
                        child: Icon(Icons.edit, size: iconSize),
                        onTap: () {
                          onEditPlace(context);
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        border: new Border.all(),
                        borderRadius: new BorderRadius.only(
                          topRight: Radius.circular(menuRadius),
                          topLeft: Radius.circular(menuRadius),
                          bottomLeft: Radius.zero,
                          bottomRight: Radius.circular(menuRadius),
                        ),
                      ),
                      child: Icon(Icons.star, size: iconSize),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        border: new Border.all(),
                        borderRadius: new BorderRadius.only(
                          topRight: Radius.zero,
                          topLeft: Radius.circular(menuRadius),
                          bottomLeft: Radius.circular(menuRadius),
                          bottomRight: Radius.circular(menuRadius),
                        ),
                      ),
                      child: Icon(Icons.delete_forever, size: iconSize),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        border: new Border.all(),
                        borderRadius: new BorderRadius.only(
                          topRight: Radius.circular(menuRadius),
                          topLeft: Radius.zero,
                          bottomLeft: Radius.circular(menuRadius),
                          bottomRight: Radius.circular(menuRadius),
                        ),
                      ),
                      child: Icon(Icons.near_me, size: iconSize),
                    )
                  ],
                )
              ],
            )),
            Container(child: null),
          ],
        ));
  }
}
