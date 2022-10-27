import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/pages/home/widgets/item_property/item_property.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:provider/provider.dart';

class PageNotificacionesInmueblesNuevos extends StatefulWidget {
  PageNotificacionesInmueblesNuevos({Key? key}) : super(key: key);
  //final List<InmuebleTotal> inmueblesTotal;
  @override
  _PageNotificacionesInmueblesNuevosState createState() => _PageNotificacionesInmueblesNuevosState();
}

class _PageNotificacionesInmueblesNuevosState extends State<PageNotificacionesInmueblesNuevos> {
  @override
  Widget build(BuildContext context) {
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Notificaciones"),

      ),
      body: Container(
          child: ListView.builder(
            addAutomaticKeepAlives: true,
            addRepaintBoundaries: true,
            addSemanticIndexes: true,
            cacheExtent: 10,
            scrollDirection: Axis.vertical,
            itemCount: _inmueblesFiltrado.inmueblesNuevos.length,
            dragStartBehavior: DragStartBehavior.down,
            itemBuilder:(_,i){
              var propertyTotal=_inmueblesFiltrado.inmueblesNuevos[i];
              //print("object J 0}");
              if(i<_inmueblesFiltrado.inmueblesNuevos.length-1){
                return ItemProperty(propertyTotal:propertyTotal,index:i);
              }
              return Container(
                child: Column(
                  children: [
                    ItemProperty(propertyTotal: propertyTotal,index: i,),
                    SizedBox(height: 10,)
                  ],
                ),
              );
            },
          ),
        ),
    );
  }
}