import 'package:inmobiliariaapp/data/configuration/graphql_configuration.dart';
import 'package:inmobiliariaapp/data/repositories/usuario/super_usuario_repository_gql.dart';
import 'package:inmobiliariaapp/domain/entities/solicitud_administrador.dart';
import 'package:inmobiliariaapp/domain/entities/usuario.dart';
import 'package:inmobiliariaapp/domain/entities/membresia_pago.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_reportado.dart';
import 'package:inmobiliariaapp/domain/entities/usuarios_inmuebles_favoritos.dart';
import 'package:inmobiliariaapp/domain/repositories/abstract_usuario.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;

class SuperUsuarioRepository extends AbstractSuperUsuarioRepository{
  @override
  Future<Map<String, dynamic>> asignarAdministradorZona(String idAdministrador, String idZona) async{
    bool completed=true;
    Map<String,dynamic> map={};
    String id="";
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationAsignarAdministradorZona(),
      
      ),
      variables: ({"id_administrador":idAdministrador,"id_zona":idZona}),
      onCompleted: (dynamic data){
        if(data!=null){
          if(data["asignarAdministradorZona"]!=null){
            id=data["asignarAdministradorZona"];
          }
        }
      },
      onError: (error){
        completed=false;
      }
    ));
    map["completed"]=completed;
    map["id"]=id;
    return map;
  }

  @override
  Future<bool> habilitarAdministradores(String idUsuario) async{
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationHabilitarAdministrador(),
      
      ),
      variables: ({"id_usuario":idUsuario}),
      onCompleted: (dynamic data){
        if(data!=null){
          if(data["habilitarAdministrador"]!=null){
            
          }
        }
      },
      onError: (error){
        completed=false;
      }
    ));
    return completed;
  }

  @override
  Future<bool> inhabilitarAdministradores(String idUsuario) async{
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationInhabilitarAdministrador(),
      
      ),
      variables: ({"id_usuario":idUsuario}),
      onCompleted: (dynamic data){
        if(data!=null){
          if(data["inhabilitarAdministrador"]!=null){
            
          }
        }
      },
      onError: (error){
        completed=false;
      }
    ));
    return completed;
  }

  @override
  Future<Map<String, dynamic>> obtenerAdministradores() async{
   Map<String,dynamic> map={};
    List<Usuario> administradores=[];
    List administradoresD=[];
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(getQueryObtenerAdministradores()),
        fetchPolicy: graphql.FetchPolicy.noCache,
      ),
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
        if(result.data!["obtenerAdministradores"]!=null){
          administradoresD=result.data!["obtenerAdministradores"];
          administradoresD.forEach((element) {
            administradores.add(Usuario.fromMap(element));
          });
      }
    }

    map["completed"]=completed;
    map["administradores"]=administradores;
    return map;
  }

  @override
  Future<Map<String, dynamic>> obtenerNotificacionesExisteSuperUsuario(Usuario usuario) async{
    Map<String,dynamic> map={};
    bool completed=true;
    bool existeNotificacion=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(getQueryObtenerNotificacionesExisteSuperUsuario()),
        variables: ({
          "id":usuario.id
        }),
        fetchPolicy: graphql.FetchPolicy.noCache,
      ),
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
        if(result.data!["obtenerNotificacionesExisteSuperUsuario"]!=null){
          existeNotificacion=result.data!["obtenerNotificacionesExisteSuperUsuario"];
      }
    }

    map["completed"]=completed;
    map["existe_notificacion"]=existeNotificacion;
    return map;
  }

  @override
  Future<Map<String, dynamic>> obtenerNotificacionesSuperUsuario(Usuario usuario, String tipoSesion) async{
    Map<String,dynamic> map={};
    List<InmuebleReportado> inmueblesReportados=[];
    List<InmuebleQueja> inmueblesQuejas=[];
    List<MembresiaPago> membresiasPagos=[];
    List reportes=[];
    List quejas=[];
    List membresias=[];
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(getQueryObtenerNotificacionesSuperUsuario()),
        variables: ({
          "id":usuario.id
        }),
        fetchPolicy: graphql.FetchPolicy.noCache,
      ),
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
        if(result.data!["obtenerNotificacionesSuperUsuario"]!=null){
          reportes=result.data!["obtenerNotificacionesSuperUsuario"]["reportar_inmueble"];
          reportes.forEach((element) {
            inmueblesReportados.add(InmuebleReportado.fromMap(element, tipoSesion));
          });
          quejas=result.data!["obtenerNotificacionesSuperUsuario"]["inmuebles_quejas"];
          quejas.forEach((element) {
            inmueblesQuejas.add(InmuebleQueja.fromMap(element));
          });
          membresias=result.data!["obtenerNotificacionesSuperUsuario"]["membresias_pagos"];
          membresias.forEach((element) {
            membresiasPagos.add(MembresiaPago.fromMap(element));
          });
      }
    }

    map["completed"]=completed;
    map["inmuebles_reportados"]=inmueblesReportados;
    map["inmuebles_quejas"]=inmueblesQuejas;
    map["membresias_pagos"]=membresiasPagos;
    return map;
  }

  @override
  Future<Map<String, dynamic>> obtenerUsuariosInmueblesBuscadosCiudad(String ciudad) async{
     Map<String,dynamic> map={};
    List inmueblesBuscados=[];
    List<int> superficiesTerreno=[0,0,150,200,250,300];
    List<int> superficiesConstruccion=[0,0,100,200,300,400];
    List<int> antiguedadConstruccion=[0,0,10,20,30];
    List<int> tamanioFrente=[0,0,5,10,15,20];
    double cantidadDatos=0;
    Map<String,dynamic> mapSuperficiesTerreno={
      "Cualquiera":0,
      "0-149":0,
      "150-199":0,
      "200-249":0,
      "250-299":0,
      "300 a más":0
    };
    Map<String,dynamic> mapSuperficiesConstruccion={
      "Cualquiera":0,
      "0-99":0,
      "100-199":0,
      "200-299":0,
      "300-399":0,
      "400 a más":0
    };
    Map<String,dynamic> mapMetrosFrente={
      "Cualquiera":0,
      "0-4":0,
      "5-9":0,
      "10-14":0,
      "15-19":0,
      "20 a más":0
    };
    Map<String,dynamic> mapAntiguedadConstruccion={
      "Cualquiera":0,
      "0-9":0,
      "10-19":0,
      "20-29":0,
      "30 a más":0
    };
    Map<String,dynamic> mapMascotasPermitidasRequerido={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapSinHipoteca={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapConstruccionEstrenar={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapMaterialesPrimera={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapProyectoPreventa={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapInmuebleCompartido={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapNumeroDuenios={
      "1":0,
      "2":0,
      "3":0,
      "4":0,
      "5+":0
    };
    Map<String,dynamic> mapServiciosBasicos={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapGasDomiciliario={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapWifi={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapMedidorIndependiente={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapTermotanque={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapCalleAsfaltada={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapTransporte={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapPreparadoDiscapacidad={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapPapelesOrden={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapHabilitadoCredito={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapPlantas={
      "Cualquiera":0,
      "1":0,
      "2":0,
      "3":0,
      "4":0,
      "5+":0
    };
    Map<String,dynamic> mapAmbientes={
      "Cualquiera":0,
      "1":0,
      "2":0,
      "3":0,
      "4":0,
      "5+":0
    };
    Map<String,dynamic> mapDormitorios={
      "Cualquiera":0,
      "1":0,
      "2":0,
      "3":0,
      "4":0,
      "5+":0
    };
    Map<String,dynamic> mapBanios={
      "Cualquiera":0,
      "1":0,
      "2":0,
      "3":0,
      "4":0,
      "5+":0
    };
    Map<String,dynamic> mapGaraje={
      "Cualquiera":0,
      "1":0,
      "2":0,
      "3":0,
      "4":0,
      "5+":0
    };
    Map<String,dynamic> mapAmoblado={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapLavanderia={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapCuartoLavado={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapChurrasquero={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapAzotea={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapCondominioPrivado={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapCancha={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapPiscina={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapSauna={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapJacuzzi={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapEstudio={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapJardin={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapPortonElectrico={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapAireAcondicionado={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapCalefaccion={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapAscensor={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapDeposito={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapSotano={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapBalcon={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapTienda={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapAmuralladoTerreno={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapIglesia={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapParqueInfantil={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapEscuela={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapUniversidad={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapPlazuela={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapModuloPolicial={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapSaunaPiscinaPublica={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapGymPublico={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapCentroDeportivo={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapPuestoSalud={
      "Requerido":0,
      "No requerido":0
    };
    Map<String,dynamic> mapZonaComercial={
      "Requerido":0,
      "No requerido":0
    };
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document: graphql.gql(getQueryObtenerUsuariosInmueblesBuscadosCiudad()),
        fetchPolicy: graphql.FetchPolicy.noCache,
        variables: {
          "ciudad":ciudad
        }
      )
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
      inmueblesBuscados=[];
        if(result.data!["obtenerUsuariosInmuebleBuscadosCiudad"]!=null){
          inmueblesBuscados=result.data!["obtenerUsuariosInmuebleBuscadosCiudad"];
          //print(inmuebles);
          inmueblesBuscados.forEach((map) {
            cantidadDatos=cantidadDatos+1;
            UsuarioInmuebleBuscado buscado=UsuarioInmuebleBuscado.fromMap(map);
            String seleccionado=getValorSeleccionado(superficiesTerreno, buscado.superficieTerrenoMin, buscado.superficieTerrenoMax);
            mapSuperficiesTerreno[seleccionado]=mapSuperficiesTerreno[seleccionado]+1;
            seleccionado=getValorSeleccionado(superficiesConstruccion, buscado.superficieConstruccionMin, buscado.superficieConstruccionMax);
            mapSuperficiesConstruccion[seleccionado]=mapSuperficiesConstruccion[seleccionado]+1;
            seleccionado=getValorSeleccionado(tamanioFrente, buscado.tamanioFrenteMin, buscado.tamanioFrenteMax);
            mapMetrosFrente[seleccionado]=mapMetrosFrente[seleccionado]+1;
            seleccionado=getValorSeleccionado(antiguedadConstruccion, buscado.antiguedadConstruccionMin, buscado.antiguedadConstruccionMax);
            mapAntiguedadConstruccion[seleccionado]=mapAntiguedadConstruccion[seleccionado]+1;
            if(buscado.mascotasPermitidas)mapMascotasPermitidasRequerido["Requerido"]++;
            if(buscado.sinHipoteca)mapSinHipoteca["Requerido"]++;
            if(buscado.construccionEstrenar)mapConstruccionEstrenar["Requerido"]++;
            if(buscado.materialesPrimera)mapMaterialesPrimera["Requerido"]++;
            if(buscado.proyectoPreventa)mapProyectoPreventa["Requerido"]++;
            if(buscado.inmuebleCompartido)mapProyectoPreventa["Requerido"]++;
            if(buscado.numeroDuenios>=5){
              mapNumeroDuenios["5+"]++;
            }else{
              mapNumeroDuenios[buscado.numeroDuenios.toString()]++;
            }
            if(buscado.serviciosBasicos) mapServiciosBasicos["Requerido"]++;
            if(buscado.gasDomiciliario) mapGasDomiciliario["Requerido"]++;
            if(buscado.wifi) mapWifi["Requerido"]++;
            if(buscado.medidorIndependiente) mapMedidorIndependiente["Requerido"]++;
            if(buscado.termotanque) mapTermotanque["Requerido"]++;
            if(buscado.calleAsfaltada) mapCalleAsfaltada["Requerido"]++;
            if(buscado.transporte) mapTransporte["Requerido"]++;
            if(buscado.preparadoDiscapacidad) mapPreparadoDiscapacidad["Requerido"]++;
            if(buscado.papelesOrden) mapPapelesOrden["Requerido"]++;
            if(buscado.habilitadoCredito) mapHabilitadoCredito["habilitado_credito"]++;
            if(buscado.plantas>=5){
              mapPlantas["5+"]++;
            }else if(buscado.plantas==0){
                mapPlantas["Cualquiera"]++;
            }else{
              mapPlantas[buscado.plantas.toString()]++;
            }
            if(buscado.ambientes>=5){
              mapAmbientes["5+"]++;
            }else if(buscado.ambientes==0){
                mapAmbientes["Cualquiera"]++;
            }else{
              mapAmbientes[buscado.ambientes.toString()]++;
            }
            if(buscado.dormitorios>=5){
              mapDormitorios["5+"]++;
            }else if(buscado.dormitorios==0){
                mapDormitorios["Cualquiera"]++;
            }else{
              mapDormitorios[buscado.dormitorios.toString()]++;
            }
            if(buscado.banios>=5){
              mapBanios["5+"]++;
            }else if(buscado.banios==0){
                mapBanios["Cualquiera"]++;
            }else{
              mapBanios[buscado.banios.toString()]++;
            }
            if(buscado.garaje>=5){
              mapGaraje["5+"]++;
            }else if(buscado.garaje==0){
                mapGaraje["Cualquiera"]++;
            }else{
              mapGaraje[buscado.garaje.toString()]++;
            }
            if(buscado.amoblado)mapAmoblado["Requerido"]++;
            if(buscado.lavanderia)mapLavanderia["Requerido"]++;
            if(buscado.cuartoLavado)mapCuartoLavado["Requerido"]++;
            if(buscado.churrasquero)mapChurrasquero["Requerido"]++;
            if(buscado.azotea)mapAzotea["Requerido"]++;
            if(buscado.condominioPrivado)mapCondominioPrivado["Requerido"]++;
            if(buscado.cancha)mapCancha["Requerido"]++;
            if(buscado.piscina)mapPiscina["Requerido"]++;
            if(buscado.sauna)mapSauna["Requerido"]++;
            if(buscado.jacuzzi)mapJacuzzi["Requerido"]++;
            if(buscado.estudio)mapEstudio["Requerido"]++;
            if(buscado.jardin)mapJardin["Requerido"]++;
            if(buscado.portonElectrico)mapPortonElectrico["Requerido"]++;
            if(buscado.aireAcondicionado)mapAireAcondicionado["Requerido"]++;
            if(buscado.calefaccion)mapCalefaccion["Requerido"]++;
            if(buscado.ascensor)mapAscensor["Requerido"]++;
            if(buscado.deposito)mapDeposito["Requerido"]++;
            if(buscado.sotano)mapSotano["Requerido"]++;
            if(buscado.balcon)mapBalcon["Requerido"]++;
            if(buscado.tienda)mapTienda["Requerido"]++;
            if(buscado.amuralladoTerreno)mapAmuralladoTerreno["Requerido"]++;
            if(buscado.iglesia)mapIglesia["Requerido"]++;
            if(buscado.parqueInfantil)mapParqueInfantil["Requerido"]++;
            if(buscado.escuela)mapEscuela["Requerido"]++;
            if(buscado.universidad)mapUniversidad["Requerido"]++;
            if(buscado.plazuela)mapPlazuela["Requerido"]++;
            if(buscado.moduloPolicial)mapModuloPolicial["Requerido"]++;
            if(buscado.saunaPiscinaPublica)mapSaunaPiscinaPublica["Requerido"]++;
            if(buscado.gymPublico)mapGymPublico["Requerido"]++;
            if(buscado.centroDeportivo)mapCentroDeportivo["Requerido"]++;
            if(buscado.puestoSalud)mapPuestoSalud["Requerido"]++;
            if(buscado.zonaComercial)mapZonaComercial["Requerido"]++;
          });
        }
    }
    mapMascotasPermitidasRequerido["No requerido"]=cantidadDatos.toInt()-mapMascotasPermitidasRequerido["Requerido"];
    mapSinHipoteca["No requerido"]=cantidadDatos.toInt()-mapSinHipoteca["Requerido"];
    mapConstruccionEstrenar["No requerido"]=cantidadDatos.toInt()-mapConstruccionEstrenar["Requerido"];
    mapMaterialesPrimera["No requerido"]=cantidadDatos.toInt()-mapMaterialesPrimera["Requerido"];
    mapProyectoPreventa["No requerido"]=cantidadDatos.toInt()-mapProyectoPreventa["Requerido"];
    mapInmuebleCompartido["No requerido"]=cantidadDatos.toInt()-mapInmuebleCompartido["Requerido"];
    mapServiciosBasicos["No requerido"]=cantidadDatos.toInt()-mapServiciosBasicos["Requerido"];
    mapGasDomiciliario["No requerido"]=cantidadDatos.toInt()-mapGasDomiciliario["Requerido"];
    mapWifi["No requerido"]=cantidadDatos.toInt()-mapWifi["Requerido"];
    mapMedidorIndependiente["No requerido"]=cantidadDatos.toInt()-mapMedidorIndependiente["Requerido"];
    mapTermotanque["No requerido"]=cantidadDatos.toInt()-mapTermotanque["Requerido"];
    mapCalleAsfaltada["No requerido"]=cantidadDatos.toInt()-mapCalleAsfaltada["Requerido"];
    mapTransporte["No requerido"]=cantidadDatos.toInt()-mapTransporte["Requerido"];
    mapPreparadoDiscapacidad["No requerido"]=cantidadDatos.toInt()-mapTransporte["Requerido"];
    mapPapelesOrden["No requerido"]=cantidadDatos.toInt()-mapPapelesOrden["Requerido"];
    mapHabilitadoCredito["No requerido"]=cantidadDatos.toInt()-mapHabilitadoCredito["Requerido"];
    mapAmoblado["No requerido"]=cantidadDatos.toInt()-mapAmoblado["Requerido"];
    mapLavanderia["No requerido"]=cantidadDatos.toInt()-mapLavanderia["Requerido"];
    mapCuartoLavado["No requerido"]=cantidadDatos.toInt()-mapCuartoLavado["Requerido"];
    mapChurrasquero["No requerido"]=cantidadDatos.toInt()-mapChurrasquero["Requerido"];
    mapAzotea["No requerido"]=cantidadDatos.toInt()-mapAzotea["Requerido"];
    mapCondominioPrivado["No requerido"]=cantidadDatos.toInt()-mapCondominioPrivado["Requerido"];
    mapCancha["No requerido"]=cantidadDatos.toInt()-mapCancha["Requerido"];
    mapPiscina["No requerido"]=cantidadDatos.toInt()-mapPiscina["Requerido"];
    mapSauna["No requerido"]=cantidadDatos.toInt()-mapSauna["Requerido"];
    mapJacuzzi["No requerido"]=cantidadDatos.toInt()-mapJacuzzi["Requerido"];
    mapEstudio["No requerido"]=cantidadDatos.toInt()-mapEstudio["Requerido"];
    mapJardin["No requerido"]=cantidadDatos.toInt()-mapJardin["Requerido"];
    mapPortonElectrico["No requerido"]=cantidadDatos.toInt()-mapPortonElectrico["Requerido"];
    mapAireAcondicionado["No requerido"]=cantidadDatos.toInt()-mapAireAcondicionado["Requerido"];
    mapCalefaccion["No requerido"]=cantidadDatos.toInt()-mapCalefaccion["Requerido"];
    mapAscensor["No requerido"]=cantidadDatos.toInt()-mapAscensor["Requerido"];
    mapDeposito["No requerido"]=cantidadDatos.toInt()-mapDeposito["Requerido"];
    mapSotano["No requerido"]=cantidadDatos.toInt()-mapSotano["Requerido"];
    mapBalcon["No requerido"]=cantidadDatos.toInt()-mapBalcon["Requerido"];
    mapTienda["No requerido"]=cantidadDatos.toInt()-mapTienda["Requerido"];
    mapAmuralladoTerreno["No requerido"]=cantidadDatos.toInt()-mapAmuralladoTerreno["Requerido"];
    mapIglesia["No requerido"]=cantidadDatos.toInt()-mapIglesia["Requerido"];
    mapParqueInfantil["No requerido"]=cantidadDatos.toInt()-mapParqueInfantil["Requerido"];
    mapEscuela["No requerido"]=cantidadDatos.toInt()-mapEscuela["Requerido"];
    mapUniversidad["No requerido"]=cantidadDatos.toInt()-mapUniversidad["Requerido"];
    mapPlazuela["No requerido"]=cantidadDatos.toInt()-mapPlazuela["Requerido"];
    mapModuloPolicial["No requerido"]=cantidadDatos.toInt()-mapModuloPolicial["Requerido"];
    mapSaunaPiscinaPublica["No requerido"]=cantidadDatos.toInt()-mapSaunaPiscinaPublica["Requerido"];
    mapGymPublico["No requerido"]=cantidadDatos.toInt()-mapGymPublico["Requerido"];
    mapCentroDeportivo["No requerido"]=cantidadDatos.toInt()-mapCentroDeportivo["Requerido"];
    mapPuestoSalud["No requerido"]=cantidadDatos.toInt()-mapPuestoSalud["Requerido"];
    mapZonaComercial["No requerido"]=cantidadDatos.toInt()-mapZonaComercial["Requerido"];
    map["completed"]=completed;
    map["map_superficies_terreno"]=mapSuperficiesTerreno;
    map["map_superficies_construccion"]=mapSuperficiesConstruccion;
    map["map_metros_frente"]=mapMetrosFrente;
    map["map_antiguedad_construccion"]=mapAntiguedadConstruccion;
    map["map_mascotas_permitidas"]=mapMascotasPermitidasRequerido;
    map["map_sin_hipoteca"]=mapSinHipoteca;
    map["map_construccion_estrenar"]=mapConstruccionEstrenar;
    map["map_materiales_primera"]=mapMaterialesPrimera;
    map["map_proyecto_preventa"]=mapProyectoPreventa;
    map["map_inmueble_compartido"]=mapInmuebleCompartido;
    map["map_numero_duenios"]=mapNumeroDuenios;
    map["map_servicios_basicos"]=mapServiciosBasicos;
    map["map_gas_domiciliario"]=mapGasDomiciliario;
    map["map_wifi"]=mapWifi;
    map["map_medidor_independiente"]=mapMedidorIndependiente;
    map["map_termotanque"]=mapTermotanque;
    map["map_calle_asfaltada"]=mapCalleAsfaltada;
    map["map_transporte"]=mapTransporte;
    map["map_preparado_discapacidad"]=mapPreparadoDiscapacidad;
    map["map_papeles_orden"]=mapServiciosBasicos;
    map["map_habilitado_credito"]=mapHabilitadoCredito;
    map["map_papeles_orden"]=mapPapelesOrden;
    map["map_plantas"]=mapPlantas;
    map["map_ambientes"]=mapAmbientes;
    map["map_dormitorios"]=mapDormitorios;
    map["map_banios"]=mapBanios;
    map["map_garaje"]=mapGaraje;
    map["map_amoblado"]=mapAmoblado;
    map["map_lavanderia"]=mapLavanderia;
    map["map_cuarto_lavado"]=mapCuartoLavado;
    map["map_churrasquero"]=mapChurrasquero;
    map["map_azotea"]=mapAzotea;
    map["map_condominio_privado"]=mapCondominioPrivado;
    map["map_cancha"]=mapCancha;
    map["map_piscina"]=mapPiscina;
    map["map_sauna"]=mapSauna;
    map["map_jacuzzi"]=mapJacuzzi;
    map["map_estudio"]=mapEstudio;
    map["map_jardin"]=mapJardin;
    map["map_porton_electrico"]=mapPortonElectrico;
    map["map_aire_acondicionado"]=mapAireAcondicionado;
    map["map_calefaccion"]=mapCalefaccion;
    map["map_ascensor"]=mapAscensor;
    map["map_deposito"]=mapDeposito;
    map["map_sotano"]=mapSotano;
    map["map_balcon"]=mapBalcon;
    map["map_tienda"]=mapTienda;
    map["map_amurallado_terreno"]=mapAmuralladoTerreno;
    map["map_iglesia"]=mapIglesia;
    map["map_parque_infantil"]=mapParqueInfantil;
    map["map_escuela"]=mapEscuela;
    map["map_universidad"]=mapUniversidad;
    map["map_plazuela"]=mapPlazuela;
    map["map_modulo_policial"]=mapModuloPolicial;
    map["map_sauna_piscina_publica"]=mapSaunaPiscinaPublica;
    map["map_gym_publico"]=mapGymPublico;
    map["map_centro_deportivo"]=mapCentroDeportivo;
    map["map_puesto_salud"]=mapPuestoSalud;
    map["map_zona_comercial"]=mapZonaComercial;

    map["cantidad_datos"]=cantidadDatos;
    return map;
  }

  @override
  Future<bool> quitarAdministradorZona(String id) async{
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationQuitarAdministradorZona(),
      
      ),
      variables: ({"id":id}),
      onCompleted: (dynamic data){
        if(data!=null){
          if(data["quitarAdministradorZona"]!=null){
            id=data["quitarAdministradorZona"];
          }
        }
      },
      onError: (error){
        print(error);
        completed=false;
      }
    ));
    return completed;
  }

  @override
  Future<bool> responderInmuebleQueja(InmuebleQueja queja, String idSuperUsuario) async{
    bool respuesta=false;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    Map<String,dynamic> mapVariables=queja.toMap();
    mapVariables.addAll({"id_super_usuario":idSuperUsuario});
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationResponderInmuebleQueja(),
      
      ),
      variables: (mapVariables),
      onCompleted: (dynamic data){
        if(data!=null){
          respuesta=true;
          if(data["responderInmuebleQuejaSuperUsuario"]!=null){
            queja.fechaRespuesta=data["responderInmuebleQuejaSuperUsuario"]["fecha_respuesta"];
          }
        }
      },
      onError: (error){
        print(error);
        respuesta=false;
      }
    ));
    return respuesta;
  }

  @override
  Future<bool> responderMembresiaPagoSuperUsuario(MembresiaPago membresia, String idSuperUsuario) async{
    bool respuesta=false;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    Map<String,dynamic> mapVariables=membresia.toMap();
    mapVariables.addAll({"id_super_usuario":idSuperUsuario});
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationResponderMembresiaPagoSuperUsuario(),
      
      ),
      variables: (mapVariables),
      onCompleted: (dynamic data){
        if(data!=null){
          respuesta=true;
          if(data["responderMembresiaPagoSuperUsuario"]!=null){
            membresia.fechaRespuestaSuperUsuario=data["responderMembresiaPagoSuperUsuario"]["fecha_respuesta_super_usuario"];
          }
        }
      },
      onError: (error){
        print(error);
        respuesta=false;
      }
    ));
    return respuesta;
  }

  @override
  Future<bool> responderReporteInmueble(InmuebleReportado reportado) async{
    bool respuesta=false;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      
      graphql.MutationOptions(
        document: graphql.gql(getMutationResponderReporteInmueble(),
      
      ),
      variables: (reportado.toMap()),
      onCompleted: (dynamic data){
        if(data!=null){
          respuesta=true;
          if(data["responderReporteInmueble"]!=null){
            reportado.fechaRespuesta=data["responderReporteInmueble"]["fecha_respuesta"];
          }
        }
      },
      onError: (error){
        print(error);
        respuesta=false;
      }
    ));
    return respuesta;
  }

  @override
  Future<Map<String, dynamic>> obtenerSolicitudesAdministradoresSuperUsuario(String id) async{
    Map<String,dynamic> map={};
    List<SolicitudAdministrador> administradorSolicitudes=[];
    List administradorSolicitudesD=[];
    bool completado=true;
    String mensajeError="";
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(getQueryObtenerSolicitudesAdministradoresSuperUsuario()),
        fetchPolicy: graphql.FetchPolicy.noCache,
        variables: ({
          "id":id
        })
      ),
    );
    if(result.hasException){
      result.exception!.graphqlErrors.forEach((element) { 
        mensajeError=element.message;
      });
      completado=false;
    }else if(!result.hasException){
        if(result.data!["obtenerSolicitudesAdministradoresSuperUsuario"]!=null){
          administradorSolicitudesD=result.data!["obtenerSolicitudesAdministradoresSuperUsuario"];
          administradorSolicitudesD.forEach((element) {
            administradorSolicitudes.add(SolicitudAdministrador.fromMap(element));
          });
      }
    }
    map["mensaje_error"]=mensajeError;
    map["completado"]=completado;
    map["administrador_solicitudes"]=administradorSolicitudes;
    return map;
  }

}



String getValorSeleccionado(List<int> numeros,int valorMin,int valorMax){
  String valorSeleccionado="";
  if(valorMax>0&&valorMin>0){
    for(int i=1;i<numeros.length;i++){
      if(numeros[i]==valorMin){
        if(i<numeros.length-1){
          valorSeleccionado=numeros[i].toString()+"-"+(numeros[i+1]-1).toString();
        }else{
          valorSeleccionado=numeros[i].toString()+" a más";
        }
      }
    }
  }else{
    valorSeleccionado="Cualquiera";
  }
  return valorSeleccionado;
}