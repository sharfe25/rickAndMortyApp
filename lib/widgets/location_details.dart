import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:rick_and_morty/models/character.dart';
import 'package:rick_and_morty/models/location.dart';
import 'package:rick_and_morty/providers/character_provider.dart';


class LocationDetails extends StatefulWidget{
  final Location location;
  const LocationDetails({Key? key, required this.location}) : super(key: key);

  @override
  _LocationDetails createState() => _LocationDetails();
} 

class _LocationDetails extends State<LocationDetails>{

  final TextStyle textStyle = const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0);
  
  late Location locationInfo;
  HashMap<String, String> details = HashMap();
  String createdDate = "";
  List<String> charactersInLocation = [];

  @override
  void initState(){
    super.initState();
    _formatCharacter();
  }

  void _formatCharacter() async{
    Location location = widget.location;
    createdDate = DateFormat('yyyy-MM-dd').format(location.created);
    setState(() {
      locationInfo = location;
    });
    details.addAll({
      "Air Date"    : location.dimension,
      "Characters"  : location.residents.length.toString(),
      "Url"         : location.url,
      "Created"     : createdDate,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child:DraggableScrollableSheet(
          initialChildSize: 0.6,
          builder: (BuildContext context, ScrollController scrollController) {
            return Material(
              color: const Color.fromARGB(174, 141, 197, 233),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30)
              ),
              child: Column (
                children: [
                  Row(children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 15, top: 10),
                      child: ClipOval(
                        child: Icon(FontAwesomeIcons.earthAmericas,
                            size: 50, //Icon Size
                            color: Colors.white, //Color Of Icon
                        ),
                      )
                    ),
                    Expanded(
                      child:Column(
                        children: [
                            ListTile(
                            title: Text(
                                  widget.location.name, 
                                  style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0,
                                        letterSpacing: 1.0)
                                  ),
                            subtitle: Text(
                              widget.location.type,
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
                        color: Color.fromARGB(255, 37, 88, 119),
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