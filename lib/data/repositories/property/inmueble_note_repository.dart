import 'package:inmobiliariaapp/data/repositories/property/inmueble_note_repository_gql.dart';
import 'package:inmobiliariaapp/domain/entities/property.dart';
import 'package:inmobiliariaapp/domain/repositories/abstract_property.dart';
import 'package:inmobiliariaapp/data/configuration/graphql_configuration.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
class PropertyNoteRepository extends AbstractPropertyNoteRepository{
  @override
  Future<Map<String,dynamic>> searchPropertyNote(String propertyId, String userId) async{
    Map<String,dynamic> map={};
    PropertyClientNote propertyClientNote=PropertyClientNote.empty();
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document: graphql.gql(querySearchPropertyNote()),
        cacheRereadPolicy: graphql.CacheRereadPolicy.mergeOptimistic,
        fetchPolicy: graphql.FetchPolicy.cacheAndNetwork,
        variables: {
          "id_inmueble":propertyId,
          "id_usuario":userId
        }
      )
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
        if(result.data!["buscarInmuebleNota"]!=null){
          propertyClientNote=PropertyClientNote.fromMap(result.data!["buscarInmuebleNota"]);
        }
    }
    map["completed"]=completed;
    map["property_client_note"]=propertyClientNote;
    return map;
  }

  @override
  Future<Map<String,dynamic>> savePropertyNote(String propertyId,String userId,PropertyClientNote propertyClientNote) async{
    bool completed=true;
    Map<String,dynamic> mapResultado={};
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationSavePropertyNote()),
        variables: (
          {
            "id_inmueble":propertyId,
            "id_usuario":userId,
            "nota":propertyClientNote.note
          }
        ),
        onCompleted: (data){
          if(data!["guardarInmuebleNota"]!=null){
            propertyClientNote.id=data["guardarInmuebleNota"]["id"];
            propertyClientNote.date=data["guardarInmuebleNota"]["fecha"];
          }
        },
        onError: (error){
          completed=false;
        }
      )
    );
    mapResultado["completed"]=completed;
    mapResultado["property_client_note"]=propertyClientNote;
    return mapResultado;
  }

}