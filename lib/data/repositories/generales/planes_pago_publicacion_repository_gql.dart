String getMutationRegistrarPlanesPagoPublicacion(){
  String query="";
  query=r"""
  mutation registrarPlanesPagoPublicacion(
    $nombre_plan:String,$costo:Int,$activo:Boolean
  ){
    registrarPlanesPagoPublicacion(
      input:{
        nombre_plan:$nombre_plan
        costo:$costo
        activo:$activo
      }
    ){
      id
    }
  }
  """;
  return query;
}
String getMutationModificarPlanesPagoPublicacion(){
  String query="";
  query=r"""
  mutation modificarPlanesPagoPublicacion(
    $id:ID,
    $nombre_plan:String,$costo:Int,$activo:Boolean
  ){
    modificarPlanesPagoPublicacion(
      id:$id
      input:{
        nombre_plan:$nombre_plan
        costo:$costo
        activo:$activo
      }
    )
  }
  """;
  return query;
}
String getMutationEliminarPlanesPagoPublicacion(){
  String query="";
  query=r"""
  mutation eliminarPlanesPagoPublicacion(
    $id:ID
  ){
    eliminarPlanesPagoPublicacion(
      id:$id
    )
  }
  """;
  return query;
}
String getQueryObtenerPlanesPagoPublicacion(){
  String query="";
  query=r"""
  query obtenerPlanesPagoPublicacion{
    obtenerPlanesPagoPublicacion{
      id
      nombre_plan
      costo
      activo
    }
  }
  """;
  return query;
}