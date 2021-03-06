import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:game2048flutter/providers/dimensions_provider.dart';
import 'package:game2048flutter/providers/grid_provider.dart';
import 'package:provider/provider.dart';

import '../generic/animated_text.dart';
import '../generic/bordered_box.dart';

/// A widget that shows the current game score above [GameGrid]
const String testDevice = 'YOUR_DEVICE_ID';

class Scoreboard extends StatefulWidget {
  /// Creates a new scoreboard widget
  const Scoreboard({Key key}) : super(key: key);

  @override
  _ScoreboardState createState() => _ScoreboardState();
}

class _ScoreboardState extends State<Scoreboard> {
  int _coins = 0;
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    childDirected: true,
    nonPersonalizedAds: true,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      print("RewardedVideoAd event $event");
      if (event == RewardedVideoAdEvent.rewarded) {
        setState(() {
          _coins = _coins + rewardAmount;
          print("Yasda $_coins coins");
        });
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DimensionsProvider>(
      builder: (context, dimensions, scoreText) {
        final double gapSize = dimensions.gapSize;
        final double gameSize = dimensions.gameSize;

        return Container(
          width: gameSize + gapSize,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              BorderedBox(
                borderWidth: gapSize / 2,
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  'Score',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ScaleAnimatedTextKit(
                    onTap: () {
                      print("Tap Event");
                    },
                    text: ["2x"],
                    textStyle: TextStyle(fontSize: 17.0, color: Colors.blue),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.live_tv,
                        size: 36,
                        color: Colors.teal,
                      ),
                      onPressed: () {
                        setState(() {
                          RewardedVideoAd.instance.load(
                              adUnitId:
                                  "ca-app-pub-1064653046120204/4540959200",
                              targetingInfo: targetingInfo);
                          RewardedVideoAd.instance.show();
                        });
                      }),
                ],
              ),
              BorderedBox(
                borderWidth: gapSize / 2,
                padding: const EdgeInsets.all(2.0),
                child: scoreText,
              ),
            ],
          ),
        );
      },
      child: Consumer<GridProvider>(
        builder: (context, grid, _) {
          return AnimatedText(
            key: ObjectKey(grid),
            text: '${grid.score + _coins}',
            maxLines: 1,
            textAlign: TextAlign.right,
            textStyle: Theme.of(context).textTheme.headline6,
            tweenBuilder: ({String begin, String end}) => _ScoreTween(
              begin: begin,
              end: end,
            ),
          );
        },
      ),
    );
  }
}

class _ScoreTween extends Tween<String> {
  _ScoreTween({String begin, String end})
      : _internalTween = IntTween(
          begin: (begin == null) ? null : int.parse(begin),
          end: (end == null) ? null : int.parse(end),
        ),
        super(begin: begin, end: end);

  final IntTween _internalTween;

  @override
  set begin(String newBegin) {
    final int newIntBegin = int.parse(newBegin);

    if (newBegin != null) {
      assert(newIntBegin != null);
    }

    _internalTween.begin = newIntBegin;
    super.begin = newBegin;
  }

  @override
  set end(String newEnd) {
    final int newIntEnd = int.parse(newEnd);

    if (newEnd != null) {
      assert(newIntEnd != null);
    }

    _internalTween.end = newIntEnd;
    super.end = newEnd;
  }

  @override
  String lerp(double t) => _internalTween.lerp(t).toString();
}
