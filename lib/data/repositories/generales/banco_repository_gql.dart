String getMutationRegistrarCuentaBanco(){
  String query="";
  query=r"""
  mutation registrarCuentaBanco(
    $numero_cuenta:String,$nombre_banco:String,$titular:String,$link_logo_banco:String,$activo:Boolean
  ){
    registrarCuentaBanco(input:{
      activo:$activo
      numero_cuenta:$numero_cuenta
      nombre_banco:$nombre_banco
      titular:$titular
      link_logo_banco:$link_logo_banco
    }){
      id
      fecha_habilitacion
      fecha_cierre
      activo
      numero_cuenta
      titular
      nombre_banco
      link_logo_banco
    }
  }
  """;
  return query;
}
String getQueryObtenerCuentasBancos(){
  String query="";
  query=r"""
  query obtenerCuentasBancos{
    obtenerCuentasBancos{
      id
      fecha_habilitacion
      fecha_cierre
      activo
      numero_cuenta
      titular
      nombre_banco
      link_logo_banco
    }
  }
  """;
  return query;
}
String getMutationRegistrarBanco(){
  String query="";
  query=r"""
  mutation registrarBanco(
    $nombre_banco:String,
    $link_logo_banco:String,
    $web:String,$app:String,$pre_aprobacion:String
  ){
    registrarBanco(
      input:{
        nombre_banco:$nombre_banco
        link_logo_banco:$link_logo_banco
        web:$web
        app:$app
        pre_aprobacion:$pre_aprobacion
      }
    ){
      id
    }
  }
  """;
  return query;
}
String getMutationModificarBanco(){
  String query="";
  query=r"""
  mutation modificarBanco(
    $id:ID,
    $nombre_banco:String,
    $link_logo_banco:String,
    $web:String,$app:String,$pre_aprobacion:String
  ){
    modificarBanco(
      id:$id
      input:{
        nombre_banco:$nombre_banco
        link_logo_banco:$link_logo_banco
        web:$web
        app:$app
        pre_aprobacion:$pre_aprobacion
      }
    )
  }
  """;
  return query;
}
String getMutationEliminarBanco(){
  String query="";
  query=r"""
    mutation eliminarBanco(
      $id:ID
    ){
      eliminarBanco(
        id:$id
      )
    }
  """;
  return query;
}
String getQueryObtenerBancos(){
  String query="";
  query=r"""
  query obtenerBancos{
    obtenerBancos{
      id
      nombre_banco
      link_logo_banco
      web
      app
      pre_aprobacion
    }
  }
  """;
  return query;
}