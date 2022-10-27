import 'package:inmobiliariaapp/data/configuration/graphql_configuration.dart';
import 'package:inmobiliariaapp/data/repositories/generals/publicity_repository_gql.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:inmobiliariaapp/domain/entities/publicity.dart';
import 'package:inmobiliariaapp/domain/repositories/abstract_generals.dart';

class PublicityRepository extends AbstractPublicityRepository{
  @override
  Future<Map<String, dynamic>> deleteAd(String adId) async{
    Map<String,dynamic> map={};
    String errorMessage="";
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      
      graphql.MutationOptions(
        document: graphql.gql(mutationDeleteAd(),
      ),
      variables: (
        {
          "id":adId,
        }
      ),
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
    map["completed"]=completed;
    map["error_message"]=errorMessage;
    return map;
  }

  @override
  Future<Map<String, dynamic>> getAds() async{
    Map<String,dynamic> map={};
    List<List<String>> ads=[];
    String errorMessage="";
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document: graphql.gql(queryGetAds())
      )
    );
    if(result.hasException){
      completed=false;
      result.exception!.graphqlErrors.forEach((element) {
        errorMessage=element.message;
       });
    }else if(!result.hasException){
      ads=[];
      List adsD;
      if(result.data!["obtener"]!=null){
        adsD=result.data!["obtener"];
        adsD.forEach((element) {
          ads.add([element["id_ad"],element["tipo_ad"]]);
        });
      }
    }
    map["ads"]=ads;
    map["error_message"]=errorMessage;
    map["completed"]=completed;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registerAd(String adId, String adType) async{
    bool completed=true;
    String errorMessage="";
    Map<String,dynamic> map={};
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      
      graphql.MutationOptions(
        document: graphql.gql(mutationRegisterAd(),
      
      ),
      variables: (
        {
          "id_ad":adId,
          "tipo_ad":adType
        }
      ),
      onCompleted: (dynamic data){
        if(data!=null){
          print(data!);
        }
      },
      onError: (error){
        error!.graphqlErrors.forEach((element) { 
          errorMessage=element.message;
        });
        completed=false;
      }
    ));
    map["completed"]=completed;
    map["error_message"]=errorMessage;
    return map;
  }

  @override
  Future<Map<String, dynamic>> deletePublicity(String id) async{
    Map<String,dynamic> map={};
    String errorMessage="";
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationDeletePublicity(),
      ),
      variables: (
        {
          "id":id
        }
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
    map["completed"]=completed;
    map["error_message"]=errorMessage;
    return map;
  }

  @override
  Future<Map<String, dynamic>> updatePublicity(Publicity publicity, int monthsValidity) async{
  
    bool completed=true;
    String errorMessage="";
    Map<String,dynamic> mapResult={};
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    Map<String,dynamic> map=publicity.toMap();
    map.addAll({"meses_vigencia":monthsValidity});
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationUpdatePublicity(),
      ),
      variables: (
        map
      ),
      fetchPolicy: graphql.FetchPolicy.noCache,
      
      onCompleted: (dynamic data){
        if(data!=null){
          Publicity p=Publicity.fromMap(data!["modificarPublicidad"]);
          publicity.expirationDate=p.expirationDate;
        }
      },
      onError: (error){
        error!.graphqlErrors.forEach((element) { 
          errorMessage=element.message;
        });
        completed=false;
      }
    ));
    mapResult["error_message"]=errorMessage;
    mapResult["completed"]=completed;
    mapResult["publicity"]=publicity;
    return mapResult;
  }

  @override
  Future<Map<String, dynamic>> getPublicities() async{
    Map<String,dynamic> map={};
    List<Publicity> publicities=[];
    List publicitiesD=[];
    bool completed=true;
    String errorMessage="";
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(queryGetPublicities()),
        
        fetchPolicy: graphql.FetchPolicy.noCache,
      ),
    );
    if(result.hasException){
      result.exception!.graphqlErrors.forEach((element) { 
        errorMessage=element.message;
      });
      completed=false;
    }else if(!result.hasException){
        if(result.data!["obtenerPublicidad"]!=null){
          publicitiesD=result.data!["obtenerPublicidad"];
          publicitiesD.forEach((element) {
            publicities.add(Publicity.fromMap(element));
          });
      }
    }
    map["error_message"]=errorMessage;
    map["completed"]=completed;
    map["publicities"]=publicities;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registerPublicity(Publicity publicity, int monthsValidity) async{
    bool completed=true;
    String errorMessage="";
    Map<String,dynamic> mapResultado={};
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    Map<String,dynamic> map=publicity.toMap();
    map.addAll({"meses_vigencia":monthsValidity});
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationRegisterPublicity(),
      ),
      variables: (
        map
      ),
      fetchPolicy: graphql.FetchPolicy.noCache,
      onCompleted: (dynamic data){
        if(data!=null){
          Publicity p=Publicity.fromMap(data!["registrarPublicidad"]);
          publicity.id=p.id;
          publicity.creationDate=p.creationDate;
          publicity.expirationDate=p.expirationDate;
        }
      },
      onError: (error){
        completed=false;
      }
    ));
    mapResultado["error_message"]=errorMessage;
    mapResultado["completed"]=completed;
    mapResultado["publicity"]=publicity;
    return mapResultado;
  }

}