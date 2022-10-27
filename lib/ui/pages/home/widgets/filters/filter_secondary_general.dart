import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/auxiliares/global_variables.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/pages/home/widgets/filters/see_more_button.dart';
import 'package:inmobiliariaapp/ui/pages/home/widgets/filters/selectors_buttons.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_general_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../widgets/f_list_tile_switch.dart';
import 'drop_down_filters.dart';
import 'drop_down_selectable_data_filter_city.dart';
import 'drop_down_selectable_data_filter_zone.dart';
// ignore: must_be_immutable
class FiltersSecondaryGeneral extends StatefulWidget {
  Map<String,dynamic> mapFiltro;
  FiltersSecondaryGeneral({Key? key,required this.mapFiltro}) : super(key: key);

  @override
  _FiltersSecondaryGeneralState createState() => _FiltersSecondaryGeneralState();
}

class _FiltersSecondaryGeneralState extends State<FiltersSecondaryGeneral> {
  bool seeMore=false;
  
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final filterGeneralProvider=context.watch<FilterGeneralProvider>();
    Widget sizedBox=SizedBox(height: 10*SizeDefault.scaleHeight,);
    return Container(
      width: MediaQuery.of(context).size.width,
       child: Column(
         children: [
          DropDownSelectableDataFilterCity(text: "Ciudad"),
          sizedBox,
          DropDownSelectableDataFilterZone(text: "Zona"),
          sizedBox,
          DropDownFilters(
            attribute: "land_surface", 
            mapData: filterGeneralProvider.mapSelectableData, 
            mapFilter: filterGeneralProvider.mapFilter, 
            onChanged: (x){
              filterGeneralProvider.setMapFilterItem("land_surface", x, selectable: true,context: context);
            }, 
            text: "Superficie de terreno"
          ),

          filterGeneralProvider.mapFilterPlus["pre_sale_project"]?
          Container():
          Column(
            children: [
              sizedBox,
              DropDownFilters(
                attribute: "construction_surface", 
                mapData: filterGeneralProvider.mapSelectableData, 
                mapFilter: filterGeneralProvider.mapFilter, 
                onChanged: (x){
                  filterGeneralProvider.setMapFilterItem("construction_surface", x, selectable: true,context: context);
                }, 
                text: "Superficie de construcción"
              ),
            ],
          ),
          sizedBox,
          DropDownFilters(
            attribute: "front_size", 
            mapData: filterGeneralProvider.mapSelectableData, 
            mapFilter: filterGeneralProvider.mapFilter, 
            onChanged: (x){
              filterGeneralProvider.setMapFilterItem("front_size", x, selectable: true,context: context);
            }, 
            text: "Metros de frente"
          ),
          sizedBox,
          DropDownFilters(
            attribute: "construction_antiquity", 
            mapData: filterGeneralProvider.mapSelectableData, 
            mapFilter: filterGeneralProvider.mapFilter, 
            onChanged: (x){
              filterGeneralProvider.setMapFilterItem("construction_antiquity", x, selectable: true,context: context);
            }, 
            text: "Antigüedad de construción"
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
          seeMore?FiltersSecondaryGeneralPlus():Container()
        ],
       ),
    );
  }
}
class FiltersSecondaryGeneralPlus extends StatefulWidget {

  FiltersSecondaryGeneralPlus({Key? key}) : super(key: key);

  @override
  _FiltersSecondaryGeneralPlusState createState() => _FiltersSecondaryGeneralPlusState();
}

class _FiltersSecondaryGeneralPlusState extends State<FiltersSecondaryGeneralPlus> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final filterGeneralProvider=context.watch<FilterGeneralProvider>();
    return Container(
       child: Column(
         children: [
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Mascotas permitidas", 
            value: filterGeneralProvider.mapFilterPlus["enable_pets"], 
            onChanged: (value){
              filterGeneralProvider.setMapFilterPlusItem("enable_pets",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Sin hipoteca", 
            value: filterGeneralProvider.mapFilterPlus["no_mortgage"], 
            onChanged: (value){
              filterGeneralProvider.setMapFilterPlusItem("no_mortgage",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Construcciones a estrenar", 
            value: filterGeneralProvider.mapFilterPlus["new_construction"], 
            onChanged: (value){
              filterGeneralProvider.setMapFilterPlusItem("new_construction",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Materiales de primera", 
            value: filterGeneralProvider.mapFilterPlus["premium_materials"], 
            onChanged: (value){
              filterGeneralProvider.setMapFilterPlusItem("premium_materials",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Proyecto preventa", 
            value: filterGeneralProvider.mapFilterPlus["pre_sale_project"], 
            onChanged: (value){
              filterGeneralProvider.setMapFilterPlusItem("pre_sale_project",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Inmueble compartido", 
            value: filterGeneralProvider.mapFilterPlus["shared_property"], 
            onChanged: (value){
              filterGeneralProvider.setMapFilterPlusItem("shared_property",value,context: context);
            }
          ),
           !filterGeneralProvider.mapFilterPlus["shared_property"]?
           Container():
           SelectorsButtons(
            text: "Número de dueños", 
            selected: filterGeneralProvider.mapFilterPlus["owners_number"], 
            options: selectorsButtonsValues, 
            onChanged: (x){
              filterGeneralProvider.setMapFilterPlusItem("owners_number", x,context: context);
            }
          ),
           FListTileSwitch(
            isLeadingVisible: true,
            title: "Servicios básicos (agua, luz, etc.)", 
            value: filterGeneralProvider.mapFilterPlus["basic_services"], 
            onChanged: (value){
              filterGeneralProvider.setMapFilterPlusItem("basic_services",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Gas domiciliario", 
            value: filterGeneralProvider.mapFilterPlus["household_gas"], 
            onChanged: (value){
              filterGeneralProvider.setMapFilterPlusItem("household_gas",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Wi-Fi", 
            value: filterGeneralProvider.mapFilterPlus["wifi"], 
            onChanged: (value){
              filterGeneralProvider.setMapFilterPlusItem("wifi",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Medidor independiente", 
            value: filterGeneralProvider.mapFilterPlus["independent_meter"], 
            onChanged: (value){
              filterGeneralProvider.setMapFilterPlusItem("independent_meter",value,context: context);
            }
          ),        
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Termotanques", 
            value: filterGeneralProvider.mapFilterPlus["hot_water_tank"], 
            onChanged: (value){
              filterGeneralProvider.setMapFilterPlusItem("hot_water_tank",value,context: context);
            }
          ), 
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Calle asfaltada", 
            value: filterGeneralProvider.mapFilterPlus["paved_street"], 
            onChanged: (value){
              filterGeneralProvider.setMapFilterPlusItem("paved_street",value,context: context);
            }
          ), 
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Transporte (0 - 100m)", 
            value: filterGeneralProvider.mapFilterPlus["transport"], 
            onChanged: (value){
              filterGeneralProvider.setMapFilterPlusItem("transport",value,context: context);
            }
          ), 
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Preparado para discapacidad", 
            value: filterGeneralProvider.mapFilterPlus["disability_prepared"], 
            onChanged: (value){
              filterGeneralProvider.setMapFilterPlusItem("disability_prepared",value,context: context);
            }
          ), 
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Papeles en orden", 
            value: filterGeneralProvider.mapFilterPlus["order_papers"], 
            onChanged: (value){
              filterGeneralProvider.setMapFilterPlusItem("order_papers",value,context: context);
            }
          ),   
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Habilitado para crédito de vivienda social", 
            value: filterGeneralProvider.mapFilterPlus["enabled_credit"], 
            onChanged: (value){
              filterGeneralProvider.setMapFilterPlusItem("enabled_credit",value,context: context);
            }
          ),                      
        ],
      ),
    );
  }
}