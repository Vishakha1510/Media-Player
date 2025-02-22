import 'package:flutter/material.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2>
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
        centerTitle: true,
        title: Text("MEDIA PLAYER APP"),
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
      body: TabBarView(controller: tabController, children: [
        Container(
          color: Colors.blue.shade100,
          child: Center(child: Text("AUDIO PLAYER")),
        ),
        Container(
          color: Colors.orange.shade100,
          child: Center(child: Text("VIDEO PLAYER")),
        ),
        Container(
          color: Colors.deepPurpleAccent.shade100,
          child: Center(child: Text("SLIDER")),
        )
      ]),
    );
  }
}
