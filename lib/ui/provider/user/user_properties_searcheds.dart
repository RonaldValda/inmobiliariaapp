import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/domain/entities/user_property_favorite.dart';
import 'package:inmobiliariaapp/domain/usecases/property/filter_properties.dart';
import 'package:inmobiliariaapp/domain/usecases/user/usecase_user.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_comunity_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_general_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_internal_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_main_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_others_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_user_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_provider.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_provider.dart';
import 'package:provider/provider.dart';

class UserPropertiesSearchedsProvider extends ChangeNotifier{
  List<UserPropertySearched> _userPropertiesSearcheds=[];
  List<PropertyTotal> _propertiesSearcheds=[];
  UserPropertySearched _userPropertySearchedSelected=UserPropertySearched.empty();

  List<UserPropertySearched> get userPropertiesSearcheds=>_userPropertiesSearcheds;
  void setUserPropertiesSearcheds(List<UserPropertySearched> userPropertiesSearcheds,{required BuildContext context}){
    _userPropertiesSearcheds=userPropertiesSearcheds;
    loadPropertiesSearcheds(context: context);
  }

  UserPropertySearched get userPropertySearchedSelected => _userPropertySearchedSelected;
  void setUserPropertySearchedSelected(UserPropertySearched userPropertySearched){
    if(_userPropertySearchedSelected.id==userPropertySearched.id){
      _userPropertySearchedSelected=UserPropertySearched.empty();
    }else{
      _userPropertySearchedSelected=UserPropertySearched.copyWith(userPropertySearched);
    }
    notifyListeners();
  }

  List<PropertyTotal> get propertiesSearcheds => _propertiesSearcheds;
  void loadPropertiesSearcheds({required BuildContext context}){
    final user=context.read<UserProvider>().user;
    _propertiesSearcheds=[];
    _userPropertiesSearcheds.forEach((element) { 
      Map<String,dynamic> mapFilter={};
      mapFilter.addAll(element.toMapFilterAll());
      mapFilter.addAll({"penultimate_entry_date":user.penultimateEntryDate});
      final propertiesAux=filterProperties(context.read<PropertiesProvider>().propertiesGeneral, mapFilter);
      _propertiesSearcheds.addAll(propertiesAux);
      element.foundQuantity=propertiesAux.length;
    });
  }

  void applyFilters(BuildContext context){
    final filterMainProvider=context.read<FilterMainProvider>();
    filterMainProvider.init();
    _userPropertySearchedSelected.toMapFilterMain().forEach((key, value) { 
      filterMainProvider.mapFilter[key]=value;
    });
    final filterGeneralProvider=context.read<FilterGeneralProvider>();
    filterGeneralProvider.init();
    _userPropertySearchedSelected.toMapFilterGeneral().forEach((key, value) { 
      filterGeneralProvider.mapFilter[key]=value;
    });
    _userPropertySearchedSelected.toMapFilterGeneralPlus().forEach((key, value) {
      filterGeneralProvider.mapFilterPlus[key]=value;
    });
    final filterInternalProvider=context.read<FilterInternalProvider>();
    filterInternalProvider.init();
    _userPropertySearchedSelected.toMapFilterInternal().forEach((key, value) {
      filterInternalProvider.mapFilter[key]=value;
    });
    _userPropertySearchedSelected.toMapFilterInternalPlus().forEach((key, value) {
      filterInternalProvider.mapFilterPlus[key]=value;
    });
    final filterCommunityProvider=context.read<FilterComunityProvider>();
    filterCommunityProvider.init();
    _userPropertySearchedSelected.toMapFilterCommunity().forEach((key, value) { 
      filterCommunityProvider.mapFilter[key]=value;
    });
    _userPropertySearchedSelected.toMapFilterCommunityPlus().forEach((key, value) {
      filterCommunityProvider.mapFilterPlus[key]=value;
    });
    context.read<FilterUserProvider>().init();
    final filterOthersProvider=context.read<FilterOthersProvider>();
    filterOthersProvider.init();
    _userPropertySearchedSelected.toMapFilterOthersPlus().forEach((key, value) { 
      filterOthersProvider.mapFilterPlus[key]=value;
    });
    print(context.read<FilterMainProvider>().mapFilter);
    context.read<PropertiesProvider>().filterProperties(context: context);
  }

  Future<bool> updateUserPropertySearchedPersonalInformation()async{
    bool completed=false;
    UseCaseUser useCaseUser=UseCaseUser();
    await useCaseUser.updateUserPropertySearchedPersonalInformation(_userPropertySearchedSelected)
    .then((responseOk) {
      if(responseOk){
        completed=true;
        final index=_userPropertiesSearcheds.lastIndexWhere((element) => element.id==_userPropertySearchedSelected.id);
        _userPropertiesSearcheds[index]=UserPropertySearched.copyWith(_userPropertySearchedSelected);
        notifyListeners();
      }
    });
    return completed;
  }

  Future<bool> registerUserPropertySearched({required BuildContext context})async{
    bool completed=false;
    UseCaseUser useCaseUser=UseCaseUser();
    final filterMainProvider=context.read<FilterMainProvider>();
    final filterGeneralProvider=context.read<FilterGeneralProvider>();
    final filterInternalProvider=context.read<FilterInternalProvider>();
    final filterCommunityProvider=context.read<FilterComunityProvider>();
    final filterOthersProvider=context.read<FilterOthersProvider>();
    final user=context.read<UserProvider>().user;
    Map<String,dynamic> mapFilter={};
    mapFilter.addAll(filterMainProvider.mapFilter);
    mapFilter.addAll(filterGeneralProvider.mapFilter);
    mapFilter.addAll(filterGeneralProvider.mapFilterPlus);
    mapFilter.addAll(filterInternalProvider.mapFilter);
    mapFilter.addAll(filterInternalProvider.mapFilterPlus);
    mapFilter.addAll(filterCommunityProvider.mapFilter);
    mapFilter.addAll(filterCommunityProvider.mapFilterPlus);
    mapFilter.addAll(filterOthersProvider.mapFilterPlus);
    _userPropertySearchedSelected=UserPropertySearched.fromMap2(_userPropertySearchedSelected, mapFilter);
    await useCaseUser.registerUserPropertySearched(user,_userPropertySearchedSelected)
    .then((response) {
      if(response["completed"]){
        completed=true;
        _userPropertiesSearcheds.add(UserPropertySearched.copyWith(response["user_property_searched"]));
        notifyListeners();
      }else{
        print("error");
      }
    });
    return completed;
  }

  Future<bool> updateUserPropertySearched({required BuildContext context})async{
    bool completed=false;
    UseCaseUser useCaseUser=UseCaseUser();
    final filterMainProvider=context.read<FilterMainProvider>();
    final filterGeneralProvider=context.read<FilterGeneralProvider>();
    final filterInternalProvider=context.read<FilterInternalProvider>();
    final filterCommunityProvider=context.read<FilterComunityProvider>();
    final filterOthersProvider=context.read<FilterOthersProvider>();
    Map<String,dynamic> mapFilter={};
    mapFilter.addAll(filterMainProvider.mapFilter);
    mapFilter.addAll(filterGeneralProvider.mapFilter);
    mapFilter.addAll(filterGeneralProvider.mapFilterPlus);
    mapFilter.addAll(filterInternalProvider.mapFilter);
    mapFilter.addAll(filterInternalProvider.mapFilterPlus);
    mapFilter.addAll(filterCommunityProvider.mapFilter);
    mapFilter.addAll(filterCommunityProvider.mapFilterPlus);
    mapFilter.addAll(filterOthersProvider.mapFilterPlus);
    _userPropertySearchedSelected=UserPropertySearched.fromMap2(_userPropertySearchedSelected, mapFilter);
    await useCaseUser.updateUserPropertySearched(_userPropertySearchedSelected)
    .then((response) {
      if(response["completed"]){
        completed=true;
        int index=_userPropertiesSearcheds.lastIndexWhere((element) => element.id==_userPropertySearchedSelected.id);
        _userPropertiesSearcheds[index]=UserPropertySearched.copyWith(_userPropertySearchedSelected);
        notifyListeners();
      }else{
        print("error");
      }
    });
    return completed;
  }

}