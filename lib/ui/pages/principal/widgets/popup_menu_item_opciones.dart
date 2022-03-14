import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/dialog_registro_inmueble_buscado.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/app_bar.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/filtros/filtros_ordenacion.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_otros_info.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:provider/provider.dart';
import 'package:fluttericon/entypo_icons.dart' as iconentypo;
class PopupMenuItemOpciones extends StatefulWidget {
  PopupMenuItemOpciones({Key? key}) : super(key: key);

  @override
  _PopupMenuItemOpcionesState createState() => _PopupMenuItemOpcionesState();
}

class _PopupMenuItemOpcionesState extends State<PopupMenuItemOpciones> {
  int seleccionado=-1;
  @override
  Widget build(BuildContext context) {
    final _inmueblesFiltrados=Provider.of<ListadoInmueblesFiltrado>(context);
    final mapaFiltroOrden=Provider.of<MapaFiltroOtrosInfo>(context);
    final _usuario=Provider.of<UsuariosInfo>(context);
    return Container(
      child: Column(
        children: [
          if(seleccionado<0)Column(
            children: [
              ListTile(
                //title: Text("Ordenar ${mapaFiltroOrden.getMapaFiltroOrden["orden"]==getOrden.ascendente.index?"(asc.)":"(desc.)"}",
                title: Text("Ordenar",
                  style: TextStyle(
                    fontSize: 14
                  ),
                ),
                trailing: Icon(mapaFiltroOrden.getMapaFiltroOrden["orden"]==getOrden.ascendente.index?iconentypo.Entypo.up_thin:iconentypo.Entypo.down_thin),
                onTap: (){
                  setState(() {
                    seleccionado=1;
                  });
                },
              ),
              if(_usuario.getSuscrito()=="Suscrito")ListTile(
                trailing: IconoNotificacion(numeroNotificacion: _inmueblesFiltrados.inmueblesBuscados.length),
                title: Text("Buscados",
                  style: TextStyle(
                    fontSize: 14
                  ),
                ),
                onTap: (){
                  setState(() {
                    seleccionado=2;
                  });
                },
              )
            ],
          ),
          if(seleccionado==1)
          FiltrosOrdenacion(),
          if(seleccionado==2)
          CargarInmuebleBuscado()
        ],
      ),
    );
  }
}