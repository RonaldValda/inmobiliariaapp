import 'package:inmobiliariaapp/data/configuration/graphql_configuration.dart';
import 'package:inmobiliariaapp/data/repositories/venta/inmueble_venta_repository_gql.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_reportado.dart';
import 'package:inmobiliariaapp/domain/entities/notificacion.dart';
import 'package:inmobiliariaapp/domain/entities/solicitud_administrador.dart';
import 'package:inmobiliariaapp/domain/repositories/abstract_inmueble.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
class InmuebleVentaRepository extends AbstractInmuebleVentaRepository{
  @override
  Future<bool> modificarEstadoInmueble(InmuebleTotal inmuebleTotal, String tipoAccion) async{
    bool respuesta=false;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    Map<String,dynamic> mapDarBaja=inmuebleTotal.solicitudAdministrador.inmuebleDarBaja.toMap();
    Map<String,dynamic> mapVendido=inmuebleTotal.solicitudAdministrador.inmuebleVendido.toMap();
    Map<String,dynamic> mapVariables={};
    mapVariables.addAll(mapDarBaja);
    mapVariables.addAll(mapVendido);
    mapVariables.addAll({"id_inmueble":inmuebleTotal.inmueble.id,"tipo_accion":tipoAccion});
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationModificarEstadoInmuebleVendedor()),
        variables: (mapVariables),
        onCompleted: (data){
          if(data!=null){
            respuesta=true;
          }
        },
        onError: (error){
          print(error);
          respuesta=false;
        }
      )
    );
    return respuesta;
  }

  @override
  Future<Map<String, dynamic>> obtenerNotificacionesAccionesVendedor(String idInmueble) async{
    Map<String,dynamic> map={};
    List<Notificacion> notificaciones=[];
    List inmuebleQuejas=[];
    List solicitudesAdministradores=[];
    int numeroNotificaciones=0;
    SolicitudAdministrador solicitudAdministrador=SolicitudAdministrador.vacio();
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(getQueryObtenerNotificacionesAccionesVendedor()),
        variables: ({
          "id_inmueble":idInmueble
        }),
        fetchPolicy: graphql.FetchPolicy.noCache,
      ),
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
        if(result.data!["obtenerNotificacionesAccionesVendedor"]!=null){
          inmuebleQuejas=result.data!["obtenerNotificacionesAccionesVendedor"]["inmueble_queja"];
          solicitudesAdministradores=result.data!["obtenerNotificacionesAccionesVendedor"]["solicitudes_administradores"];
        // print(idInmueble);
        // print(result.data!["obtenerNotificacionesAccionesVendedor"]["administrador_inmueble"]);
          solicitudAdministrador=SolicitudAdministrador.fromMap(result.data!["obtenerNotificacionesAccionesVendedor"]["administrador_inmueble"]);
          inmuebleQuejas.forEach((element) {
            InmuebleQueja inmuebleQueja=InmuebleQueja.fromMap(element);
            if(inmuebleQueja.respuesta!=""&&!inmuebleQueja.respuestaEntregada){
              numeroNotificaciones++;
            }
            //numeroNotificaciones++;
            notificaciones.add(Notificacion(fecha: inmuebleQueja.fechaSolicitud, dato: inmuebleQueja));
          });
          solicitudesAdministradores.forEach((element) {
            SolicitudAdministrador solicitud=SolicitudAdministrador.fromMap(element);
            if(solicitud.respuesta!=""&&!solicitud.respuestaEntregada){
              numeroNotificaciones++;
            }
            //numeroNotificaciones++;
            notificaciones.add(Notificacion(fecha: solicitud.fechaSolicitud, dato: solicitud));
          });
      }
    }

    map["completed"]=completed;
    map["notificaciones"]=notificaciones;
    map["administrador_inmueble"]=solicitudAdministrador;
    map["numero_notificaciones"]=numeroNotificaciones;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registrarInmuebleQueja(InmuebleQueja inmuebleQueja) async{
    bool completed=true;
    Map<String,dynamic> map={};
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationRegistrarInmuebleQueja()),
        variables: (inmuebleQueja.toMap()),
        onCompleted: (data){
          if(data!=null){
            inmuebleQueja=InmuebleQueja.fromMap(data["registrarInmuebleQueja"]);
          }
        },
        onError: (error){
          print(error);
          completed=false;
        }
      )
    );
    map["completed"]=completed;
    map["inmueble_queja"]=inmuebleQueja;
    return map;
  }

  @override
  Future<Map<String, dynamic>> actualizarPrecioInmueble(String id, int precio) async{
    bool completado=true;
    String mensajeError="";
    Map<String,dynamic> map={};
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getQueryMutationActualizarPrecioInmueble()),
        variables: ({"id":id,"precio":precio}),
        onCompleted: (data){
          if(data!=null){
          }
        },
        onError: (error){
          error!.graphqlErrors.forEach((element) { 
            mensajeError=element.message;
          });
          completado=false;
        }
      )
    );
    map["completado"]=completado;
    map["mensaje_error"]=mensajeError;
    return map;
  }

}
