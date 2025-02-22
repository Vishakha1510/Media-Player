import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("MEDIA PLAYER APP"),
            bottom: TabBar(tabs: [
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
          body: TabBarView(children: [
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
        ));
  }
}
