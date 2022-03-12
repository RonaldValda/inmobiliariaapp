import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/administrador_zona.dart';
import 'package:inmobiliariaapp/domain/entities/generales.dart';
import 'package:inmobiliariaapp/domain/entities/publicidad.dart';

class DatosGeneralesInfo with ChangeNotifier{
  List<Ciudad> ciudades=[];
  List<Departamento> departamentos=[];
  List<Zona> zonas=[];
  List<Zona> zonasCiudad=[];
  List<Zona> zonasLibres=[];
  Ciudad ciudadSeleccionada=Ciudad.vacio();
  List<Publicidad> publicidadesRectangulo=[];
  List<Publicidad> publicidadesCuadrado=[];
  void setPublicidadRectangulo(List<Publicidad> publicidades){
    this.publicidadesRectangulo=publicidades;
  }
  void setPublicidadCuadrado(List<Publicidad> publicidades){
    this.publicidadesCuadrado=publicidades;
  }
  void setCiudades(List<Ciudad> ciudades){
    this.ciudades=ciudades;
  }
  void setDepartamentos(List<Departamento> departamento){
    this.departamentos=departamentos;
  }
  void setZonas(List<Zona> zonas){
    this.zonas=zonas;
    seleccionarZonasCiudad(ciudades[0].id);
  }
  
  void seleccionarZonasCiudad(String idCiudad){
    zonasCiudad=[];
    zonasCiudad.add(Zona.vacio());
    zonasCiudad[0].nombreZona="Cualquiera";
    zonasCiudad.addAll(zonas.where((element) => element.idCiudad==idCiudad));
  }
  void setCiudad(c){
    this.ciudadSeleccionada=c;
  }
  void seleccionarZonasLibres(List<AdministradorZona> administradorZonas){
    zonasLibres=[];
    for(int i=1;i<zonasCiudad.length;i++){
      int contador=0;
      for(int j=0;j<administradorZonas.length;j++){
        if(administradorZonas[j].zona.id==zonasCiudad[i].id){
          contador++;
          break;
        }
      }
      if(contador==0){
        zonasLibres.add(zonasCiudad[i]);
      }
    }
    notifyListeners();
  }
}