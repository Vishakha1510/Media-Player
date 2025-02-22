// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';

// class AudioComponent extends StatefulWidget {
//   const AudioComponent({super.key});

//   @override
//   State<AudioComponent> createState() => _AudioComponentState();
// }

// class _AudioComponentState extends State<AudioComponent> {
//   AudioPlayer audioPlayer = AudioPlayer();

//   Duration? totalDuration;
//   Duration? currentPosition;

//   @override
//   void initState() {
//     super.initState();
//     loadAudio();
//   }

//   Future<void> loadAudio() async {
//     await audioPlayer.setSource(AssetSource("audios/alarm.mp3"));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             "ALARM TUNE",
//             style: TextStyle(fontSize: 20),
//           ),
//           SizedBox(height: 12),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               StreamBuilder(
//                   stream: audioPlayer.onPositionChanged,
//                   builder: (context, snapshot) {
//                     if (snapshot.hasError) {
//                       return Center(
//                         child: Text("ERROR: ${snapshot.error}"),
//                       );
//                     } else if (snapshot.hasData) {
//                       currentPosition = snapshot.data;
//                       return (currentPosition == null)
//                           ? Text("")
//                           : Text(
//                               "${currentPosition.toString().split(".")[0]}",
//                               style: TextStyle(fontSize: 18),
//                             );
//                     }
//                     return CircularProgressIndicator();
//                   }),
//               Text(
//                 "/",
//                 style: TextStyle(fontSize: 18),
//               ),
//               StreamBuilder(
//                   stream: audioPlayer.onDurationChanged,
//                   builder: (context, snapshot) {
//                     if (snapshot.hasError) {
//                       Text("ERROR:${snapshot.error}");
//                     } else if (snapshot.hasData) {
//                       totalDuration = snapshot.data;
//                       return (totalDuration == null)
//                           ? Text("")
//                           : Text(
//                               "${totalDuration.toString().split(".")[0]}",
//                               style: TextStyle(fontSize: 18),
//                             );
//                     }
//                     return CircularProgressIndicator();
//                   })
//             ],
//           ),
//           StreamBuilder(
//               stream: audioPlayer.onPositionChanged,
//               builder: (context, snapshot) {
//                 if (snapshot.hasError) {
//                   return Center(
//                     child: Text("ERROR: ${snapshot.error}"),
//                   );
//                 } else if (snapshot.hasData) {
//                   currentPosition = snapshot.data;
//                   return Slider(
//                       min: 0,
//                       max: totalDuration == null
//                           ? 0
//                           : totalDuration!.inSeconds.toDouble(),
//                       value: currentPosition == null
//                           ? 0
//                           : currentPosition!.inSeconds.toDouble(),
//                       onChanged: (val) async {
//                         await audioPlayer.seek(Duration(seconds: val.toInt()));
//                       });
//                 }
//                 return CircularProgressIndicator();
//               }),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               IconButton(
//                   onPressed: () async {
//                     await audioPlayer.play(AssetSource("audios/alarm.mp3"));
//                   },
//                   icon: Icon(Icons.play_arrow)),
//               IconButton(
//                   onPressed: () async {
//                     await audioPlayer.pause();
//                   },
//                   icon: Icon(Icons.pause)),
//               IconButton(
//                   onPressed: () async {
//                     await audioPlayer.stop();
//                   },
//                   icon: Icon(Icons.stop)),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioComponent extends StatefulWidget {
  const AudioComponent({super.key});

  @override
  State<AudioComponent> createState() => _AudioComponentState();
}

class _AudioComponentState extends State<AudioComponent> {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration? totalDuration;
  Duration? currentPosition;
  int currentIndex = 0;

  List<Map<String, String>> songs = [
    {"path": "audios/Singham_Again.mp3", "name": "Singham Again"},
    {"path": "audios/Bhool_Bhulaiyaa.mp3", "name": "Bhool Bhulaiyaa"},
    {"path": "audios/Apna_Bana_Le.mp3", "name": "Apna Bana Le"},
    {"path": "audios/Deva_Deva.mp3", "name": "Deva Deva"},
    {"path": "audios/Baaki_Sab_Theek.mp3", "name": "Baaki Sab Theek"},
    {"path": "audios/alarm.mp3", "name": "Alarm"},
    {"path": "audios/Bird.mp3", "name": "Bird Sounds"},
    {"path": "audios/Forest.mp3", "name": "Forest Ambience"},
  ];

  @override
  void initState() {
    super.initState();
    loadAudio();
  }

  Future<void> loadAudio() async {
    await audioPlayer.setSource(AssetSource(songs[currentIndex]["path"]!));
  }

  void playSong(int index) async {
    setState(() {
      currentIndex = index;
    });
    await audioPlayer.stop();
    await audioPlayer.setSource(AssetSource(songs[currentIndex]["path"]!));
    await audioPlayer.play(AssetSource(songs[currentIndex]["path"]!));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Select a Song",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              DropdownButton<int>(
                value: currentIndex,
                isExpanded: true,
                items: List.generate(songs.length, (index) {
                  return DropdownMenuItem(
                    value: index,
                    child: Text(songs[index]["name"]!),
                  );
                }),
                onChanged: (index) {
                  if (index != null) {
                    playSong(index);
                  }
                },
              ),
              SizedBox(height: 20),
              StreamBuilder(
                stream: audioPlayer.onPositionChanged,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    currentPosition = snapshot.data;
                    return Text(
                      "${currentPosition.toString().split(".")[0]}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
              SizedBox(height: 8),
              StreamBuilder(
                stream: audioPlayer.onDurationChanged,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    totalDuration = snapshot.data;
                    return Text(
                      "${totalDuration.toString().split(".")[0]}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
              SizedBox(height: 12),
              StreamBuilder(
                stream: audioPlayer.onPositionChanged,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    currentPosition = snapshot.data;
                    return Slider(
                      min: 0,
                      max: totalDuration == null
                          ? 0
                          : totalDuration!.inSeconds.toDouble(),
                      value: currentPosition == null
                          ? 0
                          : currentPosition!.inSeconds.toDouble(),
                      onChanged: (val) async {
                        await audioPlayer.seek(Duration(seconds: val.toInt()));
                      },
                      activeColor: Colors.blueAccent,
                      inactiveColor: Colors.grey.shade400,
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      await audioPlayer
                          .play(AssetSource(songs[currentIndex]["path"]!));
                    },
                    icon: Icon(Icons.play_arrow, size: 32, color: Colors.green),
                  ),
                  IconButton(
                    onPressed: () async {
                      await audioPlayer.pause();
                    },
                    icon: Icon(Icons.pause, size: 32, color: Colors.blue),
                  ),
                  IconButton(
                    onPressed: () async {
                      await audioPlayer.stop();
                    },
                    icon: Icon(Icons.stop, size: 32, color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
