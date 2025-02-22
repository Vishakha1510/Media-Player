import 'package:flutter/material.dart';
import 'package:media_player/Components/Audio_component.dart';
import 'package:media_player/Components/Slider_component.dart';
import 'package:media_player/Components/Video_component.dart';

class HomePage3 extends StatefulWidget {
  const HomePage3({super.key});

  @override
  State<HomePage3> createState() => _HomePage3State();
}

class _HomePage3State extends State<HomePage3>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        centerTitle: true,
        title: Text(
          "MEDIA PLAYER APP",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(controller: tabController, tabs: [
          Tab(
            icon: Icon(Icons.music_note),
            child: Text("Audio"),
          ),
          Tab(
            icon: Icon(Icons.video_collection_outlined),
            child: Text("Video"),
          ),
          Tab(
            icon: Icon(Icons.apps_outlined),
            child: Text("Slider"),
          )
        ]),
      ),
      body: TabBarView(
          controller: tabController,
          children: [AudioComponent(), VideoComponent(), SliderComponent()]),
    );
  }
}
