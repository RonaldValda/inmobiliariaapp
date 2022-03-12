import 'package:inmobiliariaapp/auxiliares/version_app.dart';
import 'package:inmobiliariaapp/data/configuration/graphql_configuration.dart';
import 'package:inmobiliariaapp/data/repositories/generales/generales_repository_gql.dart';
import 'package:inmobiliariaapp/domain/entities/generales.dart';
import 'package:inmobiliariaapp/domain/repositories/abstract_generales.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:inmobiliariaapp/ui/pages/principal/page_home.dart';
class GeneralesRepository extends AbstractGeneralesRepository{
  @override
  Future<bool> eliminarCiudad(String idCiudad) async{
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationEliminarCiudad()),
        variables: ({"id_ciudad":idCiudad}),
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
  Future<bool> eliminarDepartamento(String idDepartamento) async{
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationEliminarDepartamento()),
        variables: ({"id_departamento":idDepartamento}),
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
  Future<bool> eliminarZona(String idZona) async{
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationEliminarZona()),
        variables: ({"id_zona":idZona}),
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
  Future<bool> modificarCiudad(String idCiudad, String nombreCiudad) async{
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationModificarCiudad()),
        variables: ({
          "id_ciudad":idCiudad,
          "nombre_ciudad":nombreCiudad
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
  Future<bool> modificarDepartamento(String idDepartamento, String nombreDepartamento) async{
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationModificarDepartamento()),
        variables: ({
          "id_departamento":idDepartamento,
          "nombre_departamento":nombreDepartamento
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
  Future<bool> modificarZona(Zona zona) async{
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationModificarZona()),
        variables: ({
        "id_zona":zona.id,
          "nombre_zona":zona.nombreZona,
          "coordenadas":[zona.area[0][0],zona.area[0][1],zona.area[1][0],zona.area[1][1]],
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
  Future<Map<String, dynamic>> obtenerCiudades(String idDepartamento) async{
    Map<String,dynamic> map={};
    List<Ciudad> ciudades=[];
    List ciudadesD=[];
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(getQueryObtenerCiudades()),
        variables: ({"id_departamento":idDepartamento}),
        fetchPolicy: graphql.FetchPolicy.noCache,
      ),
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
        if(result.data!["obtenerCiudades"]!=null){
          ciudadesD=result.data!["obtenerCiudades"];
          ciudadesD.forEach((element) {
            ciudades.add(Ciudad.fromMap(element));
          });
      }
    }

    map["completed"]=completed;
    map["ciudades"]=ciudades;
    return map;
  }

  @override
  Future<Map<String, dynamic>> obtenerDepartamentos() async{
    Map<String,dynamic> map={};
    List<Departamento> departamentos=[];
    List departamentosD=[];
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(getQueryObtenerDepartamentos()),
        
        fetchPolicy: graphql.FetchPolicy.noCache,
      ),
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
        if(result.data!["obtenerDepartamentos"]!=null){
          departamentosD=result.data!["obtenerDepartamentos"];
          departamentosD.forEach((element) {
            departamentos.add(Departamento.fromMap(element));
          });
      }
    }

    map["completed"]=completed;
    map["departamentos"]=departamentos;
    return map;
  }

  @override
  Future<Map<String, dynamic>> obtenerGeneralesLugares() async{
    Map<String,dynamic> map={};
    List<Ciudad> ciudades=[];
    List<Zona> zonas=[];
    List ciudadesD=[];
    List zonasD=[];
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(getQueryObtenerGeneralesLugares()),
        fetchPolicy:modoOffline?graphql.FetchPolicy.cacheFirst: graphql.FetchPolicy.cacheAndNetwork,
      ),
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
        if(result.data!["obtenerGeneralesLugares"]!=null){
          ciudadesD=result.data!["obtenerGeneralesLugares"]["ciudades"];
          ciudadesD.forEach((element) {
            ciudades.add(Ciudad.fromMap(element));
          });
          zonasD=result.data!["obtenerGeneralesLugares"]["zonas"];
          zonasD.forEach((element) {
            zonas.add(Zona.fromMap(element));
          });
      }
    }

    map["completado"]=completed;
    map["ciudades"]=ciudades;
    map["zonas"]=zonas;
    return map;
  }

  @override
  Future<Map<String, dynamic>> obtenerZonas(String idCiudad) async{
    Map<String,dynamic> map={};
    List<Zona> zonas=[];
    List zonasD=[];
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(getQueryObtenerZonas()),
        variables: ({"id_ciudad":idCiudad}),
        fetchPolicy: graphql.FetchPolicy.noCache,
      ),
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
        if(result.data!["obtenerZonas"]!=null){
          zonasD=result.data!["obtenerZonas"];
          zonasD.forEach((element) {
            zonas.add(Zona.fromMap(element));
          });
      }
    }

    map["completed"]=completed;
    map["zonas"]=zonas;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registrarCiudad(String idDepartamento, String nombreCiudad) async{
    bool completed=true;
    Ciudad ciudad=Ciudad.vacio();
    Map<String,dynamic> map={};
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationRegistrarCiudad()),
        variables: ({
          "id_departamento":idDepartamento,
          "nombre_ciudad":nombreCiudad
        }),
        onCompleted: (dynamic data){
          if(data!=null){
            if(data["registrarCiudad"]!=null){
              ciudad=Ciudad.fromMap(data["registrarCiudad"]);
            }
          }
        },
        onError: (error){
          completed=false;
        }
    ));
    map["completed"]=completed;
    map["ciudad"]=ciudad;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registrarDepartamento(String nombreDepartamento) async{
    bool completed=true;
    Departamento departamento=Departamento.vacio();
    Map<String,dynamic> map={};
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationRegistrarDepartamento()),
        variables: ({"nombre_departamento":nombreDepartamento}),
        onCompleted: (dynamic data){
          if(data!=null){
            if(data["registrarDepartamento"]!=null){
              departamento=Departamento.fromMap(data["registrarDepartamento"]);
            }
          }
        },
        onError: (error){
          completed=false;
        }
    ));
    map["completed"]=completed;
    map["departamento"]=departamento;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registrarZona(String idCiudad, Zona zona) async{
     bool completed=true;
    Zona zonar=Zona.vacio();
    Map<String,dynamic> map={};
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationRegistrarZona()),
        variables: ({
          "id_ciudad":idCiudad,
          "nombre_zona":zona.nombreZona,
          "coordenadas":[zona.area[0][0],zona.area[0][1],zona.area[1][0],zona.area[1][1]],
        }),
        onCompleted: (dynamic data){
          if(data!=null){
            if(data["registrarZona"]!=null){
              zonar=Zona.fromMap(data["registrarZona"]);
            }
          }
        },
        onError: (error){
          completed=false;
        }
    ));
    map["completed"]=completed;
    map["zona"]=zonar;
    return map;
  }

  @override
  Future<Map<String, dynamic>> obtenerVersionApp() async{
    Map<String,dynamic> map={};
    VersionAPP versionAPP=VersionAPP.vacio();
    bool error=false;
    try{
      GraphQLConfiguration configuration=GraphQLConfiguration();
      graphql.GraphQLClient client=configuration.myGQLClient();
      graphql.QueryResult result=await client
      .query(
        graphql.QueryOptions(
          document: graphql.gql(getQueryObtenerVersionesAPP()),
          cacheRereadPolicy: graphql.CacheRereadPolicy.mergeOptimistic,
          fetchPolicy: graphql.FetchPolicy.cacheAndNetwork,
        ),
      );
      if(result.hasException){
        error=true;
      }else if(!result.hasException){
        if(result.data!["obtenerVersionesAPP"]!=null){
          versionAPP=VersionAPP.fromMap(result.data!["obtenerVersionesAPP"]);
        }
      }
    }catch (e){
      error=true;
    }
    map["versionApp"]=versionAPP;
    map["error"]=error;
    return map;
  }

}
