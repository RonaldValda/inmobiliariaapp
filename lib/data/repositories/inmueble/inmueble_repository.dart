import 'package:inmobiliariaapp/data/configuration/graphql_configuration.dart';
import 'package:inmobiliariaapp/data/repositories/inmueble/inmueble_repository_gql.dart';
import 'package:inmobiliariaapp/data/repositories/usuario/administrador_repository_gql.dart';
import 'package:inmobiliariaapp/data/repositories/usuario/super_usuario_repository_gql.dart';
import 'package:inmobiliariaapp/data/repositories/venta/inmueble_venta_repository_gql.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/domain/entities/publicidad.dart';
import 'package:inmobiliariaapp/domain/entities/usuario.dart';
import 'package:inmobiliariaapp/domain/repositories/abstract_inmueble.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:inmobiliariaapp/ui/pages/principal/page_home.dart';

class InmuebleRepository extends AbstractInmuebleRepository{
  @override
  Future<Map<String, dynamic>> listarInmuebles(Usuario usuario, String tipoSesion, String ciudad) async{
    Map<String,dynamic> map={};
    List inmuebles=[];
    List<InmuebleTotal> inmueblesTotal=[];
    List<Publicidad> publicidades=[];
    List publicidesD=[];
    //print("usuario id ${usuario.usuario.id}");
    bool error=false;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(

      graphql.QueryOptions(
        document: graphql.gql(
          tipoSesion=="Comprar"||tipoSesion=="Observar"?getQuery()
          :
          (tipoSesion=="Vender"? getQueryObtenerMisInmueblesVenta()
          :tipoSesion=="Administrar"?getQueryObtenerAdministradorInmueble()
          :getQueryObtenerAdministradorInmuebleSuperUsuario())
        ),
        
        cacheRereadPolicy: graphql.CacheRereadPolicy.mergeOptimistic,
        fetchPolicy: modoOffline?graphql.FetchPolicy.cacheFirst:graphql.FetchPolicy.cacheAndNetwork,
        
        //pollInterval: Duration(milliseconds: 500),
        //cacheRereadPolicy: graphql.CacheRereadPolicy.ignoreOptimisitic,
        variables: {
          "ciudad":ciudad,
          "id_usuario":usuario.id,
          "id":usuario.id
        }
      )
    );
    if(result.hasException){
      print("Error $result");
    }else if(!result.hasException){
      inmueblesTotal=[];
      if(tipoSesion=="Comprar"||tipoSesion=="Observar"){
        
        if(result.data!["obtenerInmueblesSimpleFiltro"]!=null&&result.data!["obtenerInmueblesSimpleFiltro"].length>0){
          if(result.data!["obtenerInmueblesSimpleFiltro"]["inmuebles"]!=null){
            inmuebles=result.data!["obtenerInmueblesSimpleFiltro"]["inmuebles"];
            inmuebles.forEach((inmueble) {
              inmueblesTotal.add(InmuebleTotal.fromMap(tipoSesion, inmueble));
            });
          }
          if(result.data!["obtenerInmueblesSimpleFiltro"]["publicidades"]!=null){
            publicidesD=result.data!["obtenerInmueblesSimpleFiltro"]["publicidades"];
            publicidesD.forEach((element) {
              //print(element);
              publicidades.add(Publicidad.fromMap(element));
            });
          }
        }
      }else if(tipoSesion=="Administrar"){
        if(result.data!["obtenerAdministradorInmueble"]!=null){
          inmuebles=result.data!["obtenerAdministradorInmueble"];
          inmuebles.forEach((inmueble) {
            inmueblesTotal.add(InmuebleTotal.fromMap(tipoSesion, inmueble));
          });
        }
      }else if(tipoSesion=="Vender"){
        if(result.data!["obtenerMisInmueblesVenta"]!=null){
          inmuebles=result.data!["obtenerMisInmueblesVenta"];
          inmuebles.forEach((inmueble) {
            inmueblesTotal.add(InmuebleTotal.fromMap(tipoSesion, inmueble));
          });
        }
      }else if(tipoSesion=="Supervisar"){
        if(result.data!["obtenerAdministradorInmuebleSuperUsuario"]!=null){
          inmuebles=result.data!["obtenerAdministradorInmuebleSuperUsuario"];
          inmuebles.forEach((inmueble) {
            inmueblesTotal.add(InmuebleTotal.fromMap(tipoSesion, inmueble));
          });
        }
      }
    }

    map["error"]=error;
    map["inmuebles_total"]=inmueblesTotal;
    map["publicidades"]=publicidades;
    return map;
  }

  @override
  Future<bool> registrarFavoritos(Usuario usuario, InmuebleTotal inmuebleTotal) async{
    bool respuesta=false;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    
    await client
    .mutate(
      
      graphql.MutationOptions(
        document: graphql.gql(getQueryMutationRegistrarFavorito(),
      
      ),
      update: (cache,data){
        return cache;
      },
      variables: (
        getMapRegistroFavoritos(
          usuario.id, 
          inmuebleTotal.getInmueble.id, 
          inmuebleTotal.getUsuarioFavorito)
      ),
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