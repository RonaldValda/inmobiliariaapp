import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/container_listado_inmuebles.dart';
import 'package:inmobiliariaapp/domain/usecases/inmueble/filtrado_inmuebles.dart';
class ListadoInmueblesFiltrado with ChangeNotifier{
  List<InmuebleTotal> inmueblessTotal=[];
  List<InmuebleTotal> inmueblesTotalGeneralAux=[];
  List<InmuebleTotal> inmueblessTotalGeneral=[];
  List<InmuebleTotal> inmueblesBuscados=[];
  List<InmuebleTotal> inmueblesNuevos=[];
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
  void setInmueblesBuscados(List<InmuebleTotal> inmuebleTotal){
    this.inmueblesBuscados=inmueblesBuscados;
  }
  void setInmueblesTotal(List<InmuebleTotal> inmuebleTotal){
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
  void setInmueblesNuevos(List<InmuebleTotal> inmuebles){
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
  List<InmuebleTotal> get getInmueblesTotal{
    return this.inmueblessTotal;
  }
  void setInmueblesTotalGeneral(List<InmuebleTotal> inmueblesTotalGeneral){
    this.inmueblessTotalGeneral=inmueblesTotalGeneral;
    this.inmueblesTotalGeneralAux=inmueblesTotalGeneral;
    //notifyListeners();
  }
  List<InmuebleTotal> get getInmueblesTotalGeneral{
    return this.inmueblessTotalGeneral;
  }
  void setInmueblesItem(InmuebleTotal inmuebleTotal,Map<String,dynamic> mapaFiltroOrden,String accion){
    
    //setInmueblesTotalGeneral(modificarListaInmuebleTotal(inmueblesTotalGeneral, inmuebleTotal,accion));
    //inmueblesTotalGeneralAux=[];
    
   // print("antes ${inmueblesTotalGeneral[inmueblesTotalGeneral.length-1].getInmueble.indice}");
    inmueblesTotalGeneral=modificarListaInmuebleTotal(inmueblesTotalGeneral, inmuebleTotal,accion);
   // print("despues ${inmueblesTotalGeneral[inmueblesTotalGeneral.length-1].getInmueble.indice}");
    //modificarListaInmuebleTotal(inmueblesTotalAux, inmuebleTotal,accion);
    
    notifyListeners();
    //notifyListeners();
    //modificarListaInmuebleTotal(inmueblesTotal, inmuebleTotal,accion);
    //ordenarLista(inmueblesTotal, mapaFiltroOrden);
    
  }
}