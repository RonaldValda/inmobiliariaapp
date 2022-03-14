import 'package:flutter/cupertino.dart';
class EstadoWidgets with ChangeNotifier{
  bool verMapa=false;
  bool primeraPantalla=true;
  bool recargar=false;
  
  Map<String,dynamic> mapVerificacionCuenta={
    "email_verificado":false,
    "password_verificado":false
  };
  void setVerMapa(bool verMapa){
    if(verMapa){
       botonesAnteriorVisible=true;
       botonesPosteriorVisible=true;
       scrollControllerListaInmueble.removeListener(onScrollListener);
       scrollControllerListaInmueble.dispose();
       scrollControllerListaInmueble=ScrollController(
      keepScrollOffset: true,
      initialScrollOffset: offsetAnteriorController
    //initialScrollOffset: 200
  );
  scrollControllerListaInmueble.addListener(onScrollListener);
    }else{
      //scrollControllerListaInmueble.animateTo(50, duration: Duration(microseconds: 0), curve: Curves.ease);
    }
    desactivarListener=true;
    //scrollControllerListaInmueble.jumpTo(200);
    this.verMapa=verMapa;
    desactivarListener=false;
    notifyListeners();
  }
  bool get isVerMapa=>this.verMapa;
  Map<String,dynamic> get getMapVerificacionCuenta=>this.mapVerificacionCuenta;
  void setMapVerificacionCuentaItem(String clave,dynamic valor){
    this.mapVerificacionCuenta[clave]=valor;
    notifyListeners();
  }
  double offsetAnteriorController=0;
  double offsetPosteriorController=0;
  bool botonesAnteriorVisible=true;
  bool botonesPosteriorVisible=true;
  bool desactivarListener=false;
  ScrollController scrollControllerListaInmueble=ScrollController(
    keepScrollOffset: true,
    initialScrollOffset: -154
    //initialScrollOffset: 200
  );
  void init(){
    print("iniciando scroll");
    scrollControllerListaInmueble=ScrollController(
    keepScrollOffset: true,
    initialScrollOffset: 0
    );
    scrollControllerListaInmueble.addListener(onScrollListener);
    
    @override
    void dispose(){
      scrollControllerListaInmueble.removeListener(onScrollListener);
      scrollControllerListaInmueble.dispose();
      super.dispose();
    }
  }
  void reiniciarScroll()async{
    desactivarListener=true;
    int duration=(scrollControllerListaInmueble.offset~/4).toInt();
    scrollControllerListaInmueble.removeListener(onScrollListener);
    await scrollControllerListaInmueble.animateTo(-6, duration: Duration(milliseconds: duration), curve: Curves.easeIn);
    botonesAnteriorVisible=true;
    botonesPosteriorVisible=true;
    desactivarListener=false;
    notifyListeners();
    scrollControllerListaInmueble.addListener(onScrollListener);
  }
  void onScrollListener(){
    //print(scrollControllerListaInmueble);
    if(scrollControllerListaInmueble.offset==0){
      botonesAnteriorVisible=true;
      botonesPosteriorVisible=true;
      notifyListeners();
    }
    else{
      if(!desactivarListener){
        if(scrollControllerListaInmueble.offset>offsetAnteriorController){
          offsetAnteriorController=scrollControllerListaInmueble.offset;
          botonesAnteriorVisible=false;
          if(botonesAnteriorVisible!=botonesPosteriorVisible){
            botonesPosteriorVisible=botonesAnteriorVisible;
            notifyListeners();
          }
        }else if(scrollControllerListaInmueble.offset<offsetAnteriorController){
          offsetAnteriorController=scrollControllerListaInmueble.offset;
          botonesAnteriorVisible=true;
          if(botonesAnteriorVisible!=botonesPosteriorVisible){
            botonesPosteriorVisible=botonesAnteriorVisible;
            notifyListeners();
          }
        }
      }
    }
    //notifyListeners();
  }
}