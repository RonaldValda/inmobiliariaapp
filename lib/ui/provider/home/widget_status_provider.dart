import 'package:flutter/cupertino.dart';
class WidgetStatusProvider with ChangeNotifier{
  bool _seeMap=false;

  double _offsetBeforeController=0;
  double _offsetAfterController=0;
  bool _buttonsBeforeVisible=true;
  bool _buttonsAfterVisible=true;
  bool _deactivateListener=false;

  ScrollController _scrollControllerProperties=ScrollController(
    keepScrollOffset: true,
    initialScrollOffset: -154
  );
  
  Map<String,dynamic> mapVerificacionCuenta={
    "email_verificado":false,
    "password_verificado":false
  };
  void setSeeMap(bool seeMap){
    if(seeMap){
       _buttonsBeforeVisible=true;
       _buttonsAfterVisible=true;
       _scrollControllerProperties.removeListener(onScrollListener);
       _scrollControllerProperties.dispose();
       _scrollControllerProperties=ScrollController(
          keepScrollOffset: true,
          initialScrollOffset: _offsetBeforeController
      );
      _scrollControllerProperties.addListener(onScrollListener);
    }else{
    }
    _deactivateListener=true;
    this._seeMap=seeMap;
    _deactivateListener=false;
    notifyListeners();
  }
  bool get seeMap => _seeMap;
  Map<String,dynamic> get getMapVerificacionCuenta=>this.mapVerificacionCuenta;
  void setMapVerificacionCuentaItem(String clave,dynamic valor){
    this.mapVerificacionCuenta[clave]=valor;
    notifyListeners();
  }
  
  void init(){
    print("iniciando scroll");
    _scrollControllerProperties=ScrollController(
      keepScrollOffset: true,
      initialScrollOffset: 0
    );
    _scrollControllerProperties.addListener(onScrollListener);
  }
  @override
  void dispose(){
    _scrollControllerProperties.removeListener(onScrollListener);
    _scrollControllerProperties.dispose();
    super.dispose();
  }
  void reiniciarScroll()async{
    _deactivateListener=true;
    int duration=(_scrollControllerProperties.offset~/4).toInt();
    _scrollControllerProperties.removeListener(onScrollListener);
    await _scrollControllerProperties.animateTo(-6, duration: Duration(milliseconds: duration), curve: Curves.easeIn);
    _buttonsBeforeVisible=true;
    _buttonsAfterVisible=true;
    _deactivateListener=false;
    notifyListeners();
  }
  void onScrollListener(){
    //print(scrollControllerListaInmueble);
    /*if(_scrollControllerProperties.offset==0){
      _buttonsBeforeVisible=true;
      _buttonsAfterVisible=true;
      notifyListeners();
    }
    else{
      if(!_deactivateListener){
        if(_scrollControllerProperties.offset>_offsetBeforeController){
          _offsetBeforeController=_scrollControllerProperties.offset;
          _buttonsBeforeVisible=false;
          if(_buttonsBeforeVisible!=_buttonsBeforeVisible){
            _buttonsBeforeVisible=_buttonsBeforeVisible;
            notifyListeners();
          }
        }else if(_scrollControllerProperties.offset<_offsetBeforeController){
          _offsetBeforeController=_scrollControllerProperties.offset;
          _buttonsBeforeVisible=true;
          if(_buttonsBeforeVisible!=_buttonsBeforeVisible){
            _buttonsBeforeVisible=_buttonsBeforeVisible;
            notifyListeners();
          }
        }
      }
    }*/
  }

  bool get buttonsBeforeVisible => _buttonsBeforeVisible;

  bool get buttonsAfterVisible => _buttonsAfterVisible;

  ScrollController get scrollControllerProperties => _scrollControllerProperties;
}