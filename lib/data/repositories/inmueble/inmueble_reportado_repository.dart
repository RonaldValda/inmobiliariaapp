import 'package:inmobiliariaapp/data/configuration/graphql_configuration.dart';
import 'package:inmobiliariaapp/data/repositories/inmueble/inmueble_reportado_repository_gql.dart';
import 'package:inmobiliariaapp/domain/entities/usuario.dart';
import 'package:inmobiliariaapp/domain/entities/solicitud_administrador.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_reportado.dart';
import 'package:inmobiliariaapp/domain/repositories/abstract_inmueble.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;

class InmuebleReportadoRepository extends AbstractInmuebleReportadoRepository{
  @override
  Future<List<SolicitudAdministrador>> obtenerReportesInmueble(Usuario usuario, InmuebleTotal inmuebleTotal, bool estado1, bool estado2) async{
    List<SolicitudAdministrador> solicitudes=[];
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document: graphql.gql(getQueryObtenerReportesInmueble()),
        variables: {
          "id_usuario":usuario.id,
          "id_inmueble":inmuebleTotal.inmueble.id,
          "estado_1":estado1,
          "estado_2":estado2
        }
      )
    );
    if(result.hasException){
      print("Error");
    }else if(!result.hasException){
      solicitudes=[];
      List solicitudesD;
      if(result.data!["obtenerReportesInmueble"]!=null){
        solicitudesD=result.data!["obtenerReportesInmueble"];
        //print(solicitudesD);
        solicitudesD.forEach((element) {
          solicitudes.add(SolicitudAdministrador.fromMap(element));
        });
      }
      
    }
    return solicitudes;
  }

  @override
  Future<bool> reportarInmueble(InmuebleReportado reportado) async{
    bool respuesta=false;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    
    await client
    .mutate(
      
      graphql.MutationOptions(
        document: graphql.gql(getMutationReportarInmueble(),
      
      ),
      variables: (reportado.toMap()),
      onCompleted: (dynamic data){
        if(data!=null){
          respuesta=true;
        }
      },
      onError: (error){
        respuesta=false;
      }
    ));
    return respuesta;
  }

}