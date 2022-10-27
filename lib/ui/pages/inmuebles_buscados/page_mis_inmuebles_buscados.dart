import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/pages/home/widgets/item_property/item_property.dart';

import 'package:inmobiliariaapp/ui/pages/inmuebles_buscados/widgets/filtros_imuebles_buscados.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_properties_searcheds.dart';
import 'package:provider/provider.dart';
import 'package:inmobiliariaapp/domain/usecases/property/filter_properties.dart' as filtrado_inmuebles;

import '../home/widgets/home/container_properties.dart';
class PageMisInmueblesBuscados extends StatefulWidget {
  PageMisInmueblesBuscados({Key? key}) : super(key: key);

  @override
  _PageMisInmueblesBuscadosState createState() => _PageMisInmueblesBuscadosState();
}

class _PageMisInmueblesBuscadosState extends State<PageMisInmueblesBuscados> {
  @override
  Widget build(BuildContext context) {
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context); 
    _inmueblesFiltrado.inmueblesBuscados=[];
    final userPropertiesSearchedsProvider=context.watch<UserPropertiesSearchedsProvider>();
    final userPropertiesSearcheds=userPropertiesSearchedsProvider.userPropertiesSearcheds;
    if(_inmueblesFiltrado.filtroBuscadoSeleccionado>=0){
      _inmueblesFiltrado.inmueblesBuscados.addAll(filtrado_inmuebles.filterProperties(inmueblesTotalGeneral, userPropertiesSearcheds[_inmueblesFiltrado.filtroBuscadoSeleccionado].toMap()));
    }else{
      for(int i=0;i<userPropertiesSearcheds.length;i++){
        _inmueblesFiltrado.inmueblesBuscados.addAll(filtrado_inmuebles.filterProperties(inmueblesTotalGeneral, userPropertiesSearcheds[i].toMap()));
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Mis inmuebles buscados"),
        actions: [
          Container(
          //height:10,
          width: 40,
            child: PopupMenuButton(
              tooltip: "Filtrar",
              elevation: 30,
              offset: const Offset(0, 40),
              color: Colors.white.withOpacity(0.8),
              enableFeedback: false,
              icon: Icon(Icons.person),
              padding: EdgeInsets.zero,
              itemBuilder: (context){
                return [
                  PopupMenuItem<int>(
                    padding: EdgeInsets.all(0),
                    value: 0, 

                    child: FiltrosInmueblesBuscados()
                  ),
                ];
              }
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children:[
            Expanded(
              child: ListView.builder(
                itemCount: _inmueblesFiltrado.inmueblesBuscados.length,
                itemBuilder: (context, index) {
                  final propertyTotal=_inmueblesFiltrado.inmueblesBuscados[index];
                  return ItemProperty(propertyTotal:propertyTotal,index:index);
                },
              )
            )
          ]
        ),
      ),
    );
  }
}