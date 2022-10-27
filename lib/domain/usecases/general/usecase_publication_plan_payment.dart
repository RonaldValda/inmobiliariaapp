import 'package:inmobiliariaapp/data/repositories/generals/publication_plan_payment.dart';
import 'package:inmobiliariaapp/domain/entities/publication_plan_payment.dart';

class UseCasePublicationPlanPayment{
  PublicationPlanPaymentRepository publicationPlanPaymentRepository=PublicationPlanPaymentRepository();
  Future<Map<String,dynamic>> getPublicationPlansPayment(String planType){
    return publicationPlanPaymentRepository.getPublicationPlansPayment(planType);
  }
  Future<Map<String,dynamic>> registerPublicationPlanPayment(PublicationPlanPayment plan){
    return publicationPlanPaymentRepository.registerPublicationPlanPayment(plan);
  }
  Future<Map<String,dynamic>> updatePublicationPlanPayment(PublicationPlanPayment plan){
    return publicationPlanPaymentRepository.updatePublicationPlanPayment(plan);
  }
  Future<Map<String,dynamic>> deletePublicationPlanPayment(String id){
    return publicationPlanPaymentRepository.deletePublicationPlanPayment(id);
  }
}