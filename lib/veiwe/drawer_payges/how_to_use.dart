import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';

class HowToUseScreen extends StatelessWidget {
  const HowToUseScreen({Key? key}) : super(key: key);
  videoviw(data) {
    return AspectRatio(
      aspectRatio: 1,
      child: BetterPlayer.network(
        data['url'],
        betterPlayerConfiguration: const BetterPlayerConfiguration(
            aspectRatio: 1,
            autoPlay: false,
            placeholderOnTop: true,
            showPlaceholderUntilPlay: false,
            autoDetectFullscreenDeviceOrientation: false,
            autoDetectFullscreenAspectRatio: false,
            allowedScreenSleep: true,
            autoDispose: true,
            subtitlesConfiguration: BetterPlayerSubtitlesConfiguration(
              outlineEnabled: true,
              backgroundColor: Colors.black,
              fontSize: 12,
              outlineColor: Colors.redAccent,
            ),
            fit: BoxFit.fill,
            controlsConfiguration: BetterPlayerControlsConfiguration(
                showControls: true,
                showControlsOnInitialize: false,
                enableSkips: true,
                enableProgressText: true,
                enableAudioTracks: true,
                enableFullscreen: true,
                //skipBackIcon: Icons.replay_10_outlined,
                //   qualitiesIcon: Icons.add,
                enablePlayPause: true,
                backgroundColor: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
    FirebaseFirestore.instance.collection('how_to_use');
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
           future: users.doc('1111').get(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
              var data = snapshot.data;
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return videoviw(data);
              }
            }),
      ),
    );
  }
}
