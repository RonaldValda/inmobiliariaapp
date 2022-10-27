import 'package:flutter/cupertino.dart';
import 'package:inmobiliariaapp/domain/entities/publication_plan_payment.dart';
import 'package:inmobiliariaapp/domain/usecases/general/usecase_publication_plan_payment.dart';

class PublicationPlanPaymentProvider extends ChangeNotifier{
  PublicationPlanPayment _publicationPlanPayment=PublicationPlanPayment.empty();
  List<PublicationPlanPayment> _publicationPlansPayment=[];
  List<PublicationPlanPayment> _publicationPlansPaymentPublish=[];
  List<PublicationPlanPayment> _publicationPlansPaymentUpdate=[];
  PublicationPlanPayment _publicationPlanPaymentSelected=PublicationPlanPayment.empty();
  Map<String,dynamic> _mapValidatePublication={
    "plan_name":"",
  };
  
  PublicationPlanPayment get publicationPlanPayment => _publicationPlanPayment;

  List<PublicationPlanPayment> get publicationPlansPayment => _publicationPlansPayment;
  List<PublicationPlanPayment> get publicationPlansPaymentPublish => _publicationPlansPaymentPublish;
  List<PublicationPlanPayment> get publicationPlansPaymentUpdate => _publicationPlansPaymentUpdate;

  UseCasePublicationPlanPayment _useCasePublicationPlanPayment=UseCasePublicationPlanPayment();
  

  Future<bool> loadPublicationPlansPayment()async{
    bool completed=false;
    if(_publicationPlansPayment.length==0){
      await _useCasePublicationPlanPayment.getPublicationPlansPayment("")
      .then((response){
        if(response["completed"]){
          completed=true;
          _publicationPlansPayment=response["publication_plans_payment"];
          _publicationPlansPaymentPublish.addAll(_publicationPlansPayment.where((element) => element.planType=="Publicar"));
          _publicationPlansPaymentUpdate.addAll(_publicationPlansPayment.where((element) => element.planType=="Actualizar"));
          notifyListeners();
        }
      });
    }else{
      completed=true;
    }
    return completed;
  }

  void setPublicationPlanPayment(PublicationPlanPayment publicationPlanPayment){
    if(_publicationPlanPaymentSelected.id!=publicationPlanPayment.id){
      _publicationPlanPaymentSelected=PublicationPlanPayment.copyWith(publicationPlanPayment);
    }else{
      _publicationPlanPaymentSelected=PublicationPlanPayment.empty();
    }
    notifyListeners();
  }

  PublicationPlanPayment get publicationPlanPaymentSelected => _publicationPlanPaymentSelected;

  //*CRUD 
  bool validatePublication(){
    bool validate=true;
    String errorText="Requerido";
    _mapValidatePublication.forEach((key, value) { 
      _mapValidatePublication[key]="";
    });
    if(_publicationPlanPaymentSelected.planName=="") _mapValidatePublication["plan_name"]=errorText;
    _mapValidatePublication.forEach((key, value) { 
      if(_mapValidatePublication[key]!=""){
        validate=false;
      }
    });
    print(_mapValidatePublication);
    notifyListeners();
    return validate;
  }
  Map<String,dynamic> get mapValidatePublication => _mapValidatePublication;

  Future<bool> registerPublicactionPlanPayment()async{
    bool completed=false;
    _publicationPlanPaymentSelected.active=true;
    await _useCasePublicationPlanPayment.registerPublicationPlanPayment(_publicationPlanPaymentSelected)
    .then((response) {
      if(response["completed"]){
        completed=true;
        _publicationPlansPayment.add(PublicationPlanPayment.copyWith(response["publication_plan_payment"]));
        notifyListeners();
      }
    });
    return completed;
  }
  Future<bool> updatePublicactionPlanPayment()async{
    bool completed=false;
    _publicationPlanPaymentSelected.active=true;
    await _useCasePublicationPlanPayment.updatePublicationPlanPayment(_publicationPlanPaymentSelected)
    .then((response) {
      if(response["completed"]){
        completed=true;
        int index=_publicationPlansPayment.lastIndexWhere((element) => element.id==_publicationPlanPaymentSelected.id);
        _publicationPlansPayment[index]=PublicationPlanPayment.copyWith(_publicationPlanPaymentSelected);
        notifyListeners();
      }
    });
    return completed;
  }
  Future<bool> deletePublicactionPlanPayment()async{
    bool completed=false;
    _publicationPlanPaymentSelected.active=true;
    await _useCasePublicationPlanPayment.deletePublicationPlanPayment(_publicationPlanPaymentSelected.id)
    .then((response) {
      if(response["completed"]){
        completed=true;
        _publicationPlansPayment.removeWhere((element) => element.id==_publicationPlanPaymentSelected.id,);
        notifyListeners();
      }
    });
    return completed;
  }
}