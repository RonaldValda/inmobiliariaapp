import 'package:inmobiliariaapp/data/repositories/generals/bank_repository.dart';
import 'package:inmobiliariaapp/domain/entities/bank.dart';

class UseCaseBank{
  BankRepository bankRepository=BankRepository();
  Future<Map<String,dynamic>> getBankAccounts(){
    return bankRepository.getBankAccounts();
  }
  Future<Map<String,dynamic>> registerBankAccount(BankAccount bankAccount){
    return bankRepository.registerBankAccount(bankAccount);
  }

  Future<Map<String,dynamic>> updateBankAccount(BankAccount bankAccount){
    return bankRepository.updateBankAccount(bankAccount);
  }
  Future<Map<String,dynamic>> deleteBankAccount(BankAccount bankAccount){
    return bankRepository.deleteBankAccount(bankAccount);
  }
  Future<Map<String,dynamic>> registerBank(Bank bank){
    return bankRepository.registerBank(bank);
  }
  Future<Map<String,dynamic>> updateBank(Bank bank){
    return bankRepository.updateBank(bank);
  }
  Future<Map<String,dynamic>> deleteBank(String bankId){
    return bankRepository.deleteBank(bankId);
  }
  Future<Map<String,dynamic>> getBanks(){
    return bankRepository.getBanks();
  }
}