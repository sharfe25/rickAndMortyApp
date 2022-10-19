import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rick_and_morty/models/character.dart';


class CharacterDetails extends StatefulWidget{
  final Character character;
  const CharacterDetails({Key? key, required this.character}) : super(key: key);

  @override
  _CharacterDetails createState() => _CharacterDetails();
} 

class _CharacterDetails extends State<CharacterDetails>{

  final TextStyle textStyle = const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0);
  
  late Character characterInfo;
  HashMap<String, String> details = HashMap();
  String createdDate = "";

  @override
  void initState(){
    super.initState();
    _formatCharacter();
  }

  void _formatCharacter(){
    Character character = widget.character;
    createdDate = DateFormat('yyyy-MM-dd').format(character.created);
    setState(() {
      characterInfo = character;
    });
    details.addAll({
      "Species"    : character.species,
      "Type"       : character.type.isEmpty ? "--" : character.type,
      "Gender"     : character.gender,
      "Origin"     : character.origin.name,
      "Location"   : character.location.name,
      "Episodes"   : character.episode.length.toString(),
      "Created"    : createdDate,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child:DraggableScrollableSheet(
          initialChildSize: 0.6,
          builder: (BuildContext context, ScrollController scrollController) {
            return Material(
              color: const Color.fromARGB(174, 48, 97, 37),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30)
              ),
              child: Column (
                children: [
                  Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 10),
                      child: ClipOval(
                        child: Image.network(widget.character.image, width: 70, height: 70,),
                      )
                    ),
                    Expanded(
                      child:Column(
                        children: [
                            ListTile(
                            title: Text(
                                  widget.character.name, 
                                  style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0,
                                        letterSpacing: 1.0)
                                  ),
                            subtitle: Text(
                              widget.character.status,
                              style: textStyle
                            )
                          ),
                        ],
                      )
                    ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Material(
                        color: Color.fromARGB(255, 36, 73, 28),
                        elevation: 80,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: details.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                                trailing: Text(
                                  details.values.elementAt(index),
                                  style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 12),
                                ),
                                title: Text(details.keys.elementAt(index), style: textStyle,));
                          }
                        ),
                      ),
                    ),
                  ),     
                ])
            );
          },
      ),
    );
  }
}