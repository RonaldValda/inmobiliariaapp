import 'package:inmobiliariaapp/auxiliares/version_app.dart';
import 'package:inmobiliariaapp/data/configuration/graphql_configuration.dart';
import 'package:inmobiliariaapp/data/repositories/generals/generals_repository_gql.dart';
import 'package:inmobiliariaapp/domain/entities/generals.dart';
import 'package:inmobiliariaapp/domain/repositories/abstract_generals.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;

import '../../../auxiliares/global_variables.dart';
class GeneralsRepository extends AbstractGeneralesRepository{
  @override
  Future<bool> deleteCity(String cityId) async{
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationDeleteCity()),
        variables: ({"id_ciudad":cityId}),
        onCompleted: (dynamic data){
          if(data!=null){
          }
        },
        onError: (error){
          completed=false;
        }
    ));
    return completed;
  }

  @override
  Future<bool> deleteDepartament(String departamentId) async{
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationDeleteDepartament()),
        variables: ({"id_departamento":departamentId}),
        onCompleted: (dynamic data){
          if(data!=null){
          }
        },
        onError: (error){
          completed=false;
        }
    ));
    return completed;
  }

  @override
  Future<bool> deleteZone(String zoneId) async{
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationDeleteZone()),
        variables: ({"id_zona":zoneId}),
        onCompleted: (dynamic data){
          if(data!=null){
          }
        },
        onError: (error){
          completed=false;
        }
    ));
    return completed;
  }

  @override
  Future<bool> updateCity(String cityId, String cityName) async{
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationUpdateCity()),
        variables: ({
          "id_ciudad":cityId,
          "nombre_ciudad":cityName
        }),
        onCompleted: (dynamic data){
          if(data!=null){
          }
        },
        onError: (error){
          completed=false;
        }
    ));
    return completed;
  }

  @override
  Future<bool> updateDepartament(String departamentId,String departamentName) async{
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationUpdateDepartament()),
        variables: ({
          "id_departamento":departamentId,
          "nombre_departamento":departamentName
        }),
        onCompleted: (dynamic data){
          if(data!=null){
          }
        },
        onError: (error){
          completed=false;
        }
    ));
    return completed;
  }

  @override
  Future<bool> updateZone(Zone zone) async{
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationUpdateZone()),
        variables: ({
        "id_zona":zone.id,
          "nombre_zona":zone.zoneName,
          "coordenadas":[zone.area[0][0],zone.area[0][1],zone.area[1][0],zone.area[1][1]],
        }),
        onCompleted: (dynamic data){
          if(data!=null){
          }
        },
        onError: (error){
          completed=false;
        }
    ));
    return completed;
  }

  @override
  Future<Map<String, dynamic>> getCities(String departamentId)async{
    Map<String,dynamic> map={};
    List<City> cities=[];
    List citiesD=[];
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(queryGetCities()),
        variables: ({"id_departamento":departamentId}),
        fetchPolicy: graphql.FetchPolicy.noCache,
      ),
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
        if(result.data!["obtenerCiudades"]!=null){
          citiesD=result.data!["obtenerCiudades"];
          citiesD.forEach((element) {
            cities.add(City.fromMap(element));
          });
      }
    }

    map["completed"]=completed;
    map["cities"]=cities;
    return map;
  }

  @override
  Future<Map<String, dynamic>> getDepartaments() async{
    Map<String,dynamic> map={};
    List<Departament> departaments=[];
    List departamentsD=[];
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(queryGetDepartaments()),
        
        fetchPolicy: graphql.FetchPolicy.noCache,
      ),
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
        if(result.data!["obtenerDepartamentos"]!=null){
          departamentsD=result.data!["obtenerDepartamentos"];
          departamentsD.forEach((element) {
            departaments.add(Departament.fromMap(element));
          });
      }
    }

    map["completed"]=completed;
    map["departaments"]=departaments;
    return map;
  }

  @override
  Future<Map<String, dynamic>> getGeneralsPlaces() async{
    Map<String,dynamic> map={};
    List<City> cities=[];
    List<Zone> zones=[];
    List citiesD=[];
    List zonesD=[];
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(queryGetGeneralsPlaces()),
        fetchPolicy:modoOffline?graphql.FetchPolicy.cacheFirst: graphql.FetchPolicy.cacheAndNetwork,
      ),
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
        if(result.data!["obtenerGeneralesLugares"]!=null){
          citiesD=result.data!["obtenerGeneralesLugares"]["ciudades"];
          citiesD.forEach((element) {
            cities.add(City.fromMap(element));
          });
          zonesD=result.data!["obtenerGeneralesLugares"]["zonas"];
          zonesD.forEach((element) {
            zones.add(Zone.fromMap(element));
          });
      }
    }

    map["completed"]=completed;
    map["cities"]=cities;
    map["zones"]=zones;
    return map;
  }

  @override
  Future<Map<String, dynamic>> getZones(String cityId) async{
    Map<String,dynamic> map={};
    List<Zone> zones=[];
    List zonesD=[];
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(queryGetZones()),
        variables: ({"id_ciudad":cityId}),
        fetchPolicy: graphql.FetchPolicy.noCache,
      ),
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
        if(result.data!["obtenerZonas"]!=null){
          zonesD=result.data!["obtenerZonas"];
          zonesD.forEach((element) {
            zones.add(Zone.fromMap(element));
          });
      }
    }

    map["completed"]=completed;
    map["zones"]=zones;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registerCity(String departamentId, String cityName) async{
    bool completed=true;
    City city=City.empty();
    Map<String,dynamic> map={};
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationRegisterCity()),
        variables: ({
          "id_departamento":departamentId,
          "nombre_ciudad":cityName
        }),
        onCompleted: (dynamic data){
          if(data!=null){
            if(data["registrarCiudad"]!=null){
              city=City.fromMap(data["registrarCiudad"]);
            }
          }
        },
        onError: (error){
          completed=false;
        }
    ));
    map["completed"]=completed;
    map["city"]=city;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registerDepartament(String departamentName)async{
    bool completed=true;
    Departament departament=Departament.empty();
    Map<String,dynamic> map={};
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationRegisterDepartament()),
        variables: ({"nombre_departamento":departamentName}),
        onCompleted: (dynamic data){
          if(data!=null){
            if(data["registrarDepartamento"]!=null){
              departament=Departament.fromMap(data["registrarDepartamento"]);
            }
          }
        },
        onError: (error){
          completed=false;
        }
    ));
    map["completed"]=completed;
    map["departament"]=departament;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registerZone(String cityId, Zone zone) async{
     bool completed=true;
    Map<String,dynamic> map={};
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationRegisterZone()),
        variables: ({
          "id_ciudad":cityId,
          "nombre_zona":zone.zoneName,
          "coordenadas":[zone.area[0][0],zone.area[0][1],zone.area[1][0],zone.area[1][1]],
        }),
        onCompleted: (dynamic data){
          if(data!=null){
            if(data["registrarZona"]!=null){
              zone=Zone.fromMap(data["registrarZona"]);
            }
          }
        },
        onError: (error){
          completed=false;
        }
    ));
    map["completed"]=completed;
    map["zone"]=zone;
    return map;
  }

  @override
  Future<Map<String, dynamic>> getAppVersion() async{
    Map<String,dynamic> map={};
    AppVersion appVersion=AppVersion.empty();
    bool error=false;
    try{
      GraphQLConfiguration configuration=GraphQLConfiguration();
      graphql.GraphQLClient client=configuration.myGQLClient();
      graphql.QueryResult result=await client
      .query(
        graphql.QueryOptions(
          document: graphql.gql(queryGetAppVersion()),
          cacheRereadPolicy: graphql.CacheRereadPolicy.mergeOptimistic,
          fetchPolicy: graphql.FetchPolicy.cacheAndNetwork,
        ),
      );
      if(result.hasException){
        error=true;
      }else if(!result.hasException){
        if(result.data!["obtenerVersionesAPP"]!=null){
          appVersion=AppVersion.fromMap(result.data!["obtenerVersionesAPP"]);
        }
      }
    }catch (e){
      error=true;
    }
    map["app_version"]=appVersion;
    map["error"]=error;
    return map;
  }

}
