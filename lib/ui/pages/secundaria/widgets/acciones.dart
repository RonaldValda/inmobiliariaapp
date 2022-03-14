import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/solicitud_administrador.dart';
import 'package:inmobiliariaapp/domain/usecases/usuario/usecase_administrador.dart';
import 'package:inmobiliariaapp/ui/provider/inmueble_info.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:provider/provider.dart';

import 'acciones_solicitudes.dart';
class Acciones extends StatefulWidget {
  Acciones({Key? key}) : super(key: key);
  
  @override
  _AccionesState createState() => _AccionesState();
}

class _AccionesState extends State<Acciones> {
  List<SolicitudAdministrador> administradorSolicitudes=[];
  UseCaseAdministrador useCaseAdministrador=UseCaseAdministrador();
  late UsuariosInfo usuarioProvider;
  late InmuebleInfo inmuebleInfo;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      inmuebleInfo=Provider.of<InmuebleInfo>(context,listen: false);
      usuarioProvider = Provider.of<UsuariosInfo>(context, listen: false);
      useCaseAdministrador.obtenerSolicitudesAdministradores(inmuebleInfo.inmuebleTotal.solicitudAdministrador.id)
      .then((resultado){
        if(resultado["completado"]){
          administradorSolicitudes=resultado["administrador_solicitudes"];
          setState(() {
            
          });
        }
      });
      ;
    });
    
  }
  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: Row(
        children: [
          ElevatedButton(
            onPressed: ()async{
              
            }, 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /*Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("")
                    )
                  ),
                ),*/
                Text("Dar Alta")
              ],
            ),
            style: ElevatedButton.styleFrom(
                            primary: Colors.blue
                          ),
          ),
          SizedBox(
            width: 5,
          ),
          ElevatedButton(
            onPressed: ()async{
              
            }, 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Dar Baja")
              ],
            ),
            style: ElevatedButton.styleFrom(
                            primary: Colors.red
                          ),
          ),
          SizedBox(
            width:5
          ),
          ElevatedButton(
            onPressed: ()async{
              
            }, 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Vendido")
              ],
            ),
            style: ElevatedButton.styleFrom(
                            primary: Colors.green
                          ),
          ),
          SizedBox(
            width:5
          ),
          PopupMenuSolicitudesAdministrador(administradorSolicitudes: administradorSolicitudes,)
        ],
      ),
    );
  }
}