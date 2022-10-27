import 'package:flutter/cupertino.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_provider.dart';
import 'package:provider/provider.dart';

class FilterSuperUserProvider with ChangeNotifier{
  DateTime date=DateTime.now();
  Map<String,dynamic> _mapFilter={
    "initial_date":"",
    "final_date":"",
    "sold":false,
    "unsold":false
  };
  bool loading=false;

  Map<String,dynamic> get mapFilter => _mapFilter;

  void setMapFilterItem(String key,dynamic value,{required BuildContext context}){
    this._mapFilter[key]=value;
    context.read<PropertiesProvider>().filterProperties(context: context);
    notifyListeners();
  }
  void setMapFilterPlusItem2(String key1,dynamic value1,String key2,dynamic value2){
    this._mapFilter[key1]=value1;
    this._mapFilter[key2]=value2;
    notifyListeners();
  }
  void setLoading(bool value){
    this.loading=value;
    notifyListeners();
  }
  bool get isLoading{
    return this.loading;
  }
}