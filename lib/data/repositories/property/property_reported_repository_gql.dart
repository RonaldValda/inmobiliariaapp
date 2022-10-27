String mutationReportProperty(){
    String query="";
    query=r"""
      mutation reportarInmueble(
        $id_inmueble:ID,
        $id_solicitante:ID,
        $vendido_multiples_lugares:Boolean,
        $contenido_falso_imagen:Boolean,
        $contenido_falso_texto:Boolean,
        $contenido_inapropiado:Boolean,
        $otro:Boolean,
        $observaciones_solicitud:String,
      ){
        reportarInmueble(
          id_inmueble:$id_inmueble,
          id_solicitante:$id_solicitante,
          input:{
            vendido_multiples_lugares:$vendido_multiples_lugares
            contenido_falso_imagen:$contenido_falso_imagen
            contenido_falso_texto:$contenido_falso_texto
            contenido_inapropiado:$contenido_inapropiado
            otro:$otro
            observaciones_solicitud:$observaciones_solicitud
          }
        ){
          fecha_solicitud
          fecha_respuesta
        }
      }
    """;
    return query;
  }
  String queryGetPropertiesReported(){
  String query="";
  query=r"""
  query obtenerReportesInmueble(
    $id_usuario:ID,$id_inmueble:ID,$estado_1:Boolean,$estado_2:Boolean
  ){
    obtenerReportesInmueble(
      id_usuario:$id_usuario
      id_inmueble:$id_inmueble
      estado_1:$estado_1
      estado_2:$estado_2
    ){
      id
      fecha_solicitud
      fecha_respuesta
      respuesta_entregada
      tipo_solicitud
      respuesta
      observaciones
      link_respaldo_solicitud
      link_respaldo_respuesta
      solicitud_terminada
    }
  }
  """;
  return query;
}