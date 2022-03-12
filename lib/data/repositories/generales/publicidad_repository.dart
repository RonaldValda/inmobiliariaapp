import 'package:inmobiliariaapp/data/configuration/graphql_configuration.dart';
import 'package:inmobiliariaapp/data/repositories/generales/publicidad_repository_gql.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:inmobiliariaapp/domain/entities/publicidad.dart';
import 'package:inmobiliariaapp/domain/repositories/abstract_generales.dart';

class PublicidadRepository extends AbstractPublicidadRepository{
  @override
  Future<Map<String, dynamic>> eliminarAd(String idAd) async{
    Map<String,dynamic> map={};
    String mensajeError="";
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      
      graphql.MutationOptions(
        document: graphql.gql(getMutationEliminarAd(),
      ),
      variables: (
        {
          "id":idAd,
        }
      ),
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
    map["completado"]=completado;
    map["mensaje_error"]=mensajeError;
    return map;
  }

  @override
  Future<Map<String, dynamic>> obtenerAds() async{
    Map<String,dynamic> map={};
    List<List<String>> ads=[];
    String mensajeError="";
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document: graphql.gql(getQueryObtenerAds())
      )
    );
    if(result.hasException){
      completado=false;
      result.exception!.graphqlErrors.forEach((element) {
        mensajeError=element.message;
       });
    }else if(!result.hasException){
      ads=[];
      List adsD;
      if(result.data!["obtener"]!=null){
        adsD=result.data!["obtener"];
        adsD.forEach((element) {
          ads.add([element["id_ad"],element["tipo_ad"]]);
        });
      }
    }
    map["ads"]=ads;
    map["mensaje_error"]=mensajeError;
    map["completado"]=completado;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registrarAd(String idAd, String tipoAd) async{
    bool completado=true;
    String mensajeError="";
    Map<String,dynamic> map={};
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      
      graphql.MutationOptions(
        document: graphql.gql(getMutationRegistrarAd(),
      
      ),
      variables: (
        {
          "id_ad":idAd,
          "tipo_ad":tipoAd
        }
      ),
      onCompleted: (dynamic data){
        if(data!=null){
          print(data!);
        }
      },
      onError: (error){
        error!.graphqlErrors.forEach((element) { 
          mensajeError=element.message;
        });
        completado=false;
      }
    ));
    map["completado"]=completado;
    map["mensaje_error"]=mensajeError;
    return map;
  }

  @override
  Future<Map<String, dynamic>> eliminarPublicidad(String id) async{
    Map<String,dynamic> map={};
    String mensajeError="";
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationEliminarPublicacion(),
      ),
      variables: (
        {
          "id":id
        }
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
    map["completado"]=completado;
    map["mensaje_error"]=mensajeError;
    return map;
  }

  @override
  Future<Map<String, dynamic>> modificarPublicidad(Publicidad publicidad, int mesesVigencia) async{
  
    bool completado=true;
    String mensajeError="";
    Map<String,dynamic> mapResultado={};
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    Map<String,dynamic> map=publicidad.toMap();
    map.addAll({"meses_vigencia":mesesVigencia});
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationModificarPublicidad(),
      ),
      variables: (
        map
      ),
      fetchPolicy: graphql.FetchPolicy.noCache,
      
      onCompleted: (dynamic data){
        if(data!=null){
          Publicidad p=Publicidad.fromMap(data!["modificarPublicidad"]);
          publicidad.fechaVencimiento=p.fechaVencimiento;
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
    mapResultado["completado"]=completado;
    mapResultado["publicidad"]=publicidad;
    return mapResultado;
  }

  @override
  Future<Map<String, dynamic>> obtenerPublicidades() async{
    Map<String,dynamic> map={};
    List<Publicidad> publicidades=[];
    List publicidadesD=[];
    bool completado=true;
    String mensajeError="";
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(getQueryObtenerPublicidad()),
        
        fetchPolicy: graphql.FetchPolicy.noCache,
      ),
    );
    if(result.hasException){
      result.exception!.graphqlErrors.forEach((element) { 
        mensajeError=element.message;
      });
      completado=false;
    }else if(!result.hasException){
        if(result.data!["obtenerPublicidad"]!=null){
          publicidadesD=result.data!["obtenerPublicidad"];
          publicidadesD.forEach((element) {
            publicidades.add(Publicidad.fromMap(element));
          });
      }
    }
    map["mensaje_error"]=mensajeError;
    map["completado"]=completado;
    map["publicidades"]=publicidades;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registrarPublicidad(Publicidad publicidad, int mesesVigencia) async{
    bool completado=true;
    String mensajeError="";
    Map<String,dynamic> mapResultado={};
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    Map<String,dynamic> map=publicidad.toMap();
    map.addAll({"meses_vigencia":mesesVigencia});
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationRegistrarPublicidad(),
      ),
      variables: (
        map
      ),
      fetchPolicy: graphql.FetchPolicy.noCache,
      onCompleted: (dynamic data){
        if(data!=null){
          Publicidad p=Publicidad.fromMap(data!["registrarPublicidad"]);
          publicidad.id=p.id;
          publicidad.fechaCreacion=p.fechaCreacion;
          publicidad.fechaVencimiento=p.fechaVencimiento;
        }
      },
      onError: (error){
        completado=false;
      }
    ));
    map["mensaje_error"]=mensajeError;
    mapResultado["completado"]=completado;
    mapResultado["publicidad"]=publicidad;
    return mapResultado;
  }

}