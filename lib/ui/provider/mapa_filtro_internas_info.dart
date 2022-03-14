import 'package:flutter/cupertino.dart';

class MapaFiltroInternasInfo with ChangeNotifier{
  Map<String,dynamic> _mapaFiltro={
    "plantas":0,
    "ambientes":0,
    "dormitorios":0,
    "banios":0,
    "garaje":0
  };
  Map<String,dynamic> _mapaFiltroMas={
    "amoblado":false,
    "lavanderia":false,
    "cuarto_lavado":false,
    "churrasquero":false,
    "azotea":false,
    "condominio_privado":false,
    "cancha":false,
    "piscina":false,
    "sauna":false,
    "jacuzzi":false,
    "estudio":false,
    "jardin":false,
    "porton_electrico":false,
    "aire_acondicionado":false,
    "calefaccion":false,
    "ascensor":false,
    "deposito":false,
    "sotano":false,
    "balcon":false,
    "tienda":false,
    "amurallado_terreno":false
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
    this._mapaFiltro["plantas"]=0;
    this._mapaFiltro["ambientes"]=0;
    this._mapaFiltro["dormitorios"]=0;
    this._mapaFiltro["banios"]=0;
    this._mapaFiltro["garaje"]=0;
    this._mapaFiltroMas["amboblado"]=false;
    this._mapaFiltroMas["lavanderia"]=false;
    this._mapaFiltroMas["cuarto_lavado"]=false;
    this._mapaFiltroMas["churrasquero"]=false;
    this._mapaFiltroMas["azotea"]=false;
    this._mapaFiltroMas["condominio_privado"]=false;
    this._mapaFiltroMas["cancha"]=false;
    this._mapaFiltroMas["piscina"]=false;
    this._mapaFiltroMas["sauna"]=false;
    this._mapaFiltroMas["jacuzzi"]=false;
    this._mapaFiltroMas["estudio"]=false;
    this._mapaFiltroMas["jardin"]=false;
    this._mapaFiltroMas["porton_electrico"]=false;
    this._mapaFiltroMas["aire_acondicionado"]=false;
    this._mapaFiltroMas["calefaccion"]=false;
    this._mapaFiltroMas["ascensor"]=false;
    this._mapaFiltroMas["deposito"]=false;
    this._mapaFiltroMas["sotano"]=false;
    this._mapaFiltroMas["balcon"]=false;
    this._mapaFiltroMas["tienda"]=false;
    this._mapaFiltroMas["estudio"]=false;
    this._mapaFiltroMas["amurallado_terreno"]=false;
  }
}