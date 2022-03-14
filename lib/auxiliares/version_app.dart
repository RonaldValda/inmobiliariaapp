class VersionAPP{
  String id;
  String numeroVersion;
  String fechaPublicacion;
  String linkDescarga;
  VersionAPP({
    required this.id,
    required this.numeroVersion,
    required this.fechaPublicacion,
    required this.linkDescarga
  });
  factory VersionAPP.fromMap(Map<String,dynamic> map){
    return VersionAPP(
      id: map["id"],
      numeroVersion: map["numero_version"],
      fechaPublicacion: map["fecha_publicacion"],
      linkDescarga: map["link_descarga"]
    );
  }
  factory VersionAPP.vacio(){
    return VersionAPP(
      id: "",
      numeroVersion: "", 
      fechaPublicacion: "", 
      linkDescarga: ""
    );
  }
  bool verificarVersion(VersionAPP version){
    if(this.numeroVersion==version.numeroVersion){
      return true;
    }
    return false;
  }
}