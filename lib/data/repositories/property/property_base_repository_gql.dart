String mutationUpdateDatePropertyBase(){
  String query="";
  query=r"""
    mutation actualizarFechaInmuebleBase($id: ID, $fecha: String){
      actualizarFechaInmuebleBase(
        id:$id
        fecha:$fecha
      )
    }
  """;
  return query;
}
String mutationUpdatePropertyBase(){
  String query="";
  query=r"""
    mutation actualizarInmuebleBase($id_usuario: ID,
  	$dormitorios_min_v: Int,$dormitorios_max_v:Int, $banios_min_v: Int,$banios_max_v:Int,
    $garaje_min_v: Int,$garaje_max_v:Int,$superficie_terreno_min_v: Int,$superficie_terreno_max_v:Int,
  	$superficie_construccion_min_v: Int,$superficie_construccion_max_v:Int,
  	$antiguedad_construccion_min_v: Int,$antiguedad_construccion_max_v:Int,$precio_min_v:Int,$precio_max_v:Int,
  	$cantidad_inmuebles_v:Int,
  	$amoblado_v:Int,$lavanderia_v:Int,$cuarto_lavado_v:Int,$churrasquero_v: Int,$azotea_v:Int,$condominio_privado_v:Int,$cancha_v:Int,
  	$piscina_v:Int,$sauna_v:Int,$jacuzzi_v:Int,$estudio_v:Int,$jardin_v:Int,$porton_electrico_v:Int,
  	$aire_acondicionado_v:Int,$calefaccion_v:Int,$ascensor_v:Int,$deposito_v:Int,$sotano_v:Int,$balcon_v:Int,
  	$tienda_v:Int,$amurallado_terreno_v:Int,
  	$dormitorios_min_dv: Int,$dormitorios_max_dv:Int, $banios_min_dv: Int,$banios_max_dv:Int,
    $garaje_min_dv: Int,$garaje_max_dv:Int,$superficie_terreno_min_dv: Int,$superficie_terreno_max_dv:Int,
  	$superficie_construccion_min_dv: Int,$superficie_construccion_max_dv:Int,
  	$antiguedad_construccion_min_dv: Int,$antiguedad_construccion_max_dv:Int,$precio_min_dv:Int,$precio_max_dv:Int,
  	$cantidad_inmuebles_dv:Int,
  	$amoblado_dv:Int,$lavanderia_dv:Int,$cuarto_lavado_dv:Int,$churrasquero_dv: Int,$azotea_dv:Int,$condominio_privado_dv:Int,$cancha_dv:Int,
  	$piscina_dv:Int,$sauna_dv:Int,$jacuzzi_dv:Int,$estudio_dv:Int,$jardin_dv:Int,$porton_electrico_dv:Int,
  	$aire_acondicionado_dv:Int,$calefaccion_dv:Int,$ascensor_dv:Int,$deposito_dv:Int,$sotano_dv:Int,$balcon_dv:Int,
  	$tienda_dv:Int,$amurallado_terreno_dv:Int,
  	$dormitorios_min_f: Int,$dormitorios_max_f:Int, $banios_min_f: Int,$banios_max_f:Int,
    $garaje_min_f: Int,$garaje_max_f:Int,$superficie_terreno_min_f: Int,$superficie_terreno_max_f:Int,
  	$superficie_construccion_min_f: Int,$superficie_construccion_max_f:Int,
  	$antiguedad_construccion_min_f: Int,$antiguedad_construccion_max_f:Int,$precio_min_f:Int,$precio_max_f:Int,
  	$cantidad_inmuebles_f:Int,
  	$amoblado_f:Int,$lavanderia_f:Int,$cuarto_lavado_f:Int,$churrasquero_f: Int,$azotea_f:Int,$condominio_privado_f:Int,$cancha_f:Int,
  	$piscina_f:Int,$sauna_f:Int,$jacuzzi_f:Int,$estudio_f:Int,$jardin_f:Int,$porton_electrico_f:Int,
  	$aire_acondicionado_f:Int,$calefaccion_f:Int,$ascensor_f:Int,$deposito_f:Int,$sotano_f:Int,$balcon_f:Int,
  	$tienda_f:Int,$amurallado_terreno_f:Int,
){
    actualizarInmuebleBase(
      id_usuario:$id_usuario,
      input_visto:{
        dormitorios_min: $dormitorios_min_v
        dormitorios_max: $dormitorios_max_v
        banios_min: $banios_min_v
        banios_max: $banios_max_v
        garaje_min: $garaje_min_v
        garaje_max: $garaje_max_v
        superficie_terreno_min: $superficie_terreno_min_v
        superficie_terreno_max: $superficie_terreno_max_v
        superficie_construccion_min: $superficie_construccion_min_v
        superficie_construccion_max: $superficie_construccion_max_v
        antiguedad_construccion_min: $antiguedad_construccion_min_v
        antiguedad_construccion_max: $antiguedad_construccion_max_v
        precio_min:$precio_min_v
        precio_max:$precio_max_v
        cantidad_inmuebles:$cantidad_inmuebles_v
        amoblado:$amoblado_v
        lavanderia:$lavanderia_v
        cuarto_lavado:$cuarto_lavado_v
        churrasquero:$churrasquero_v
        azotea:$azotea_v
        condominio_privado:$condominio_privado_v
        cancha:$cancha_v
        piscina:$piscina_v
        sauna:$sauna_v
        jacuzzi:$jacuzzi_v
        estudio:$estudio_v
        jardin:$jardin_v
        porton_electrico:$porton_electrico_v
        aire_acondicionado:$aire_acondicionado_v
        calefaccion:$calefaccion_v
        ascensor:$ascensor_v
        deposito:$deposito_v
        sotano:$sotano_v
        balcon:$balcon_v
        tienda:$tienda_v
        amurallado_terreno:$amurallado_terreno_v
      },
      input_doble_visto:{
        dormitorios_min: $dormitorios_min_dv
        dormitorios_max: $dormitorios_max_dv
        banios_min: $banios_min_dv
        banios_max: $banios_max_dv
        garaje_min: $garaje_min_dv
        garaje_max: $garaje_max_dv
        superficie_terreno_min: $superficie_terreno_min_dv
        superficie_terreno_max: $superficie_terreno_max_dv
        superficie_construccion_min: $superficie_construccion_min_dv
        superficie_construccion_max: $superficie_construccion_max_dv
        antiguedad_construccion_min: $antiguedad_construccion_min_dv
        antiguedad_construccion_max: $antiguedad_construccion_max_dv
        precio_min:$precio_min_dv
        precio_max:$precio_max_dv
        cantidad_inmuebles:$cantidad_inmuebles_dv
        amoblado:$amoblado_dv
        lavanderia:$lavanderia_dv
        cuarto_lavado:$cuarto_lavado_dv
        churrasquero:$churrasquero_dv
        azotea:$azotea_dv
        condominio_privado:$condominio_privado_dv
        cancha:$cancha_dv
        piscina:$piscina_dv
        sauna:$sauna_dv
        jacuzzi:$jacuzzi_dv
        estudio:$estudio_dv
        jardin:$jardin_dv
        porton_electrico:$porton_electrico_dv
        aire_acondicionado:$aire_acondicionado_dv
        calefaccion:$calefaccion_dv
        ascensor:$ascensor_dv
        deposito:$deposito_dv
        sotano:$sotano_dv
        balcon:$balcon_dv
        tienda:$tienda_dv
        amurallado_terreno:$amurallado_terreno_dv
      },
      input_favorito:{
        dormitorios_min: $dormitorios_min_f
        dormitorios_max: $dormitorios_max_f
        banios_min: $banios_min_f
        banios_max: $banios_max_f
        garaje_min: $garaje_min_f
        garaje_max: $garaje_max_f
        superficie_terreno_min: $superficie_terreno_min_f
        superficie_terreno_max: $superficie_terreno_max_f
        superficie_construccion_min: $superficie_construccion_min_f
        superficie_construccion_max: $superficie_construccion_max_f
        antiguedad_construccion_min: $antiguedad_construccion_min_f
        antiguedad_construccion_max: $antiguedad_construccion_max_f
        precio_min:$precio_min_f
        precio_max:$precio_max_f
        cantidad_inmuebles:$cantidad_inmuebles_f
        amoblado:$amoblado_f
        lavanderia:$lavanderia_f
        cuarto_lavado:$cuarto_lavado_f
        churrasquero:$churrasquero_f
        azotea:$azotea_f
        condominio_privado:$condominio_privado_f
        cancha:$cancha_f
        piscina:$piscina_f
        sauna:$sauna_f
        jacuzzi:$jacuzzi_f
        estudio:$estudio_f
        jardin:$jardin_f
        porton_electrico:$porton_electrico_f
        aire_acondicionado:$aire_acondicionado_f
        calefaccion:$calefaccion_f
        ascensor:$ascensor_f
        deposito:$deposito_f
        sotano:$sotano_f
        balcon:$balcon_f
        tienda:$tienda_f
        amurallado_terreno:$amurallado_terreno_f
      }
    )
  }
  """;
  return query;
}