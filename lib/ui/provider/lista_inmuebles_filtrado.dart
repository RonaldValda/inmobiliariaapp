import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/domain/usecases/property/filter_properties.dart';

import '../pages/home/widgets/home/container_properties.dart';
class ListadoInmueblesFiltrado with ChangeNotifier{
  List<PropertyTotal> inmueblessTotal=[];
  List<PropertyTotal> inmueblesTotalGeneralAux=[];
  List<PropertyTotal> inmueblessTotalGeneral=[];
  List<PropertyTotal> inmueblesBuscados=[];
  List<PropertyTotal> inmueblesNuevos=[];
  int filtroBuscadoSeleccionado=-1;
  bool filtrar=false;
  bool consultarBD=false;
  int mayorVistos=0;
  int mayorDobleVistos=0;
  List<int> limitesVistos=[];
  List<int> limitesDobleVistos=[];
  List<Color> colores=[Colors.red,Colors.blue,Colors.orange,Colors.green,Colors.purple,Colors.pink];
  void clasificarIndicadores(){
    List<int> porcentajes=[20,40,60,80,100];  
    limitesVistos=[];
    limitesDobleVistos=[];
    for(int i=0;i<porcentajes.length;i++){
      limitesVistos.add((mayorVistos*porcentajes[i]/100).ceil());
      limitesDobleVistos.add((mayorDobleVistos*porcentajes[i]/100).ceil());
    }
    notifyListeners();
  }
  Color  getColorValor(int valor,List<int> limites){
    print("limite ${limites.length}");
    int i=1;
    for(i=1;i<limites.length;i++){
      if(i==0){
        if(valor>=0&&valor<=limites[i]){
          break;
        }
      }else{
        if(valor>=(limites[i-1]+1)&&valor<=limites[i]){
          print("hola");
          break;
        }
      }
    }
    return colores[i];
  }
  void setInmueblesBuscados(List<PropertyTotal> inmuebleTotal){
    this.inmueblesBuscados=inmueblesBuscados;
  }
  void setInmueblesTotal(List<PropertyTotal> inmuebleTotal){
    this.inmueblessTotal=inmuebleTotal;
    //inmueblesTotalAux=[];
    //this.inmueblesTotalAux.addAll(inmueblesTotal);
    //notifyListeners();
  }
  void setFiltrar(bool filtrar){
    this.filtrar=filtrar;
    /*if(isFiltrar){
      setInmueblesTotalGeneral(inmueblesTotalGeneralAux);
      notifyListeners();
    }*/
    
  }
  void setInmueblesNuevos(List<PropertyTotal> inmuebles){
    this.inmueblesNuevos=inmuebles;
  }
  void setFiltroBuscadoSeleccionado(int selected){
    this.filtroBuscadoSeleccionado=selected;
    notifyListeners();
  }
  bool get isFiltrar{
    return this.filtrar;
  }
  void setConsultarBD(bool consultar){
    this.consultarBD=consultar;
  }
  bool get isConsultar{
    return this.consultarBD;
  }
  List<PropertyTotal> get getInmueblesTotal{
    return this.inmueblessTotal;
  }
  void setInmueblesTotalGeneral(List<PropertyTotal> inmueblesTotalGeneral){
    this.inmueblessTotalGeneral=inmueblesTotalGeneral;
    this.inmueblesTotalGeneralAux=inmueblesTotalGeneral;
    //notifyListeners();
  }
  List<PropertyTotal> get getInmueblesTotalGeneral{
    return this.inmueblessTotalGeneral;
  }
  void setInmueblesItem(PropertyTotal inmuebleTotal,Map<String,dynamic> mapaFiltroOrden,String accion){
    
    //setInmueblesTotalGeneral(modificarListaInmuebleTotal(inmueblesTotalGeneral, inmuebleTotal,accion));
    //inmueblesTotalGeneralAux=[];
    
   // print("antes ${inmueblesTotalGeneral[inmueblesTotalGeneral.length-1].getInmueble.indice}");
    inmueblesTotalGeneral=updateListPropertyTotal(inmueblesTotalGeneral, inmuebleTotal,accion);
   // print("despues ${inmueblesTotalGeneral[inmueblesTotalGeneral.length-1].getInmueble.indice}");
    //modificarListaInmuebleTotal(inmueblesTotalAux, inmuebleTotal,accion);
    
    notifyListeners();
    //notifyListeners();
    //modificarListaInmuebleTotal(inmueblesTotal, inmuebleTotal,accion);
    //ordenarLista(inmueblesTotal, mapaFiltroOrden);
    
  }
}