import 'package:flutter/cupertino.dart';

class MapaFiltroPrincipalesInfo with ChangeNotifier{
  Map<String,dynamic> _mapaFiltro={
    "tipo_inmueble":"Todos",
    "tipo_contrato":"Todos",
    "ciudad":"Sucre",
    "zona":"Cualquiera"
  };
  bool isCambio=true;
  bool loading=false;
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
  void setMapaFiltroItem4(String clave1,dynamic valor1,String clave2,dynamic valor2,String clave3,dynamic valor3,String clave4,dynamic valor4){
    this._mapaFiltro[clave1]=valor1;
    this._mapaFiltro[clave2]=valor2;
    this._mapaFiltro[clave3]=valor3;
    this._mapaFiltro[clave4]=valor4;
    notifyListeners();
  }
  void setLoading(bool valor){
    this.loading=valor;
    notifyListeners();
  }
  bool get isLoading{
    return this.loading;
  }
}