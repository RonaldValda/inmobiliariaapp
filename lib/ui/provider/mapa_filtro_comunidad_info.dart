import 'package:flutter/cupertino.dart';

class MapaFiltroComunidadInfo with ChangeNotifier{
  Map<String,dynamic> _mapaFiltro={
    "iglesia":false,
    "parque_infantil":false,
    "escuela":false,
    "universidad":false,
    "plazuela":false
  };
  Map<String,dynamic> _mapaFiltroMas={
    "modulo_policial":false,
    "sauna_piscina_publica":false,
    "gym_publico":false,
    "centro_deportivo":false,
    "puesto_salud":false,
    "zona_comercial":false
  };
  Map<String,dynamic> get getMapaFiltro{
    return this._mapaFiltro;
  }
  void setMapaFiltro(Map<String,dynamic> mapaFiltro){
    this._mapaFiltro=mapaFiltro;
    notifyListeners();
  }
  void setMapaFiltroItem(String clave,dynamic valor){
    this._mapaFiltro[clave]=valor;
    notifyListeners();
  }
  Map<String,dynamic> get getMapaFiltroMas{
    return this._mapaFiltroMas;
  }
  void setMapaFiltroMas(Map<String,dynamic> mapaFiltro){
    this._mapaFiltroMas=mapaFiltro;
    notifyListeners();
  }
  void setMapaFiltroMasItem(String clave,dynamic valor){
    this._mapaFiltroMas[clave]=valor;
    notifyListeners();
  }
  void inicializarFiltros(){
    this._mapaFiltro["iglesia"]=false;
    this._mapaFiltro["parque_infantil"]=false;
    this._mapaFiltro["escuela"]=false;
    this._mapaFiltro["universidad"]=false;
    this._mapaFiltro["plazuela"]=false;
    this._mapaFiltroMas["modulo_policial"]=false;
    this._mapaFiltroMas["sauna_piscina_publica"]=false;
    this._mapaFiltroMas["gym_publico"]=false;
    this._mapaFiltroMas["centro_deportivo"]=false;
    this._mapaFiltroMas["puesto_salud"]=false;
    this._mapaFiltroMas["zona_comercial"]=false;
  }
}