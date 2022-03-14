String getMesLetra(int mes){
  List<String> meses=["","Enero","Febrero","Marzo","Abril","Mayo",
                      "Junio","Julio","Agosto","Septiembre",
                      "Octubre","Noviembre","Diciembre"];
  return meses[mes];
}
int getDiasMes(int mes,int anio){
  List<int> dias=[0,31,28,31,
                  30,31,30,
                  31,31,30,
                  31,30,31];
  if(anio%4==0){
    dias[2]=29;
  }
  return dias[mes];
}
Map<String,dynamic> getAdelantarDias(bool adelantar){
  DateTime tiempo=DateTime.now().toUtc();
  int dia=tiempo.day;
  int mes=tiempo.month;
  int anio=tiempo.year;
  int nuevoDia=0;
  int nuevoMes=0;
  int nuevoAnio=0;
  if(adelantar){
    if(dia+2>getDiasMes(mes, anio)){
      nuevoDia=dia+2-getDiasMes(mes, anio);
      if(mes+1>12){
        nuevoMes=1;
        nuevoAnio=anio+1;
      }else{
        nuevoMes=mes+1;
        nuevoAnio=anio;
      }
    }else{
      nuevoDia=dia+2;
      nuevoMes=mes;
      nuevoAnio=anio;
    }
  }else{
    nuevoDia=dia;
    nuevoMes=mes;
    nuevoAnio=anio;
  }
  Map<String,dynamic> map={
    "dia":nuevoDia,
    "mes":nuevoMes,
    "anio":nuevoAnio
  };
  return map;
}
List<int> getPlanesPagoMes(){
  List<int> planes=[70,120,150];
  return planes;
}
int getMontoPagar(Map<String,dynamic> mapFechaActivacion,int montoMes){
  int diasTotal=mapFechaActivacion["dia"];
  diasTotal=30-diasTotal+1;
  int costoTotal=(montoMes/30*diasTotal).floor();
  return costoTotal;
}
String formatFechaUTC(DateTime time){
  //print("antes $time");
  DateTime timeNow=time.toLocal();
 // print("despues $timeNow");
  
  String fecha=timeNow.day.toString()+"-"+timeNow.month.toString()+"-"+timeNow.year.toString()+" "+timeNow.hour.toString()+":"+timeNow.minute.toString();
  return fecha;
}