class AppVersion{
  String id;
  String versionNumber;
  String publicationDate;
  String downloadLink;
  AppVersion({
    required this.id,
    required this.versionNumber,
    required this.publicationDate,
    required this.downloadLink
  });
  factory AppVersion.fromMap(Map<String,dynamic> map){
    return AppVersion(
      id: map["id"],
      versionNumber: map["numero_version"],
      publicationDate: map["fecha_publicacion"],
      downloadLink: map["link_descarga"]
    );
  }
  factory AppVersion.empty(){
    return AppVersion(
      id: "",
      versionNumber: "", 
      publicationDate: "", 
      downloadLink: ""
    );
  }
  bool checkVersion(){
    print(this.versionNumber==myAppVersionCurrent.versionNumber);
    return this.versionNumber==myAppVersionCurrent.versionNumber;
  }

  AppVersion get myAppVersionCurrent  => AppVersion(
      id: "", versionNumber: "1.0.0.1", 
      publicationDate: "", downloadLink: ""
  );
}