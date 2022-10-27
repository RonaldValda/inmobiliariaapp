import 'package:flutter/cupertino.dart';
import 'package:inmobiliariaapp/data/services/images_repository.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/domain/entities/user.dart';
import 'package:inmobiliariaapp/domain/usecases/property/usecase_property.dart';
import 'package:inmobiliariaapp/domain/usecases/property/usecase_property_sale.dart';
import 'package:inmobiliariaapp/domain/usecases/user/usecase_user.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_provider.dart';
import 'package:inmobiliariaapp/ui/provider/registration_property/registration_property_plan_provider.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_provider.dart';
import 'package:provider/provider.dart';

import '../home/properties_widget_provider.dart';

class RegistrationPropertyProvider extends ChangeNotifier{
  List<String> _cities=["La Paz","Oruro","Potosi","Cochabamba","Sucre","Tarija","Beni","Pando","Santa Cruz"];
  List<String> _contractTypes=["Venta","Alquiler","Anticrético"];
  List<String> _propertyTypes=["Casa","Departamento","Terreno constructivo","Terreno agrícola","Habitaciones","Condominio abierto","Condominio privado","Local comercial","Local eventual","Oficinas","Garajes","Galpones"];
  
  Map<String,dynamic> _mapSelectableData = {"city":"", "contract_type":"", "property_type":""};
  Map<String,dynamic> _mapSelectedData = {"city":"", "contract_type":"", "property_type":""};
  Map<String,dynamic> _mapValidate = {
    "city":"", 
    "contract_type":"", 
    "property_type":"",
    "price":"",
    "zone":"",
    "address":"",
    "land_surface":"",
    "construction_surface":"",
    "front_size":"",
    "images_main":""
  };
  
  PropertyTotal _propertyTotal=PropertyTotal.empty();
  PropertyTotal _propertyTotalCopy=PropertyTotal.empty();


  void init(){
    _mapSelectableData={
      "city":_cities,
      "contract_type":_contractTypes,
      "property_type":_propertyTypes
    };
    _mapSelectedData={
      "city":_propertyTotalCopy.property.city,
      "property_type":_propertyTotalCopy.property.propertyType,
      "contract_type":_propertyTotalCopy.property.contractType
    };
    
  }

  void setPropertyTotal(PropertyTotal propertyTotal){
    _propertyTotal=PropertyTotal.copyWith(propertyTotal);
  }
  PropertyTotal get propertyTotal => _propertyTotal;

  void setPropertyTotalCopy(PropertyTotal propertyTotal){
    _propertyTotalCopy=PropertyTotal.copyWith(propertyTotal);
  }
  PropertyTotal get propertyTotalCopy => _propertyTotalCopy;

  void setPrice(int price){
    _propertyTotalCopy.property.price=price;
  }

  Map<String,dynamic> get mapSelectableData => _mapSelectableData;

  Map<String,dynamic> get mapValidate => _mapValidate;
  
  Map<String,dynamic> get mapSelectedData => _mapSelectedData;

  void selectOption(String key,String value){
    _mapValidate[key]="";
    _mapSelectedData[key]=value;
    notifyListeners();
  }

  void notify(){
    notifyListeners();
  }
  bool validate(){
    String errorText="Requerido";
    bool validate=true;
    _mapValidate.forEach((key, value) { 
      _mapValidate[key]="";
    });
    _propertyTotalCopy.property.city=_mapSelectedData["city"];
    _propertyTotalCopy.property.propertyType=_mapSelectedData["property_type"];
    _propertyTotalCopy.property.contractType=_mapSelectedData["contract_type"];
    if(_propertyTotalCopy.property.city=="") _mapValidate["city"]=errorText;
    if(_propertyTotalCopy.property.propertyType=="") _mapValidate["property_type"]=errorText;
    if(_propertyTotalCopy.property.price==0) _mapValidate["price"]=errorText;
    if(_propertyTotalCopy.property.zoneName=="") _mapValidate["zone"]=errorText;
    if(_propertyTotalCopy.property.address=="") _mapValidate["address"]=errorText;
    if(_propertyTotalCopy.property.landSurface==0) _mapValidate["construction_surface"]=errorText;
    if(_propertyTotalCopy.property.frontSize==0) _mapValidate["front_size"]=errorText;
    if(_propertyTotalCopy.property.mapImages["principales"].length<3) _mapValidate["images_main"]="Debe seleccionar 3 imágenes principales";
    _mapValidate.forEach((key, value) { 
      if(_mapValidate[key]!=""){
        validate=false;
      }
    });
    notifyListeners();
    return validate;
  }
  Future<bool> registerUpdateProperty({required BuildContext context})async{
    final userProvider=context.read<UserProvider>();
    _propertyTotalCopy.creator=User.copyWith(userProvider.user);
    _propertyTotalCopy.owner=User.copyWith(userProvider.user);
    final plan=context.read<RegistrationPropertyPlanProvider>().publicationPlanPayment(context);
    final propertyOrigin=context.read<PropertiesProvider>().propertyTotalLast.property;
    
    if(_propertyTotalCopy.property.publicationDate==""){
      _propertyTotalCopy.property.authorization="Pendiente - Publicar";
      _propertyTotalCopy.property.allowedUpdate=plan.modificationsAllowed;
      _propertyTotalCopy.administratorRequest.propertyVoucher.voucherType="Publicar";
    }else{
      _propertyTotalCopy.property.counterUpdate=_propertyTotalCopy.property.counterUpdate+1;
      _propertyTotalCopy.property.authorization="Pendiente - Actualizar";
      if(propertyOrigin.counterUpdate>=propertyOrigin.allowedUpdate){
        _propertyTotalCopy.administratorRequest.propertyVoucher.voucherType="Actualizar";
      }else{
        _propertyTotalCopy.administratorRequest.propertyVoucher.voucherType="";
      }   
    }
    UseCaseProperty useCaseProperty=UseCaseProperty();
    bool completed=false;
    await useCaseProperty.registerUpdateProperty(_propertyTotalCopy, userProvider.sessionType)
    .then((response) {
      if(response["completed"]){
        completed=true;
        if(_propertyTotalCopy.property.id==""){
          context.read<PropertiesProvider>()
          .addPropertiesGeneral(propertyTotal: PropertyTotal.copyWith(response["property_total"]), context: context);
        }else{
          context.read<PropertiesProvider>().updatePropertiesGeneral(propertyTotal: _propertyTotalCopy,context: context);
        }
      }else{
        _propertyTotalCopy.property.counterUpdate=propertyOrigin.counterUpdate;
        _propertyTotalCopy.property.allowedUpdate=propertyOrigin.allowedUpdate;
      }
    });
    return completed;
  }

  bool isPriceRequest({required BuildContext context}){
    final propertyOrigin=context.read<PropertiesProvider>().propertyTotalLast.property;
    bool isPriceRequest=false;
    if(propertyOrigin.pricesHistory.length>1||(propertyOrigin.price*0.1<(propertyOrigin.price-_propertyTotalCopy.property.price))){
      isPriceRequest=true;
    }
    return isPriceRequest;
  }

  Future<bool> updatePropertyPrice({required BuildContext context})async{
    final propertyOrigin=context.read<PropertiesProvider>().propertyTotalLast.property;
    if(propertyOrigin.counterUpdate>=propertyOrigin.allowedUpdate){
      _propertyTotalCopy.administratorRequest.propertyVoucher.voucherType="Actualizar";
      _propertyTotalCopy.property.authorization="Pendiente - Bajar precio";
    }else{
      if(isPriceRequest(context: context)){
        _propertyTotalCopy.property.authorization="Pendiente - Bajar precio";
      }else{
        _propertyTotalCopy.property.counterUpdate=_propertyTotalCopy.property.counterUpdate+1;
      }
    }  
    _propertyTotalCopy.property.pricesHistory.add(_propertyTotalCopy.property.price);
    bool completed=false;
    UseCasePropertySale useCasePropertySale=UseCasePropertySale();
    await useCasePropertySale.updatePropertyPrice(_propertyTotalCopy)
    .then((response) {
      if(response["completed"]){
        completed=true;
        context.read<PropertiesProvider>().updatePropertiesGeneral(propertyTotal: _propertyTotalCopy,context: context);
      }else{
        _propertyTotalCopy.property.pricesHistory.removeLast();
        _propertyTotalCopy.property.counterUpdate=propertyOrigin.counterUpdate;
      }
    });
    return completed;
  }

  Future<bool> updatePropertyStatus({required BuildContext context,required String actionType})async{
    bool completed=false;
    UseCasePropertySale useCasePropertySale=UseCasePropertySale();
    await useCasePropertySale.updatePropertyStatus(_propertyTotalCopy, actionType)
    .then((responseOk) {
      if(responseOk){
        completed=true;
        if(actionType=="Dar baja"){
          _propertyTotalCopy.property.authorization="Inactivo";
        }else if(actionType=="Dar baja y reportar"){
          _propertyTotalCopy.property.authorization="Pendiente - Dar baja";
        }else if(actionType=="Dar alta"){
          _propertyTotalCopy.property.authorization="Pendiente - Dar alta";
        }else if(actionType=="Vendido y reportar"){
          _propertyTotalCopy.property.authorization="Pendiente - Vendido";
        }else{
          _propertyTotalCopy.property.negotiationStatus=actionType;
        }
        context.read<PropertiesProvider>().updatePropertiesGeneral(propertyTotal: _propertyTotalCopy,context: context);
      }
    });
    return completed;
  }

  Map<String,dynamic> _mapValidateDisableReport={
    "property_document":""
  };
  Map<String,dynamic> get mapValidateDisableReport => _mapValidateDisableReport;
  void initDisableReport(){
    _mapValidateDisableReport={
      "property_document":""
    };
  }


  bool validateDisableReport(){
    bool validate=true;
    _mapValidateDisableReport.forEach((key, value) { 
      _mapValidateDisableReport[key]="";
    });
    final propertyVoucher=_propertyTotalCopy.administratorRequest.propertyVoucher;
    if(propertyVoucher.documentPropertyImageLink=="") _mapValidateDisableReport["property_document"]="Requerido";
    _mapValidateDisableReport.forEach((key, value) {
      if(_mapValidateDisableReport[key]!=""){
        validate=false;
      }
    });
    notifyListeners();
    return validate;
  }

  Map<String,dynamic> _mapValidateSoldReport={
    "testimony_number":"",
    "user_buyer":""
  };

  Map<String,dynamic> get mapValidateSoldReport => _mapValidateSoldReport;

  void initSoldReport(){
    _mapValidateSoldReport={
      "testimony_number":"",
      "user_buyer":""
    };
  }

  
  bool validateSoldReport(){
    bool validate=true;
    _mapValidateSoldReport.forEach((key, value) { 
      _mapValidateSoldReport[key]="";
    });
    final propertyVoucher=_propertyTotalCopy.administratorRequest.propertyVoucher;
    if(propertyVoucher.userBuyer.id=="") _mapValidateSoldReport["user_buyer"]="Email inválido";
    if(propertyVoucher.testimonyNumber=="") _mapValidateSoldReport["testimony_number"]="Requerido";
    _mapValidateSoldReport.forEach((key, value) {
      if(_mapValidateSoldReport[key]!=""){
        validate=false;
      }
    });
    notifyListeners();
    return validate;
  }

  Future<void> searchUserBuyer({required BuildContext context,required String email})async{
    UseCaseUser useCaseUser=UseCaseUser();
    Map<String,dynamic> response=await useCaseUser.getUserEmail(email);
    if(response["completed"]){
      _propertyTotalCopy.administratorRequest.propertyVoucher.userBuyer=User.copyWith(response["user"]);
    }else{
      _propertyTotalCopy.administratorRequest.propertyVoucher.userBuyer=User.empty();
    }
    notifyListeners();
  }

  Future<bool> closeOperationsProperty({required BuildContext context})async{
    bool completed=false;
    PropertyTotal propertyTotalAux=PropertyTotal.copyWith(_propertyTotalCopy);
    _propertyTotalCopy.property.mapImages.forEach((key,value) { 
      if(key!="principales"){
        _propertyTotalCopy.property.mapImages[key]=[];
      }
    });
    UseCasePropertySale useCasePropertySale=UseCasePropertySale();
    Map<String,dynamic> responseDB=await useCasePropertySale.closeOperationsProperty(_propertyTotalCopy);
    if(responseDB["completed"]){
      _propertyTotalCopy.property.authorization="Inactivo";
      context.read<PropertiesWidgetProvider>().loadConfig(property: propertyTotal.property);
      context.read<PropertiesProvider>().updatePropertiesGeneral(propertyTotal: _propertyTotalCopy,context: context);
      completed=true;
      propertyTotalAux.property.mapImages.forEach((key,value) { 
        if(key!="principales"){
          value.forEach((element) async{
            int indexMain=propertyTotalAux.property.mapImages["principales"].lastIndexWhere((e)=>e==element);
            if(indexMain<0){
              await deleteImage(element);
            }
          });
        }
      });
    }
    return completed;
  }
  
}