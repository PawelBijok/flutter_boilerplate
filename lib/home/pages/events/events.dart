import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:ox_flutter/home/widgets/custom_app_bar.dart';

class Events extends StatefulWidget {
  final ScrollController scrollController;
  const Events({Key? key, required this.scrollController}) : super(key: key);

  @override
  State<Events> createState() => _NewsState();
}

class _NewsState extends State<Events>
    with AutomaticKeepAliveClientMixin<Events> {
  @override
  bool get wantKeepAlive => true;

  List<SliverList> innerLists = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < numLists; i++) {
      final _innerList = <ColorRow>[];
      for (int j = 0; j < numberOfItemsPerList; j++) {
        _innerList.add(const ColorRow());
      }
      innerLists.add(
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) => _innerList[index],
            childCount: numberOfItemsPerList,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  final numLists = 15;

  final numberOfItemsPerList = 100;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      controller: widget.scrollController,
      slivers: [CustomAppBar(), ...innerLists],
    );
  }
}

@immutable
class ColorRow extends StatefulWidget {
  const ColorRow({Key? key}) : super(key: key);

  @override
  State createState() => ColorRowState();
}

class ColorRowState extends State<ColorRow> {
  Color? color;

  @override
  void initState() {
    super.initState();
    color = randomColor();
  }

  @override
  Widget build(BuildContext context) {
    print('Building ColorRowState');
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            randomColor(),
            randomColor(),
          ],
        ),
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(height: 50, width: 50, color: Colors.white),
          ),
          Flexible(
            child: Column(
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('I\'m a widget!',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Color randomColor() =>
    Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
