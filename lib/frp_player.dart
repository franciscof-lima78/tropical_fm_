import 'package:flutter/material.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:flutter_radio_player/models/frp_source_modal.dart';
import 'frp_source_list.dart';

import 'frp_controls.dart';

class FRPlayer extends StatefulWidget {
  final FlutterRadioPlayer flutterRadioPlayer;
  final FRPSource frpSource;
  final bool useIcyData;

  const FRPlayer({
    super.key,
    required this.flutterRadioPlayer,
    required this.frpSource,
    required this.useIcyData,
  });

  @override
  State<FRPlayer> createState() => _FRPlayerState();
}

class _FRPlayerState extends State<FRPlayer> {
  int currentIndex = 0;
  //String frpStatus = "flutter_radio_stopped";
  //Navigator.of(context).pop()
  String frpStatus = "flutter_radio_playing";

  @override
  void initState() {
    super.initState();
    widget.flutterRadioPlayer.useIcyData(widget.useIcyData);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FRPPlayerControls(
          flutterRadioPlayer: widget.flutterRadioPlayer,
          addSourceFunction: () =>
              widget.flutterRadioPlayer.addMediaSources(widget.frpSource),
          updateCurrentStatus: (String status) =>
              "flutter_radio_playing", //frpStatus = status,
          nextSource: () => {},
          prevSource: () => {},
        ),
        FRPSourceList(
          flutterRadioPlayer: widget.flutterRadioPlayer,
          frpSource: widget.frpSource,
        ),
      ],
    );
  }
}
