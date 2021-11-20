import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game2048flutter/providers/settings_provider.dart';
import 'package:game2048flutter/widgets/generic/theme_switch.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// User preferences screen widget
class SettingsScreen extends StatefulWidget {
  /// Creates a new settings screen widget
  const SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String mp3Uri = '';
  bool _isPlaying = false;
  AudioPlayer player = AudioPlayer();
  SharedPreferences prefs;

  // void _playSound() async {
  //   AudioCache cache;
  //   cache = AudioCache(prefix: "assets/");
  //   player = await cache.play('game_2048_mp3.mp3');
  //   player.setReleaseMode(ReleaseMode.LOOP);
  // }


  // void getAudio() {
  //   if (_isPlaying) {
  //     player.stop();
  //     setState(() {
  //       _isPlaying = false;
  //     });
  //   } else {
  //     _playSound();
  //     setState(() {
  //       _isPlaying = true;
  //     });
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = AppBar(
      title: const Text('Settings'),
      primary: false,
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          appBar.preferredSize.width,
          appBar.preferredSize.height - MediaQuery.of(context).padding.top,
        ),
        child: appBar,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Appearance',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Divider(
                  height: 8.0,
                  thickness: 1.0,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Dark mode',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Consumer<SettingsProvider>(
                        builder: (context, settings, _) {
                          return ThemeSwitch(
                            value: settings.darkMode,
                            onChanged: (value) => settings.darkMode = value,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Game palette',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/palette_picker');
                        },
                        child: Row(
                          children: <Widget>[
                            Consumer<SettingsProvider>(
                              builder: (context, settings, _) {
                                return Text(settings.palette.name);
                              },
                            ),
                            const Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Gameplay',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Divider(
                  height: 8.0,
                  thickness: 1.0,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Save only unfinished games',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Consumer<SettingsProvider>(
                        builder: (context, settings, _) {
                          return ThemeSwitch(
                            value: settings.autoReset,
                            onChanged: (v) => settings.autoReset = v,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: <Widget>[
            //     Text(
            //       'Game Music',
            //       style: Theme.of(context).textTheme.headline6,
            //     ),
            //     Divider(
            //       height: 8.0,
            //       thickness: 1.0,
            //       color: Theme.of(context).colorScheme.onPrimary,
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: <Widget>[
            //           Text(
            //             'Adjust the music of the game',
            //             style: Theme.of(context).textTheme.bodyText1,
            //           ),
            //           IconButton(
            //               icon: Icon(
            //                 _isPlaying == false
            //                     ? Icons.music_note
            //                     : Icons.music_off,
            //                 color: Colors.yellow,
            //                 size: 35,
            //               ),
            //               iconSize: 35,
            //               onPressed: (){
            //
            //               }
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

// Consumer<SettingsProvider>(
// builder: (context, settings, _) {
// return ThemeSwitch(
// value: settings.musicMode,
// onChanged: (v) => settings.musicMode = v,
// );
// },
// ),

/*
IconButton(
                          icon: Icon(
                            _isPlaying == false
                                ? Icons.music_note
                                : Icons.music_off,
                            color: Colors.yellow,
                            size: 35,
                          ),
                          iconSize: 35,
                          onPressed: getAudio
                      ),
 */
