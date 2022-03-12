import 'package:flutter/cupertino.dart';
class MapaFiltroPorUsuario with ChangeNotifier{
   Map<String,dynamic> _mapaFiltro={
    "vistos":false,
    "doble_visto":false,
    "favoritos":false,
  };
  Map<String,dynamic> _mapaFiltroMas={
    "contactados":false
  };
  Map<String,dynamic> get getMapaFiltro{
    return _mapaFiltro;
  }
  void setMapaFiltro(Map<String,dynamic> mapaFiltro){
    this._mapaFiltro=mapaFiltro;
    notifyListeners();
  }
  void setMapaFiltroItem(String clave,valor){
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
    this._mapaFiltro["vistos"]=false;
    this._mapaFiltro["doble_visto"]=false;
    this._mapaFiltro["favoritos"]=false;
    this._mapaFiltroMas["contactados"]=false;
    notifyListeners();
  }
}