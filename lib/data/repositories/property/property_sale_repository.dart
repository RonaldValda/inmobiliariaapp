import 'package:inmobiliariaapp/data/configuration/graphql_configuration.dart';
import 'package:inmobiliariaapp/data/repositories/property/property_sale_repository_gql.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/domain/entities/property_reported.dart';
import 'package:inmobiliariaapp/domain/entities/notificacionn.dart';
import 'package:inmobiliariaapp/domain/entities/administrator_request.dart';
import 'package:inmobiliariaapp/domain/repositories/abstract_property.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
class PropertySaleRepository extends AbstractPropertySaleRepository{
  @override
  Future<bool> updatePropertyStatus(PropertyTotal propertyTotal,String actionType) async{
    bool response=false;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    //Map<String,dynamic> mapUnsubscribe=propertyTotal.administratorRequest.propertyUnsubscribe.toMap();
    //Map<String,dynamic> mapSold=propertyTotal.administratorRequest.propertySold.toMap();
    Map<String,dynamic> mapVariables={};
    /*mapVariables.addAll(mapUnsubscribe);
    mapVariables.addAll(mapSold);*/
    mapVariables.addAll(propertyTotal.administratorRequest.propertyVoucher.toMap());
    mapVariables.addAll({"id_inmueble":propertyTotal.property.id,"tipo_accion":actionType});
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationUpdatePropertyStatusSalesperson()),
        variables: (mapVariables),
        onCompleted: (data){
          if(data!=null){
            response=true;
          }
        },
        onError: (error){
          print(error);
          response=false;
        }
      )
    );
    return response;
  }

  @override
  Future<Map<String, dynamic>> getNotificationsActionsSalesperson(String propertyId) async{
    Map<String,dynamic> map={};
    List<Notificationn> notifications=[];
    List propertyComplaints=[];
    List administratorsRequests=[];
    int notificationsNumber=0;
    AdministratorRequest administratorProperty=AdministratorRequest.empty();
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(queryGetNotificationsSalespersonActions()),
        variables: ({
          "id_inmueble":propertyId
        }),
        fetchPolicy: graphql.FetchPolicy.noCache,
      ),
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
        if(result.data!["obtenerNotificacionesAccionesVendedor"]!=null){
          propertyComplaints=result.data!["obtenerNotificacionesAccionesVendedor"]["inmueble_queja"];
          administratorsRequests=result.data!["obtenerNotificacionesAccionesVendedor"]["solicitudes_administradores"];
          administratorProperty=AdministratorRequest.fromMap(result.data!["obtenerNotificacionesAccionesVendedor"]["administrador_inmueble"]);
          propertyComplaints.forEach((element) {
            PropertyComplaint propertyComplaint=PropertyComplaint.fromMap(element);
            if(propertyComplaint.response!=""&&!propertyComplaint.deliveredResponse){
              notificationsNumber++;
            }
            notifications.add(Notificationn(date: propertyComplaint.requestDate, data: propertyComplaint));
          });
          administratorsRequests.forEach((element) {
            AdministratorRequest request=AdministratorRequest.fromMap(element);
            if(request.response!=""){
              if(request.response=="Confirmado"){
                if(request.responseSuperUser!=""&&!request.deliveredResponse){
                  notificationsNumber++;
                }
              }else{
                if(!request.deliveredResponse){
                  notificationsNumber++;
                }
              }
            }
            notifications.add(Notificationn(date: request.requestDate, data: request));
          });
          notifications.sort((b,a)=>a.date.compareTo(b.date));
      }
    }

    map["completed"]=completed;
    map["notifications"]=notifications;
    map["administrator_property"]=administratorProperty;
    map["notifications_number"]=notificationsNumber;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registerPropertyComplaint(PropertyComplaint propertyComplaint) async{
    bool completed=true;
    Map<String,dynamic> map={};
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationRegisterPropertyComplaint()),
        variables: (propertyComplaint.toMap()),
        onCompleted: (data){
          if(data!=null){
            propertyComplaint=PropertyComplaint.fromMap(data["registrarInmuebleQueja"]);
          }
        },
        onError: (error){
          print(error);
          completed=false;
        }
      )
    );
    map["completed"]=completed;
    map["property_complaint"]=propertyComplaint;
    return map;
  }

  @override
  Future<Map<String, dynamic>> updatePropertyPrice(PropertyTotal propertyTotal) async{
    bool completed=true;
    String errorMessage="";
    Map<String,dynamic> map={};
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    print(propertyTotal.toMap());
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationUpdatePriceProperty()),
        variables: (propertyTotal.toMap()),
        onCompleted: (data){
          if(data!=null){
          }
        },
        onError: (error){
          error!.graphqlErrors.forEach((element) { 
            errorMessage=element.message;
          });
          completed=false;
        }
      )
    );
    map["completed"]=completed;
    map["error_message"]=errorMessage;
    return map;
  }
  
  @override
  Future<Map<String, dynamic>> readAdministratorRequestUser(String requestId) async{
    bool completed=true;
    Map<String,dynamic> map={};
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationReadAdministratorRequestUser()),
        variables: ({"id":requestId}),
        onCompleted: (data){
          if(data!=null){
          }
        },
        onError: (error){
          error!.graphqlErrors.forEach((element) { 
          });
          completed=false;
        }
      )
    );
    map["completed"]=completed;
    return map;
  }
  
  @override
  Future<Map<String, dynamic>> getComplaintsReportsProperty(String propertyId) async{
    Map<String,dynamic> map={};
    List propertyComplaintsD=[];
    List<PropertyComplaint> propertyComplaints=[];
    List propertyReportsD=[];
    List<PropertyReported> propertyReports=[];
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(queryGetComplaintReportPropety()),
        variables: ({
          "id_inmueble":propertyId
        }),
        fetchPolicy: graphql.FetchPolicy.noCache,
      ),
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
      if(result.data!["obtenerReportesQuejasInmueble"]!=null){
        propertyComplaintsD=result.data!["obtenerReportesQuejasInmueble"]["inmueble_quejas"];
        propertyReportsD=result.data!["obtenerReportesQuejasInmueble"]["reportes_inmueble"];
        propertyComplaintsD.forEach((element) {
          propertyComplaints.add(PropertyComplaint.fromMap(element));
        });
        propertyReportsD.forEach((element) {
          propertyReports.add(PropertyReported.fromMap(element,""));
        });
      }
    }

    map["completed"]=completed;
    map["property_complaints"]=propertyComplaints;
    map["property_reports"]=propertyReports;
    return map;
  }
  
  @override
  Future<Map<String, dynamic>> closeOperationsProperty(PropertyTotal propertyTotal) async{
    Map<String,dynamic> response={};
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationCloseOperationsProperty(),
      ),
      variables: (
        propertyTotal.toMap()
      ),
      onCompleted: (dynamic data){
        if(data!=null){
          completed=true;
        }
      },
      onError: (error){
        print(error);
        completed=false;
      }
    ));
    response["completed"]=completed;
    return response;
  }

}
