import 'package:inmobiliariaapp/data/configuration/graphql_configuration.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:inmobiliariaapp/domain/entities/administrator_request.dart';
import 'package:inmobiliariaapp/domain/entities/administrator_zone.dart';
import 'package:inmobiliariaapp/domain/entities/agent_registration.dart';
import 'package:inmobiliariaapp/domain/entities/membership_payment.dart';
import 'package:inmobiliariaapp/domain/entities/user.dart';
import 'package:inmobiliariaapp/domain/repositories/abstract_user.dart';

import '../../../auxiliares/global_variables.dart';
import 'administrator_repository_gql.dart';
class AdministratorRepository extends AbstractAdministratorRepository{
  @override
  Future<Map<String, dynamic>> getAdministratorZones(String administradorId) async{
    Map<String,dynamic> map={};
    List<AdministratorZone> administratorZones=[];
    List administratorZonesD=[];
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(queryGetAdministratorZones()),
        variables: ({"id_administrador":administradorId}),
        fetchPolicy: graphql.FetchPolicy.noCache,
      ),
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
        if(result.data!["obtenerAdministradorZonas"]!=null){
          administratorZonesD=result.data!["obtenerAdministradorZonas"];
          administratorZonesD.forEach((element) {
            administratorZones.add(AdministratorZone.fromMap(element));
          });
      }
    }

    map["completed"]=completed;
    map["administrator_zones"]=administratorZones;
    return map;
  }

  @override
  Future<Map<String, dynamic>> getNotificationsAdministrator(String administratorId) async{
    Map<String,dynamic> map={};
    List<MembershipPayment> membershipsPayments=[];
    List membershipsPaymentsD=[];
    List<AgentRegistration> agentsRegistrations=[];
    List agentsRegistrationsD=[];
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(queryGetNotificationsAdministrator()),
        variables: ({"id":administratorId}),
        fetchPolicy: graphql.FetchPolicy.noCache,
      ),
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
        if(result.data!["obtenerNotificacionesAdministrador"]!=null){
          membershipsPaymentsD=result.data!["obtenerNotificacionesAdministrador"]["membresias_pagos"];
          membershipsPaymentsD.forEach((element) {
            membershipsPayments.add(MembershipPayment.fromMap(element));
          });
          agentsRegistrationsD=result.data!["obtenerNotificacionesAdministrador"]["inscripciones_agentes"];
          agentsRegistrationsD.forEach((element) { 
            agentsRegistrations.add(AgentRegistration.fromMap(element));
          });
      }
    }

    map["completed"]=completed;
    map["memberships_payments"]=membershipsPayments;
    map["agents_registrations"]=agentsRegistrations;
    return map;
  }

  @override
  Future<Map<String, dynamic>> answerAdministratorRequest(User user, AdministratorRequest administratorProperty, AdministratorRequest administratorRequest) async{
    Map<String,dynamic> map={};
    bool completed=false;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    String message="";
    graphql.GraphQLClient client=configuration.myGQLClient();
    Map<String,dynamic> mapVariables=administratorRequest.toMap();
    mapVariables["id_respondedor"]=user.id;
    mapVariables.addAll({"id":administratorProperty.id});
    print(mapVariables);
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationAnswerAdministratorRequest()),
        variables: (
          mapVariables
        ),
        onCompleted: (data){
          if(data!=null){
            message=data["responderSolicitudAdministrador"].toString();
            completed=true;
          }
        },
        onError: (error){
          var ms=error!.graphqlErrors;
          ms.forEach((element) {
            message=element.message;
          });
          completed=false;
        }
      )
    );
    map["completed"]=completed;
    map["message"]=message;
    return map;
  }

  @override
  Future<Map<String, dynamic>> answerAgentRegistrationRequest(AgentRegistration agentRegistration) async{
    Map<String,dynamic> map={};
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    String message="";
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationAnswerAgentRegistrationRequest()),
        variables: (
          agentRegistration.toMap()
        ),
        onCompleted: (data){
          if(data!=null){
            if(data["responderSolicitudInscripcionAgente"]!=null){
              agentRegistration.responseDate=data["responderSolicitudInscripcionAgente"]["fecha_respuesta"];
            }
          }
        },
        onError: (error){
          var ms=error!.graphqlErrors;
          ms.forEach((element) {
            print(element);
            message=element.message;
          });
          completed=false;
        }
      )
    );
    map["completed"]=completed;
    map["message"]=message;
    map["agent_registration"]=agentRegistration;
    return map;
  }
  @override
  Future<Map<String, dynamic>> getAdministratorsRequests(String id) async{
    Map<String,dynamic> map={};
    List requestsD=[];
    List<AdministratorRequest> administratorsRequests=[];
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document: graphql.gql(queryGetAdministratorsRequests()),
        fetchPolicy: modoOffline?graphql.FetchPolicy.cacheFirst:graphql.FetchPolicy.cacheAndNetwork,
        variables: {
          "id":id
        }
      )
    );
    if(result.hasException){
      print(result);
      completed=false;
    }else if(!result.hasException){
        if(result.data!["obtenerSolicitudesAdministradores"]!=null){
          requestsD=result.data!["obtenerSolicitudesAdministradores"];
          requestsD.forEach((map) {
          administratorsRequests.add(AdministratorRequest.fromMap(map));
          });
        }
    }
    administratorsRequests.sort((b,a)=>a.requestDate.compareTo(b.requestDate));
    map["completed"]=completed;
    map["administrators_requests"]=administratorsRequests;
    return map;
  }
}