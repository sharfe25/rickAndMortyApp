import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rick_and_morty/models/character.dart';
import 'package:rick_and_morty/providers/character_provider.dart';
import 'package:rick_and_morty/widgets/character_details.dart';
import 'package:rick_and_morty/widgets/location_details.dart';

import '../models/location.dart';
import '../providers/location_provider.dart';


class LocationsView extends StatefulWidget {
  const LocationsView({Key? key}) : super(key: key);

  @override
  State<LocationsView> createState() => _LocationsView();
}

class _LocationsView extends State<LocationsView> {
  List<Location> locations = [];
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
    getAllLocations(page);
  }

  void pagination() {
    //Esta funcion nos permite traer informaciona a medida que se hace scroll
   if ((scrollcontroller.position.pixels ==
            scrollcontroller.position.maxScrollExtent) &&
        (locations.length < 126)) {
      setState(() {
        isLoading = true;
        page += 1;
      });
      getAllLocations(page);
    }
  }

  void _showLocationInfo(Location locationInfo){
    //Esta funcion muestra el modal con los detalles
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context, 
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (context){
        return  LocationDetails(location: locationInfo);
      }
    );
  }

  void getAllLocations(int page) async{
    //Esta funcion obtiene todos las locations
    final locationRes = await LocationProvider().getAllLocations(page);
    setState(() {
      locations = locationRes;
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
          itemCount: locations.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => _showLocationInfo(locations[index]),
              child:Padding(
                padding: const EdgeInsets.only(top: 10), 
                child:  Chip(
                  elevation: 3,
                  backgroundColor: const Color.fromARGB(255, 56, 56, 56),
                  avatar: const CircleAvatar(
                    child: Icon(FontAwesomeIcons.earthAmericas,
                        size: 30, //Icon Size
                        color: Colors.white, //Color Of Icon
                    )
                  ),
                  label: Container(
                    alignment: Alignment.center,
                    width: 230,
                    height: 50,
                    child: Text(locations[index].name, style: textStyle,)
                  ),
                )
              )
            );
          }
        ),
    );
  }
}
