import 'package:flutter/material.dart';

import 'package:inmobiliariaapp/ui/pages/inmuebles_buscados/widgets/filtros_imuebles_buscados.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/container_listado_inmuebles.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/inmueble_item/inmueble_item.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:provider/provider.dart';
import 'package:inmobiliariaapp/domain/usecases/inmueble/filtrado_inmuebles.dart' as filtrado_inmuebles;
class PageMisInmueblesBuscados extends StatefulWidget {
  PageMisInmueblesBuscados({Key? key}) : super(key: key);

  @override
  _PageMisInmueblesBuscadosState createState() => _PageMisInmueblesBuscadosState();
}

class _PageMisInmueblesBuscadosState extends State<PageMisInmueblesBuscados> {
  @override
  Widget build(BuildContext context) {
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context); 
    final _usuario=Provider.of<UsuariosInfo>(context);
    _inmueblesFiltrado.inmueblesBuscados=[];
    if(_inmueblesFiltrado.filtroBuscadoSeleccionado>=0){
      _inmueblesFiltrado.inmueblesBuscados.addAll(filtrado_inmuebles.filtrarInmuebles(inmueblesTotalGeneral, _usuario.usuarioInmueblesBuscados[_inmueblesFiltrado.filtroBuscadoSeleccionado].toMap()));
    }else{
      for(int i=0;i<_usuario.usuarioInmueblesBuscados.length;i++){
        _inmueblesFiltrado.inmueblesBuscados.addAll(filtrado_inmuebles.filtrarInmuebles(inmueblesTotalGeneral, _usuario.usuarioInmueblesBuscados[i].toMap()));
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
                  var inmueble=_inmueblesFiltrado.inmueblesBuscados[index];
                  return InmuebleItem(inmuebleTotal:inmueble,index:index);
                },
              )
            )
          ]
        ),
      ),
    );
  }
}