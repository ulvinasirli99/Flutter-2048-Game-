import 'package:flutter/material.dart';
import 'package:game2048flutter/providers/dimensions_provider.dart';
import 'package:game2048flutter/providers/settings_provider.dart';
import 'package:game2048flutter/util/misc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../generic/future_widget.dart';
import 'main_app.dart';

/// A widget that shows a loading indicator while running
/// [SharedPreferences.getInstance] and, when done, shows [MainApp]
class MainAppLoader extends StatelessWidget {
  /// Creates a new loader widget
  const MainAppLoader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureWidget<SharedPreferences>(
      computation: () => SharedPreferences.getInstance(),
      loadingChild: (context) {
        return Misc.buildDefaultMaterialApp(
          context,
          childBuilder: Misc.buildDefaultMaterialApp,
        );
      },
      builder: (context, snapshot) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<SettingsProvider>.value(
              value: SettingsProvider.load(snapshot.data),
            ),
            ChangeNotifierProvider<DimensionsProvider>.value(
              value: DimensionsProvider(),
            ),
          ],
          child: const MainApp(),
        );
      },
    );
  }
}
