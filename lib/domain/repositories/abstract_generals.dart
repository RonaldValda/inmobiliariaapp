import 'package:inmobiliariaapp/domain/entities/bank.dart';
import 'package:inmobiliariaapp/domain/entities/generals.dart';
import 'package:inmobiliariaapp/domain/entities/membership_plan_payment.dart';
import 'package:inmobiliariaapp/domain/entities/publication_plan_payment.dart';
import 'package:inmobiliariaapp/domain/entities/publicity.dart';

abstract class AbstractGeneralesRepository{
  Future<Map<String,dynamic>> getDepartaments();
  Future<Map<String,dynamic>> getCities(String departamentId);
  Future<Map<String,dynamic>> getGeneralsPlaces();
  Future<Map<String,dynamic>> getZones(String cityId);
  Future<Map<String,dynamic>> registerDepartament(String departamentName);
  Future<bool> updateDepartament(String departamentId,String departamentName);
  Future<bool> deleteDepartament(String departamentId);
  Future<Map<String,dynamic>> registerCity(String departamentId,String cityName);
  Future<bool> updateCity(String cityId,String cityName);
  Future<bool> deleteCity(String cityId);
  Future<Map<String,dynamic>> registerZone(String cityId,Zone zone);
  Future<bool> updateZone(Zone zone);
  Future<bool> deleteZone(String zoneId);
  Future<Map<String,dynamic>> getAppVersion();
}
abstract class AbstractBankRepository{
  Future<Map<String,dynamic>> getBankAccounts();
  Future<Map<String,dynamic>> registerBankAccount(BankAccount bankAccount);
  Future<Map<String,dynamic>> updateBankAccount(BankAccount bankAccount);
  Future<Map<String,dynamic>> deleteBankAccount(BankAccount bankAccount);

  Future<Map<String,dynamic>> registerBank(Bank bank);
  Future<Map<String,dynamic>> updateBank(Bank bank);
  Future<Map<String,dynamic>> deleteBank(String idBanK);
  Future<Map<String,dynamic>> getBanks();
}
abstract class AbstractPublicityRepository{
  Future<Map<String,dynamic>> registerAd(String adId,String adType);
  Future<Map<String,dynamic>> deleteAd(String adId);
  Future<Map<String,dynamic>> getAds();
  Future<Map<String,dynamic>> deletePublicity(String id);
  Future<Map<String,dynamic>> updatePublicity(Publicity publicity,int monthsValidity);
  Future<Map<String,dynamic>> registerPublicity(Publicity publicity,int monthsValidity);
  Future<Map<String,dynamic>> getPublicities();
}
abstract class AbstractPublicationPlanPaymentRepository{
  Future<Map<String,dynamic>> getPublicationPlansPayment(String planType);
  Future<Map<String,dynamic>> registerPublicationPlanPayment(PublicationPlanPayment plan);
  Future<Map<String,dynamic>> updatePublicationPlanPayment(PublicationPlanPayment plan);
  Future<Map<String,dynamic>> deletePublicationPlanPayment(String id);
}
abstract class AbstractMembershipPlanPaymentRepository{
  Future<Map<String,dynamic>> getMembershipPlanPayment();
  Future<Map<String,dynamic>> registerMembershipPlanPayment(MembershipPlanPayment membershipPlanPayment);
  Future<Map<String,dynamic>> updateMembershipPlanPayment(MembershipPlanPayment membershipPlanPayment);
}