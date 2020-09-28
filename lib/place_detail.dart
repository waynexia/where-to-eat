import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:where_to_eat/place_list.dart';

import 'components.dart';
import 'model.dart';

//ignore: must_be_immutable
class PlaceDetail extends StatelessWidget {
  final Place place;
  HashSet<String> selectedTags = new HashSet();
  bool isSelectedTagsWanted = true;

  PlaceDetail({Key key, @required this.place}) : super(key: key);

  void onTagSelected(String tagText) {
    if (this.selectedTags.contains(tagText)) {
      this.selectedTags.remove(tagText);
    } else {
      this.selectedTags.add(tagText);
    }
  }

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
                  RaisedButton(
                    child: Text("想吃..."),
                    onPressed: () {
                      this.isSelectedTagsWanted = true;
                    },
                  ),
                  VerticalDivider(),
                  RaisedButton(
                    child: Text("不要..."),
                    onPressed: () {
                      this.isSelectedTagsWanted = false;
                    },
                  ),
                ],
              )),
        ]),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          alignment: Alignment.centerLeft,
          child: TagContainer(
            tags: place.tags,
            onTap: this.onTagSelected,
          ),
        ),
        Divider(),
        ResultContainer(
          selectedTags: selectedTags,
          isSelectedTagsWanted: isSelectedTagsWanted,
          place: place,
        ),
      ]),
    );
  }
}

enum ResultContainerStatus {
  Initialized,
  Rolling,
  Rolled,
  Picked,
}

//ignore: must_be_immutable
class ResultContainer extends StatefulWidget {
  @required
  HashSet<String> selectedTags;
  @required
  bool isSelectedTagsWanted;

  @required
  final Place place;

  ResultContainer(
      {Key key, this.selectedTags, this.isSelectedTagsWanted, this.place})
      : super(key: key);

  String selectDelicious() {
    final random = new Random();

    // todo: maybe move empty delicious list check to upper widget.
    if (place.delicious.isEmpty) {
      return "No Delicious provided.";
    } else if (selectedTags.isEmpty) {
      return place.delicious[random.nextInt(place.delicious.length)].name;
    }

    HashSet<String> candidates = new HashSet();

    for (var delicious in place.delicious) {
      for (var tag in selectedTags) {
        if (delicious.containsTag(tag)) {
          candidates.add(delicious.name);
          break;
        }
      }
    }

    if (candidates.isEmpty) {
      return "No such Delicious.";
    }

    return candidates.toList()[random.nextInt(candidates.length)];
  }

  @override
  _ResultContainerState createState() => _ResultContainerState();
}

class _ResultContainerState extends State<ResultContainer> {
  ResultContainerStatus status = ResultContainerStatus.Initialized;
  String currentDelicious = "";

  void startRoll() {
    setState(() {
      status = ResultContainerStatus.Rolling;
    });
  }

  void finishRoll() {
    // Todo: Is this delayed `setState()` necessary?
    Future.delayed(Duration(milliseconds: 200)).then((_) {
      setState(() {
        status = ResultContainerStatus.Rolled;
      });
    });
    currentDelicious = widget.selectDelicious();
  }

  void startReroll() {
    setState(() {
      status = ResultContainerStatus.Rolling;
    });
    print(widget.selectedTags);
  }

  void pickResult() {
    setState(() {
      status = ResultContainerStatus.Picked;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (this.status) {
      case ResultContainerStatus.Initialized:
        return Container(
          alignment: Alignment.center,
          child: RaisedButton(
            onPressed: startRoll,
            child: Text("Roll!"),
          ),
        );
      case ResultContainerStatus.Rolling:
        return RollingWidget(
          onFinished: finishRoll,
        );
      case ResultContainerStatus.Rolled:
        return RolledResult(
          onReroll: startReroll,
          onPick: pickResult,
          result: currentDelicious,
        );
      case ResultContainerStatus.Picked:
        return Container(
          child: Text("Picked"),
        );
    }
    throw UnsupportedError("Unreachable");
  }
}

class RollingWidget extends StatelessWidget {
  final void Function() onFinished;

  RollingWidget({Key key, this.onFinished}) : super(key: key);

  Future<bool> timer() async {
    await Future.delayed(Duration(seconds: 1));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: timer(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          onFinished();
        }
        return Container(
          alignment: Alignment.center,
          child: SpinKitThreeBounce(
              color: Theme.of(context).backgroundColor,
              size: MediaQuery.of(context).size.width * 0.2),
        );
      },
    );
  }
}

//ignore: must_be_immutable
class RolledResult extends StatelessWidget {
  @required
  final void Function() onReroll;
  @required
  final void Function() onPick;
  @required
  String result;

  RolledResult({Key key, this.onReroll, this.onPick, this.result})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text(result),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                onPressed: onReroll,
                child: Text("Reroll"),
              ),
              RaisedButton(
                onPressed: onPick,
                child: Text("Pick"),
              )
            ],
          )
        ]));
  }
}
