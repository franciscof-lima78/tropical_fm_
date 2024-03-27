import 'package:flutter/material.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:flutter_radio_player/models/frp_source_modal.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(238, 236, 240, 241),
        drawer: NavDrawer(),
        appBar: AppBar(
          title: const Text('Tropical FM'),
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
