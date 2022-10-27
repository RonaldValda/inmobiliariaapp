String mutationRegisterPublicationPlanPayment(){
  String query="";
  query=r"""
  mutation registrarPlanesPagoPublicacion(
    $nombre_plan:String,$tipo_plan:String,$costo:Int,$modificaciones_permitidas:Int,$activo:Boolean
  ){
    registrarPlanesPagoPublicacion(
      input:{
        nombre_plan:$nombre_plan
        tipo_plan:$tipo_plan
        costo:$costo
        modificaciones_permitidas:$modificaciones_permitidas
        activo:$activo
      }
    ){
      id
    }
  }
  """;
  return query;
}
String mutationUpdatePublicationPlanPayment(){
  String query="";
  query=r"""
  mutation modificarPlanesPagoPublicacion(
    $id:ID,
    $nombre_plan:String,$tipo_plan:String,$costo:Int,$modificaciones_permitidas:Int,$activo:Boolean
  ){
    modificarPlanesPagoPublicacion(
      id:$id
      input:{
        nombre_plan:$nombre_plan
        tipo_plan:$tipo_plan
        costo:$costo
        modificaciones_permitidas:$modificaciones_permitidas
        activo:$activo
      }
    )
  }
  """;
  return query;
}
String mutationDeletePublicationPlanPayment(){
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
String queryGetPublicationPlansPayment(){
  String query="";
  query=r"""
  query obtenerPlanesPagoPublicacion(
    $tipo_plan:String
  ){
    obtenerPlanesPagoPublicacion(
      tipo_plan:$tipo_plan
    ){
      id
      nombre_plan
      tipo_plan
      costo
      modificaciones_permitidas
      activo
    }
  }
  """;
  return query;
}