//Author: Sharon Rueda Fernandez
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/pages/characters_view.dart';
import 'package:rick_and_morty/pages/episodes_view.dart';
import 'package:rick_and_morty/pages/locations_views.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Rick and Morty'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Sky _selectedSegment = Sky.characters;
  Map<Sky,Widget> views = <Sky, Widget>{
    Sky.characters: const CharacterView(),
    Sky.locations: const LocationsView(),
    Sky.episodes: const EpisodesView(),
  };
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: CupertinoPageScaffold(
        backgroundColor: skyColors[_selectedSegment],
        navigationBar: CupertinoNavigationBar(
          // This Cupertino segmented control has the enum "Sky" as the type.
          middle: CupertinoSlidingSegmentedControl<Sky>(
            backgroundColor: const Color.fromARGB(255, 73, 73, 73),
            thumbColor: skyColors[_selectedSegment]!,
            // This represents the currently selected segmented control.
            groupValue: _selectedSegment,
            // Callback that sets the selected segmented control.
            onValueChanged: (Sky? value) {
              if (value != null) {
                setState(() {
                  _selectedSegment = value;
                });
              }
            },
            children: const <Sky, Widget>{
              Sky.characters: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Characters',
                  style: TextStyle(color: CupertinoColors.white, fontSize: 15),
                ),
              ),
              Sky.locations: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Locations',
                  style: TextStyle(color: CupertinoColors.white, fontSize: 15),
                ),
              ),
              Sky.episodes: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Episodes',
                  style: TextStyle(color: CupertinoColors.white, fontSize: 15),
                ),
              ),
            },
          ),
        ),
        child: Center(
          child: views[_selectedSegment],
        ),
      )
    );
  }
}

enum Sky { characters, locations, episodes}

Map<Sky, Color> skyColors = <Sky, Color>{
  Sky.characters: const Color.fromARGB(255, 87, 153, 72),
  Sky.locations: const Color.fromARGB(255, 141, 197, 233),
  Sky.episodes: const Color.fromARGB(255, 191, 187, 79),
};
