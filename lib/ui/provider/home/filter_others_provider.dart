import 'package:flutter/cupertino.dart';
import 'package:inmobiliariaapp/ui/pages/utils/constants.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_provider.dart';
import 'package:provider/provider.dart';
enum GetParameterOrder{
  defaults,
  price,
  landSurface,
  constructionSurface,
  constructionAntiquity,
  bedrooms,
  viewed,
  viewed_double,
  favorite,
}
enum GetOrder{
  asc,
  desc
}
class FilterOthersProvider with ChangeNotifier{
  Map<String,dynamic> _mapSelectableData={};
  Map<String,dynamic> _mapValuesSelectableData={};
  Map<String,dynamic> _mapFilter={
    "lowereds":false,
    "verifieds":false,
  };
  Map<String,dynamic> _mapFilterPlus={
    "initial_negotiated":false,
    "avanced_negotiated":false,
    "judicial_auctions":false,
    "video_2D":false,
    "tour_virtual_360":false,
    "video_tour_360":false,
    "days_P360_min":0,
    "days_P360_max":-1,
    "days_P360_sel":"Cualquiera",
  };
  Map<String,dynamic> _mapaFilterOrder={
    "paramenter":GetParameterOrder.price.index,
    "order":GetOrder.desc.index,
  };
  Map<String,dynamic> get mapFilter => _mapFilter;
  /*
  void setMapaFiltro(Map<String,dynamic> mapaFiltro){
    this._mapaFiltro=mapaFiltro;
    notifyListeners();
  }*/
  void setMapFilterItem(String key,value,{required BuildContext context}){
    this._mapFilter[key]=value;
    context.read<PropertiesProvider>().filterProperties(context: context);
    notifyListeners();
  }
  Map<String,dynamic> get mapFilterPlus => _mapFilterPlus;

  void setMapFilterPlusItem(String key,dynamic value,{bool selectable=false,required BuildContext context}){
    if(selectable){
      int index=_mapSelectableData[key].lastIndexOf(value);
      _mapFilterPlus[key+"_sel"]=value;
      _mapFilterPlus[key+"_min"]=_mapValuesSelectableData[key][index][0];
      _mapFilterPlus[key+"_max"]=_mapValuesSelectableData[key][index][1];
    }else{
      this._mapFilterPlus[key]=value;
    }
    context.read<PropertiesProvider>().filterProperties(context: context);
    notifyListeners();
  }
  void setMapFilterPlusItem2(String key1,dynamic value1,String key2,dynamic value2){
    this._mapFilterPlus[key1]=value1;
    this._mapFilterPlus[key2]=value2;
    notifyListeners();
  }

  Map<String,dynamic> get mapSelectableData => _mapSelectableData;
  void init(){
    _mapSelectableData={
      "days_P360":Constants.days360
    };
    _mapValuesSelectableData={
      "days_P360":Constants.valuesDays360
    };
    _mapFilter["lowereds"]=false;
    _mapFilter["verifieds"]=false;
    _mapFilterPlus["days_P360_sel"]="Cualquiera";
    _mapFilterPlus["days_P360_min"]=0;
    _mapFilterPlus["days_P360_max"]=-1;
    _mapFilterPlus.forEach((key, value) { 
      if(value is bool){
        _mapFilterPlus[key]=false;
      }
    });
    mapFilterOrder["parameter"]=GetParameterOrder.price.index;
    mapFilterOrder["order"]=GetOrder.desc.index;
    notifyListeners();
  }
  void setMapFilterOrder(String key,dynamic value,{required BuildContext context}){
    this._mapaFilterOrder[key]=value;
    context.read<PropertiesProvider>().filterProperties(context: context);
    notifyListeners();
  }
  
   Map<String,dynamic> get mapFilterOrder => _mapaFilterOrder;
}