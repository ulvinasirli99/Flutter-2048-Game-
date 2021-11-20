import 'package:flutter/material.dart';
import 'package:game2048flutter/ads/ads_servie.dart';
import 'package:game2048flutter/providers/grid_provider.dart';
import 'package:game2048flutter/types/dialog_result.dart';
import 'package:game2048flutter/types/swipe_gesture_type.dart';
import 'package:game2048flutter/util/misc.dart';
import 'package:game2048flutter/widgets/dialogs/pause_dialog.dart';
import 'package:game2048flutter/widgets/generic/future_widget.dart';
import 'package:provider/provider.dart';

import '../helpers/buttons_bar.dart';
import '../helpers/game_grid.dart';
import '../helpers/scoreboard.dart';

/// The main game screen widget
///
/// Combines [Scoreboard], [GameGrid] and [ButtonsBar]
class GameScreen extends StatefulWidget {
  /// Creates a new game screen
  const GameScreen({Key key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  final AdsService _service = AdsService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //TODO burda reklam acilir ve initiliaze olur....
    _service.showInterstitial();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureWidget<GridProvider>(
        computation: () => GridProvider.fromJSON(context),
        loadingChild: Misc.buildLoadingWidget,
        onError: (error) => throw Exception('Something went wrong: $error'),
        builder: (context, snapshot) {
          return ChangeNotifierProvider<GridProvider>.value(
            value: snapshot.data,
            child: Consumer<GridProvider>(
              builder: (context, grid, _) {
                return WillPopScope(
                  onWillPop: () => _pause(context),
                  child: GestureDetector(
                    onVerticalDragEnd: (details) => grid.swipe(
                      details.velocity.pixelsPerSecond.dy < 0
                          ? SwipeGestureType.up
                          : SwipeGestureType.down,
                    ),
                    onHorizontalDragEnd: (details) => grid.swipe(
                      details.velocity.pixelsPerSecond.dx < 0
                          ? SwipeGestureType.left
                          : SwipeGestureType.right,
                    ),
                    behavior: HitTestBehavior.opaque,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Scoreboard(),
                          GameGrid(),
                          ButtonsBar(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future<bool> _pause(BuildContext context) {
    return Misc.showDialog<DialogOption>(
      context: context,
      builder: (_) => const PauseDialog(),
    ).then((result) {
      Future<bool> returnValue;

      if (result == null || result == DialogOption.pause) {
        returnValue = Future.value(false);
      } else if (result == DialogOption.exit) {
        returnValue = Future.value(true);
      } else if (result == DialogOption.reset) {
        GridProvider.of(context)
            .savedDataManager
            .wipe()
            .then((_) => Navigator.of(context).pushReplacementNamed('/game'));
        returnValue = Future.value(false);
      }

      return returnValue;
    });
  }
}
