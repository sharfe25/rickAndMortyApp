import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rick_and_morty/models/episode.dart';
import 'package:rick_and_morty/providers/episode_provider.dart';
import 'package:rick_and_morty/widgets/episode_details.dart';


class EpisodesView extends StatefulWidget {
  const EpisodesView({Key? key}) : super(key: key);

  @override
  State<EpisodesView> createState() => _EpisodesView();
}

class _EpisodesView extends State<EpisodesView> {
  List<Episode> episodes = [];
  var scrollcontroller = ScrollController();
  var page = 1;
  var isLoading = false;
  final TextStyle textStyle = const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0);

  @override
  void initState(){
    super.initState();
    scrollcontroller.addListener(pagination);
    getAllEpisodes(page);
  }

  void pagination() {
    //Esta funcion nos permite traer informaciona a medida que se hace scroll
   if ((scrollcontroller.position.pixels ==
            scrollcontroller.position.maxScrollExtent) &&
        (episodes.length < 51)) {
      setState(() {
        isLoading = true;
        page += 1;
      });
      getAllEpisodes(page);
    }
  }

  void _showEpisodeInfo(Episode episodeInfo){
    //Esta funcion muestra el modal con los detalles
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context, 
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (context){
        return  EpisodeDetails(episode: episodeInfo);
      }
    );
  }

  void getAllEpisodes(int page) async{
    //Esta funcion obtiene todos los episodios
    final episodeRes = await EpisodeProvider().getAllEpisodes(page);
    setState(() {
      episodes = episodeRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 20.0),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          controller: scrollcontroller,
          shrinkWrap: true,
          itemCount: episodes.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => _showEpisodeInfo(episodes[index]),
              child:Padding(
                padding: const EdgeInsets.only(top: 10), 
                child:  Chip(
                  elevation: 3,
                  backgroundColor: const Color.fromARGB(255, 56, 56, 56),
                  avatar: const CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 148, 144, 41),
                    child: Icon(FontAwesomeIcons.cameraRetro,
                        size: 25, //Icon Size
                        color: Colors.white, //Color Of Icon
                    )
                  ),
                  label: Container(
                    alignment: Alignment.center,
                    width: 230,
                    height: 50,
                    child: Text(episodes[index].name, style: textStyle,)
                  ),
                )
              )
            );
          }
        ),
    );
  }
}
