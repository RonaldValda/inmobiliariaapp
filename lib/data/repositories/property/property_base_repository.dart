import 'package:inmobiliariaapp/data/configuration/graphql_configuration.dart';
import 'package:inmobiliariaapp/domain/entities/user_property_favorite.dart';
import 'package:inmobiliariaapp/domain/repositories/abstract_property.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../auxiliares/global_variables.dart';
import '../../../ui/pages/home/page_home.dart';
import 'property_base_repository_gql.dart';

class PropertyBaseRepository extends AbstractPropertyBaseRepository{
  @override
  Future<bool> updateDatePropertyBase(String id, String date) async{
    bool response=false;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationUpdateDatePropertyBase(),
      ),
      cacheRereadPolicy: graphql.CacheRereadPolicy.mergeOptimistic,
      fetchPolicy: modoOffline?graphql.FetchPolicy.cacheFirst:graphql.FetchPolicy.cacheAndNetwork,
      variables: (
        {
          "id":id,
          "fecha":date
        }
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

  @override
  Future<void> registerPropertyBase(List<UserPropertyBase> userPropertyBases, Future<SharedPreferences> _prefs) async{
    UserPropertyBase viewedBase=UserPropertyBase.empty();
    UserPropertyBase viewedDoubleBase=UserPropertyBase.empty();
    UserPropertyBase favoriteBase=UserPropertyBase.empty();
    userPropertyBases.sort((a,b)=>a.type.compareTo(b.type));
    viewedDoubleBase=userPropertyBases[0];
    favoriteBase=userPropertyBases[1];
    viewedBase=userPropertyBases[2];
    final SharedPreferences prefs=await _prefs;
    await prefs.setInt("dormitorios_min_v",viewedBase.bedroomsMin);
    await prefs.setInt("dormitorios_max_v",viewedBase.bedroomsMax);
    await prefs.setInt("banios_min_v",viewedBase.bathroomsMin);
    await prefs.setInt("banios_max_v",viewedBase.bathroomsMax);
    await prefs.setInt("garaje_min_v",viewedBase.garagesMin);
    await prefs.setInt("garaje_max_v",viewedBase.garagesMax);
    await prefs.setInt("superficie_terreno_min_v",viewedBase.landSurfaceMin);
    await prefs.setInt("superficie_terreno_max_v",viewedBase.landSurfaceMax);
    await prefs.setInt("superficie_construccion_min_v",viewedBase.constructionSurfaceMin);
    await prefs.setInt("superficie_construccion_max_v",viewedBase.constructionSurfaceMax);
    await prefs.setInt("antiguedad_construccion_min_v",viewedBase.constructionAntiquityMin);
    await prefs.setInt("antiguedad_construccion_max_v",viewedBase.constructionAntiquityMax);
    await prefs.setInt("precio_min_v",viewedBase.priceMin);
    await prefs.setInt("precio_max_v",viewedBase.priceMax);
    await prefs.setInt("cantidad_inmuebles_v",viewedBase.propertiesQuantity);
    await prefs.setInt("amoblado_v",viewedBase.furnished);
    await prefs.setInt("lavanderia_v",viewedBase.laundry);
    await prefs.setInt("cuarto_lavado_v",viewedBase.laundryRoom);
    await prefs.setInt("churrasquero_v",viewedBase.grill);
    await prefs.setInt("azotea_v",viewedBase.rooftop);
    await prefs.setInt("condominio_privado_v",viewedBase.privateCondominium);
    await prefs.setInt("cancha_v",viewedBase.court);
    await prefs.setInt("piscina_v",viewedBase.pool);
    await prefs.setInt("sauna_v",viewedBase.sauna);
    await prefs.setInt("jacuzzi_v",viewedBase.jacuzzi);
    await prefs.setInt("estudio_v",viewedBase.studio);
    await prefs.setInt("jardin_v",viewedBase.garden);
    await prefs.setInt("porton_electrico_v",viewedBase.electricGate);
    await prefs.setInt("aire_acondicionado_v",viewedBase.airConditioning);
    await prefs.setInt("calefaccion_v",viewedBase.heating);
    await prefs.setInt("ascensor_v",viewedBase.elevator);
    await prefs.setInt("deposito_v",viewedBase.warehouse);
    await prefs.setInt("sotano_v",viewedBase.basement);
    await prefs.setInt("balcon_v",viewedBase.balcony);
    await prefs.setInt("tienda_v",viewedBase.store);
    await prefs.setInt("amurallado_terreno_v",viewedBase.landWalled);

    await prefs.setInt("dormitorios_min_dv",viewedDoubleBase.bedroomsMin);
    await prefs.setInt("dormitorios_max_dv",viewedDoubleBase.bedroomsMax);
    await prefs.setInt("banios_min_dv",viewedDoubleBase.bathroomsMin);
    await prefs.setInt("banios_max_dv",viewedDoubleBase.bathroomsMax);
    await prefs.setInt("garaje_min_dv",viewedDoubleBase.garagesMin);
    await prefs.setInt("garaje_max_dv",viewedDoubleBase.garagesMax);
    await prefs.setInt("superficie_terreno_min_dv",viewedDoubleBase.landSurfaceMin);
    await prefs.setInt("superficie_terreno_max_dv",viewedDoubleBase.landSurfaceMax);
    await prefs.setInt("superficie_construccion_min_dv",viewedDoubleBase.constructionSurfaceMin);
    await prefs.setInt("superficie_construccion_max_dv",viewedDoubleBase.constructionSurfaceMax);
    await prefs.setInt("antiguedad_construccion_min_dv",viewedDoubleBase.constructionAntiquityMin);
    await prefs.setInt("antiguedad_construccion_max_dv",viewedDoubleBase.constructionAntiquityMax);
    await prefs.setInt("precio_min_dv",viewedDoubleBase.priceMin);
    await prefs.setInt("precio_max_dv",viewedDoubleBase.priceMax);
    await prefs.setInt("cantidad_inmuebles_dv",viewedDoubleBase.propertiesQuantity);
    await prefs.setInt("amoblado_dv",viewedDoubleBase.furnished);
    await prefs.setInt("lavanderia_dv",viewedDoubleBase.laundry);
    await prefs.setInt("cuarto_lavado_dv",viewedDoubleBase.laundryRoom);
    await prefs.setInt("churrasquero_dv",viewedDoubleBase.grill);
    await prefs.setInt("azotea_dv",viewedDoubleBase.rooftop);
    await prefs.setInt("condominio_privado_dv",viewedDoubleBase.privateCondominium);
    await prefs.setInt("cancha_dv",viewedDoubleBase.court);
    await prefs.setInt("piscina_dv",viewedDoubleBase.pool);
    await prefs.setInt("sauna_dv",viewedDoubleBase.sauna);
    await prefs.setInt("jacuzzi_dv",viewedDoubleBase.jacuzzi);
    await prefs.setInt("estudio_dv",viewedDoubleBase.studio);
    await prefs.setInt("jardin_dv",viewedDoubleBase.garden);
    await prefs.setInt("porton_electrico_dv",viewedDoubleBase.electricGate);
    await prefs.setInt("aire_acondicionado_dv",viewedDoubleBase.airConditioning);
    await prefs.setInt("calefaccion_dv",viewedDoubleBase.heating);
    await prefs.setInt("ascensor_dv",viewedDoubleBase.elevator);
    await prefs.setInt("deposito_dv",viewedDoubleBase.warehouse);
    await prefs.setInt("sotano_dv",viewedDoubleBase.basement);
    await prefs.setInt("balcon_dv",viewedDoubleBase.balcony);
    await prefs.setInt("tienda_dv",viewedDoubleBase.store);
    await prefs.setInt("amurallado_terreno_dv",viewedDoubleBase.landWalled);

    await prefs.setInt("dormitorios_min_f",favoriteBase.bedroomsMin);
    await prefs.setInt("dormitorios_max_f",favoriteBase.bedroomsMax);
    await prefs.setInt("banios_min_f",favoriteBase.bathroomsMin);
    await prefs.setInt("banios_max_f",favoriteBase.bathroomsMax);
    await prefs.setInt("garaje_min_f",favoriteBase.garagesMin);
    await prefs.setInt("garaje_max_f",favoriteBase.garagesMax);
    await prefs.setInt("superficie_terreno_min_f",favoriteBase.landSurfaceMin);
    await prefs.setInt("superficie_terreno_max_f",favoriteBase.landSurfaceMax);
    await prefs.setInt("superficie_construccion_min_f",favoriteBase.constructionSurfaceMin);
    await prefs.setInt("superficie_construccion_max_f",favoriteBase.constructionSurfaceMax);
    await prefs.setInt("antiguedad_construccion_min_f",favoriteBase.constructionAntiquityMin);
    await prefs.setInt("antiguedad_construccion_max_f",favoriteBase.constructionAntiquityMax);
    await prefs.setInt("precio_min_f",favoriteBase.priceMin);
    await prefs.setInt("precio_max_f",favoriteBase.priceMax);
    await prefs.setInt("cantidad_inmuebles_f",favoriteBase.propertiesQuantity);
    await prefs.setInt("amoblado_f",favoriteBase.furnished);
    await prefs.setInt("lavanderia_f",favoriteBase.laundry);
    await prefs.setInt("cuarto_lavado_f",favoriteBase.laundryRoom);
    await prefs.setInt("churrasquero_f",favoriteBase.grill);
    await prefs.setInt("azotea_f",favoriteBase.rooftop);
    await prefs.setInt("condominio_privado_f",favoriteBase.privateCondominium);
    await prefs.setInt("cancha_f",favoriteBase.court);
    await prefs.setInt("piscina_f",favoriteBase.pool);
    await prefs.setInt("sauna_f",favoriteBase.sauna);
    await prefs.setInt("jacuzzi_f",favoriteBase.jacuzzi);
    await prefs.setInt("estudio_f",favoriteBase.studio);
    await prefs.setInt("jardin_f",favoriteBase.garden);
    await prefs.setInt("porton_electrico_f",favoriteBase.electricGate);
    await prefs.setInt("aire_acondicionado_f",favoriteBase.airConditioning);
    await prefs.setInt("calefaccion_f",favoriteBase.heating);
    await prefs.setInt("ascensor_f",favoriteBase.elevator);
    await prefs.setInt("deposito_f",favoriteBase.warehouse);
    await prefs.setInt("sotano_f",favoriteBase.basement);
    await prefs.setInt("balcon_f",favoriteBase.balcony);
    await prefs.setInt("tienda_f",favoriteBase.store);
    await prefs.setInt("amurallado_terreno_f",favoriteBase.landWalled);
  }

  @override
  Future<Map<String, dynamic>> searchPropertyBaseShared(Future<SharedPreferences> _prefs) async{
    Map<String,dynamic> map={};
    UserPropertyBase viewedBase=UserPropertyBase.empty();
    UserPropertyBase viewedDoubleBase=UserPropertyBase.empty();
    UserPropertyBase favoriteBase=UserPropertyBase.empty();
    final SharedPreferences prefs=await _prefs;
    email=(prefs.getString("email")??"");
    initialCityDefault=(prefs.getString("initial_city")??"");
    viewedBase.type="visto";
    viewedBase.propertiesQuantity=(prefs.getInt("cantidad_inmuebles_v")??0);
    viewedBase.bedroomsMin=(prefs.getInt("dormitorios_min_v")??0);
    viewedBase.bedroomsMax=(prefs.getInt("dormitorios_max_v")??0);
    viewedBase.bathroomsMin=(prefs.getInt("banios_min_v")??0);
    viewedBase.bathroomsMax=(prefs.getInt("banios_max_v")??0);
    viewedBase.garagesMin=(prefs.getInt("garaje_min_v")??0);
    viewedBase.garagesMax=(prefs.getInt("garaje_max_v")??0);
    viewedBase.landSurfaceMin=(prefs.getInt("superficie_terreno_min_v")??0);
    viewedBase.landSurfaceMax=(prefs.getInt("superficie_terreno_max_v")??0);
    viewedBase.constructionSurfaceMin=(prefs.getInt("superficie_construccion_min_v")??0);
    viewedBase.constructionSurfaceMax=(prefs.getInt("superficie_construccion_max_v")??0);
    viewedBase.constructionAntiquityMin=(prefs.getInt("antiguedad_construccion_min_v")??0);
    viewedBase.constructionAntiquityMax=(prefs.getInt("antiguedad_construccion_max_v")??0);
    viewedBase.priceMin=(prefs.getInt("precio_min_v")??0);
    viewedBase.priceMax=(prefs.getInt("precio_max_v")??0);
    viewedBase.furnished=(prefs.getInt("amoblado_v")??0);
    viewedBase.laundry=(prefs.getInt("lavanderia_v")??0);
    viewedBase.laundryRoom=(prefs.getInt("cuarto_lavado_v")??0);
    viewedBase.grill=(prefs.getInt("churrasquero_v")??0);
    viewedBase.rooftop=(prefs.getInt("azotea_v")??0);
    viewedBase.privateCondominium=(prefs.getInt("condominio_privado_v")??0);
    viewedBase.court=(prefs.getInt("cancha_v")??0);
    viewedBase.pool=(prefs.getInt("piscina_v")??0);
    viewedBase.sauna=(prefs.getInt("sauna_v")??0);
    viewedBase.jacuzzi=(prefs.getInt("jacuzzi_v")??0);
    viewedBase.studio=(prefs.getInt("estudio_v")??0);
    viewedBase.garden=(prefs.getInt("jardin_v")??0);
    viewedBase.electricGate=(prefs.getInt("porton_electrico_v")??0);
    viewedBase.airConditioning=(prefs.getInt("aire_acondicionado_v")??0);
    viewedBase.heating=(prefs.getInt("calefaccion_v")??0);
    viewedBase.elevator=(prefs.getInt("ascensor_v")??0);
    viewedBase.warehouse=(prefs.getInt("deposito_v")??0);
    viewedBase.basement=(prefs.getInt("sotano_v")??0);
    viewedBase.balcony=(prefs.getInt("balcon_v")??0);
    viewedBase.store=(prefs.getInt("tienda_v")??0);
    viewedBase.landWalled=(prefs.getInt("amurallado_terreno_v")??0);
    viewedDoubleBase.type="doble_visto";
    viewedDoubleBase.propertiesQuantity=(prefs.getInt("cantidad_inmuebles_dv")??0);
    viewedDoubleBase.bedroomsMin=(prefs.getInt("dormitorios_min_dv")??0);
    viewedDoubleBase.bedroomsMax=(prefs.getInt("dormitorios_max_dv")??0);
    viewedDoubleBase.bathroomsMin=(prefs.getInt("banios_min_dv")??0);
    viewedDoubleBase.bathroomsMax=(prefs.getInt("banios_max_dv")??0);
    viewedDoubleBase.garagesMin=(prefs.getInt("garaje_min_dv")??0);
    viewedDoubleBase.garagesMax=(prefs.getInt("garaje_max_dv")??0);
    viewedDoubleBase.landSurfaceMin=(prefs.getInt("superficie_terreno_min_dv")??0);
    viewedDoubleBase.landSurfaceMax=(prefs.getInt("superficie_terreno_max_dv")??0);
    viewedDoubleBase.constructionSurfaceMin=(prefs.getInt("superficie_construccion_min_dv")??0);
    viewedDoubleBase.constructionSurfaceMax=(prefs.getInt("superficie_construccion_max_dv")??0);
    viewedDoubleBase.constructionAntiquityMin=(prefs.getInt("antiguedad_construccion_min_dv")??0);
    viewedDoubleBase.constructionAntiquityMax=(prefs.getInt("antiguedad_construccion_max_dv")??0);
    viewedDoubleBase.priceMin=(prefs.getInt("precio_min_dv")??0);
    viewedDoubleBase.priceMax=(prefs.getInt("precio_max_dv")??0);
    viewedDoubleBase.furnished=(prefs.getInt("amoblado_dv")??0);
    viewedDoubleBase.laundry=(prefs.getInt("lavanderia_dv")??0);
    viewedDoubleBase.laundryRoom=(prefs.getInt("cuarto_lavado_dv")??0);
    viewedDoubleBase.grill=(prefs.getInt("churrasquero_dv")??0);
    viewedDoubleBase.rooftop=(prefs.getInt("azotea_dv")??0);
    viewedDoubleBase.privateCondominium=(prefs.getInt("condominio_privado_dv")??0);
    viewedDoubleBase.court=(prefs.getInt("cancha_dv")??0);
    viewedDoubleBase.pool=(prefs.getInt("piscina_dv")??0);
    viewedDoubleBase.sauna=(prefs.getInt("sauna_dv")??0);
    viewedDoubleBase.jacuzzi=(prefs.getInt("jacuzzi_dv")??0);
    viewedDoubleBase.studio=(prefs.getInt("estudio_dv")??0);
    viewedDoubleBase.garden=(prefs.getInt("jardin_dv")??0);
    viewedDoubleBase.electricGate=(prefs.getInt("porton_electrico_dv")??0);
    viewedDoubleBase.airConditioning=(prefs.getInt("aire_acondicionado_dv")??0);
    viewedDoubleBase.heating=(prefs.getInt("calefaccion_dv")??0);
    viewedDoubleBase.elevator=(prefs.getInt("ascensor_dv")??0);
    viewedDoubleBase.warehouse=(prefs.getInt("deposito_dv")??0);
    viewedDoubleBase.basement=(prefs.getInt("sotano_dv")??0);
    viewedDoubleBase.balcony=(prefs.getInt("balcon_dv")??0);
    viewedDoubleBase.store=(prefs.getInt("tienda_dv")??0);
    viewedDoubleBase.landWalled=(prefs.getInt("amurallado_terreno_dv")??0);
    favoriteBase.type="favorito";
    favoriteBase.propertiesQuantity=(prefs.getInt("cantidad_inmuebles_f")??0);
    favoriteBase.bedroomsMin=(prefs.getInt("dormitorios_min_f")??0);
    favoriteBase.bedroomsMax=(prefs.getInt("dormitorios_max_f")??0);
    favoriteBase.bathroomsMin=(prefs.getInt("banios_min_f")??0);
    favoriteBase.bathroomsMax=(prefs.getInt("banios_max_f")??0);
    favoriteBase.garagesMin=(prefs.getInt("garaje_min_f")??0);
    favoriteBase.garagesMax=(prefs.getInt("garaje_max_f")??0);
    favoriteBase.landSurfaceMin=(prefs.getInt("superficie_terreno_min_f")??0);
    favoriteBase.landSurfaceMax=(prefs.getInt("superficie_terreno_max_f")??0);
    favoriteBase.constructionSurfaceMin=(prefs.getInt("superficie_construccion_min_f")??0);
    favoriteBase.constructionSurfaceMax=(prefs.getInt("superficie_construccion_max_f")??0);
    favoriteBase.constructionAntiquityMin=(prefs.getInt("antiguedad_construccion_min_f")??0);
    favoriteBase.constructionAntiquityMax=(prefs.getInt("antiguedad_construccion_max_f")??0);
    favoriteBase.priceMin=(prefs.getInt("precio_min_f")??0);
    favoriteBase.priceMax=(prefs.getInt("precio_max_f")??0);
    favoriteBase.furnished=(prefs.getInt("amoblado_f")??0);
    favoriteBase.laundry=(prefs.getInt("lavanderia_f")??0);
    favoriteBase.laundryRoom=(prefs.getInt("cuarto_lavado_f")??0);
    favoriteBase.grill=(prefs.getInt("churrasquero_f")??0);
    favoriteBase.rooftop=(prefs.getInt("azotea_f")??0);
    favoriteBase.privateCondominium=(prefs.getInt("condominio_privado_f")??0);
    favoriteBase.court=(prefs.getInt("cancha_f")??0);
    favoriteBase.pool=(prefs.getInt("piscina_f")??0);
    favoriteBase.sauna=(prefs.getInt("sauna_f")??0);
    favoriteBase.jacuzzi=(prefs.getInt("jacuzzi_f")??0);
    favoriteBase.studio=(prefs.getInt("estudio_f")??0);
    favoriteBase.garden=(prefs.getInt("jardin_f")??0);
    favoriteBase.electricGate=(prefs.getInt("porton_electrico_f")??0);
    favoriteBase.airConditioning=(prefs.getInt("aire_acondicionado_f")??0);
    favoriteBase.heating=(prefs.getInt("calefaccion_f")??0);
    favoriteBase.elevator=(prefs.getInt("ascensor_f")??0);
    favoriteBase.warehouse=(prefs.getInt("deposito_f")??0);
    favoriteBase.basement=(prefs.getInt("sotano_f")??0);
    favoriteBase.balcony=(prefs.getInt("balcon_f")??0);
    favoriteBase.store=(prefs.getInt("tienda_f")??0);
    favoriteBase.landWalled=(prefs.getInt("amurallado_terreno_f")??0);
    map["initial_city"]=initialCityDefault;
    print("email cache $email");
    map["email"]=email;
    map["viewed_base"]=viewedBase;
    map["viewed_double_base"]=viewedDoubleBase;
    map["favorite_base"]=favoriteBase;
    return map;
  }

}