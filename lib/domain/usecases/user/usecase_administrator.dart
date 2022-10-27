
import 'package:inmobiliariaapp/data/repositories/user/administrator_repository.dart';
import 'package:inmobiliariaapp/domain/entities/agent_registration.dart';
import 'package:inmobiliariaapp/domain/entities/administrator_request.dart';
import 'package:inmobiliariaapp/domain/entities/user.dart';

class UseCaseAdministrator{
  AdministratorRepository administratorRepository=AdministratorRepository();
  Future<Map<String,dynamic>> answerAdministratorRequest(User user,AdministratorRequest administratorPropery,AdministratorRequest administratorRequest){
    return administratorRepository.answerAdministratorRequest(user,administratorPropery,administratorRequest);
  }
  Future<Map<String,dynamic>> getAdministratorZones(String administratorId){
    return administratorRepository.getAdministratorZones(administratorId);
  }
  Future<Map<String,dynamic>> getNotificationsAdministrator(String administratorId){
    return administratorRepository.getNotificationsAdministrator(administratorId);
  }
  Future<Map<String,dynamic>> answerAgentRegistrationRequest(AgentRegistration agentRegistration){
    return administratorRepository.answerAgentRegistrationRequest(agentRegistration);
  }
  Future<Map<String,dynamic>> getAdministratorsRequests(String id){
    return administratorRepository.getAdministratorsRequests(id);
  }
}