import 'package:inmobiliariaapp/data/configuration/graphql_configuration.dart';
import 'package:inmobiliariaapp/data/repositories/inmueble/inmueble_base_repository_gql.dart';
import 'package:inmobiliariaapp/domain/entities/usuarios_inmuebles_favoritos.dart';
import 'package:inmobiliariaapp/domain/repositories/abstract_inmueble.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:inmobiliariaapp/ui/pages/principal/page_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InmuebleBaseRepository extends AbstractInmuebleBaseRepository{
  @override
  Future<bool> actualizarFechaInmuebleBase(String id, String fecha) async{
    bool respuesta=false;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationActualizarFechaInmuebleBase(),
      ),
      cacheRereadPolicy: graphql.CacheRereadPolicy.mergeOptimistic,
      fetchPolicy: modoOffline?graphql.FetchPolicy.cacheFirst:graphql.FetchPolicy.cacheAndNetwork,
      variables: (
        {
          "id":id,
          "fecha":fecha
        }
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
  Future<void> registrarInmuebleBase(List<UsuarioInmuebleBase> usuarioInmuebleBases, Future<SharedPreferences> _prefs) async{
    UsuarioInmuebleBase baseVisto=UsuarioInmuebleBase.vacio();
    UsuarioInmuebleBase baseDobleVisto=UsuarioInmuebleBase.vacio();
    UsuarioInmuebleBase baseFavorito=UsuarioInmuebleBase.vacio();
    usuarioInmuebleBases.sort((a,b)=>a.tipo.compareTo(b.tipo));
    baseDobleVisto=usuarioInmuebleBases[0];
    baseFavorito=usuarioInmuebleBases[1];
    baseVisto=usuarioInmuebleBases[2];
    final SharedPreferences prefs=await _prefs;
    await prefs.setInt("dormitorios_min_v",baseVisto.dormitoriosMin);
    await prefs.setInt("dormitorios_max_v",baseVisto.dormitoriosMax);
    await prefs.setInt("banios_min_v",baseVisto.baniosMin);
    await prefs.setInt("banios_max_v",baseVisto.baniosMax);
    await prefs.setInt("garaje_min_v",baseVisto.garajeMin);
    await prefs.setInt("garaje_max_v",baseVisto.garajeMax);
    await prefs.setInt("superficie_terreno_min_v",baseVisto.superficieTerrenoMin);
    await prefs.setInt("superficie_terreno_max_v",baseVisto.superficieTerrenoMax);
    await prefs.setInt("superficie_construccion_min_v",baseVisto.superficieConstruccionMin);
    await prefs.setInt("superficie_construccion_max_v",baseVisto.superficieConstruccionMax);
    await prefs.setInt("antiguedad_construccion_min_v",baseVisto.antiguedadConstruccionMin);
    await prefs.setInt("antiguedad_construccion_max_v",baseVisto.antiguedadConstruccionMax);
    await prefs.setInt("precio_min_v",baseVisto.precioMin);
    await prefs.setInt("precio_max_v",baseVisto.precioMax);
    await prefs.setInt("cantidad_inmuebles_v",baseVisto.cantidadInmuebles);
    await prefs.setInt("amoblado_v",baseVisto.amoblado);
    await prefs.setInt("lavanderia_v",baseVisto.lavanderia);
    await prefs.setInt("cuarto_lavado_v",baseVisto.cuartoLavado);
    await prefs.setInt("churrasquero_v",baseVisto.churrasquero);
    await prefs.setInt("azotea_v",baseVisto.azotea);
    await prefs.setInt("condominio_privado_v",baseVisto.condominioPrivado);
    await prefs.setInt("cancha_v",baseVisto.cancha);
    await prefs.setInt("piscina_v",baseVisto.piscina);
    await prefs.setInt("sauna_v",baseVisto.sauna);
    await prefs.setInt("jacuzzi_v",baseVisto.jacuzzi);
    await prefs.setInt("estudio_v",baseVisto.estudio);
    await prefs.setInt("jardin_v",baseVisto.jardin);
    await prefs.setInt("porton_electrico_v",baseVisto.portonElectrico);
    await prefs.setInt("aire_acondicionado_v",baseVisto.aireAcondicionado);
    await prefs.setInt("calefaccion_v",baseVisto.calefaccion);
    await prefs.setInt("ascensor_v",baseVisto.ascensor);
    await prefs.setInt("deposito_v",baseVisto.deposito);
    await prefs.setInt("sotano_v",baseVisto.sotano);
    await prefs.setInt("balcon_v",baseVisto.balcon);
    await prefs.setInt("tienda_v",baseVisto.tienda);
    await prefs.setInt("amurallado_terreno_v",baseVisto.amuralladoTerreno);

    await prefs.setInt("dormitorios_min_dv",baseDobleVisto.dormitoriosMin);
    await prefs.setInt("dormitorios_max_dv",baseDobleVisto.dormitoriosMax);
    await prefs.setInt("banios_min_dv",baseDobleVisto.baniosMin);
    await prefs.setInt("banios_max_dv",baseDobleVisto.baniosMax);
    await prefs.setInt("garaje_min_dv",baseDobleVisto.garajeMin);
    await prefs.setInt("garaje_max_dv",baseDobleVisto.garajeMax);
    await prefs.setInt("superficie_terreno_min_dv",baseDobleVisto.superficieTerrenoMin);
    await prefs.setInt("superficie_terreno_max_dv",baseDobleVisto.superficieTerrenoMax);
    await prefs.setInt("superficie_construccion_min_dv",baseDobleVisto.superficieConstruccionMin);
    await prefs.setInt("superficie_construccion_max_dv",baseDobleVisto.superficieConstruccionMax);
    await prefs.setInt("antiguedad_construccion_min_dv",baseDobleVisto.antiguedadConstruccionMin);
    await prefs.setInt("antiguedad_construccion_max_dv",baseDobleVisto.antiguedadConstruccionMax);
    await prefs.setInt("precio_min_dv",baseDobleVisto.precioMin);
    await prefs.setInt("precio_max_dv",baseDobleVisto.precioMax);
    await prefs.setInt("cantidad_inmuebles_dv",baseDobleVisto.cantidadInmuebles);
    await prefs.setInt("amoblado_dv",baseDobleVisto.amoblado);
    await prefs.setInt("lavanderia_dv",baseDobleVisto.lavanderia);
    await prefs.setInt("cuarto_lavado_dv",baseDobleVisto.cuartoLavado);
    await prefs.setInt("churrasquero_dv",baseDobleVisto.churrasquero);
    await prefs.setInt("azotea_dv",baseDobleVisto.azotea);
    await prefs.setInt("condominio_privado_dv",baseDobleVisto.condominioPrivado);
    await prefs.setInt("cancha_dv",baseDobleVisto.cancha);
    await prefs.setInt("piscina_dv",baseDobleVisto.piscina);
    await prefs.setInt("sauna_dv",baseDobleVisto.sauna);
    await prefs.setInt("jacuzzi_dv",baseDobleVisto.jacuzzi);
    await prefs.setInt("estudio_dv",baseDobleVisto.estudio);
    await prefs.setInt("jardin_dv",baseDobleVisto.jardin);
    await prefs.setInt("porton_electrico_dv",baseDobleVisto.portonElectrico);
    await prefs.setInt("aire_acondicionado_dv",baseDobleVisto.aireAcondicionado);
    await prefs.setInt("calefaccion_dv",baseDobleVisto.calefaccion);
    await prefs.setInt("ascensor_dv",baseDobleVisto.ascensor);
    await prefs.setInt("deposito_dv",baseDobleVisto.deposito);
    await prefs.setInt("sotano_dv",baseDobleVisto.sotano);
    await prefs.setInt("balcon_dv",baseDobleVisto.balcon);
    await prefs.setInt("tienda_dv",baseDobleVisto.tienda);
    await prefs.setInt("amurallado_terreno_dv",baseDobleVisto.amuralladoTerreno);

    await prefs.setInt("dormitorios_min_f",baseFavorito.dormitoriosMin);
    await prefs.setInt("dormitorios_max_f",baseFavorito.dormitoriosMax);
    await prefs.setInt("banios_min_f",baseFavorito.baniosMin);
    await prefs.setInt("banios_max_f",baseFavorito.baniosMax);
    await prefs.setInt("garaje_min_f",baseFavorito.garajeMin);
    await prefs.setInt("garaje_max_f",baseFavorito.garajeMax);
    await prefs.setInt("superficie_terreno_min_f",baseFavorito.superficieTerrenoMin);
    await prefs.setInt("superficie_terreno_max_f",baseFavorito.superficieTerrenoMax);
    await prefs.setInt("superficie_construccion_min_f",baseFavorito.superficieConstruccionMin);
    await prefs.setInt("superficie_construccion_max_f",baseFavorito.superficieConstruccionMax);
    await prefs.setInt("antiguedad_construccion_min_f",baseFavorito.antiguedadConstruccionMin);
    await prefs.setInt("antiguedad_construccion_max_f",baseFavorito.antiguedadConstruccionMax);
    await prefs.setInt("precio_min_f",baseFavorito.precioMin);
    await prefs.setInt("precio_max_f",baseFavorito.precioMax);
    await prefs.setInt("cantidad_inmuebles_f",baseFavorito.cantidadInmuebles);
    await prefs.setInt("amoblado_f",baseFavorito.amoblado);
    await prefs.setInt("lavanderia_f",baseFavorito.lavanderia);
    await prefs.setInt("cuarto_lavado_f",baseFavorito.cuartoLavado);
    await prefs.setInt("churrasquero_f",baseFavorito.churrasquero);
    await prefs.setInt("azotea_f",baseFavorito.azotea);
    await prefs.setInt("condominio_privado_f",baseFavorito.condominioPrivado);
    await prefs.setInt("cancha_f",baseFavorito.cancha);
    await prefs.setInt("piscina_f",baseFavorito.piscina);
    await prefs.setInt("sauna_f",baseFavorito.sauna);
    await prefs.setInt("jacuzzi_f",baseFavorito.jacuzzi);
    await prefs.setInt("estudio_f",baseFavorito.estudio);
    await prefs.setInt("jardin_f",baseFavorito.jardin);
    await prefs.setInt("porton_electrico_f",baseFavorito.portonElectrico);
    await prefs.setInt("aire_acondicionado_f",baseFavorito.aireAcondicionado);
    await prefs.setInt("calefaccion_f",baseFavorito.calefaccion);
    await prefs.setInt("ascensor_f",baseFavorito.ascensor);
    await prefs.setInt("deposito_f",baseFavorito.deposito);
    await prefs.setInt("sotano_f",baseFavorito.sotano);
    await prefs.setInt("balcon_f",baseFavorito.balcon);
    await prefs.setInt("tienda_f",baseFavorito.tienda);
    await prefs.setInt("amurallado_terreno_f",baseFavorito.amuralladoTerreno);
  }

  @override
  Future<Map<String, dynamic>> buscarInmuebleBaseShared(Future<SharedPreferences> _prefs) async{
    Map<String,dynamic> map={};
    UsuarioInmuebleBase baseVisto=UsuarioInmuebleBase.vacio();
    UsuarioInmuebleBase baseDobleVisto=UsuarioInmuebleBase.vacio();
    UsuarioInmuebleBase baseFavorito=UsuarioInmuebleBase.vacio();
    final SharedPreferences prefs=await _prefs;
    email=(prefs.getString("email")??"");
    baseVisto.tipo="visto";
    baseVisto.cantidadInmuebles=(prefs.getInt("cantidad_inmuebles_v")??0);
    baseVisto.dormitoriosMin=(prefs.getInt("dormitorios_min_v")??0);
    baseVisto.dormitoriosMax=(prefs.getInt("dormitorios_max_v")??0);
    baseVisto.baniosMin=(prefs.getInt("banios_min_v")??0);
    baseVisto.baniosMax=(prefs.getInt("banios_max_v")??0);
    baseVisto.garajeMin=(prefs.getInt("garaje_min_v")??0);
    baseVisto.garajeMax=(prefs.getInt("garaje_max_v")??0);
    baseVisto.superficieTerrenoMin=(prefs.getInt("superficie_terreno_min_v")??0);
    baseVisto.superficieTerrenoMax=(prefs.getInt("superficie_terreno_max_v")??0);
    baseVisto.superficieConstruccionMin=(prefs.getInt("superficie_construccion_min_v")??0);
    baseVisto.superficieConstruccionMax=(prefs.getInt("superficie_construccion_max_v")??0);
    baseVisto.antiguedadConstruccionMin=(prefs.getInt("antiguedad_construccion_min_v")??0);
    baseVisto.antiguedadConstruccionMax=(prefs.getInt("antiguedad_construccion_max_v")??0);
    baseVisto.precioMin=(prefs.getInt("precio_min_v")??0);
    baseVisto.precioMax=(prefs.getInt("precio_max_v")??0);
    baseVisto.amoblado=(prefs.getInt("amoblado_v")??0);
    baseVisto.lavanderia=(prefs.getInt("lavanderia_v")??0);
    baseVisto.cuartoLavado=(prefs.getInt("cuarto_lavado_v")??0);
    baseVisto.churrasquero=(prefs.getInt("churrasquero_v")??0);
    baseVisto.azotea=(prefs.getInt("azotea_v")??0);
    baseVisto.condominioPrivado=(prefs.getInt("condominio_privado_v")??0);
    baseVisto.cancha=(prefs.getInt("cancha_v")??0);
    baseVisto.piscina=(prefs.getInt("piscina_v")??0);
    baseVisto.sauna=(prefs.getInt("sauna_v")??0);
    baseVisto.jacuzzi=(prefs.getInt("jacuzzi_v")??0);
    baseVisto.estudio=(prefs.getInt("estudio_v")??0);
    baseVisto.jardin=(prefs.getInt("jardin_v")??0);
    baseVisto.portonElectrico=(prefs.getInt("porton_electrico_v")??0);
    baseVisto.aireAcondicionado=(prefs.getInt("aire_acondicionado_v")??0);
    baseVisto.calefaccion=(prefs.getInt("calefaccion_v")??0);
    baseVisto.ascensor=(prefs.getInt("ascensor_v")??0);
    baseVisto.deposito=(prefs.getInt("deposito_v")??0);
    baseVisto.sotano=(prefs.getInt("sotano_v")??0);
    baseVisto.balcon=(prefs.getInt("balcon_v")??0);
    baseVisto.tienda=(prefs.getInt("tienda_v")??0);
    baseVisto.amuralladoTerreno=(prefs.getInt("amurallado_terreno_v")??0);
    baseDobleVisto.tipo="doble_visto";
    baseDobleVisto.cantidadInmuebles=(prefs.getInt("cantidad_inmuebles_dv")??0);
    baseDobleVisto.dormitoriosMin=(prefs.getInt("dormitorios_min_dv")??0);
    baseDobleVisto.dormitoriosMax=(prefs.getInt("dormitorios_max_dv")??0);
    baseDobleVisto.baniosMin=(prefs.getInt("banios_min_dv")??0);
    baseDobleVisto.baniosMax=(prefs.getInt("banios_max_dv")??0);
    baseDobleVisto.garajeMin=(prefs.getInt("garaje_min_dv")??0);
    baseDobleVisto.garajeMax=(prefs.getInt("garaje_max_dv")??0);
    baseDobleVisto.superficieTerrenoMin=(prefs.getInt("superficie_terreno_min_dv")??0);
    baseDobleVisto.superficieTerrenoMax=(prefs.getInt("superficie_terreno_max_dv")??0);
    baseDobleVisto.superficieConstruccionMin=(prefs.getInt("superficie_construccion_min_dv")??0);
    baseDobleVisto.superficieConstruccionMax=(prefs.getInt("superficie_construccion_max_dv")??0);
    baseDobleVisto.antiguedadConstruccionMin=(prefs.getInt("antiguedad_construccion_min_dv")??0);
    baseDobleVisto.antiguedadConstruccionMax=(prefs.getInt("antiguedad_construccion_max_dv")??0);
    baseDobleVisto.precioMin=(prefs.getInt("precio_min_dv")??0);
    baseDobleVisto.precioMax=(prefs.getInt("precio_max_dv")??0);
    baseDobleVisto.amoblado=(prefs.getInt("amoblado_dv")??0);
    baseDobleVisto.lavanderia=(prefs.getInt("lavanderia_dv")??0);
    baseDobleVisto.cuartoLavado=(prefs.getInt("cuarto_lavado_dv")??0);
    baseDobleVisto.churrasquero=(prefs.getInt("churrasquero_dv")??0);
    baseDobleVisto.azotea=(prefs.getInt("azotea_dv")??0);
    baseDobleVisto.condominioPrivado=(prefs.getInt("condominio_privado_dv")??0);
    baseDobleVisto.cancha=(prefs.getInt("cancha_dv")??0);
    baseDobleVisto.piscina=(prefs.getInt("piscina_dv")??0);
    baseDobleVisto.sauna=(prefs.getInt("sauna_dv")??0);
    baseDobleVisto.jacuzzi=(prefs.getInt("jacuzzi_dv")??0);
    baseDobleVisto.estudio=(prefs.getInt("estudio_dv")??0);
    baseDobleVisto.jardin=(prefs.getInt("jardin_dv")??0);
    baseDobleVisto.portonElectrico=(prefs.getInt("porton_electrico_dv")??0);
    baseDobleVisto.aireAcondicionado=(prefs.getInt("aire_acondicionado_dv")??0);
    baseDobleVisto.calefaccion=(prefs.getInt("calefaccion_dv")??0);
    baseDobleVisto.ascensor=(prefs.getInt("ascensor_dv")??0);
    baseDobleVisto.deposito=(prefs.getInt("deposito_dv")??0);
    baseDobleVisto.sotano=(prefs.getInt("sotano_dv")??0);
    baseDobleVisto.balcon=(prefs.getInt("balcon_dv")??0);
    baseDobleVisto.tienda=(prefs.getInt("tienda_dv")??0);
    baseDobleVisto.amuralladoTerreno=(prefs.getInt("amurallado_terreno_dv")??0);
    baseFavorito.tipo="favorito";
    baseFavorito.cantidadInmuebles=(prefs.getInt("cantidad_inmuebles_f")??0);
    baseFavorito.dormitoriosMin=(prefs.getInt("dormitorios_min_f")??0);
    baseFavorito.dormitoriosMax=(prefs.getInt("dormitorios_max_f")??0);
    baseFavorito.baniosMin=(prefs.getInt("banios_min_f")??0);
    baseFavorito.baniosMax=(prefs.getInt("banios_max_f")??0);
    baseFavorito.garajeMin=(prefs.getInt("garaje_min_f")??0);
    baseFavorito.garajeMax=(prefs.getInt("garaje_max_f")??0);
    baseFavorito.superficieTerrenoMin=(prefs.getInt("superficie_terreno_min_f")??0);
    baseFavorito.superficieTerrenoMax=(prefs.getInt("superficie_terreno_max_f")??0);
    baseFavorito.superficieConstruccionMin=(prefs.getInt("superficie_construccion_min_f")??0);
    baseFavorito.superficieConstruccionMax=(prefs.getInt("superficie_construccion_max_f")??0);
    baseFavorito.antiguedadConstruccionMin=(prefs.getInt("antiguedad_construccion_min_f")??0);
    baseFavorito.antiguedadConstruccionMax=(prefs.getInt("antiguedad_construccion_max_f")??0);
    baseFavorito.precioMin=(prefs.getInt("precio_min_f")??0);
    baseFavorito.precioMax=(prefs.getInt("precio_max_f")??0);
    baseFavorito.amoblado=(prefs.getInt("amoblado_f")??0);
    baseFavorito.lavanderia=(prefs.getInt("lavanderia_f")??0);
    baseFavorito.cuartoLavado=(prefs.getInt("cuarto_lavado_f")??0);
    baseFavorito.churrasquero=(prefs.getInt("churrasquero_f")??0);
    baseFavorito.azotea=(prefs.getInt("azotea_f")??0);
    baseFavorito.condominioPrivado=(prefs.getInt("condominio_privado_f")??0);
    baseFavorito.cancha=(prefs.getInt("cancha_f")??0);
    baseFavorito.piscina=(prefs.getInt("piscina_f")??0);
    baseFavorito.sauna=(prefs.getInt("sauna_f")??0);
    baseFavorito.jacuzzi=(prefs.getInt("jacuzzi_f")??0);
    baseFavorito.estudio=(prefs.getInt("estudio_f")??0);
    baseFavorito.jardin=(prefs.getInt("jardin_f")??0);
    baseFavorito.portonElectrico=(prefs.getInt("porton_electrico_f")??0);
    baseFavorito.aireAcondicionado=(prefs.getInt("aire_acondicionado_f")??0);
    baseFavorito.calefaccion=(prefs.getInt("calefaccion_f")??0);
    baseFavorito.ascensor=(prefs.getInt("ascensor_f")??0);
    baseFavorito.deposito=(prefs.getInt("deposito_f")??0);
    baseFavorito.sotano=(prefs.getInt("sotano_f")??0);
    baseFavorito.balcon=(prefs.getInt("balcon_f")??0);
    baseFavorito.tienda=(prefs.getInt("tienda_f")??0);
    baseFavorito.amuralladoTerreno=(prefs.getInt("amurallado_terreno_f")??0);
    map["email"]=email;
    map["base_visto"]=baseVisto;
    map["base_doble_visto"]=baseDobleVisto;
    map["base_favorito"]=baseFavorito;
    return map;
  }

}