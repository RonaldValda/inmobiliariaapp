import 'package:inmobiliariaapp/data/configuration/graphql_configuration.dart';
import 'package:inmobiliariaapp/data/repositories/generals/membership_plan_payment_repository_gql.dart';
import 'package:inmobiliariaapp/domain/entities/membership_plan_payment.dart';
import 'package:inmobiliariaapp/domain/repositories/abstract_generals.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;

class MembershipPlanPaymentRepository extends AbstractMembershipPlanPaymentRepository{
  @override
  Future<Map<String, dynamic>> updateMembershipPlanPayment(MembershipPlanPayment membershipPlanPayment) async{
    Map<String,dynamic> map={};
    String errorMessage="";
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationUpdateMembershipPlanPayment(),
      ),
      variables: (
        membershipPlanPayment.toMap()
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
  Future<Map<String, dynamic>> getMembershipPlanPayment() async{
    Map<String,dynamic> map={};
    List<MembershipPlanPayment> membershipPlansPayment=[];
    List membershipD=[];
    bool completed=true;
    String errorMessage="";
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(queryGetMembershipPlansPayment()),
        
        fetchPolicy: graphql.FetchPolicy.noCache,
      ),
    );
    if(result.hasException){
      result.exception!.graphqlErrors.forEach((element) { 
        errorMessage=element.message;
      });
      completed=false;
    }else if(!result.hasException){
      membershipD=[];
        if(result.data!["obtenerMembresiaPlanesPago"]!=null){
          membershipD=result.data!["obtenerMembresiaPlanesPago"];
          membershipD.forEach((element) {
            membershipPlansPayment.add(MembershipPlanPayment.fromMap(element));
          });
      }
    }

    map["completed"]=completed;
    map["error_message"]=errorMessage;
    map["membership_plans_payment"]=membershipPlansPayment;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registerMembershipPlanPayment(MembershipPlanPayment membershipPlanPayment)async{
    bool completed=true;
    String errorMessage="";
    Map<String,dynamic> mapResultado={};
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationRegisterMembershipPlanPayment(),
      ),
      variables: (
        membershipPlanPayment.toMap()
      ),
      fetchPolicy: graphql.FetchPolicy.noCache,
      onCompleted: (dynamic data){
        if(data!=null){
          membershipPlanPayment=MembershipPlanPayment.fromMap(data!["registrarMembresiaPlanesPago"]);
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
    mapResultado["membership_plan_payment"]=membershipPlanPayment;
    return mapResultado;
  }

}