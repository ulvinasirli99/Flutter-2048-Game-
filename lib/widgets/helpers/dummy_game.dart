import 'package:flutter/material.dart';
import 'package:game2048flutter/providers/dimensions_provider.dart';
import 'package:game2048flutter/types/tuple.dart';
import 'package:game2048flutter/types/extensions.dart';
import 'package:game2048flutter/util/misc.dart';
import 'package:game2048flutter/widgets/tiles/immovable_tile.dart';
import 'package:provider/provider.dart';
import 'package:game2048flutter/types/size_options.dart';
import '../generic/bordered_box.dart';
import 'package:game2048flutter/widgets/generic/bordered_box.dart';


class DummyGame extends StatelessWidget {
  /// Creates a dummy game with [SizeOption.sizes]
  DummyGame.withSizes(int sizes, {Key key}) : super(key: key) {
    ArgumentError.checkNotNull(sizes);

    if (DummyGame._tiles == null || sizes != DummyGame._tiles.length) {
      DummyGame._tiles = List.generate(sizes, (_) => [], growable: false);
    }
  }

  static List<List<Widget>> _tiles;

  void _spawnTiles(int index, int sideLength) {
    final int flatLength = sideLength * sideLength;
    final int spawnAmount = Misc.rand.nextIntRanged(
      sideLength - 1,
      flatLength - sideLength,
    );

    final List<Tuple<int, int>> spawningPosList = List.generate(
      flatLength,
          (i) => Tuple(i ~/ sideLength, i % sideLength),
    );

    for (int i = 0; i < spawnAmount; i++) {
      final Tuple<int, int> pickedSpawnedPos = Misc.rand.pick(
        spawningPosList,
        remove: true,
      );
      final int value = Misc.rand.nextInt(sideLength);

      final ImmovableTile newTile = ImmovableTile(
        gridPos: pickedSpawnedPos,
        value: value,
      );

      _tiles[index].add(newTile);

      assert(!spawningPosList.contains(pickedSpawnedPos));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Consumer<DimensionsProvider>(
        builder: (context, dimensions, _) {
          final double gameSize = dimensions.gameSize;
          final int index = dimensions.selectedSizeOption.index;

          if (_tiles[index].isEmpty) {
            _spawnTiles(index, dimensions.selectedSizeOption.sideLength);
          }

          return BorderedBox(
            width: gameSize,
            height: gameSize,
            borderWidth: dimensions.gapSize * (index + 1.0),
            child: Stack(
              overflow: Overflow.visible,
              children: _tiles[index],
            ),
          );
        },
      ),
    );
  }
}