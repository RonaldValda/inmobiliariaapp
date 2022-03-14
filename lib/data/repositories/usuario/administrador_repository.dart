import 'package:inmobiliariaapp/data/configuration/graphql_configuration.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:inmobiliariaapp/data/repositories/usuario/administrador_repository_gql.dart';
import 'package:inmobiliariaapp/domain/entities/administrador_zona.dart';
import 'package:inmobiliariaapp/domain/entities/inscripcion_agente.dart';
import 'package:inmobiliariaapp/domain/entities/membresia_pago.dart';
import 'package:inmobiliariaapp/domain/entities/solicitud_administrador.dart';
import 'package:inmobiliariaapp/domain/entities/usuario.dart';
import 'package:inmobiliariaapp/domain/repositories/abstract_usuario.dart';
import 'package:inmobiliariaapp/ui/pages/principal/page_home.dart';
class AdministradorRepository extends AbstractAdministradorRepository{
  @override
  Future<Map<String, dynamic>> obtenerAdministradorZonas(String idAdministrador) async{
     Map<String,dynamic> map={};
    List<AdministradorZona> administradorZonas=[];
    List administradorZonasD=[];
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(getQueryObtenerAdministradorZonas()),
        variables: ({"id_administrador":idAdministrador}),
        fetchPolicy: graphql.FetchPolicy.noCache,
      ),
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
        if(result.data!["obtenerAdministradorZonas"]!=null){
          administradorZonasD=result.data!["obtenerAdministradorZonas"];
          administradorZonasD.forEach((element) {
            administradorZonas.add(AdministradorZona.fromMap(element));
          });
      }
    }

    map["completed"]=completed;
    map["administrador_zonas"]=administradorZonas;
    return map;
  }

  @override
  Future<Map<String, dynamic>> obtenerNotificacionesAdministrador(String idAdministrador) async{
    Map<String,dynamic> map={};
    List<MembresiaPago> membresias=[];
    List membresiasD=[];
    List<InscripcionAgente> inscripciones=[];
    List inscripcionesD=[];
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(getQueryObtenerNotificacionesAdministrador()),
        variables: ({"id":idAdministrador}),
        fetchPolicy: graphql.FetchPolicy.noCache,
      ),
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
        if(result.data!["obtenerNotificacionesAdministrador"]!=null){
          membresiasD=result.data!["obtenerNotificacionesAdministrador"]["membresias_pagos"];
          membresiasD.forEach((element) {
            membresias.add(MembresiaPago.fromMap(element));
          });
          inscripcionesD=result.data!["obtenerNotificacionesAdministrador"]["inscripciones_agentes"];
          inscripcionesD.forEach((element) { 
            inscripciones.add(InscripcionAgente.fromMap(element));
          });
      }
    }

    map["completed"]=completed;
    map["membresias_pagos"]=membresias;
    map["inscripciones_agentes"]=inscripciones;
    return map;
  }

  @override
  Future<Map<String, dynamic>> responderSolicitudAdministrador(Usuario usuario, SolicitudAdministrador administradorInmueble, SolicitudAdministrador solicitudAdministrador) async{
    Map<String,dynamic> map={};
    bool completed=false;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    String mensaje="";
    graphql.GraphQLClient client=configuration.myGQLClient();
    Map<String,dynamic> mapVariables=solicitudAdministrador.toMap();
    mapVariables["id_respondedor"]=usuario.id;
    mapVariables.addAll({"id":administradorInmueble.id});
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationResponderSolicitudAdministrador()),
        variables: (
          mapVariables
        ),
        onCompleted: (data){
          if(data!=null){
            mensaje=data["responderSolicitudAdministrador"].toString();
            completed=true;
          }
        },
        onError: (error){
          var ms=error!.graphqlErrors;
          ms.forEach((element) {
            mensaje=element.message;
          });
          completed=false;
        }
      )
    );
    map["completed"]=completed;
    map["mensaje"]=mensaje;
    return map;
  }

  @override
  Future<Map<String, dynamic>> responderSolicitudInscripcionAgente(InscripcionAgente inscripcionAgente) async{
    Map<String,dynamic> map={};
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    String mensaje="";
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getQueryResponderSolicitudInscripcionAgente()),
        variables: (
          inscripcionAgente.toMap()
        ),
        onCompleted: (data){
          if(data!=null){
            if(data!["responderSolicitudInscripcionAgente"]!=null){
              inscripcionAgente.fechaRespuesta=data!["responderSolicitudInscripcionAgente"]["fecha_respuesta"];
            }
          }
        },
        onError: (error){
          var ms=error!.graphqlErrors;
          ms.forEach((element) {
            print(element);
            mensaje=element.message;
          });
          completed=false;
        }
      )
    );
    map["completed"]=completed;
    map["mensaje"]=mensaje;
    map["inscripcion_agente"]=inscripcionAgente;
    return map;
  }
  @override
  Future<Map<String, dynamic>> obtenerSolicitudesAdministradores(String id) async{
    Map<String,dynamic> map={};
    List solicitudesD=[];
    List<SolicitudAdministrador> administradorSolicitudes=[];
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document: graphql.gql(getQueryObtenerSolicitudesAdministradores()),
        fetchPolicy: modoOffline?graphql.FetchPolicy.cacheFirst:graphql.FetchPolicy.cacheAndNetwork,
        variables: {
          "id":id
        }
      )
    );
    if(result.hasException){
      print(result);
      completed=false;
    }else if(!result.hasException){
        if(result.data!["obtenerSolicitudesAdministradores"]!=null){
          print(result.data!["obtenerSolicitudesAdministradores"]);
          solicitudesD=result.data!["obtenerSolicitudesAdministradores"];
          solicitudesD.forEach((map) {
          administradorSolicitudes.add(SolicitudAdministrador.fromMap(map));
          print(map);
          });
        }
    }
  print("object");
    map["completado"]=completed;
    map["administrador_solicitudes"]=administradorSolicitudes;
    return map;
  }
}