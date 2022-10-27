import 'package:inmobiliariaapp/data/repositories/generals/membership_plan_payment_repository.dart';
import 'package:inmobiliariaapp/domain/entities/membership_plan_payment.dart';

class UseCaseMembershipPlanPayment{
  MembershipPlanPaymentRepository membershipPlanPaymentRepository=MembershipPlanPaymentRepository();
  Future<Map<String,dynamic>> getMembershipPlanPayment(){
    return membershipPlanPaymentRepository.getMembershipPlanPayment();
  }
  
  Future<Map<String,dynamic>> registerMembershipPlanPayment(MembershipPlanPayment membershipPlanPayment){
    return membershipPlanPaymentRepository.registerMembershipPlanPayment(membershipPlanPayment);
  }
  Future<Map<String,dynamic>> updateMembershipPlanPayment(MembershipPlanPayment membershipPlanPayment){
    return membershipPlanPaymentRepository.updateMembershipPlanPayment(membershipPlanPayment);
  }
}