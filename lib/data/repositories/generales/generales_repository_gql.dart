String getQueryObtenerDepartamentos(){
  String query="";
  query=r"""
  query obtenerDepartamentos{
    obtenerDepartamentos{
      id
      nombre_departamento
    }
  }
  """;
  return query;
}
String getQueryObtenerCiudades(){
  String query="";
  query=r"""
    query obtenerCiudades($id_departamento:ID){
      obtenerCiudades(
        id_departamento:$id_departamento
      ){
        id
        nombre_ciudad
      }
    }
  """;
  return query;
}
String getQueryObtenerGeneralesLugares(){
  String query=r"""
    query obtenerGeneralesLugares{
      obtenerGeneralesLugares{
        zonas{
          id
          nombre_zona
          coordenadas
          ciudad
        }
        ciudades{
          id
          nombre_ciudad
          departamento{
            id
            nombre_departamento
          }
        }
      }
    }
  """;
  return query;
}
String getMutationRegistrarDepartamento(){
  String query="";
  query=r"""
    mutation registrarDepartamento(
      $nombre_departamento:String
    ){
      registrarDepartamento(
        nombre_departamento:$nombre_departamento
      ){
        id
        nombre_departamento
      }
    }
  """;
  return query;
}
String getMutationModificarDepartamento(){
  String query="";
  query=r"""
    mutation modificarDepartamento(
      $id_departamento:ID,
      $nombre_departamento:String
    ){
      modificarDepartamento(
        id:$id_departamento
        nombre_departamento:$nombre_departamento
      )
    }
  """;
  return query;
}
String getMutationEliminarDepartamento(){
  String query="";
  query=r"""
    mutation eliminarDepartamento(
      $id_departamento:ID
    ){
      eliminarDepartamento(
        id:$id_departamento
      )
    }
  """;
  return query;
}
String getMutationRegistrarCiudad(){
  String query="";
  query=r"""
    mutation registrarCiudad(
      $id_departamento:ID,
      $nombre_ciudad:String
    ){
      registrarCiudad(
        id_departamento:$id_departamento
        nombre_ciudad:$nombre_ciudad
      ){
        id
        nombre_ciudad
      }
    }
  """;
  return query;
}
String getMutationModificarCiudad(){
  String query="";
  query=r"""
    mutation modificarCiudad(
      $id_ciudad:ID
      $nombre_ciudad:String
    ){
      modificarCiudad(
        id:$id_ciudad
        nombre_ciudad:$nombre_ciudad
      )
    }
  """;
  return query;
}
String getMutationEliminarCiudad(){
  String query="";
  query=r"""
    mutation eliminarCiudad(
      $id_ciudad:ID
    ){
      eliminarCiudad(
        id:$id_ciudad
      )
    }
  """;
  return query;
}
String getQueryObtenerZonas(){
    String query="";
    query=r"""
    query obtenerZonas($id_ciudad:ID){
      obtenerZonas(
        id_ciudad:$id_ciudad){
        id
        nombre_zona
        coordenadas
      }
    }
    """;
    return query;
}
String getMutationRegistrarZona(){
    String query="";
    query=r"""
    mutation registrarZona(
      $id_ciudad:ID,
      $nombre_zona:String,
      $coordenadas:[Float]
    ){
        registrarZona(
          id_ciudad:$id_ciudad
          input:{
          nombre_zona:$nombre_zona
          coordenadas:$coordenadas
        }){
          id
          nombre_zona
          coordenadas
        }
      }
    """;
    return query;
  }
  String getMutationModificarZona(){
    String query="";
    query=r"""
    mutation modificarZona(
      $id_zona:ID,
      $nombre_zona:String,
      $coordenadas:[Float]
    ){
      modificarZona(
        id:$id_zona,
        input:{
          nombre_zona:$nombre_zona
          coordenadas:$coordenadas
      })
    }
    """;
    return query;
  }
  String getMutationEliminarZona(){
    String query="";
    query=r"""
    mutation eliminarZona(
      $id_zona:ID,
    ){
      eliminarZona(
        id:$id_zona
      )
    }
    """;
    return query;
  }
  String getQueryObtenerVersionesAPP(){
  String query="";
  query=r"""
    query obtenerVersionesAPP{
      obtenerVersionesAPP{
        id
        numero_version
        fecha_publicacion
        link_descarga
      }
    }
  """;
  return query;
}
