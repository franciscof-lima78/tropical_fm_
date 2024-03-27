import 'package:flutter/material.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:flutter_radio_player/models/frp_source_modal.dart';

class FRPSourceList extends StatefulWidget {
  final FlutterRadioPlayer flutterRadioPlayer;
  final FRPSource frpSource;

  const FRPSourceList({
    super.key,
    required this.flutterRadioPlayer,
    required this.frpSource,
  });

  @override
  State<FRPSourceList> createState() => _FRPSourceListState();
}

class _FRPSourceListState extends State<FRPSourceList> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.frpSource.mediaSources?.length,
        itemBuilder: (context, index) {
          MediaSources mediaItem = widget.frpSource.mediaSources![index];
          return InkWell(
            onTap: () => {
              setState(
                () {
                  currentIndex = index;
                  widget.flutterRadioPlayer.seekToMediaSource(index, true);
                  widget.flutterRadioPlayer.useIcyData(true);
                  // widget.flutterRadioPlayer.
                },
              ),
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              child: Card(
                  color: Color.fromARGB(238, 236, 240, 241),
                  /*shape: currentIndex == index
                      ? RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Color.fromARGB(238, 236, 240, 241),
                              width: 0.0),
                          borderRadius: BorderRadius.circular(0.0),
                        )
                      : RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Color.fromARGB(238, 236, 240, 241),
                              width: 0.0),
                          borderRadius: BorderRadius.circular(0.0),
                        ),*/
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          //mediaItem.title ?? "N/A",
                          "",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(238, 236, 240, 241)),
                        ),
                        Text(
                          "",
                          style: const TextStyle(
                              color: Color.fromARGB(238, 236, 240, 241)),
                        ),
                      ],
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }
}