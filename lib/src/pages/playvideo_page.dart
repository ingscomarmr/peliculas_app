import 'package:flutter/material.dart';
//import 'package:video_player/video_player.dart';

class PlayVideoPage extends StatefulWidget {
  PlayVideoPage({Key key}) : super(key: key);

  @override
  _PlayVideoPageState createState() => _PlayVideoPageState();
}

class _PlayVideoPageState extends State<PlayVideoPage> {
  //VideoPlayerController _controller;
  //Future<void> _initializeVideoPlayerFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ver trailer Oficial'),
      ),
      body: Container(
        child: Text('Playing....'),
      ),
    );
  }
}
