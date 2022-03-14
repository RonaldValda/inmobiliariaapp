import 'package:flutter/cupertino.dart';

class MapaFiltroGeneralesInfo with ChangeNotifier{
  Map<String,dynamic> _mapaFiltro={
    "precio_min":0,
    "precio_max":-1000,
    "precio_sel":"Cualquiera",
    "superficie_terreno_min":0,
    "superficie_terreno_max":-1,
    "superficie_terreno_sel":"Cualquiera",
    "superficie_construccion_min":0,
    "superficie_construccion_max":-1,
    "superficie_construccion_sel":"Cualquiera",
    "tamanio_frente_min":0,
    "tamanio_frente_max":-1,
    "tamanio_frente_sel":"Cualquiera",
    "antiguedad_construccion_min":0,
    "antiguedad_construccion_max":-1,
    "antiguedad_construccion_sel":"Cualquiera",
  };
  bool loading=false;
  Map<String,dynamic> _mapaFiltroMas={
    "mascotas_permitidas":false,
    "sin_hipoteca":false,
    "construccion_estrenar":false,
    "materiales_primera":false,
    "proyecto_preventa":false,
    "inmueble_compartido":false,
    "numero_duenios":1,
    "servicios_basicos":false,
    "gas_domiciliario":false,
    "wifi":false,
    "medidor_independiente":false,
    "termotanque":false,
    "calle_asfaltada":false,
    "transporte":false,
    "preparado_discapacidad":false,
    "papeles_orden":false,
    "habilitado_credito":false,
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
  void setMapaFiltroItem2(String clave1,dynamic valor1,String clave2,dynamic valor2){
    this._mapaFiltro[clave1]=valor1;
    this._mapaFiltro[clave2]=valor2;
    notifyListeners();
  }
  Map<String,dynamic> get getMapaFiltroMas{
    return _mapaFiltroMas;
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
  void setLoading(bool valor){
    this.loading=valor;
    notifyListeners();
  }
  bool get isLoading{
    return this.loading;
  }
  void inicializarFiltros(){
    this._mapaFiltro["superficie_terreno_min"]=0;
    this._mapaFiltro["superficie_terreno_max"]=-1;
    this._mapaFiltro["superficie_terreno_sel"]="Cualquiera";
    this._mapaFiltro["superficie_construccion_min"]=0;
    this._mapaFiltro["superficie_construccion_max"]=-1;
    this._mapaFiltro["superficie_construccion_sel"]="Cualquiera";
    this._mapaFiltro["tamanio_frente_min"]=0;
    this._mapaFiltro["tamanio_frente_max"]=-1;
    this._mapaFiltro["tamanio_frente_sel"]="Cualquiera";
    this._mapaFiltro["antiguedad_construccion_min"]=0;
    this._mapaFiltro["antiguedad_construccion_max"]=-1;
    this._mapaFiltro["antiguedad_construccion_sel"]="Cualquiera";
    this._mapaFiltroMas["mascotas_permitidas"]=false;
    this._mapaFiltroMas["sin_hipoteca"]=false;
    this._mapaFiltroMas["construccion_estrenar"]=false;
    this._mapaFiltroMas["materiales_primera"]=false;
    this._mapaFiltroMas["proyecto_preventa"]=false;
    this._mapaFiltroMas["inmueble_compartido"]=false;
    this._mapaFiltroMas["numero_duenios"]=1;
    this._mapaFiltroMas["servicios_basicos"]=false;
    this._mapaFiltroMas["gas_domiciliario"]=false;
    this._mapaFiltroMas["wifi"]=false;
    this._mapaFiltroMas["medidor_independiente"]=false;
    this._mapaFiltroMas["termotanques"]=false;
    this._mapaFiltroMas["calle_asfaltada"]=false;
    this._mapaFiltroMas["transporte"]=false;
    this._mapaFiltroMas["preparado_discapacidad"]=false;
    this._mapaFiltroMas["papeles_orden"]=false;
    this._mapaFiltroMas["habilitado_credito"]=false;
    //notifyListeners();
  }
}