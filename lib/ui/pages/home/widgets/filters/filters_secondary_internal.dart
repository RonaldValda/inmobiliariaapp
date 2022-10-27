import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/pages/home/widgets/filters/see_more_button.dart';
import 'package:inmobiliariaapp/ui/pages/home/widgets/filters/selectors_buttons.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_internal_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../auxiliares/global_variables.dart';
import '../../../../../widgets/f_list_tile_switch.dart';
class FiltersSecondaryInternal extends StatefulWidget {
  FiltersSecondaryInternal({Key? key}) : super(key: key);

  @override
  _FiltersSecondaryInternalState createState() => _FiltersSecondaryInternalState();
}

class _FiltersSecondaryInternalState extends State<FiltersSecondaryInternal> {
  bool seeMore=false;
  @override
  Widget build(BuildContext context) {
    final filterInternalProvider=context.watch<FilterInternalProvider>();
    final sizedBox=SizedBox(height: 10*SizeDefault.scaleHeight,);
    return Container(
       child: Column(
         children: [
          SelectorsButtons(
            text: "Plantas", 
            selected: filterInternalProvider.mapFilter["floors_number"], 
            options: selectorsButtonsValues, 
            onChanged: (x){
              if(x==filterInternalProvider.mapFilter["floors_number"]){
                filterInternalProvider.setMapFilterItem("floors_number", -1,context: context);
              }else{
                filterInternalProvider.setMapFilterItem("floors_number", x,context: context);
              }
            }
          ),
          sizedBox,
          SelectorsButtons(
            text: "Ambientes", 
            selected: filterInternalProvider.mapFilter["rooms_number"], 
            options: selectorsButtonsValues, 
            onChanged: (x){
              if(x==filterInternalProvider.mapFilter["rooms_number"]){
                filterInternalProvider.setMapFilterItem("rooms_number", -1,context: context);
              }else{
                filterInternalProvider.setMapFilterItem("rooms_number", x,context: context);
              }
            }
          ),
          sizedBox,
          SelectorsButtons(
            text: "Dormitorios", 
            selected: filterInternalProvider.mapFilter["bedrooms_number"], 
            options: selectorsButtonsValues, 
            onChanged: (x){
              if(x==filterInternalProvider.mapFilter["bedrooms_number"]){
                filterInternalProvider.setMapFilterItem("bedrooms_number", -1,context: context);
              }else{
                filterInternalProvider.setMapFilterItem("bedrooms_number", x,context: context);
              }
            }
          ),
          sizedBox,
          SelectorsButtons(
            text: "Baños", 
            selected: filterInternalProvider.mapFilter["bathrooms_number"], 
            options: selectorsButtonsValues, 
            onChanged: (x){
              if(x==filterInternalProvider.mapFilter["bathrooms_number"]){
                filterInternalProvider.setMapFilterItem("bathrooms_number", -1,context: context);
              }else{
                filterInternalProvider.setMapFilterItem("bathrooms_number", x,context: context);
              }
            }
          ),
          sizedBox,
          SelectorsButtons(
            text: "Garaje [Vehículos]", 
            selected: filterInternalProvider.mapFilter["garages_number"], 
            options: selectorsButtonsValues, 
            onChanged: (x){
              if(x==filterInternalProvider.mapFilter["garages_number"]){
                filterInternalProvider.setMapFilterItem("garages_number", -1,context: context);
              }else{
                filterInternalProvider.setMapFilterItem("garages_number", x,context: context);
              }
            }
          ),
          sizedBox,
          SeeMoreButton(
            activate: seeMore, 
            onTap: (){
              setState(() {
                seeMore=!seeMore;
              });
            }
          ), 
           seeMore?FiltersSecondaryInternalPlus():Container(),
         ]
       ),
    );
  }
}
class FiltersSecondaryInternalPlus extends StatefulWidget {
  FiltersSecondaryInternalPlus({Key? key}) : super(key: key);

  @override
  _FiltersSecondaryInternalPlusState createState() => _FiltersSecondaryInternalPlusState();
}

class _FiltersSecondaryInternalPlusState extends State<FiltersSecondaryInternalPlus> {
  @override
  Widget build(BuildContext context) {
    final filterInternalProvider=context.watch<FilterInternalProvider>();
    return Container(
       child: Column(
         children: [
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Amoblado", 
            value: filterInternalProvider.mapFilterPlus["furnished"], 
            onChanged: (value){
              filterInternalProvider.setMapFilterPlusItem("furnished",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Lavandería", 
            value: filterInternalProvider.mapFilterPlus["laundry"], 
            onChanged: (value){
              filterInternalProvider.setMapFilterPlusItem("laundry",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Cuarto de lavado", 
            value: filterInternalProvider.mapFilterPlus["laundry_room"], 
            onChanged: (value){
              filterInternalProvider.setMapFilterPlusItem("laundry_room",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Churrasquero", 
            value: filterInternalProvider.mapFilterPlus["grill"], 
            onChanged: (value){
              filterInternalProvider.setMapFilterPlusItem("grill",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Azotea", 
            value: filterInternalProvider.mapFilterPlus["rooftop"], 
            onChanged: (value){
              filterInternalProvider.setMapFilterPlusItem("rooftop",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "[Club house]-> Condominio privado", 
            value: filterInternalProvider.mapFilterPlus["private_condominium"], 
            onChanged: (value){
              filterInternalProvider.setMapFilterPlusItem("private_condominium",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Cancha de Fútbol, tenis, etc. en inmueble", 
            value: filterInternalProvider.mapFilterPlus["court"], 
            onChanged: (value){
              filterInternalProvider.setMapFilterPlusItem("court",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Piscina", 
            value: filterInternalProvider.mapFilterPlus["pool"], 
            onChanged: (value){
              filterInternalProvider.setMapFilterPlusItem("pool",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Sauna", 
            value: filterInternalProvider.mapFilterPlus["sauna"], 
            onChanged: (value){
              filterInternalProvider.setMapFilterPlusItem("sauna",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Jacuzzi", 
            value: filterInternalProvider.mapFilterPlus["jacuzzi"], 
            onChanged: (value){
              filterInternalProvider.setMapFilterPlusItem("jacuzzi",value,context: context);
            }
          ),  
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Estudio", 
            value: filterInternalProvider.mapFilterPlus["studio"], 
            onChanged: (value){
              filterInternalProvider.setMapFilterPlusItem("studio",value,context: context);
            }
          ),  
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Jardín", 
            value: filterInternalProvider.mapFilterPlus["garden"], 
            onChanged: (value){
              filterInternalProvider.setMapFilterPlusItem("garden",value,context: context);
            }
          ),  
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Portón eléctrico", 
            value: filterInternalProvider.mapFilterPlus["electric_gate"], 
            onChanged: (value){
              filterInternalProvider.setMapFilterPlusItem("electric_gate",value,context: context);
            }
          ),  
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Aire acondicionado", 
            value: filterInternalProvider.mapFilterPlus["air_conditioning"], 
            onChanged: (value){
              filterInternalProvider.setMapFilterPlusItem("air_conditioning",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Calefacción", 
            value: filterInternalProvider.mapFilterPlus["heating"], 
            onChanged: (value){
              filterInternalProvider.setMapFilterPlusItem("heating",value,context: context);
            }
          ),    
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Ascensor", 
            value: filterInternalProvider.mapFilterPlus["elevator"], 
            onChanged: (value){
              filterInternalProvider.setMapFilterPlusItem("elevator",value,context: context);
            }
          ),   
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Depósito", 
            value: filterInternalProvider.mapFilterPlus["warehouse"], 
            onChanged: (value){
              filterInternalProvider.setMapFilterPlusItem("warehouse",value,context: context);
            }
          ),  
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Sótano", 
            value: filterInternalProvider.mapFilterPlus["basement"], 
            onChanged: (value){
              filterInternalProvider.setMapFilterPlusItem("basement",value,context: context);
            }
          ),  
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Balcón", 
            value: filterInternalProvider.mapFilterPlus["balcony"], 
            onChanged: (value){
              filterInternalProvider.setMapFilterPlusItem("balcony",value,context: context);
            }
          ),  
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Tienda", 
            value: filterInternalProvider.mapFilterPlus["store"], 
            onChanged: (value){
              filterInternalProvider.setMapFilterPlusItem("store",value,context: context);
            }
          ), 
          FListTileSwitch(
            isLeadingVisible: true,
            title: "[Amurallado]-> Terreno", 
            value: filterInternalProvider.mapFilterPlus["land_walled"], 
            onChanged: (value){
              filterInternalProvider.setMapFilterPlusItem("land_walled",value,context: context);
            }
          ), 
        ],
      )
    );
  }
}