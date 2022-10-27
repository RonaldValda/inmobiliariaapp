import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/pages/home/widgets/filters/see_more_button.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_comunity_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../widgets/f_list_tile_switch.dart';
class FiltersSecondaryComunity extends StatefulWidget {
  FiltersSecondaryComunity({Key? key}) : super(key: key);

  @override
  _FiltersSecondaryComunityState createState() => _FiltersSecondaryComunityState();
}

class _FiltersSecondaryComunityState extends State<FiltersSecondaryComunity> {
  
  bool seeMore=false;
  @override
  Widget build(BuildContext context) {
    final filterComunityProvider=context.watch<FilterComunityProvider>();
    return Container(
       child: Column(
         children: [
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Iglesia", 
            value: filterComunityProvider.mapFilter["church"], 
            onChanged: (value){
              filterComunityProvider.setMapFilterItem("church",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Parque infantil", 
            value: filterComunityProvider.mapFilter["playground"], 
            onChanged: (value){
              filterComunityProvider.setMapFilterItem("playground",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Escuela", 
            value: filterComunityProvider.mapFilter["school"], 
            onChanged: (value){
              filterComunityProvider.setMapFilterItem("school",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Universidad", 
            value: filterComunityProvider.mapFilter["university"], 
            onChanged: (value){
              filterComunityProvider.setMapFilterItem("university",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Plazuela", 
            value: filterComunityProvider.mapFilter["small_square"], 
            onChanged: (value){
              filterComunityProvider.setMapFilterItem("small_square",value,context: context);
            }
          ),
          SeeMoreButton(
            activate: seeMore, 
            onTap: (){
              setState(() {
                seeMore=!seeMore;
              });
            }
          ),
           seeMore?FilterSecondaryComunityPlus():Container()
        ],
      ),
    );
  }
}
class FilterSecondaryComunityPlus extends StatefulWidget {
  FilterSecondaryComunityPlus({Key? key}) : super(key: key);

  @override
  _FilterSecondaryComunityPlusState createState() => _FilterSecondaryComunityPlusState();
}

class _FilterSecondaryComunityPlusState extends State<FilterSecondaryComunityPlus> {
  @override
  Widget build(BuildContext context) {
    final filterComunityProvider=context.watch<FilterComunityProvider>();
    return Container(
       child: Column(
         children: [
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Módulo policial", 
            value: filterComunityProvider.mapFilterPlus["police_module"], 
            onChanged: (value){
              filterComunityProvider.setMapFilterPlusItem("police_module",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Sauna / piscina pública", 
            value: filterComunityProvider.mapFilterPlus["public_sauna_pool"], 
            onChanged: (value){
              filterComunityProvider.setMapFilterPlusItem("public_sauna_pool",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Gym público", 
            value: filterComunityProvider.mapFilterPlus["public_gym"], 
            onChanged: (value){
              filterComunityProvider.setMapFilterPlusItem("public_gym",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Centro deportivo", 
            value: filterComunityProvider.mapFilterPlus["sport_center"], 
            onChanged: (value){
              filterComunityProvider.setMapFilterPlusItem("sport_center",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Puesto de salud", 
            value: filterComunityProvider.mapFilterPlus["post_health"], 
            onChanged: (value){
              filterComunityProvider.setMapFilterPlusItem("post_health",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Zona comercial", 
            value: filterComunityProvider.mapFilterPlus["shooping_zone"], 
            onChanged: (value){
              filterComunityProvider.setMapFilterPlusItem("shooping_zone",value,context: context);
            }
          ),
         ],
       ),
    );
  }
}