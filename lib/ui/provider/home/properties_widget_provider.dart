import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/property.dart';

class PropertiesWidgetProvider extends ChangeNotifier{
  int _featuresSelected=-1;
  bool _changeSliding=true;
  TabController? _tabController;
  List<ImagesTabCategory> _tabs=[];
  List<ImageItem> _items=[];
  List<List<dynamic>> _imagesCategories=[];
  List<double> _offsetCategories=[];
  //List<String> nombresCategorias=["Dormitorios","Baños","Garaje"];
  ScrollController _scrollController=ScrollController();
  ScrollController _scrollControllerCategories=ScrollController();
  PageController _pageController=PageController();
  // ignore: unused_field
  int _currentPage=0;
  List<String> _categoriesKeys=[];
  bool _listen=true;
  TickerProvider? _tickerProvider;
  double _imageWidth=0.0;
  // ignore: unused_field
  double _imageHeight=0.0;
  void init(TickerProvider ticker,Property property,double imagenWidth,double imageHeight){
    _tickerProvider=ticker;
    _imageWidth=imagenWidth;
    _imageHeight=imageHeight;
    loadConfig(property: property);
  }
  @override
    void dispose(){
    _scrollControllerCategories.dispose();
    //pageController.removeListener(onPageListener);
    _pageController.dispose();
    _scrollController.removeListener(onScrollListener);
    _scrollController.dispose();
    _tabController!.dispose();
    super.dispose();
  }

  void loadConfig({
    required Property property
  }){
    property.getCategoriesImages;
    _imagesCategories=[];
    _imagesCategories.addAll(property.imagesCategories);
    _categoriesKeys=[];
    _categoriesKeys.addAll(property.categoriesKeys);
    
    _tabController=TabController(length: property.imageCategories.length, vsync: _tickerProvider!);
    _tabs=[];
    _items=[];
    _offsetCategories=[];
    double offsetFrom=0.0;
    double offsetTo=0.0;
    _offsetCategories.add(0);
    _currentPage=0;
    for(int i=0;i<_imagesCategories.length;i++){
      if(i>0){
        _offsetCategories.add((i-1)+120+_offsetCategories[i-1]);
        offsetFrom+=_imagesCategories[i-1].length*_imageWidth;
      }
      if(i<_imagesCategories.length-1){
        offsetTo=offsetFrom+_imagesCategories[i].length*_imageWidth;
      }else{
        offsetTo=double.infinity;
      }
      //print("${offsetFrom.toString()} ${offsetTo.toString()}");
      //print(nombresCategorias[i]);
      _tabs.add(ImagesTabCategory(
        name:property.imageCategories[i],images:_imagesCategories[i],selected:(i==0),
        offsetFrom: offsetFrom,
        offsetTo: offsetTo
      ));
      
      //final imagenes=<dynamic>[];
      for(int j=0;j<_imagesCategories[i].length;j++){
        _items.add(ImageItem(image: _imagesCategories[i][j]));
      }
      
    }
    _scrollControllerCategories.jumpTo(0);
    _scrollController.addListener(onScrollListener);
  }

  void moveToStartController(){
    try{
      if(_imagesCategories.length>0){
        onCategorySelected(0,animationRequired: false);
        //_imagesCategories=[];
      }
      //scrollController=ScrollController();
      //scrollControllerCategoria=ScrollController();
    }catch(e){
      print(e);
    }
    //super.dispose();
  }
  void onScrollListener(){
    if(_listen){
      for(int j=0;j<_tabs.length;j++){
        final tab=_tabs[j];
        if(_scrollController.offset>=tab.offsetFrom&&_scrollController.offset<=tab.offsetTo&&!tab.selected){
          onCategorySelected(j,animationRequired: false);
          _scrollControllerCategories.animateTo(_offsetCategories[j], duration: Duration(milliseconds: 500), curve: Curves.linear);
          _tabController!.animateTo(j);
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
  void searchCategory(int currentPage){
    if(_listen){
      int categoryPosition=0;
      int summation=0;
      for(int i=0;i<_imagesCategories.length;i++){
        summation+=_imagesCategories[i].length;
        if(currentPage<summation){
          categoryPosition=i;
          break;
        }
        
      }
      _scrollControllerCategories.animateTo(_offsetCategories[categoryPosition], duration: Duration(milliseconds: 500), curve:Curves.linear);
      onCategorySelected(categoryPosition,animationRequired: false);
    }
  }
  int searchPositionCategory(String key){
    
    int index=0;
    for(index=0;index<_categoriesKeys.length;index++){
      if(_categoriesKeys[index]==key){
        break;
      }
    }
    return index;
  }
  void onCategorySelected(int index,{bool animationRequired=true}) async{
    final tabSelected=_tabs[index];
    for(int i=0;i<_tabs.length;i++){
      _tabs[i]=_tabs[i].copyWith(tabSelected.name==_tabs[i].name);
    }
    
    //
    notifyListeners();
    if(animationRequired){
      _listen=false;
      int sumatoria=0;
      if(index>0){
        for(int i=0;i<index;i++){
          sumatoria+=_imagesCategories[i].length;
        }
      }

      await _pageController.animateToPage(sumatoria, duration: Duration(milliseconds: 200), curve: Curves.linear);
      await _scrollControllerCategories.animateTo(_offsetCategories[index], duration: Duration(milliseconds: 200), curve: Curves.linear);
      //await scrollController.animateTo(tabs[index].offsetFrom, duration: Duration(milliseconds: 500), curve: Curves.linear);
      _listen=true;
    }
  }

  void setFeaturesSelected(int n){
    _changeSliding=true;
    _featuresSelected=n;
    notifyListeners();
  }
  int get featuresSelected => _featuresSelected;

  void setChangeSliding(bool value){
    _changeSliding=value;
  }
  bool get changeSliding => _changeSliding;

  List<ImageItem> get items => _items;

  PageController get pageController => _pageController;

  ScrollController get scrollControllerCategories => _scrollControllerCategories;

  List<ImagesTabCategory> get tabs => _tabs;

}
class ImagesTabCategory{
  const ImagesTabCategory({required this.name,required this.images,required this.selected,required this.offsetFrom,required this.offsetTo});
  final String name;
  final List<dynamic> images;
  final bool selected;
  final double offsetFrom;
  final double offsetTo;
  ImagesTabCategory copyWith(bool selected)=>ImagesTabCategory(name: this.name,images: this.images,selected: selected,offsetFrom: this.offsetFrom,offsetTo:this.offsetTo);
}
class ImageItem{
  final String image;
  ImageItem({required this.image});
}
