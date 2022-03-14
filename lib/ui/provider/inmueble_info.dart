import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/generales.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/domain/entities/usuario.dart';
class InmuebleInfo with ChangeNotifier{
  InmuebleTotal inmuebleTotal=InmuebleTotal.vacio();
  InmuebleTotal inmuebleTotalCopia=InmuebleTotal.vacio();
  InmuebleTotal inmuebleReportado=InmuebleTotal.vacio();
  int caracteristicaSeleccionada=-1;
  bool cambiarSliding=true;
  List<Zona> zonas=[];
  List<PasoCategoria> pasoCategorias=[
    PasoCategoria(
      numero: 1, 
      categoria: "Planes", 
      seleccionado: true
    ),
    PasoCategoria(
      numero: 2, 
      categoria: "Generales", 
      seleccionado: false
    ),
    PasoCategoria(
      numero: 3, 
      categoria: "Internas", 
      seleccionado: false
    ),
    PasoCategoria(
      numero: 4, 
      categoria: "Comunidad", 
      seleccionado: false
    ),
    PasoCategoria(
      numero: 5, 
      categoria: "Otros", 
      seleccionado: false
    )
  ];
  void onPasoCategoriaSelected(int numero){
    //final categoriaSelected=pasoCategorias.where((element) => element.numero==index).first;
    for(int i=0;i<pasoCategorias.length;i++){
      pasoCategorias[i]=pasoCategorias[i].copyWith(pasoCategorias[i].numero==numero);
    }
    notifyListeners();
  }
  void avanzarPasoCategoria(bool adelante){
    int i=0;
    for(i=0;i<pasoCategorias.length;i++){
      if(pasoCategorias[i].seleccionado){
        break;
      }
    }
    if(adelante){
      if(i<=pasoCategorias.length){
        onPasoCategoriaSelected(pasoCategorias[i].numero+1);
      }
    }else{
      if(i>0){
        onPasoCategoriaSelected(pasoCategorias[i].numero-1);
      }
    }
  }
  bool seleccionadoCategoria(String categoria){
    for(int i=0;i<pasoCategorias.length;i++){
      if(pasoCategorias[i].categoria.toUpperCase()==categoria.toUpperCase()){
        if(pasoCategorias[i].seleccionado){
          return true;
        }
      }
    }
    return false;
  }
  void setInmueblesTotal(InmuebleTotal inmuebleTotal){
    this.inmuebleTotal=inmuebleTotal;
    this.inmuebleTotalCopia=InmuebleTotal.copyWith(inmuebleTotal);
    notifyListeners();
  }
  void setInmuebleTotalCopia(InmuebleTotal inmuebleTotal){
    this.inmuebleTotalCopia=inmuebleTotal;
    notifyListeners();
  }
  void setInmuebleReportado(InmuebleTotal inmuebleTotal){
    this.inmuebleReportado=inmuebleTotal;
  }
  InmuebleTotal get getInmuebleTotal{
    return this.inmuebleTotal;
  }
  InmuebleTotal get getInmuebleTotalCopia{
    return this.inmuebleTotalCopia;
  }
  void setZonas(List<Zona> zonass){
    this.zonas=zonass;
    notifyListeners();
  }
  List<Zona> get getZonas{
    return this.zonas;
  }
  void setPropietario(Usuario propietario){
    this.inmuebleTotal.propietario=propietario;
    notifyListeners();
  }
  void setCaracteristicaSeleccionada(int n){
    cambiarSliding=true;
    this.caracteristicaSeleccionada=n;
    notifyListeners();
  }
  void setPasoRegistro(int paso){

  }
  TabController? tabController;
  List<ImagenesTabCategoria> tabs=[];
  List<ImagenItem> items=[];
  List<List<dynamic>> imagenesCategorias=[];
  List<double> offsetCategorias=[];
  //List<String> nombresCategorias=["Dormitorios","Baños","Garaje"];
  ScrollController scrollController=ScrollController();
  ScrollController scrollControllerCategoria=ScrollController();
  PageController pageController=PageController();
  int currentPage=0;
  List<String> categoriasKeys=[];
  bool listen=true;
  void init(TickerProvider ticker,List<List<dynamic>> imagenesCategorias,List<String> nombresCategorias,List<String> categoriasKeys,double imagenWidth,double imageHeight){
    tabController=TabController(length: nombresCategorias.length, vsync: ticker);
    tabs=[];
    items=[];
    offsetCategorias=[];
    this.imagenesCategorias=imagenesCategorias;
    this.categoriasKeys=categoriasKeys;
    double offsetFrom=0.0;
    double offsetTo=0.0;
    offsetCategorias.add(0);
    currentPage=0;
    for(int i=0;i<imagenesCategorias.length;i++){
      if(i>0){
        offsetCategorias.add((i-1)+120+offsetCategorias[i-1]);
        //offsetCategorias.add((nombresCategorias[i-1].length)*9+offsetCategorias[i-1]);
        offsetFrom+=imagenesCategorias[i-1].length*imagenWidth;
      }
      if(i<imagenesCategorias.length-1){
        offsetTo=offsetFrom+imagenesCategorias[i].length*imagenWidth;
      }else{
        offsetTo=double.infinity;
      }
      //print("${offsetFrom.toString()} ${offsetTo.toString()}");
      //print(nombresCategorias[i]);
      tabs.add(ImagenesTabCategoria(
        nombre:nombresCategorias[i],imagenes:imagenesCategorias[i],selected:(i==0),
        offsetFrom: offsetFrom,
        offsetTo: offsetTo
      ));
      
      //final imagenes=<dynamic>[];
      for(int j=0;j<imagenesCategorias[i].length;j++){
        items.add(ImagenItem(imagen: imagenesCategorias[i][j]));
      }
      
    }
    scrollController.addListener(onScrollListener);
    //pageController.addListener(onPageListener);
    @override
    void dispose(){
      scrollControllerCategoria.dispose();
      //pageController.removeListener(onPageListener);
      pageController.dispose();
      scrollController.removeListener(onScrollListener);
      scrollController.dispose();
      tabController!.dispose();
      super.dispose();
    }
  }
  
  void moverInicioController(){
    try{
      if(imagenesCategorias.length>0){
        onCategoriaSelected(0,animationRequired: false);
        imagenesCategorias=[];
      }
      //scrollController=ScrollController();
      //scrollControllerCategoria=ScrollController();
    }catch(e){
      print(e);
    }
    //super.dispose();
  }
  void onScrollListener(){
    if(listen){
      for(int j=0;j<tabs.length;j++){
        final tab=tabs[j];
        if(scrollController.offset>=tab.offsetFrom&&scrollController.offset<=tab.offsetTo&&!tab.selected){
          onCategoriaSelected(j,animationRequired: false);
          scrollControllerCategoria.animateTo(offsetCategorias[j], duration: Duration(milliseconds: 500), curve: Curves.linear);
          tabController!.animateTo(j);
          break;
        }
      }
    }
  }
  /*void onPageListener(){
    if(listen){
      scrollControllerCategoria.animateTo(offsetCategorias[currentPage], duration: Duration(milliseconds: 500), curve:Curves.linear);
      buscarCategoria(currentPage);
     // onCategoriaSelected(buscarCategoria(currentPage),animationRequired: false);
    }
  }*/
  void buscarCategoria(int currentPage){
    if(listen){
      int categoriaPosicion=0;
      int sumatoria=0;
      for(int i=0;i<imagenesCategorias.length;i++){
        sumatoria+=imagenesCategorias[i].length;
        if(currentPage<sumatoria){
          categoriaPosicion=i;
          break;
        }
        
      }
      scrollControllerCategoria.animateTo(offsetCategorias[categoriaPosicion], duration: Duration(milliseconds: 500), curve:Curves.linear);
      onCategoriaSelected(categoriaPosicion,animationRequired: false);
    }
  }
  int buscarPosicionCategoria(String clave){
    
    int index=0;
    for(index=0;index<categoriasKeys.length;index++){
      if(categoriasKeys[index]==clave){
        break;
      }
    }
    return index;
  }
  void onCategoriaSelected(int index,{bool animationRequired=true}) async{
    final tabSelected=tabs[index];
    for(int i=0;i<tabs.length;i++){
      tabs[i]=tabs[i].copyWith(tabSelected.nombre==tabs[i].nombre);
    }
    
    //
    notifyListeners();
    if(animationRequired){
      listen=false;
      int sumatoria=0;
      if(index>0){
        for(int i=0;i<index;i++){
          sumatoria+=imagenesCategorias[i].length;
        }
      }

      await pageController.animateToPage(sumatoria, duration: Duration(milliseconds: 200), curve: Curves.linear);
      await scrollControllerCategoria.animateTo(offsetCategorias[index], duration: Duration(milliseconds: 200), curve: Curves.linear);
      //await scrollController.animateTo(tabs[index].offsetFrom, duration: Duration(milliseconds: 500), curve: Curves.linear);
      listen=true;
    }
  }
}
class ImagenesTabCategoria{
  const ImagenesTabCategoria({required this.nombre,required this.imagenes,required this.selected,required this.offsetFrom,required this.offsetTo});
  final String nombre;
  final List<dynamic> imagenes;
  final bool selected;
  final double offsetFrom;
  final double offsetTo;
  ImagenesTabCategoria copyWith(bool selected)=>ImagenesTabCategoria(nombre: this.nombre,imagenes: this.imagenes,selected: selected,offsetFrom: this.offsetFrom,offsetTo:this.offsetTo);
}
class ImagenItem{
  final String imagen;
  ImagenItem({required this.imagen});
}
class PasoCategoria{
  int numero;
  String categoria;
  bool seleccionado;
  PasoCategoria({
    required this.numero,
    required this.categoria,
    required this.seleccionado
  });
  factory PasoCategoria.vacio(){
    return PasoCategoria(numero:0,categoria: "", seleccionado: false);
  }
  PasoCategoria copyWith(bool select)=>PasoCategoria(numero: this.numero, categoria: this.categoria, seleccionado: select);
}