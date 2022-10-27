import 'package:flutter/cupertino.dart';
import 'package:inmobiliariaapp/domain/entities/publication_plan_payment.dart';
import 'package:inmobiliariaapp/ui/provider/generals/publication_plan_payment_provider.dart';
import 'package:inmobiliariaapp/ui/provider/registration_property/registration_property_provider.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/bank.dart';

class RegistrationPropertyPlanProvider extends ChangeNotifier{

  Map<String,dynamic> _mapDocumentsPlansImage={
    "document_property_image":"",
    "document_sales_image":"",
    "owner_DNI_image":"",
    "agent_DNI_image":"",
    "deposit_image":""
  };
  Map<String,dynamic> _mapValidatePlanFree={
    "document_property_image":"",
    "owner_DNI_image":"",
  };
  Map<String,dynamic> _mapValidatePlanPaid={
    "deposit_image":"",
    "bank_account":"",
    "transaction_number":"",
    "deposit_name":"",
  };

  void init({required BuildContext context}){
    final registrationPropertyProvider=context.read<RegistrationPropertyProvider>();
    _mapDocumentsPlansImage={
      "document_property_image":registrationPropertyProvider.propertyTotalCopy.administratorRequest.propertyVoucher.documentPropertyImageLink,
      "document_sales_image":registrationPropertyProvider.propertyTotalCopy.administratorRequest.propertyVoucher.documentSalesImageLink,
      "owner_DNI_image":registrationPropertyProvider.propertyTotalCopy.administratorRequest.propertyVoucher.ownerDNIImageLink,
      "agent_DNI_image":registrationPropertyProvider.propertyTotalCopy.administratorRequest.propertyVoucher.agentDNIImageLink,
      "deposit_image":registrationPropertyProvider.propertyTotalCopy.administratorRequest.propertyVoucher.depositImageLink
    };
    _mapValidatePlanFree={
      "document_property_image":"",
      "owner_DNI_image":"",
    };
    _mapValidatePlanPaid={
      "deposit_image":"",
      "bank_account":"",
      "transaction_number":"",
      "deposit_name":"",
    };
   // _bankAccount=BankAccount.copyWith(registrationPropertyProvider.propertyTotalCopy.propertyVoucher.bankAccount);
  }

   void setMapDocumentPlansImageItem({required String key,required String value}){
    _mapDocumentsPlansImage[key]=value;
    if(_mapValidatePlanFree[key]!=null){
      _mapValidatePlanFree[key]="";
    }
    if(_mapValidatePlanPaid[key]!=null){
      _mapValidatePlanPaid[key]="";
    }
    notifyListeners();
  }
  

  Map<String,dynamic> get mapDocumentsPlansImage => _mapDocumentsPlansImage;

  Map<String,dynamic> get mapValidatePlanFree => _mapValidatePlanFree;

  void setBankAccount({required BankAccount accountBank,required BuildContext context}){
    context.read<RegistrationPropertyProvider>().propertyTotalCopy.administratorRequest.propertyVoucher.bankAccount=BankAccount.copyWith(accountBank);
    _mapValidatePlanPaid["bank_account"]="";
    notifyListeners();
  }

  BankAccount bankAccount(BuildContext context) { 
    return context.read<RegistrationPropertyProvider>().propertyTotalCopy.administratorRequest.propertyVoucher.bankAccount;
  }

  PublicationPlanPayment publicationPlanPayment(BuildContext context){
    final propertyTotal=context.read<RegistrationPropertyProvider>().propertyTotalCopy;
    PublicationPlanPayment publicationPlanPayment=PublicationPlanPayment.empty();
    if(propertyTotal.property.publicationDate==""){
      final plans=context.read<PublicationPlanPaymentProvider>().publicationPlansPaymentPublish;
      if(propertyTotal.administratorRequest.propertyVoucher.publicationPlanPayment.id=="") propertyTotal.administratorRequest.propertyVoucher.publicationPlanPayment=PublicationPlanPayment.copyWith(plans[0]);
      publicationPlanPayment=plans
      .where((element) => element.id==propertyTotal.administratorRequest.propertyVoucher.publicationPlanPayment.id).first;
    }else{
      final plans=context.read<PublicationPlanPaymentProvider>().publicationPlansPaymentUpdate;
      print(plans.length);
      if(propertyTotal.administratorRequest.propertyVoucher.publicationPlanPayment.id=="") propertyTotal.administratorRequest.propertyVoucher.publicationPlanPayment=PublicationPlanPayment.copyWith(plans[0]);
      publicationPlanPayment=plans
      .where((element) => element.id==propertyTotal.administratorRequest.propertyVoucher.publicationPlanPayment.id).first;
    }
    return publicationPlanPayment;
  }

  bool validateFree({required BuildContext context}){
    bool validate=true;
    _mapValidatePlanFree.forEach((key, value) {
      if(_mapDocumentsPlansImage[key]==""){
        _mapValidatePlanFree[key]="Requerido";
        validate=false;
      }else{
        _mapValidatePlanFree[key]="";
      }
    });
    notifyListeners();
    if(validate){
      final propertyVoucher=context.read<RegistrationPropertyProvider>().propertyTotalCopy.administratorRequest.propertyVoucher;
      propertyVoucher.documentPropertyImageLink=_mapDocumentsPlansImage["document_property_image"];
      propertyVoucher.documentSalesImageLink=_mapDocumentsPlansImage["document_sales_image"];
      propertyVoucher.ownerDNIImageLink=_mapDocumentsPlansImage["owner_DNI_image"];
      propertyVoucher.agentDNIImageLink=_mapDocumentsPlansImage["agent_DNI_image"];
    }
    return validate;
  }

  bool validatePaid({required BuildContext context}){
    bool validate=true;
    String errorText="Requerido";
    _mapValidatePlanPaid.forEach((key, value) {
      _mapValidatePlanPaid[key]="";
    });
    final propertyVoucher=context.read<RegistrationPropertyProvider>().propertyTotalCopy.administratorRequest.propertyVoucher;
    if(_mapDocumentsPlansImage["deposit_image"]=="") _mapValidatePlanPaid["deposit_image"]=errorText;
    if(propertyVoucher.transactionNumber=="") _mapValidatePlanPaid["transaction_number"]=errorText;
    if(propertyVoucher.depositorName=="") _mapValidatePlanPaid["deposit_name"]=errorText;
    if(propertyVoucher.bankAccount.id=="") _mapValidatePlanPaid["bank_account"]=errorText;
    
    _mapValidatePlanPaid.forEach((key, value) {
      if(_mapValidatePlanPaid[key]!=""){
        validate=false;
      }
    });
    notifyListeners();
    if(validate){
      propertyVoucher.depositImageLink=_mapDocumentsPlansImage["deposit_image"];
    }
    return validate;
  }

  Map<String,dynamic> get mapValidatePlanPaid => _mapValidatePlanPaid;
}