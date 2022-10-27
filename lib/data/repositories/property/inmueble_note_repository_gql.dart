String mutationSavePropertyNote(){
  String query="";
  query=r"""
  mutation guardarInmuebleNota(
    $id_inmueble:ID,$id_usuario:ID,$nota:String
  ){
    guardarInmuebleNota(
      id_inmueble:$id_inmueble
      id_usuario:$id_usuario
      nota:$nota
    ){
      id
      fecha
    }
  }
  """;
  return query;
}
String querySearchPropertyNote(){
  String query="";
  query=r"""
  query buscarInmuebleNota(
    $id_inmueble:ID,$id_usuario:ID
  ){
    buscarInmuebleNota(
      id_inmueble:$id_inmueble
      id_usuario:$id_usuario
    ){
      id
      nota
      fecha
    }
  }
  """;
  return query;
}