import 'package:flutter/cupertino.dart';
import 'package:inmobiliariaapp/domain/entities/bank.dart';
import 'package:inmobiliariaapp/domain/usecases/general/usecase_bank.dart';

class BankAccountProvider extends ChangeNotifier{
  BankAccount _bankAccountSelected=BankAccount.empty();
  List<BankAccount> _bankAccounts=[];
  UseCaseBank _useCaseBank=UseCaseBank();
  Map<String,dynamic> _mapValidateBankAccount = {
    "account_number":"",
    "owner":"",
    "bank_name":"",
    "bank_logo":""
  };
  
  Future<bool> init()async{
    bool completed=false;
    await _useCaseBank.getBankAccounts()
    .then((response){
      if(response["completed"]){
        _bankAccounts=response["bank_accounts"];
        completed=true;
      }
    });
    return completed;
  }

  List<BankAccount> get bankAccounts => _bankAccounts;

  void setBankAccountSelected(BankAccount bankAccount){
    if(bankAccount.id!=_bankAccountSelected.id){
      _bankAccountSelected=BankAccount.copyWith(bankAccount);
    }else{
      _bankAccountSelected=BankAccount.empty();
    }
    _mapValidateBankAccount = {
      "account_number":"",
      "owner":"",
      "bank_name":"",
      "bank_logo":""
    };
    notifyListeners();
  }
  BankAccount get bankAccountSelected => _bankAccountSelected;

  bool validateBankAccount(){
    String errorText="Requerido";
    bool validate=true;
    _mapValidateBankAccount.forEach((key, value) { 
      _mapValidateBankAccount[key]="";
    });
    if(_bankAccountSelected.accountNumber=="") _mapValidateBankAccount["account_number"]=errorText;
    if(_bankAccountSelected.owner=="") _mapValidateBankAccount["owner"]=errorText;
    if(_bankAccountSelected.bankName=="") _mapValidateBankAccount["bank_name"]=errorText;
    if(_bankAccountSelected.logoImageLink=="") _mapValidateBankAccount["bank_logo"]=errorText;
    _mapValidateBankAccount.forEach((key, value) { 
      if(_mapValidateBankAccount[key]!=""){
        validate=false;
      }
    });
    notifyListeners();
    return validate;    
  }
  Map<String,dynamic> get mapValidateBankAccount => _mapValidateBankAccount;

  //* CRUD Bank account
  Future<bool> registrerBankAccount()async{
    bool completed=false;
    _bankAccountSelected.active=true;
    await _useCaseBank.registerBankAccount(_bankAccountSelected)
    .then((response) {
      if(response["completed"]){
        completed=true;
        _bankAccounts.add(BankAccount.copyWith(response["bank_account"]));
        notifyListeners();
      }
    });
    return completed;
  }

  Future<bool> updateBankAccount()async{
    bool completed=false;
    await _useCaseBank.updateBankAccount(_bankAccountSelected)
    .then((response) {
      if(response["completed"]){
        completed=true;
        int index=_bankAccounts.lastIndexWhere((element) => element.id==_bankAccountSelected.id);
        _bankAccounts[index]=BankAccount.copyWith(_bankAccountSelected);
        notifyListeners();
      }
    });
    return completed;
  }

  Future<bool> deleteBankAccount()async{
    bool completed=false;
    await _useCaseBank.deleteBankAccount(_bankAccountSelected)
    .then((response) {
      if(response["completed"]){
        completed=true;
        _bankAccounts.removeWhere((element) => element.id==_bankAccountSelected.id);
        notifyListeners();
      }
    });
    return completed;
  }

  //*Bank
  Bank _bankSelected=Bank.empty();
  List<Bank> _banks=[];
  Map<String,dynamic> _mapValidateBank = {
    "bank_name":"",
    "web":"",
    "app":"",
    "pre_approval":"",
    "bank_logo":""
  };
  Future<bool> loadBanks()async{
    bool completed=false;
    await _useCaseBank.getBanks()
    .then((response) {
      if(response["completed"]){
        completed=true;
        _banks=response["banks"];
        notifyListeners();
      }
    });
    return completed;
  }
  List<Bank> get banks => _banks;

  void setBankSelected(Bank bank){
    if(bank.id!=_bankSelected.id){
      _bankSelected=Bank.copyWith(bank);
    }else{
      _bankSelected=Bank.empty();
    }
    _mapValidateBank = {
      "bank_name":"",
      "web":"",
      "app":"",
      "pre_approval":"",
      "bank_logo":""
    };
    notifyListeners();
  }
  Bank get bankSelected => _bankSelected;

  //* CRUD Bank
  bool validateBank(){
    String errorText="Requerido";
    bool validate=true;
    _mapValidateBank.forEach((key, value) { 
      _mapValidateBank[key]="";
    });
    if(_bankSelected.bankName=="") _mapValidateBank["bank_name"]=errorText;
    if(_bankSelected.web=="") _mapValidateBank["web"]=errorText;
    if(_bankSelected.app=="") _mapValidateBank["app"]=errorText;
    if(_bankSelected.preApproval=="") _mapValidateBank["pre_approval"]=errorText;
    if(_bankSelected.logoImageLink=="") _mapValidateBank["bank_logo"]=errorText;
    _mapValidateBank.forEach((key, value) { 
      if(_mapValidateBank[key]!=""){
        validate=false;
      }
    });
    print(_mapValidateBank);
    notifyListeners();
    return validate;    
  }
  Map<String,dynamic> get mapValidateBank => _mapValidateBank;
  Future<bool> registrerBank()async{
    bool completed=false;
    _bankAccountSelected.active=true;
    await _useCaseBank.registerBank(_bankSelected)
    .then((response) {
      if(response["completed"]){
        completed=true;
        _banks.add(Bank.copyWith(response["bank"]));
        notifyListeners();
      }
    });
    return completed;
  }
  Future<bool> updateBank()async{
    bool completed=false;
    await _useCaseBank.updateBank(_bankSelected)
    .then((response) {
      if(response["completed"]){
        completed=true;
        int index=_banks.lastIndexWhere((element) => element.id==_bankSelected.id);
        _banks[index]=Bank.copyWith(_bankSelected);
        notifyListeners();
      }
    });
    return completed;
  }
  Future<bool> deleteBank()async{
    bool completed=false;
    await _useCaseBank.deleteBank(_bankSelected.id)
    .then((response) {
      if(response["completed"]){
        completed=true;
        _banks.removeWhere((element) => element.id==_bankSelected.id);
        notifyListeners();
      }
    });
    return completed;
  }
}