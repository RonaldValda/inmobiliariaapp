import 'package:inmobiliariaapp/data/configuration/graphql_configuration.dart';
import 'package:inmobiliariaapp/data/repositories/generals/publication_plan_payment_repository_gql.dart';
import 'package:inmobiliariaapp/domain/entities/publication_plan_payment.dart';
import 'package:inmobiliariaapp/domain/repositories/abstract_generals.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;

class PublicationPlanPaymentRepository extends AbstractPublicationPlanPaymentRepository{
  @override
  Future<Map<String, dynamic>> deletePublicationPlanPayment(String id) async{
    Map<String,dynamic> map={};
    bool completed=true;
    String errorMessage="";
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationDeletePublicationPlanPayment(),
      ),
      variables: (
        {"id":id}
      ),
      fetchPolicy: graphql.FetchPolicy.noCache,
      onCompleted: (dynamic data){
        if(data!=null){
          
        }
      },
      onError: (error){
        error!.graphqlErrors.forEach((element) { 
          errorMessage=element.message;
        });
        completed=false;
      }
    ));
    map["error_messahe"]=errorMessage;
    map["completed"]=completed;
    return map;
  }

  @override
  Future<Map<String, dynamic>> updatePublicationPlanPayment(PublicationPlanPayment plan) async{
    Map<String,dynamic> map={};
    bool completed=true;
    String errorMessage="";
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationUpdatePublicationPlanPayment(),
      ),
      variables: (
        plan.toMap()
      ),
      fetchPolicy: graphql.FetchPolicy.noCache,
      onCompleted: (dynamic data){
        if(data!=null){
          
        }
      },
      onError: (error){
        completed=false;
        error!.graphqlErrors.forEach((element) { 
          errorMessage=element.message;
        });
      }
    ));
    map["completed"]=completed;
    map["error_message"]=errorMessage;
    return map;
  }

  @override
  Future<Map<String, dynamic>> getPublicationPlansPayment(String planType) async{
    Map<String,dynamic> map={};
    List<PublicationPlanPayment> publicationPlansPayment=[];
    List plans=[];
    bool completed=true;
    String errorMessage="";
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(queryGetPublicationPlansPayment()),
        variables: {
          "tipo_plan":planType
        },
        fetchPolicy: graphql.FetchPolicy.noCache,
      ),
    );
    if(result.hasException){
      completed=false;
      result.exception!.graphqlErrors.forEach((element) { 
        errorMessage=element.message;
      });
    }else if(!result.hasException){
      plans=[];
        if(result.data!["obtenerPlanesPagoPublicacion"]!=null){
          plans=result.data!["obtenerPlanesPagoPublicacion"];
          plans.forEach((element) {
            publicationPlansPayment.add(PublicationPlanPayment.fromMap(element));
          });
      }
    }
    map["error_message"]=errorMessage;
    map["completed"]=completed;
    map["publication_plans_payment"]=publicationPlansPayment;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registerPublicationPlanPayment(PublicationPlanPayment plan) async{
    bool completed=true;
    String errorMessage="";
    Map<String,dynamic> mapResultado={};
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationRegisterPublicationPlanPayment(),
      ),
      variables: (
        plan.toMap()
      ),
      fetchPolicy: graphql.FetchPolicy.noCache,
      onCompleted: (dynamic data){
        if(data!=null){
          plan.id=data["registrarPlanesPagoPublicacion"]["id"];
        }
      },
      onError: (error){
        completed=false;
        error!.graphqlErrors.forEach((element) { 
          errorMessage=element.message;
        });
      }
    ));
    mapResultado["completed"]=completed;
    mapResultado["error_message"]=errorMessage;
    mapResultado["publication_plan_payment"]=plan;
    return mapResultado;
  }

}