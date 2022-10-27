import 'package:inmobiliariaapp/data/configuration/graphql_configuration.dart';
import 'package:inmobiliariaapp/data/repositories/property/property_reported_repository_gql.dart';
import 'package:inmobiliariaapp/domain/entities/user.dart';
import 'package:inmobiliariaapp/domain/entities/administrator_request.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/domain/entities/property_reported.dart';
import 'package:inmobiliariaapp/domain/repositories/abstract_property.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;

class PropertyReportedRepository extends AbstractPropertyReportedRepository{
  @override
  Future<Map<String,dynamic>> getReportsProperty(User user, PropertyTotal propertyTotal, bool status1, bool status2) async{
    Map<String,dynamic> mapResponse={};
    bool completed=true;
    List<AdministratorRequest> requests=[];
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document: graphql.gql(queryGetPropertiesReported()),
        variables: {
          "id_usuario":user.id,
          "id_inmueble":propertyTotal.property.id,
          "estado_1":status1,
          "estado_2":status2
        }
      )
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
      requests=[];
      List requestsD;
      if(result.data!["obtenerReportesInmueble"]!=null){
        requestsD=result.data!["obtenerReportesInmueble"];
        //print(solicitudesD);
        requestsD.forEach((element) {
          requests.add(AdministratorRequest.fromMap(element));
        });
      }
      
    }
    mapResponse["completed"]=completed;
    mapResponse["requests"]=requests;
    return mapResponse;
  }

  @override
  Future<bool> reportProperty(PropertyReported propertyReported) async{
    bool response=false;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationReportProperty(),
      ),
      variables: (propertyReported.toMap()),
      onCompleted: (dynamic data){
        if(data!=null){
          response=true;
        }
      },
      onError: (error){
        response=false;
      }
    ));
    return response;
  }
}