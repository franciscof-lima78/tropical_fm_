import 'package:flutter/material.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:flutter_radio_player/models/frp_source_modal.dart';
import 'package:tropical_fm/frp_controls.dart';
import 'frp_player.dart';
import 'nav-drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterRadioPlayer _flutterRadioPlayer = FlutterRadioPlayer();

  final FRPSource frpSource = FRPSource(
    mediaSources: <MediaSources>[
      MediaSources(
        url: "https://solid24.streamupsolutions.com/proxy/dcofieen?mp=/stream",
        description: "Tropical.FM",
        isPrimary: true,
        title: "Tropical.FM",
        isAac: true,
      ), /*
      MediaSources(
        url: "https://solid24.streamupsolutions.com/proxy/dcofieen?mp=/stream",
        description: "Tropical FM",
        isPrimary: false,
        title: "TropicalFM",
        isAac: false,
      ),*/
    ],
  );

  @override
  void initState() {
    super.initState();
    _flutterRadioPlayer.initPlayer();
    _flutterRadioPlayer.addMediaSources(frpSource);
  }

/*@override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }*/

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        //Execute the code here when user come back the app.
        //In my case, I needed to show if user active or not,
        _flutterRadioPlayer.initPlayer();
        _flutterRadioPlayer.addMediaSources(frpSource);
        break;
      case AppLifecycleState.paused:
        //Execute the code the when user leave the app
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(232, 21, 64, 78),
        drawer: NavDrawer(),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(232, 21, 64, 78),
          centerTitle: true,
          title: const Text('   Tropical FM',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Color.fromARGB(232, 250, 251, 251),
                  fontWeight: FontWeight.bold)),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/logo_com_nome.png',
                    ),
                    FRPlayer(
                      flutterRadioPlayer: _flutterRadioPlayer,
                      frpSource: frpSource,
                      useIcyData: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
