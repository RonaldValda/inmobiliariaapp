import 'package:inmobiliariaapp/data/configuration/graphql_configuration.dart';
import 'package:inmobiliariaapp/data/repositories/property/property_repository_gql.dart';
import 'package:inmobiliariaapp/data/repositories/property/property_sale_repository_gql.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:inmobiliariaapp/data/repositories/user/administrator_repository_gql.dart';
import 'package:inmobiliariaapp/data/repositories/user/super_user_repository_gql.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/domain/entities/publicity.dart';

import '../../../auxiliares/global_variables.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/repositories/abstract_property.dart';

class PropertyRepository extends AbstractPropertyRepository{
  @override
  Future<Map<String, dynamic>> getProperties(User user, String sessionType, String city) async{
    Map<String,dynamic> map={};
    List propertiesTotalD=[];
    List<PropertyTotal> propertiesTotal=[];
    List<Publicity> publicities=[];
    List publicitiesD=[];
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    print(user.id);
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document: graphql.gql(
          sessionType=="Comprar"||sessionType=="Observar"?queryGetProperties()
          :
          (sessionType=="Vender"? queryGetMyPropertiesSale()
          :sessionType=="Administrar"?queryGetAdministratorProperties()
          :queryGetAdministratorPropertySuperUser())
        ),
        
        cacheRereadPolicy: graphql.CacheRereadPolicy.mergeOptimistic,
        fetchPolicy: modoOffline?graphql.FetchPolicy.cacheFirst:graphql.FetchPolicy.cacheAndNetwork,
        
        //pollInterval: Duration(milliseconds: 500),
        //cacheRereadPolicy: graphql.CacheRereadPolicy.ignoreOptimisitic,
        variables: {
          "ciudad":city,
          "id_usuario":user.id,
          "id":user.id
        }
      )
    );
    if(result.hasException){
      print("Error $result");
      completed=false;
    }else if(!result.hasException){
      propertiesTotal=[];
      if(sessionType=="Comprar"||sessionType=="Observar"){
        
        if(result.data!["obtenerInmueblesSimpleFiltro"]!=null&&result.data!["obtenerInmueblesSimpleFiltro"].length>0){
          if(result.data!["obtenerInmueblesSimpleFiltro"]["inmuebles"]!=null){
            propertiesTotalD=result.data!["obtenerInmueblesSimpleFiltro"]["inmuebles"];
            propertiesTotalD.forEach((inmueble) {
              propertiesTotal.add(PropertyTotal.fromMap(sessionType, inmueble));
            });
          }
          if(result.data!["obtenerInmueblesSimpleFiltro"]["publicidades"]!=null){
            publicitiesD=result.data!["obtenerInmueblesSimpleFiltro"]["publicidades"];
            publicitiesD.forEach((element) {
              //print(element);
              publicities.add(Publicity.fromMap(element));
            });
          }
        }
      }else if(sessionType=="Administrar"){
        if(result.data!["obtenerAdministradorInmueble"]!=null){
          propertiesTotalD=result.data!["obtenerAdministradorInmueble"];
          propertiesTotalD.forEach((inmueble) {
            propertiesTotal.add(PropertyTotal.fromMap(sessionType, inmueble));
          });
        }
      }else if(sessionType=="Vender"){
        if(result.data!["obtenerMisInmueblesVenta"]!=null){
          propertiesTotalD=result.data!["obtenerMisInmueblesVenta"];
          propertiesTotalD.forEach((inmueble) {
            propertiesTotal.add(PropertyTotal.fromMap(sessionType, inmueble));
          });
        }
      }else if(sessionType=="Supervisar"){
        if(result.data!["obtenerAdministradorInmuebleSuperUsuario"]!=null){
          propertiesTotalD=result.data!["obtenerAdministradorInmuebleSuperUsuario"];
          propertiesTotalD.forEach((inmueble) {
            propertiesTotal.add(PropertyTotal.fromMap(sessionType, inmueble));
          });
        }
      }
    }

    map["completed"]=completed;
    map["properties_total"]=propertiesTotal;
    map["publicities"]=publicities;
    return map;
  }

  @override
  Future<Map<String,dynamic>> registerUpdateProperty(PropertyTotal propertyTotal,String sessionType)async{
  Map<String,dynamic> response={};
  PropertyTotal propertyTotalAux=PropertyTotal.empty();
  bool completed=true;
  GraphQLConfiguration configuration=GraphQLConfiguration();
  graphql.GraphQLClient client=configuration.myGQLClient();
  await client
  .mutate(
    graphql.MutationOptions(
      document: graphql.gql(mutationRegisterProperty(propertyTotal.property.id),
    ),
    variables: (
      propertyTotal.toMap()
    ),
    onCompleted: (dynamic data){
      if(data!=null){
        if(propertyTotal.property.id==""){
          print("registrado");
          if(data!["registrarInmueble"]!=null){
            propertyTotalAux=PropertyTotal.fromMap(sessionType, data!["registrarInmueble"]);
          }
        }else{
          if(data!["actualizarInmueble"]!=null){
            propertyTotalAux=PropertyTotal.empty();
          }
        }
      }
    },
    onError: (error){
      print(error);
      completed=false;
    }
  ));
  response["completed"]=completed;
  response["property_total"]=propertyTotalAux;
  return response;
}

  @override
  Future<bool> registerPropertyFavorite(User user, PropertyTotal propertyTotal) async{
    bool response=false;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    Map<String,dynamic> mapData={};
    mapData.addAll(propertyTotal.userPropertyFavorite.toMap());
    mapData["id_usuario"]=user.id;
    mapData["id_inmueble"]=propertyTotal.property.id;
    print(mapData);
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationRegisterPropertyFavorite(),
      ),
      update: (cache,data){
        return cache;
      },
      variables: (
        mapData
      ),
      onCompleted: (dynamic data){
        if(data!=null){
          response=true;
        }
      },
      onError: (error){
        response=false;
      }
    ));
    return response;
  }
}