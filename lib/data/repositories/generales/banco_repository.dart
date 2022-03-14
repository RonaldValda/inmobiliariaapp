import 'package:inmobiliariaapp/data/repositories/generales/banco_repository_gql.dart';
import 'package:inmobiliariaapp/domain/entities/banco.dart';
import 'package:inmobiliariaapp/domain/repositories/abstract_generales.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:inmobiliariaapp/data/configuration/graphql_configuration.dart';

class BancoRepository extends AbstractBancoRepository{
  @override
  Future<Map<String, dynamic>> obtenerCuentasBanco() async{
    Map<String,dynamic> map={};
    List<CuentaBanco> cuentasBanco=[];
    List cuentasBancoD=[];
    bool error=false;
    try{
      GraphQLConfiguration configuration=GraphQLConfiguration();
      graphql.GraphQLClient client=configuration.myGQLClient();
      graphql.QueryResult result=await client
      .query(
        graphql.QueryOptions(
          document: graphql.gql(getQueryObtenerCuentasBancos()),
          cacheRereadPolicy: graphql.CacheRereadPolicy.mergeOptimistic,
          fetchPolicy: graphql.FetchPolicy.cacheAndNetwork,
        ),
      );
      if(result.hasException){
        error=true;
      }else if(!result.hasException){
        if(result.data!["obtenerCuentasBancos"]!=null){
          cuentasBancoD=result.data!["obtenerCuentasBancos"];
          cuentasBancoD.forEach((element) { 
            cuentasBanco.add(CuentaBanco.fromMap(element));
          });
        }
      }
    }catch (e){
      error=true;
    }
    map["cuentas_bancos"]=cuentasBanco;
    map["error"]=error;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registrarCuentaBanco(CuentaBanco cuentaBanco) async{
    bool completed=true;
    Map<String,dynamic> map={};
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationRegistrarCuentaBanco()),
        variables: (cuentaBanco.toMap()),
        onCompleted: (dynamic data){
          if(data!=null){
            if(data["registrarCuentaBanco"]!=null){
              cuentaBanco=CuentaBanco.fromMap(data["registrarCuentaBanco"]);
            }
          }
        },
        onError: (error){
          completed=false;
        }
    ));
    map["completado"]=completed;
    map["cuenta_banco"]=cuentaBanco;
    return map;
  }

  @override
  Future<Map<String, dynamic>> eliminarBanco(String idBanco) async{
    Map<String,dynamic> map={};
    String mensajeError="";
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationEliminarBanco(),
      
      ),
      variables: ({"id":idBanco}),
      onCompleted: (dynamic data){
        if(data!=null){
          if(data["eliminarBanco"]!=null){
          }
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
  Future<Map<String, dynamic>> modificarBanco(Banco banco) async{
    Map<String,dynamic> map={};
    String mensajeError="";
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationModificarBanco(),
      
      ),
      variables: (banco.toMap()),
      onCompleted: (dynamic data){
        if(data!=null){
          if(data["modificarBanco"]!=null){
          }
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
  Future<Map<String, dynamic>> obtenerBancos() async{
    Map<String,dynamic> map={};
    List<Banco> bancos=[];
    List bancosD=[];
    String mensajeError="";
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(getQueryObtenerBancos()),
        
        fetchPolicy: graphql.FetchPolicy.noCache,
      ),
    );
    if(result.hasException){
      result.exception!.graphqlErrors.forEach((element) { 
        mensajeError=element.message;
      });
      completado=false;
    }else if(!result.hasException){
        if(result.data!["obtenerBancos"]!=null){
          bancosD=result.data!["obtenerBancos"];
          bancosD.forEach((element) {
            bancos.add(Banco.fromMap(element));
          });
      }
    }
    map["mensaje_error"]=mensajeError;
    map["completado"]=completado;
    map["bancos"]=bancos;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registrarBanco(Banco banco) async{
    bool completado=true;
    String mensajeError="";
    Map<String,dynamic> map={};
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationRegistrarBanco(),
      
      ),
      variables: (banco.toMap()),
      onCompleted: (dynamic data){
        if(data!=null){
          if(data["registrarBanco"]!=null){
            banco.id=data["registrarBanco"]["id"];
          }
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
    map["banco"]=banco;
    map["mensaje_error"]=mensajeError;
    return map;
  }
  

}