String getQueryObtenerAds(){
  String query="";
  query=r"""
    query obtener{
      obtener{
        id
        id_ad
        tipo_ad
      }
    }
  """;
  return query;
}
String getMutationRegistrarAd(){
  String query="";
  query=r"""
  mutation RegistrarAd($id_ad:String,$tipo_ad:String){
    RegistrarAd(
      id_ad:$id_ad
      tipo_ad:$tipo_ad
    ){
      id
      id_ad
      tipo_ad
    }
  }
  """;
  return query;
}
String getMutationEliminarAd(){
  String query="";
  query=r"""
    mutation EliminarAd($id:String){
      EliminarAd(
        id:$id
      )
    }
  """;
  return query;
}
String getMutationRegistrarPublicidad(){
  String query="";
  query=r"""
  mutation registrarPublicidad(
    $ciudad:String,
    $precio_min:Int,$precio_max:Int,$tipo_contrato:String,
    $tipo_inmueble:String,$tipo_publicidad:String,
    $descripcion_publicidad:String,$link_imagen_publicidad:String,
    $link_web_publicidad:String,$meses_vigencia:Int
  ){
    registrarPublicidad(
      input:{
        ciudad:$ciudad
        precio_min:$precio_min
        precio_max:$precio_max
        tipo_contrato:$tipo_contrato
        tipo_inmueble:$tipo_inmueble
        tipo_publicidad:$tipo_publicidad
        descripcion_publicidad:$descripcion_publicidad,
        link_imagen_publicidad:$link_imagen_publicidad
        link_web_publicidad:$link_web_publicidad
        meses_vigencia:$meses_vigencia
      }
    ){
      id
      fecha_creacion
      fecha_vencimiento
    }
  }
  """;
  return query;
}
String getMutationModificarPublicidad(){
  String query="";
  query=r"""
  mutation modificarPublicidad(
    $id:ID,
    $ciudad:String,
    $precio_min:Int,$precio_max:Int,$tipo_contrato:String,
    $tipo_inmueble:String,$tipo_publicidad:String,
    $descripcion_publicidad:String,$link_imagen_publicidad:String,
    $link_web_publicidad:String,$meses_vigencia:Int
  ){
    modificarPublicidad(
      id:$id,
      input:{
        ciudad:$ciudad
        precio_min:$precio_min
        precio_max:$precio_max
        tipo_contrato:$tipo_contrato
        tipo_inmueble:$tipo_inmueble
        tipo_publicidad:$tipo_publicidad
        descripcion_publicidad:$descripcion_publicidad,
        link_imagen_publicidad:$link_imagen_publicidad
        link_web_publicidad:$link_web_publicidad
        meses_vigencia:$meses_vigencia
      }
    ){
      fecha_vencimiento
    }
  }
  """;
  return query;
}
String getMutationEliminarPublicacion(){
  String query="";
  query=r"""
  mutation eliminarPublicidad(
    $id:ID
  ){
    eliminarPublicidad(
      id:$id
    )
  }
  """;
  return query;
}
String getQueryObtenerPublicidad(){
  String query="";
  query=r"""
  query obtenerPublicidad{
    obtenerPublicidad{
      id
      precio_min
      precio_max
      tipo_contrato
      tipo_inmueble
      tipo_publicidad
      descripcion_publicidad
      link_imagen_publicidad
      link_web_publicidad
      fecha_creacion
      fecha_vencimiento
    }
  }
  """;
  return query;
}