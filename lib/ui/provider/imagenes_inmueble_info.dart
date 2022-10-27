import 'package:flutter/material.dart';
class ImagenesInmueblesInfo with ChangeNotifier{
  TabController? tabController;
  List<ImagenesTabCategoria> tabs=[];
  List<ImagenItem> items=[];
  List<List<dynamic>> imagenesCategorias=[];
  List<double> offsetCategorias=[];
  //List<String> nombresCategorias=["Dormitorios","Baños","Garaje"];
  ScrollController scrollController=ScrollController();
  ScrollController scrollControlllerCategoria=ScrollController();
  bool listen=true;
  void init(TickerProvider ticker,List<List<dynamic>> imagenesCategorias,List<String> nombresCategorias,double imagenWidth){
    tabController=TabController(length: nombresCategorias.length, vsync: ticker);
    tabs=[];
    items=[];
    offsetCategorias=[];
    this.imagenesCategorias=imagenesCategorias;
    double offsetFrom=0.0;
    double offsetTo=0.0;
    offsetCategorias.add(0);
    for(int i=0;i<imagenesCategorias.length;i++){
      if(i>0){
        offsetCategorias.add(nombresCategorias[i-1].length*9+offsetCategorias[i-1]);
        offsetFrom+=imagenesCategorias[i-1].length*imagenWidth;
      }
      if(i<imagenesCategorias.length-1){
        offsetTo=offsetFrom+imagenesCategorias[i].length*imagenWidth;
      }else{
        offsetTo=double.infinity;
      }
      //print("${offsetFrom.toString()} ${offsetTo.toString()}");
      tabs.add(ImagenesTabCategoria(
        nombre:nombresCategorias[i],imagenes:imagenesCategorias[i],selected:(i==0),
        offsetFrom: offsetFrom,
        offsetTo: offsetTo
      ));
      
      //final imagenes=<dynamic>[];
      for(int j=0;j<imagenesCategorias[i].length;j++){
        //print(imagenesCategorias[i][j]);
        items.add(ImagenItem(imagen: imagenesCategorias[i][j]));
      }
      
    }
    scrollController.addListener(onScrollListener);
    
    
  }
  @override
  void dispose(){
    scrollControlllerCategoria.dispose();
    scrollController.removeListener(onScrollListener);
    scrollController.dispose();
    tabController!.dispose();
    super.dispose();
  }
  void onScrollListener(){
    if(listen){
      for(int j=0;j<tabs.length;j++){
        final tab=tabs[j];
        if(scrollController.offset>=tab.offsetFrom&&scrollController.offset<=tab.offsetTo&&!tab.selected){
          onCategoriaSelected(j,animationRequired: false);
          scrollControlllerCategoria.animateTo(offsetCategorias[j], duration: Duration(milliseconds: 500), curve: Curves.linear);
          tabController!.animateTo(j);
          break;
        }
      }
    }
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
      await scrollController.animateTo(tabs[index].offsetFrom, duration: Duration(milliseconds: 500), curve: Curves.linear);
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