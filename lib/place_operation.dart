import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:where_to_eat/model.dart';

import 'place_list.dart';

const double menuRadius = 30;
const double iconSize = 130;

class PlaceOperation extends StatelessWidget {
  @required
  final PlaceAbstract place;

  PlaceOperation({Key key, this.place}) : super(key: key);

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
              child: placeCell(context, place),
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
                      child: Icon(Icons.edit, size: iconSize),
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
                      margin: EdgeInsets.symmetric(horizontal: 10),
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
