import 'package:inmobiliariaapp/data/configuration/graphql_configuration.dart';
import 'package:inmobiliariaapp/data/repositories/generales/membresia_planes_pago_repository_gql.dart';
import 'package:inmobiliariaapp/domain/entities/membresia_planes_pago.dart';
import 'package:inmobiliariaapp/domain/repositories/abstract_generales.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;

class MembresiaPlanesPagoRepository extends AbstractMembresiaPlanesPagoRepository{
  @override
  Future<Map<String, dynamic>> modificarMembresiaPlanesPago(MembresiaPlanesPago membresia) async{
    Map<String,dynamic> map={};
    String mensajeError="";
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationModificarMembresiaPlanesPago(),
      ),
      variables: (
        membresia.toMap()
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
  Future<Map<String, dynamic>> obtenerMembresiaPlanesPago() async{
    Map<String,dynamic> map={};
    List<MembresiaPlanesPago> membresiasPlanesPago=[];
    List membresias=[];
    bool completado=true;
    String mensajeError="";
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(getQueryObtenerMembresiaPlanesPago()),
        
        fetchPolicy: graphql.FetchPolicy.noCache,
      ),
    );
    if(result.hasException){
      result.exception!.graphqlErrors.forEach((element) { 
        mensajeError=element.message;
      });
      completado=false;
    }else if(!result.hasException){
      membresias=[];
        if(result.data!["obtenerMembresiaPlanesPago"]!=null){
          membresias=result.data!["obtenerMembresiaPlanesPago"];
          membresias.forEach((element) {
            membresiasPlanesPago.add(MembresiaPlanesPago.fromMap(element));
          });
      }
    }

    map["completado"]=completado;
    map["mensaje_error"]=mensajeError;
    map["membresias_planes_pago"]=membresiasPlanesPago;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registrarMembresiaPlanesPago(MembresiaPlanesPago membresia) async{
    bool completado=true;
    String mensajeError="";
    Map<String,dynamic> mapResultado={};
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationRegistrarMembresiaPlanesPago(),
      ),
      variables: (
        membresia.toMap()
      ),
      fetchPolicy: graphql.FetchPolicy.noCache,
      onCompleted: (dynamic data){
        if(data!=null){
          membresia=MembresiaPlanesPago.fromMap(data!["registrarMembresiaPlanesPago"]);
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
    mapResultado["membresia_planes_pago"]=membresia;
    return mapResultado;
  }

}