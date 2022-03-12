import 'package:inmobiliariaapp/data/configuration/graphql_configuration.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:inmobiliariaapp/data/repositories/usuario/administrador_repository_gql.dart';
import 'package:inmobiliariaapp/data/repositories/usuario/usuario_repository_gql.dart';
import 'package:inmobiliariaapp/domain/entities/inscripcion_agente.dart';
import 'package:inmobiliariaapp/domain/entities/membresia_pago.dart';
import 'package:inmobiliariaapp/domain/entities/solicitud_administrador.dart';
import 'package:inmobiliariaapp/domain/entities/usuario.dart';
import 'package:inmobiliariaapp/domain/entities/usuarios_inmuebles_favoritos.dart';
import 'package:inmobiliariaapp/domain/repositories/abstract_usuario.dart';
import 'package:inmobiliariaapp/ui/pages/principal/page_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsuarioRepository extends AbstractUsuario{
  @override
  Future<Map<String, dynamic>> autenticarUsuario(Usuario usuario) async{
     Map<String,dynamic> map={};
    bool completed=true;
    MembresiaPago membresiaPagoActual=MembresiaPago.vacio();
    List<MembresiaPago> membresiaPagos=[];
    List<UsuarioInmuebleBase> usuarioInmuebleBases=[];
    usuarioInmuebleBases.add(UsuarioInmuebleBase.vacio());
    usuarioInmuebleBases.add(UsuarioInmuebleBase.vacio());
    usuarioInmuebleBases.add(UsuarioInmuebleBase.vacio());
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getQueryMutationAutenticarUsuario()),
        variables: (
          usuario.toMap()
        ),
        onCompleted: (data){
          if(data!=null){
            usuario=Usuario.fromMap(data["autenticarUsuario"]);
            
            if(data["autenticarUsuario"]["usuario_inmueble_base"]!=null){
              if(data["autenticarUsuario"]["usuario_inmueble_base"].length>=2){
                usuarioInmuebleBases=[];
                DateTime fechaUltimoGuardado;
                DateTime fechaCache;
                usuarioInmuebleBases.add(UsuarioInmuebleBase.fromMap(data!["autenticarUsuario"]["usuario_inmueble_base"][0]));
                usuarioInmuebleBases.add(UsuarioInmuebleBase.fromMap(data!["autenticarUsuario"]["usuario_inmueble_base"][1]));
                usuarioInmuebleBases.add(UsuarioInmuebleBase.fromMap(data!["autenticarUsuario"]["usuario_inmueble_base"][2]));
                fechaUltimoGuardado=DateTime.parse(usuarioInmuebleBases[0].fechaUltimoGuardado);
                fechaCache=DateTime.parse(usuarioInmuebleBases[0].fechaCache);
                int diasDiferencia=(fechaCache.difference(fechaUltimoGuardado).inHours);
                if(diasDiferencia>=24){
                  registrarUsuarioInmuebleBase(usuario.id, usuarioInmuebleBases[2], usuarioInmuebleBases[0], usuarioInmuebleBases[1]);
                }
                MembresiaPago membresiaPago=MembresiaPago.vacio();
                DateTime fechaActual=DateTime.now().toUtc();
                if(data["autenticarUsuario"]["membresia_pagos"]!=null){
                  List membresiaPagosD=data["autenticarUsuario"]["membresia_pagos"];
                  membresiaPagosD.forEach((element) {
                    membresiaPago=MembresiaPago.fromMap(element);
                    if(membresiaPago.autorizacionSuperUsuario=="Aprobado"){
                      if(DateTime.parse(membresiaPago.fechaFinal).difference(fechaActual).inMinutes>0){
                        membresiaPagoActual=membresiaPago;
                      }
                    }
                    membresiaPagos.add(membresiaPago);
                  });
                // print("cantidad pagos: "+usuariosInfo.agentePagos.length.toString());
                }
              }
            }
          }
        },
        onError: (error){
          error!.graphqlErrors.forEach((element) {
            print("---"+element.message);
           });
          completed=false;
        }
      )
    );
    map["completado"]=completed;
    map["usuario"]=usuario;
    map["usuario_inmueble_bases"]=usuarioInmuebleBases;
    map["membresia_pago_actual"]=membresiaPagoActual;
    map["membresia_pagos"]=membresiaPagos;
    return map;
  }

  @override
  Future<Map<String, dynamic>> autenticarUsuarioAutomatico(
    String email,String imeiNo,
    UsuarioInmuebleBase baseVisto,
    UsuarioInmuebleBase baseDobleVisto,
    UsuarioInmuebleBase baseFavorito
  ) async{
    Map<String,dynamic> map={};
    Usuario usuario=Usuario.vacio();
    List<UsuarioInmuebleBase> usuarioInmuebleBases=[];
    List<MembresiaPago> membresiaPagos=[];
    MembresiaPago membresiaPagoActual=MembresiaPago.vacio();
    MembresiaPago membresiaPago=MembresiaPago.vacio();
  // print("$email $imeiNo");
    
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document: graphql.gql(getQueryAutenticarUsuarioAutomatico()),
        variables: {
          "email":email,
          "imei":imeiNo
        },
        cacheRereadPolicy: graphql.CacheRereadPolicy.mergeOptimistic,
        fetchPolicy: modoOffline?graphql.FetchPolicy.cacheFirst:graphql.FetchPolicy.cacheAndNetwork,
      )
    );
    if(result.hasException){
      print(result);
    }else if(!result.hasException){
      print("aqui usuario autenticado");
      usuario=Usuario.vacio();
      usuarioInmuebleBases.add(UsuarioInmuebleBase.vacio());
      usuarioInmuebleBases.add(UsuarioInmuebleBase.vacio());
      usuarioInmuebleBases.add(UsuarioInmuebleBase.vacio());
      if(result.data!["autenticarUsuarioAutomatico"]!=null){
        usuario=Usuario.fromMap(result.data!["autenticarUsuarioAutomatico"]);
        if(result.data!["autenticarUsuarioAutomatico"]["usuario_inmueble_base"]!=null){
          if(result.data!["autenticarUsuarioAutomatico"]["usuario_inmueble_base"].length>=2){
            usuarioInmuebleBases=[];
            DateTime fechaUltimoGuardado;
            DateTime fechaCache;
            usuarioInmuebleBases.add(UsuarioInmuebleBase.fromMap(result.data!["autenticarUsuarioAutomatico"]["usuario_inmueble_base"][0]));
            usuarioInmuebleBases.add(UsuarioInmuebleBase.fromMap(result.data!["autenticarUsuarioAutomatico"]["usuario_inmueble_base"][1]));
            usuarioInmuebleBases.add(UsuarioInmuebleBase.fromMap(result.data!["autenticarUsuarioAutomatico"]["usuario_inmueble_base"][2]));
            fechaUltimoGuardado=DateTime.parse(usuarioInmuebleBases[0].fechaUltimoGuardado);
            fechaCache=DateTime.parse(usuarioInmuebleBases[0].fechaCache);
            int diasDiferencia=(fechaCache.difference(fechaUltimoGuardado).inHours);
            String fechaInicio=usuarioInmuebleBases[0].fechaInicio;
            baseVisto.fechaInicio=fechaInicio;
            baseDobleVisto.fechaInicio=fechaInicio;
            baseFavorito.fechaInicio=fechaInicio;
            if(baseVisto.cantidadInmuebles>usuarioInmuebleBases[2].cantidadInmuebles){
              usuarioInmuebleBases=[];
              usuarioInmuebleBases.add(baseDobleVisto);
              usuarioInmuebleBases.add(baseFavorito);
              usuarioInmuebleBases.add(baseVisto);
            }
            if(diasDiferencia>=24){
              registrarUsuarioInmuebleBase(usuario.id, baseVisto, baseDobleVisto, baseFavorito);
            }
          }
        }
        membresiaPagos=[];
        membresiaPagoActual=MembresiaPago.vacio();
        DateTime dateTimeNow=DateTime.now().toUtc();
        if(result.data!["autenticarUsuarioAutomatico"]["membresia_pagos"]!=null){
          List membresiaPagosD=result.data!["autenticarUsuarioAutomatico"]["membresia_pagos"];
          membresiaPagosD.forEach((element) {
            membresiaPago=MembresiaPago.fromMap(element);
            if(membresiaPago.autorizacionSuperUsuario=="Aprobado"){
              if(DateTime.parse(membresiaPago.fechaFinal).difference(dateTimeNow).inMinutes>0){
                membresiaPagoActual=membresiaPago;
              }
            }
            membresiaPagos.add(membresiaPago);
          });
        }
        
      }
    }
    map["usuario"]=usuario;
    map["usuarioInmuebleBases"]=usuarioInmuebleBases;
    map["agentePagos"]=membresiaPagos;
    map["agentePagoActual"]=membresiaPagoActual;
    
    return map;
  }

  @override
  Future<Map<String, dynamic>> buscarUsuarioEmail(String email) async{
    Map<String,dynamic> map={};
    bool completed=true;
    String mensajeError="";
    Usuario usuario=Usuario.vacio();
    GraphQLConfiguration configuration=GraphQLConfiguration();
    
    graphql.GraphQLClient client=configuration.myGQLClient();
    
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationBuscarUsuarioEmail()),
        variables: (
          {
            "email":email
          }
        ),
        onCompleted: (data){
          if(data!=null){
            usuario=Usuario.fromMap(data["buscarUsuarioEmail"]);
          }
        },
        onError: (error){
          mensajeError=error!.graphqlErrors[0].message;
          completed=false;
        }
      )
    );
    print(usuario.id);
    map["completado"]=completed;
    map["mensaje_error"]=mensajeError;
    map["usuario"]=usuario;
    return map;
  }

  @override
  Future<Map<String, dynamic>> crearModificarUsuario(Usuario usuario,String actividad) async{
    Map<String,dynamic> map={};
    Map<String,dynamic> mapVariables={};
    bool completed=true;
    String mensajeError="";
    mapVariables.addAll(usuario.toMap());
    mapVariables.addAll({"actividad":actividad});
    GraphQLConfiguration configuration=GraphQLConfiguration();
    
    graphql.GraphQLClient client=configuration.myGQLClient();
    
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getQueryMutationCrearModificarUsuario()),
        variables: (
          mapVariables
        ),
        onCompleted: (data){
          if(data!=null){
            usuario=Usuario.fromMap(data["crearModificarUsuario"]);
          }
        },
        onError: (error){
          mensajeError=error!.graphqlErrors[0].message;
          completed=false;
        }
      )
    );
    map["completado"]=completed;
    map["mensaje_error"]=mensajeError;
    return map;
  }

  @override
  Future<bool> modificarUsuario(Usuario usuario) async{
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    
    graphql.GraphQLClient client=configuration.myGQLClient();
    print(usuario.toMap());
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getQueryMutationModificarUsuario()),
        variables: (
          usuario.toMap()
        ),
        onCompleted: (data){
          if(data!=null){
          }
        },
        onError: (error){
          completed=false;
          print(error);
        }
      )
    );
    return completed;
  }

  @override
  Future<Map<String, dynamic>> modificarUsuarioInmuebleBuscado(
    UsuarioInmuebleBuscado buscado,
    Map<String,dynamic> mapInmuebleBuscado
  ) async{
    UsuarioInmuebleBuscado usuarioInmuebleBuscado=UsuarioInmuebleBuscado.vacio();
    Map<String,dynamic> map={};
    bool completed=false;
    //Map<String,dynamic> mapVariables={};
    mapInmuebleBuscado.addAll({"id":buscado.id});
    mapInmuebleBuscado.addAll({"numero_telefono":buscado.numeroTelefono});
    mapInmuebleBuscado.addAll({"nombre_configuracion":buscado.nombreConfiguracion});
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationModificarInmueblesBuscados()),
        variables: (
          mapInmuebleBuscado
        ),
        onCompleted: (data){
          if(data!=null){
            usuarioInmuebleBuscado=UsuarioInmuebleBuscado.fromMap(mapInmuebleBuscado);

            completed=true;
          }
        },
        onError: (error){
          completed=false;
        }
      )
    );
    map["completed"]=completed;
    map["usuario_inmueble_buscado"]=usuarioInmuebleBuscado;
    return map;
  }

  @override
  Future<bool> modificarUsuarioInmueblesBuscadosPersonales(UsuarioInmuebleBuscado buscado) async{
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationModificarUsuarioInmueblesBuscadosPersonales()),
        variables: (
          buscado.toMap()
        ),
        onCompleted: (data){
          if(data!=null){
          }
        },
        onError: (error){
          completed=false;
        }
      )
    );
    return completed;
  }

  @override
  Future<Map<String, dynamic>> obtenerAgentesCiudad(String ciudad) async{
    Map<String,dynamic> map={};
    List agentesD=[];
    List<Usuario> agentes=[];
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document: graphql.gql(getQueryObtenerAgentesCiudad()),
        cacheRereadPolicy: graphql.CacheRereadPolicy.mergeOptimistic,
        fetchPolicy: graphql.FetchPolicy.cacheAndNetwork,
        variables: {
          "ciudad":ciudad
        }
      )
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
        if(result.data!["obtenerAgentesCiudad"]!=null){
          agentesD=result.data!["obtenerAgentesCiudad"];
          //print(inmuebles);
          agentesD.forEach((map) {
          agentes.add(Usuario.fromMap(map));
          });
        }
    }

    map["completed"]=completed;
    map["agentes"]=agentes;
    return map;
  }

  @override
  Future<Map<String, dynamic>> obtenerEmailClaveVerificaciones(String email,int clave) async{
    Map<String,dynamic> map={};
    String mensajeError="";
    bool completed=true;
    Usuario usuario=Usuario.vacio();

    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationObtenerEmailClaveVerificaciones()),
        variables: (
          {
            "email":email,
            "clave":clave
          }
        ),
        onCompleted: (data){
          if(data!=null){
            if(data["obtenerEmailClaveVerificaciones"]!=null){
              if(data["obtenerEmailClaveVerificaciones"]["usuario"]!=null){
                usuario.nombres=data["obtenerEmailClaveVerificaciones"]["usuario"]["nombres"];
                usuario.apellidos=data["obtenerEmailClaveVerificaciones"]["usuario"]["apellidos"];
              }
            }
          }
        },
        onError: (error){
          mensajeError=error!.graphqlErrors[0].message;
          completed=false;
        }
      )
    );
    map["completado"]=completed;
    map["mensaje_error"]=mensajeError;
    map["usuario"]=usuario;
    return map;
  }

  @override
  Future<Map<String, dynamic>> obtenerMembresiaPagos(String id) async{
    Map<String,dynamic> map={};
    List<MembresiaPago> membresiaPagos=[];
    List membresiaPagosD=[];
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document: graphql.gql(getQueryObtenerMembresiaPagos()),
        fetchPolicy: modoOffline?graphql.FetchPolicy.cacheFirst:graphql.FetchPolicy.cacheAndNetwork,
        variables: {
          "id":id
        }
      )
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
        if(result.data!["obtenerMembresiaPagos"]!=null){
          membresiaPagosD=result.data!["obtenerMembresiaPagos"];
          //print(inmuebles);
          membresiaPagosD.forEach((map) {
            membresiaPagos.add(MembresiaPago.fromMap(map));
          });
        }
    }

    map["completado"]=completed;
    map["membresia_pagos"]=membresiaPagos;
    return map;
  }

  @override
  Future<Map<String, dynamic>> obtenerUsuarioEmail(String email) {
    // TODO: implement obtenerUsuarioEmail
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> obtenerUsuarioInmueblesBuscados(Usuario usuario) async{
    Map<String,dynamic> map={};
    List inmueblesBuscados=[];
    List<UsuarioInmuebleBuscado> usuarioInmueblesBuscados=[];
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document: graphql.gql(getQueryObtenerUsuarioInmueblesBuscados()),
        fetchPolicy: modoOffline?graphql.FetchPolicy.cacheFirst:graphql.FetchPolicy.cacheAndNetwork,
        variables: {
          "id":usuario.id
        }
      )
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
      inmueblesBuscados=[];
        if(result.data!["obtenerUsuarioInmueblesBuscados"]!=null){
          inmueblesBuscados=result.data!["obtenerUsuarioInmueblesBuscados"];
          //print(inmuebles);
          inmueblesBuscados.forEach((map) {
          usuarioInmueblesBuscados.add(UsuarioInmuebleBuscado.fromMap(map));
          });
        }
    }

    map["completado"]=completed;
    map["usuario_inmuebles_buscados"]=usuarioInmueblesBuscados;
    return map;
  }

  @override
  Future<Map<String, dynamic>> obtenerUsuarioSolicitudes() {
    // TODO: implement obtenerUsuarioSolicitudes
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> registrarEmailClaveVerificaciones(String email,String actividad)async{
    Map<String,dynamic> map={};
    String mensajeError="";
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationRegistrarEmailClaveVerificaciones()),
        variables: (
          {
            "email":email,
            "actividad":actividad
          }
        ),
        onCompleted: (data){
          if(data!=null){
          }
        },
        onError: (error){
          mensajeError=error!.graphqlErrors[0].message;
          completed=false;
        }
      )
    );
    map["completado"]=completed;
    map["mensaje_error"]=mensajeError;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registrarMembresiaPago(MembresiaPago membresiaPago) async{
    Map<String,dynamic> map={};
    bool completed=true;
    String mensajeError="";
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationRegistrarMembresiaPago()),
        variables: (
          membresiaPago.toMap()
        ),
        onCompleted: (data){
          if(data!=null){
            if(data!["registrarMembresiaPago"]!=null){
              membresiaPago=MembresiaPago.fromMap(data["registrarMembresiaPago"]);
            }
          }
        },
        onError: (error){
          mensajeError=error!.graphqlErrors[0].message;
          completed=false;
        }
      )
    );
    map["completado"]=completed;
    map["membresia_pago"]=mensajeError;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registrarSolicitudInscripcionAgente(InscripcionAgente inscripcionAgente) async{
    Map<String,dynamic> map={};
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationRegistrarSolicitudInscripcionAgente()),
        variables: (
          inscripcionAgente.toMap()
        ),
        onCompleted: (data){
          if(data!=null){
            if(data!["registrarSolicitudInscripcionAgente"]!=null){
              inscripcionAgente.id=data!["registrarSolicitudInscripcionAgente"]["id"];
              inscripcionAgente.fechaSolicitud=data!["registrarSolicitudInscripcionAgente"]["fecha_solicitud"];
            }
          }
        },
        onError: (error){
          completed=false;
        }
      )
    );
    map["completed"]=completed;
    map["inscripcion_agente"]=inscripcionAgente;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registrarUsuarioInmuebleBuscado(
    String nombreConfiguracion,
    String numeroTelefono,
    Usuario usuario,
    Map<String,dynamic> mapInmuebleBuscado
  ) async{
    UsuarioInmuebleBuscado usuarioInmuebleBuscado=UsuarioInmuebleBuscado.vacio();
    Map<String,dynamic> map={};
    bool completed=false;
    mapInmuebleBuscado.addAll({"id":usuario.id});
    mapInmuebleBuscado.addAll({"numero_telefono":numeroTelefono});
    mapInmuebleBuscado.addAll({"nombre_configuracion":nombreConfiguracion});
    //print(mapVariables);
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutatioRegistrarUsuarioInmuebleBuscado()),
        variables: (
          mapInmuebleBuscado
        ),
        onCompleted: (data){
          if(data!=null){
            usuarioInmuebleBuscado=UsuarioInmuebleBuscado.fromMap(data["registrarUsuarioInmuebleBuscado"]);
            completed=true;
          }
        },
        onError: (error){
          completed=false;
        }
      )
    );
    map["completed"]=completed;
    map["usuario_inmueble_buscado"]=usuarioInmuebleBuscado;
    return map;
  }

  @override
  Future<Map<String, dynamic>> responderSolicitudUsuarioCalificacion(String id,int calificacion) async{
    Map<String,dynamic> map={};
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationResponderSolicitudUsuarioCalificacion()),
        variables: (
          {
            "id_solicitud":id,
            "calificacion":calificacion
          }
        ),
        onCompleted: (data){
          if(data!=null){
          }
        },
        onError: (error){
          completado=false;
        }
      )
    );
    map["completado"]=completado;
    return map;
  }

  @override
  Future<bool> registrarUsuarioInmuebleBase(String idUsuario, UsuarioInmuebleBase baseVisto, UsuarioInmuebleBase baseDobleVisto, UsuarioInmuebleBase baseFavorito) async{
    bool respuesta=false;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationActualizarInmuebleBase(),

      ),
      cacheRereadPolicy: graphql.CacheRereadPolicy.mergeOptimistic,
        fetchPolicy: modoOffline?graphql.FetchPolicy.cacheFirst:graphql.FetchPolicy.cacheAndNetwork,
      variables: (
        baseVisto.getMapRegistroInmuebleBase(idUsuario, baseVisto,baseDobleVisto,baseFavorito)
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

  @override
  Future<void> registrarUsuarioShared(Usuario usuario, Future<SharedPreferences> _prefs) async{
    final SharedPreferences prefs=await _prefs;
    await prefs.setString("id", usuario.id);
    await prefs.setString("nombres", usuario.nombres);
    await prefs.setString("apellidos", usuario.apellidos);
    await prefs.setString("email", usuario.correo);
  }

  
}