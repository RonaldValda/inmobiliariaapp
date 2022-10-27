import 'package:flutter/cupertino.dart';
import 'package:inmobiliariaapp/ui/pages/utils/constants.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_comunity_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_general_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_internal_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_others_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_user_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_provider.dart';
import 'package:provider/provider.dart';

import '../generals/general_data_provider.dart';

class FilterMainProvider with ChangeNotifier{
  List<String> _propertyTypes=[];
  List<String> _prices=[];
  List<List<int>> _valuesPrices=[];
   Map<String,dynamic> _mapFilter={
    "property_type":"Todos",
    "contract_type":"Venta",
    "city":"Sucre",
    "zone":"Cualquiera",
    "price_min":0,
    "price_max":-1,
    "price_sel":"Cualquiera",
  };
  void initPropertyTypes(){
    _propertyTypes=[];
    _propertyTypes.addAll(Constants.propertyTypesMain);
  }

  void initPrices(){
    if(_mapFilter["contract_type"]=="Venta"){
      _prices=[];
      _prices.addAll(Constants.salePrices);
      _valuesPrices=[];
      _valuesPrices.addAll(Constants.valuesSalePrices);
    }else if(_mapFilter["contract_type"]=="Alquiler"){
      _prices=[];
      _prices.addAll(Constants.rentalPrices);
      _valuesPrices=[];
      _valuesPrices.addAll(Constants.valuesRentalPrices);
    }else{
      _prices=[];
      _prices.addAll(Constants.anticreticPrices);
      _valuesPrices=[];
      _valuesPrices.addAll(Constants.valuesAnticreticPrices);
    }
  }

  bool _change=true;
  bool _loading=false;

  List<String> get contractTypes => Constants.contractTypes;
  List<String> get propertyTypes => _propertyTypes;
  List<String> get prices => _prices;

  Map<String,dynamic> get mapFilter => _mapFilter;
  
  void setMapFilterItem(String key,dynamic value,{required BuildContext context}){
    if(key=="property_type"){
      if(value=="Terreno"){
        _propertyTypes=[];
        _propertyTypes.addAll(Constants.propertyTypesLand);
      }else if(value=="Otros"){
        _propertyTypes=[];
        _propertyTypes.addAll(Constants.propertyTypesOther);
      }else{
        _mapFilter[key]=value;
      }
    }else{
      _mapFilter[key]=value;
    }
    if(key=="contract_type"){
      initPrices();
      _mapFilter["price_sel"]=_prices[0];
      _mapFilter["price_min"]=0;
      _mapFilter["price_max"]=-1;
    }
    if(key=="price_sel"){
      _mapFilter[key]=value;
      int index=_prices.lastIndexOf(value);
      _mapFilter["price_min"]=_valuesPrices[index][0];
      _mapFilter["price_max"]=_valuesPrices[index][1];
    }
    context.read<PropertiesProvider>().filterProperties(context: context);
    notifyListeners();
  }
  void setMapFilterItemCity({required BuildContext context,required String value,required int indexCity}){
    _mapFilter["city"]=value;
    _mapFilter["zone"]="Cualquiera";
    notifyListeners();
    context.read<GeneralDataProvider>().selectZonesCity(context.read<GeneralDataProvider>().cities[indexCity].id);
    context.read<PropertiesProvider>().propertiesGeneralDB(context: context);
  }

  void setMapFilterItem2(String key1,dynamic value1,String key2,dynamic value2){
    this._mapFilter[key1]=value1;
    this._mapFilter[key2]=value2;
    notifyListeners();
  }
  void setMapFilterItem4(String key1,dynamic value1,String key2,dynamic value2,String key3,dynamic value3,String key4,dynamic value4){
    this._mapFilter[key1]=value1;
    this._mapFilter[key2]=value2;
    this._mapFilter[key3]=value3;
    this._mapFilter[key4]=value4;
    notifyListeners();
  }
  void setLoading(bool valor){
    this._loading=valor;
    notifyListeners();
  }
  bool get loading => _loading;

  void setChange(bool change){
    _change=change;
  }
  bool get change => _change;

  void init(){
    _mapFilter["zone"]="Cualquiera";
    _mapFilter["contract_type"]="Venta";
    _mapFilter["property_type"]="Todos";
    _mapFilter["price_min"]=0;
    _mapFilter["price_max"]=-1;
    _mapFilter["price_sel"]="Cualquiera";
  }

  void cleanAllFilters({required BuildContext context}){
    init();
    context.read<FilterGeneralProvider>().init();
    context.read<FilterInternalProvider>().init();
    context.read<FilterComunityProvider>().init();
    context.read<FilterOthersProvider>().init();
    context.read<FilterUserProvider>().init();
    context.read<PropertiesProvider>().filterProperties(context: context);
  }
}