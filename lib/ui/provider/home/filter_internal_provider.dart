import 'package:flutter/cupertino.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_provider.dart';
import 'package:provider/provider.dart';

class FilterInternalProvider with ChangeNotifier{
  Map<String,dynamic> _mapFilter={
    "floors_number":0,
    "rooms_number":0,
    "bedrooms_number":0,
    "bathrooms_number":0,
    "garages_number":0
  };
  Map<String,dynamic> _mapFilterPlus={
    "furnished":false,
    "laundry":false,
    "laundry_room":false,
    "grill":false,
    "rooftop":false,
    "private_condominium":false,
    "court":false,
    "pool":false,
    "sauna":false,
    "jacuzzi":false,
    "studio":false,
    "garden":false,
    "electric_gate":false,
    "air_conditioning":false,
    "heating":false,
    "elevator":false,
    "warehouse":false,
    "basement":false,
    "balcony":false,
    "store":false,
    "land_walled":false
  };
  Map<String,dynamic> get mapFilter => _mapFilter;
  /*
  void setMapaFiltro(Map<String,dynamic> mapaFiltro){
    this._mapaFiltro=mapaFiltro;
    notifyListeners();
  }*/
  void setMapFilterItem(String key,dynamic value,{required BuildContext context}){
    this._mapFilter[key]=value;
    context.read<PropertiesProvider>().filterProperties(context: context);
    notifyListeners();
  }
  Map<String,dynamic> get mapFilterPlus => _mapFilterPlus;
  /*void setMapFiltroMas(Map<String,dynamic> mapaFiltro){
    this._mapaFiltroMas=mapaFiltro;
    notifyListeners();
  }*/
  void setMapFilterPlusItem(String key,dynamic value,{required BuildContext context}){
    this._mapFilterPlus[key]=value;
    context.read<PropertiesProvider>().filterProperties(context: context);
    notifyListeners();
  }
  void init(){
    _mapFilter.forEach((key, value) { 
      _mapFilter[key]=0;
    });
    _mapFilterPlus.forEach((key, value) { 
      _mapFilterPlus[key]=false;
    });
  }
}