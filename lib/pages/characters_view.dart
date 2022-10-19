import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/models/character.dart';
import 'package:rick_and_morty/providers/character_provider.dart';
import 'package:rick_and_morty/widgets/character_details.dart';


class CharacterView extends StatefulWidget {
  const CharacterView({Key? key}) : super(key: key);

  @override
  State<CharacterView> createState() => _CharacterView();
}

class _CharacterView extends State<CharacterView> {
  List<Character> characters = [];
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
    getAllCharacters(page);
  }

  void pagination() {
    //Esta funcion nos permite traer informaciona a medida que se hace scroll
    if ((scrollcontroller.position.pixels ==
            scrollcontroller.position.maxScrollExtent) &&
        (characters.length < 826)) {
      setState(() {
        isLoading = true;
        page += 1;
      });
      getAllCharacters(page);
    }
  }

  void _showcharacterInfo(Character characterInfo){
    //Esta funcion muestra el modal con los detalles
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context, 
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (context){
        return  CharacterDetails(character: characterInfo);
      }
    );
  }

  void getAllCharacters(int page) async{
    //Esta funcion obtiene todos los characters
    final charactersRes = await CharacterProvider().getAllCharacters(page);
    setState(() {
      characters = charactersRes;
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
          itemCount: characters.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => _showcharacterInfo(characters[index]),
              child: Chip(
                elevation: 3,
                backgroundColor: const Color.fromARGB(255, 56, 56, 56),
                avatar: CircleAvatar(
                  backgroundImage: NetworkImage(
                      characters[index].image), //NetworkImage
                ),
                label: Container(
                  alignment: Alignment.center,
                  width: 230,
                  child: Text(characters[index].name, style: textStyle,)
                )
              )
            );
          }
        ),
    );
  }
}
