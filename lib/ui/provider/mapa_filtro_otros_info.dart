import 'package:flutter/cupertino.dart';
enum getParametroOrden{
  precio,
  superficieTerreno,
  superficieConstruccion,
  tiempoConstruccion,
  dormitorios,
  vistos,
  doble_vistos,
  favoritos,
}
enum getOrden{
  ascendente,
  descendente
}
class MapaFiltroOtrosInfo with ChangeNotifier{
  Map<String,dynamic> _mapaFiltro={
    "rebajados":false,
    "verificados":false,
  };
  Map<String,dynamic> _mapaFiltroMas={
    "negociado_inicial":false,
    "negociado_avanzado":false,
    "remates_judiciales":false,
    "imagenes_2D":false,
    "video_2D":false,
    "tour_virtual_360":false,
    "video_tour_360":false,
    "dias_P360_min":0,
    "dias_P360_max":-1,
    "dias_P360_sel":"Cualquiera",
  };
  Map<String,dynamic> _mapaFiltroOrden={
    "parametro":getParametroOrden.precio.index,
    "orden":getOrden.descendente.index,
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
  void setMapaFiltroMasItem2(String clave1,dynamic valor1,String clave2,dynamic valor2){
    this._mapaFiltroMas[clave1]=valor1;
    this._mapaFiltroMas[clave2]=valor2;
    notifyListeners();
  }
  void inicializarFiltros(){
    this._mapaFiltro["rebajados"]=false;
    this._mapaFiltro["verificados"]=false;
    this._mapaFiltroMas["negociado_inicial"]=false;
    this._mapaFiltroMas["negociado_avanzado"]=false;
    this._mapaFiltroMas["remates_judiciales"]=false;
    this._mapaFiltroMas["dias_P360_min"]=0;
    this._mapaFiltroMas["dias_P360_max"]=-1;
    this._mapaFiltroMas["dias_P360_sel"]="Cualquiera";
    this._mapaFiltroMas["imagenes_2D"]=false;
    this._mapaFiltroMas["video_2D"]=false;
    this._mapaFiltroMas["tour_virtual"]=false;
    this._mapaFiltroMas["video_tour"]=false;
    this._mapaFiltroOrden["parametro"]=getParametroOrden.precio.index;
    this._mapaFiltroOrden["orden"]=getOrden.descendente.index;
    notifyListeners();
  }
  void setMapaFiltroOrden(String clave,dynamic valor){
    this._mapaFiltroOrden[clave]=valor;
    //print(_mapaFiltroOrden);
    notifyListeners();
  }
  Map<String,dynamic> get getMapaFiltroOrden=>this._mapaFiltroOrden;
}