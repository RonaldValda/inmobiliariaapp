import 'package:inmobiliariaapp/data/configuration/graphql_configuration.dart';
import 'package:inmobiliariaapp/data/repositories/generales/planes_pago_publicacion_repository_gql.dart';
import 'package:inmobiliariaapp/domain/entities/planes_pago_publicacion.dart';
import 'package:inmobiliariaapp/domain/repositories/abstract_generales.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;

class PlanesPagoPublicacionRepository extends AbstractPlanesPagoPublicacionRepository{
  @override
  Future<Map<String, dynamic>> eliminarPlanesPagoPublicacion(String id) async{
    Map<String,dynamic> map={};
    bool completado=true;
    String mensajeError="";
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationEliminarPlanesPagoPublicacion(),
      ),
      variables: (
        {"id":id}
      ),
      fetchPolicy: graphql.FetchPolicy.noCache,
      onCompleted: (dynamic data){
        if(data!=null){
          
        }
      },
      onError: (error){
        error!.graphqlErrors.forEach((element) { 
          mensajeError=element.message;
        });
        completado=false;
      }
    ));
    map["mensaje_error"]=mensajeError;
    map["completado"]=completado;
    return map;
  }

  @override
  Future<Map<String, dynamic>> modificarPlanesPagoPublicacion(PlanesPagoPublicacion plan) async{
    Map<String,dynamic> map={};
    bool completado=true;
    String mensajeError="";
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationModificarPlanesPagoPublicacion(),
      ),
      variables: (
        plan.toMap()
      ),
      fetchPolicy: graphql.FetchPolicy.noCache,
      onCompleted: (dynamic data){
        if(data!=null){
          
        }
      },
      onError: (error){
        completado=false;
        error!.graphqlErrors.forEach((element) { 
          mensajeError=element.message;
        });
      }
    ));
    map["completado"]=completado;
    map["mensaje_error"]=mensajeError;
    return map;
  }

  @override
  Future<Map<String, dynamic>> obtenerPlanesPagoPublicacion() async{
    Map<String,dynamic> map={};
    List<PlanesPagoPublicacion> planesPagoPublicacion=[];
    List planes=[];
    bool completado=true;
    String mensajeError="";
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(getQueryObtenerPlanesPagoPublicacion()),
        
        fetchPolicy: graphql.FetchPolicy.noCache,
      ),
    );
    if(result.hasException){
      completado=false;
      result.exception!.graphqlErrors.forEach((element) { 
        mensajeError=element.message;
      });
    }else if(!result.hasException){
      planes=[];
        if(result.data!["obtenerPlanesPagoPublicacion"]!=null){
          planes=result.data!["obtenerPlanesPagoPublicacion"];
          planes.forEach((element) {
            planesPagoPublicacion.add(PlanesPagoPublicacion.fromMap(element));
          });
      }
    }
    map["mensaje_error"]=mensajeError;
    map["completado"]=completado;
    map["planes_pago_publicacion"]=planesPagoPublicacion;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registrarPlanesPagoPublicacion(PlanesPagoPublicacion plan) async{
    bool completado=true;
    String mensajeError="";
    Map<String,dynamic> mapResultado={};
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationRegistrarPlanesPagoPublicacion(),
      ),
      variables: (
        plan.toMap()
      ),
      fetchPolicy: graphql.FetchPolicy.noCache,
      onCompleted: (dynamic data){
        if(data!=null){
          plan.id=data["registrarPlanesPagoPublicacion"]["id"];
        }
      },
      onError: (error){
        completado=false;
        error!.graphqlErrors.forEach((element) { 
          mensajeError=element.message;
        });
      }
    ));
    mapResultado["completado"]=completado;
    mapResultado["mensaje_error"]=mensajeError;
    mapResultado["plan_pago_publicacion"]=plan;
    return mapResultado;
  }

}