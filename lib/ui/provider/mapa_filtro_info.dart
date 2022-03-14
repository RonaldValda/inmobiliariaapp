import 'package:flutter/cupertino.dart';

class MapaFiltrosInfo with ChangeNotifier{
  Map<String,dynamic> _mapaFiltro={
    "nombre_zona":"Zona 1",
    "tipo_inmueble":"Todos",
    "tipo_contrato":"Todos",
    "precio_inferior":0,
    "precio_superior":10000000,
    "dimension_inferior":0,
    "dimension_superior":20000,
    "favoritos":false
  };
  Map<String,dynamic> get getMapaFiltro{
    return _mapaFiltro;
  }
  void setMapaFiltro(Map<String,dynamic> mapaFiltro){
    this._mapaFiltro=mapaFiltro;
    notifyListeners();
  }
  void setMapaFiltroItem(String clave,dynamic valor){
    this._mapaFiltro[clave]=valor;
    notifyListeners();
  }
}