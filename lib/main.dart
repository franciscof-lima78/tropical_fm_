import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:flutter_radio_player/models/frp_source_modal.dart';
import 'package:flutter/services.dart';
import 'frp_player.dart';
import 'nav-drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  void closeAppUsingSystemPop() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  void closeAppUsingExit() {
    exit(0);
  }

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
    //WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(232, 21, 64, 78),
        drawer: const NavDrawer(),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(232, 21, 64, 78),
          centerTitle: true,
          title: const Text('   Tropical FM - BETA',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromARGB(232, 250, 251, 251),
                  fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onPressed: () {
                //context.widget.cl
                closeAppUsingSystemPop();
                closeAppUsingExit();
              },
            )
          ],
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

void closeAppUsingExit() {
  exit(0);
}

void closeAppUsingSystemPop() {
  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
}
