import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:flutter_radio_player/models/frp_player_event.dart';

class FRPPlayerControls extends StatefulWidget {
  final FlutterRadioPlayer flutterRadioPlayer;
  final Function addSourceFunction;
  final Function nextSource;
  final Function prevSource;
  final Function(String status) updateCurrentStatus;

  const FRPPlayerControls({
    super.key,
    required this.flutterRadioPlayer,
    required this.addSourceFunction,
    required this.nextSource,
    required this.prevSource,
    required this.updateCurrentStatus,
  });

  @override
  State<FRPPlayerControls> createState() => _FRPPlayerControlsState();
}

class _FRPPlayerControlsState extends State<FRPPlayerControls> {
  String latestPlaybackStatus = "flutter_radio_playing";
  String currentPlaying = "N/A";
  double volume = 0.5;
  final nowPlayingTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.flutterRadioPlayer.frpEventStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          FRPPlayerEvents frpEvent =
              FRPPlayerEvents.fromJson(jsonDecode(snapshot.data as String));
          if (kDebugMode) {
            print("====== EVENT START =====");
            print("Playback status: ${frpEvent.playbackStatus}");
            print("Icy details: ${frpEvent.icyMetaDetails}");
            print("Other: ${frpEvent.data}");
            print("====== EVENT END =====");
          }
          //frpEvent.playbackStatus = latestPlaybackStatus;
          if (frpEvent.playbackStatus != null) {
            latestPlaybackStatus = frpEvent.playbackStatus!;
            widget.updateCurrentStatus(latestPlaybackStatus);
          } else {
            //frpEvent
            //frpEvent.playbackStatus = latestPlaybackStatus;

            widget.updateCurrentStatus(latestPlaybackStatus);
          }

          if (frpEvent.icyMetaDetails != null) {
            currentPlaying = frpEvent.icyMetaDetails!;
            nowPlayingTextController.text = frpEvent.icyMetaDetails!;
          }
          var statusIcon = const Icon(Icons.pause_circle_filled,
              size: 60.0, color: Color.fromARGB(232, 96, 247, 174));
          switch (frpEvent.playbackStatus) {
            //switch (latestPlaybackStatus) {
            case "flutter_radio_playing":
              statusIcon = const Icon(Icons.pause_circle_filled,
                  size: 60.0, color: Color.fromARGB(232, 96, 247, 174));
              break;
            case "flutter_radio_paused":
              statusIcon = const Icon(Icons.play_circle_filled,
                  size: 60.0, color: Color.fromARGB(232, 96, 247, 174));
              break;
            case "flutter_radio_loading":
              statusIcon = const Icon(Icons.refresh_rounded,
                  size: 60.0, color: Color.fromARGB(232, 96, 247, 174));
              break;
            case "flutter_radio_stopped":
              statusIcon = const Icon(Icons.play_circle_filled,
                  size: 60.0, color: Color.fromARGB(232, 96, 247, 174));
              break;
          }
          return latestPlaybackStatus == "flutter_radio_stopped"
              ? ElevatedButton(
                  onPressed: () async {
                    widget.addSourceFunction();
                  },
                  child: const Text("Voltar a ouvir"),
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(currentPlaying,
                            style: const TextStyle(
                                color: Color.fromARGB(189, 255, 255, 255),
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /*IconButton(
                              onPressed: () async {
                                widget.flutterRadioPlayer.previous();
                                resetNowPlayingInfo();
                              },
                              icon: const Icon(Icons.skip_previous),
                            ),*/
                            IconButton(
                              //icon: Icon(statusIcon, size: 18.0),
                              onPressed: () async {
                                widget.flutterRadioPlayer.playOrPause();
                                resetNowPlayingInfo();
                              },
                              icon: statusIcon,
                            ),
                            /*IconButton(
                              onPressed: () async {
                                //widget.flutterRadioPlayer.stop();
                                widget.flutterRadioPlayer.playOrPause();
                                resetNowPlayingInfo();
                              },
                              //icon: const Icon(Icons.stop_circle_outlined),
                              icon: statusIcon,
                            ),*/
                            /*IconButton(
                              onPressed: () async {
                                widget.flutterRadioPlayer.next();
                                resetNowPlayingInfo();
                              },
                              icon: const Icon(Icons.skip_next),
                            ),*/
                          ],
                        ),
                        Slider(
                          value: volume,
                          onChanged: (value) {
                            setState(() {
                              volume = value;
                              widget.flutterRadioPlayer.setVolume(volume);
                            });
                          },
                        )
                      ],
                    ),
                  ),
                );
        } else if (latestPlaybackStatus == "flutter_radio_stopped") {
          return ElevatedButton(
            onPressed: () async {
              widget.addSourceFunction();
            },
            child: const Text("Voltar a ouvir"),
          );
        }
        widget.flutterRadioPlayer.play();
        resetNowPlayingInfo();
        return const Text("Carregando ...");
      },
    );
  }

  void resetNowPlayingInfo() {
    currentPlaying = "N/A";
  }
}
