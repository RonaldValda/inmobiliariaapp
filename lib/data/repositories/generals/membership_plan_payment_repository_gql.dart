String mutationUpdateMembershipPlanPayment(){
  String query="";
  query=r"""
    mutation modificarMembresiaPlanesPago(
      $id:ID,$nombre_plan:String,$unidad_medida_tiempo:String,$tiempo:Int,
      $costo:Int,$activo:Boolean
    ){
      modificarMembresiaPlanesPago(
        id:$id
        input:{
          nombre_plan:$nombre_plan
          unidad_medida_tiempo:$unidad_medida_tiempo
          tiempo:$tiempo
          costo:$costo
          activo:$activo
        }
      )
    }
  """;
  return query;
}
String queryGetMembershipPlansPayment(){
  String query="";
  query=r"""
    query obtenerMembresiaPlanesPago{
      obtenerMembresiaPlanesPago{
        id
        nombre_plan
        unidad_medida_tiempo
        tiempo
        costo
        activo
      }
    }
  """;
  return query;
}
String mutationRegisterMembershipPlanPayment(){
  String query="";
  query=r"""
    mutation registrarMembresiaPlanesPago(
      $nombre_plan:String,$unidad_medida_tiempo:String,$tiempo:Int,
      $costo:Int,$activo:Boolean
    ){
      registrarMembresiaPlanesPago(
        input:{
          nombre_plan:$nombre_plan
          unidad_medida_tiempo:$unidad_medida_tiempo
          tiempo:$tiempo
          costo:$costo
          activo:$activo
        }
      ){
        id
        nombre_plan
        unidad_medida_tiempo
        tiempo
        costo
        activo
      }
    }
  """;
  return query;
}
/*String getQueryObtenerPlanesPagoAgente(){
  String query="";
  query=r"""
  query obtenerPlanesPagoAgente{
    obtenerPlanesPagoAgente{
      id
      nombre_plan
      plan
      monto_mensual
      activo
    }
  }
  """;
  return query;
}*/