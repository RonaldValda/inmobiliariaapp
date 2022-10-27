import 'package:inmobiliariaapp/data/configuration/graphql_configuration.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:inmobiliariaapp/data/repositories/user/user_repository_gql.dart';
import 'package:inmobiliariaapp/domain/entities/agent_registration.dart';
import 'package:inmobiliariaapp/domain/entities/membership_payment.dart';
import 'package:inmobiliariaapp/domain/entities/user.dart';
import 'package:inmobiliariaapp/domain/entities/user_property_favorite.dart';
import 'package:inmobiliariaapp/domain/repositories/abstract_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../auxiliares/global_variables.dart';

class UserRepository extends AbstractUser{
  @override
  Future<Map<String, dynamic>> authenticateUser(User user) async{
     Map<String,dynamic> map={};
    bool completed=true;
    MembershipPayment membershipPaymentCurrent=MembershipPayment.empty();
    List<MembershipPayment> membershipsPayments=[];
    List<UserPropertyBase> userPropertyBases=[];
    userPropertyBases.add(UserPropertyBase.empty());
    userPropertyBases.add(UserPropertyBase.empty());
    userPropertyBases.add(UserPropertyBase.empty());
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationAuthenticateUser()),
        variables: (
          user.toMap()
        ),
        onCompleted: (data){
          if(data!=null){
            user=User.fromMap(data["autenticarUsuario"]);
            
            if(data["autenticarUsuario"]["usuario_inmueble_base"]!=null){
              if(data["autenticarUsuario"]["usuario_inmueble_base"].length>=2){
                userPropertyBases=[];
                DateTime endDateSaved;
                DateTime cacheDate;
                userPropertyBases.add(UserPropertyBase.fromMap(data["autenticarUsuario"]["usuario_inmueble_base"][0]));
                userPropertyBases.add(UserPropertyBase.fromMap(data["autenticarUsuario"]["usuario_inmueble_base"][1]));
                userPropertyBases.add(UserPropertyBase.fromMap(data["autenticarUsuario"]["usuario_inmueble_base"][2]));
                endDateSaved=DateTime.parse(userPropertyBases[0].endDateSaved);
                cacheDate=DateTime.parse(userPropertyBases[0].cacheDate);
                int diasDiferencia=(cacheDate.difference(endDateSaved).inHours);
                if(diasDiferencia>=24){
                  registerUserPropertyBase(user.id, userPropertyBases[2], userPropertyBases[0], userPropertyBases[1]);
                }
                MembershipPayment membershipPayment=MembershipPayment.empty();
                DateTime currentDate=DateTime.now().toUtc();
                if(data["autenticarUsuario"]["membresia_pagos"]!=null){
                  List membresiaPagosD=data["autenticarUsuario"]["membresia_pagos"];
                  membresiaPagosD.forEach((element) {
                    membershipPayment=MembershipPayment.fromMap(element);
                    if(membershipPayment.authorizationSuperUser=="Aprobado"){
                      if(DateTime.parse(membershipPayment.finalDate).difference(currentDate).inMinutes>0){
                        membershipPaymentCurrent=membershipPayment;
                      }
                    }
                    membershipsPayments.add(membershipPayment);
                  });
                // print("cantidad pagos: "+usuariosInfo.agentePagos.length.toString());
                }
              }
            }
          }
        },
        onError: (error){
          error!.graphqlErrors.forEach((element) {
            print("---"+element.message);
           });
          completed=false;
        }
      )
    );
    map["completed"]=completed;
    map["user"]=user;
    map["user_property_bases"]=userPropertyBases;
    map["membership_payment_current"]=membershipPaymentCurrent;
    map["memberships_payments"]=membershipsPayments;
    return map;
  }

  @override
  Future<Map<String, dynamic>> authenticateUserAutomatic(
    String email,String imeiNumber,
    UserPropertyBase viewedBase,
    UserPropertyBase viewedDoubleBase,
    UserPropertyBase favoriteBase
  ) async{
    bool completed=true;
    Map<String,dynamic> map={};
    User user=User.empty();
    List<UserPropertyBase> userPropertyBases=[];
    List<MembershipPayment> membershipsPayments=[];
    MembershipPayment membershipPaymentCurrent=MembershipPayment.empty();
    MembershipPayment membershipPayment=MembershipPayment.empty();
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document: graphql.gql(queryAuthenticateUserAutomatic()),
        variables: {
          "email":email,
          "imei":imeiNumber
        },
        cacheRereadPolicy: graphql.CacheRereadPolicy.mergeOptimistic,
        fetchPolicy: modoOffline?graphql.FetchPolicy.cacheFirst:graphql.FetchPolicy.cacheAndNetwork,
      )
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
      user=User.empty();
      userPropertyBases.add(UserPropertyBase.empty());
      userPropertyBases.add(UserPropertyBase.empty());
      userPropertyBases.add(UserPropertyBase.empty());
      if(result.data!["autenticarUsuarioAutomatico"]!=null){
        user=User.fromMap(result.data!["autenticarUsuarioAutomatico"]);
        if(result.data!["autenticarUsuarioAutomatico"]["usuario_inmueble_base"]!=null){
          if(result.data!["autenticarUsuarioAutomatico"]["usuario_inmueble_base"].length>=2){
            userPropertyBases=[];
            DateTime endDateSaved;
            DateTime cacheDate;
            userPropertyBases.add(UserPropertyBase.fromMap(result.data!["autenticarUsuarioAutomatico"]["usuario_inmueble_base"][0]));
            userPropertyBases.add(UserPropertyBase.fromMap(result.data!["autenticarUsuarioAutomatico"]["usuario_inmueble_base"][1]));
            userPropertyBases.add(UserPropertyBase.fromMap(result.data!["autenticarUsuarioAutomatico"]["usuario_inmueble_base"][2]));
            endDateSaved=DateTime.parse(userPropertyBases[0].endDateSaved);
            cacheDate=DateTime.parse(userPropertyBases[0].cacheDate);
            int daysDifference=(cacheDate.difference(endDateSaved).inHours);
            String startDate=userPropertyBases[0].startDate;
            viewedBase.startDate=startDate;
            viewedDoubleBase.startDate=startDate;
            favoriteBase.startDate=startDate;
            if(viewedBase.propertiesQuantity>userPropertyBases[2].propertiesQuantity){
              userPropertyBases=[];
              userPropertyBases.add(viewedDoubleBase);
              userPropertyBases.add(favoriteBase);
              userPropertyBases.add(viewedBase);
            }
            if(daysDifference>=24){
              registerUserPropertyBase(user.id, viewedBase, viewedDoubleBase, favoriteBase);
            }
          }
        }
        membershipsPayments=[];
        membershipPaymentCurrent=MembershipPayment.empty();
        DateTime dateTimeNow=DateTime.now().toUtc();
        if(result.data!["autenticarUsuarioAutomatico"]["membresia_pagos"]!=null){
          result.data!["autenticarUsuarioAutomatico"]["membresia_pagos"]
          .forEach((element) {
            membershipPayment=MembershipPayment.fromMap(element);
            if(membershipPayment.authorizationSuperUser=="Aprobado"){
              if(DateTime.parse(membershipPayment.finalDate).difference(dateTimeNow).inMinutes>0){
                membershipPaymentCurrent=membershipPayment;
              }
            }
            membershipsPayments.add(membershipPayment);
          });
        }
        
      }
    }
    map["completed"]=completed;
    map["user"]=user;
    map["user_property_bases"]=userPropertyBases;
    map["memberships_payments"]=membershipsPayments;
    map["membership_payment_current"]=membershipPaymentCurrent;
    
    return map;
  }

  @override
  Future<Map<String, dynamic>> searchUserEmail(String email) async{
    Map<String,dynamic> map={};
    bool completed=true;
    String errorMessage="";
    User user=User.empty();
    GraphQLConfiguration configuration=GraphQLConfiguration();
    
    graphql.GraphQLClient client=configuration.myGQLClient();
    
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationSearchUserEmail()),
        variables: (
          {
            "email":email
          }
        ),
        onCompleted: (data){
          if(data!=null){
            user=User.fromMap(data["buscarUsuarioEmail"]);
          }
        },
        onError: (error){
          errorMessage=error!.graphqlErrors[0].message;
          completed=false;
        }
      )
    );
    map["completed"]=completed;
    map["error_message"]=errorMessage;
    map["user"]=user;
    return map;
  }

  @override
  Future<Map<String, dynamic>> createUpdateUser(User user,String activity) async{
    Map<String,dynamic> map={};
    Map<String,dynamic> mapVariables={};
    bool completed=true;
    String errorMessage="";
    mapVariables.addAll(user.toMap());
    mapVariables.addAll({"actividad":activity});
    GraphQLConfiguration configuration=GraphQLConfiguration();
    
    graphql.GraphQLClient client=configuration.myGQLClient();
    
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationCreateUpdateUser()),
        variables: (
          mapVariables
        ),
        onCompleted: (data){
          if(data!=null){
            user=User.fromMap(data["crearModificarUsuario"]);
          }
        },
        onError: (error){
          errorMessage=error!.graphqlErrors[0].message;
          completed=false;
        }
      )
    );
    map["completed"]=completed;
    map["error_message"]=errorMessage;
    return map;
  }

  @override
  Future<bool> updateUser(User user) async{
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationUpdateUser()),
        variables: (
          user.toMap()
        ),
        onCompleted: (data){
          if(data!=null){
          }
        },
        onError: (error){
          completed=false;
          print(error);
        }
      )
    );
    return completed;
  }

  @override
  Future<Map<String, dynamic>> updateUserPropertySearched(
    UserPropertySearched searched
  ) async{
    UserPropertySearched userPropertySearched=UserPropertySearched.empty();
    Map<String,dynamic> map={};
    bool completed=false;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationUpdatePropertiesSearcheds()),
        variables: (
          searched.toMap()
        ),
        onCompleted: (data){
          if(data!=null){
            userPropertySearched=UserPropertySearched.fromMap(searched.toMap());
            completed=true;
          }
        },
        onError: (error){
          completed=false;
        }
      )
    );
    map["completed"]=completed;
    map["user_property_searched"]=userPropertySearched;
    return map;
  }

  @override
  Future<bool> updateUserPropertySearchedPersonalInformation(UserPropertySearched userPropertySearched) async{
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationUpdateUserPropertySearchedPersonalInformation()),
        variables: (
          userPropertySearched.toMap()
        ),
        onCompleted: (data){
          if(data!=null){
          }
        },
        onError: (error){
          completed=false;
        }
      )
    );
    return completed;
  }

  @override
  Future<Map<String, dynamic>> getAgentsCity(String city) async{
    Map<String,dynamic> map={};
    List<User> agents=[];
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document: graphql.gql(queryGetAgentsCity()),
        cacheRereadPolicy: graphql.CacheRereadPolicy.mergeOptimistic,
        fetchPolicy: graphql.FetchPolicy.cacheAndNetwork,
        variables: {
          "ciudad":city
        }
      )
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
        if(result.data!["obtenerAgentesCiudad"]!=null){
          result.data!["obtenerAgentesCiudad"]
          .forEach((map) {
            agents.add(User.fromMap(map));
          });
        }
    }

    map["completed"]=completed;
    map["agents"]=agents;
    return map;
  }

  @override
  Future<Map<String, dynamic>> getEmailKeyVerifications(String email,int key) async{
    Map<String,dynamic> map={};
    String errorMessage="";
    bool completed=true;
    User user=User.empty();

    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(queryGetEmailKeyVerifications()),
        variables: (
          {
            "email":email,
            "clave":key
          }
        ),
        onCompleted: (data){
          if(data!=null){
            if(data["obtenerEmailClaveVerificaciones"]!=null){
              if(data["obtenerEmailClaveVerificaciones"]["usuario"]!=null){
                user.names=data["obtenerEmailClaveVerificaciones"]["usuario"]["nombres"];
                user.surnames=data["obtenerEmailClaveVerificaciones"]["usuario"]["apellidos"];
              }
            }
          }
        },
        onError: (error){
          errorMessage=error!.graphqlErrors[0].message;
          completed=false;
        }
      )
    );
    map["completed"]=completed;
    map["error_message"]=errorMessage;
    map["user"]=user;
    return map;
  }

  @override
  Future<Map<String, dynamic>> getMembershipPayments(String id) async{
    Map<String,dynamic> map={};
    List<MembershipPayment> membershipsPayments=[];
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document: graphql.gql(queryGetMembershipPayments()),
        fetchPolicy: modoOffline?graphql.FetchPolicy.cacheFirst:graphql.FetchPolicy.cacheAndNetwork,
        variables: {
          "id":id
        }
      )
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
        if(result.data!["obtenerMembresiaPagos"]!=null){
          result.data!["obtenerMembresiaPagos"]
          .forEach((map) {
            membershipsPayments.add(MembershipPayment.fromMap(map));
          });
        }
    }

    map["completed"]=completed;
    map["memberships_payments"]=membershipsPayments;
    return map;
  }

  @override
  Future<Map<String, dynamic>> getUserEmail(String email) async{
    Map<String,dynamic> map={};
    User user=User.empty();
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document: graphql.gql(mutationSearchUserEmail()),
        fetchPolicy: modoOffline?graphql.FetchPolicy.cacheFirst:graphql.FetchPolicy.cacheAndNetwork,
        variables: {
          "email":email
        }
      )
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
        if(result.data!["buscarUsuarioEmail"]!=null){
          user=User.fromMap(result.data!["buscarUsuarioEmail"]);
        }
    }

    map["completed"]=completed;
    map["user"]=user;
    return map;
  }

  @override
  Future<Map<String, dynamic>> getUserPropertiesSearcheds(User user) async{
    Map<String,dynamic> map={};
    List<UserPropertySearched> userPropertiesSearcheds=[];
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document: graphql.gql(queryGetUserPropertiesSearcheds()),
        fetchPolicy: modoOffline?graphql.FetchPolicy.cacheFirst:graphql.FetchPolicy.cacheAndNetwork,
        variables: {
          "id":user.id
        }
      )
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
        if(result.data!["obtenerUsuarioInmueblesBuscados"]!=null){
          result.data!["obtenerUsuarioInmueblesBuscados"]
          .forEach((map) {
            userPropertiesSearcheds.add(UserPropertySearched.fromMap(map));
          });
        }
    }

    map["completed"]=completed;
    map["user_properties_searcheds"]=userPropertiesSearcheds;
    return map;
  }

  @override
  Future<Map<String, dynamic>> getUserRequests() {
    // TODO: implement obtenerUsuarioSolicitudes
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> registerEmailKeyVerifications(String email,String activity)async{
    Map<String,dynamic> map={};
    String errorMessage="";
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationRegisterEmailKeyVerifications()),
        variables: (
          {
            "email":email,
            "actividad":activity
          }
        ),
        onCompleted: (data){
          if(data!=null){
          }
        },
        onError: (error){
          errorMessage=error!.graphqlErrors[0].message;
          completed=false;
        }
      )
    );
    map["completed"]=completed;
    map["error_message"]=errorMessage;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registerMembershipPayment(MembershipPayment membershipPayment) async{
    Map<String,dynamic> map={};
    bool completed=true;
    String errorMessage="";
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationRegisterMembershipPayment()),
        variables: (
          membershipPayment.toMap()
        ),
        onCompleted: (data){
          if(data!=null){
            if(data["registrarMembresiaPago"]!=null){
              membershipPayment=MembershipPayment.fromMap(data["registrarMembresiaPago"]);
            }
          }
        },
        onError: (error){
          errorMessage=error!.graphqlErrors[0].message;
          completed=false;
        }
      )
    );
    map["completado"]=completed;
    map["membership_payment"]=membershipPayment;
    map["error_message"]=errorMessage;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registerAgentRegistrationRequest(AgentRegistration agentRegistration) async{
    Map<String,dynamic> map={};
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationRegisterAgentRegistrationRequest()),
        variables: (
          agentRegistration.toMap()
        ),
        onCompleted: (data){
          if(data!=null){
            if(data["registrarSolicitudInscripcionAgente"]!=null){
              agentRegistration.id=data["registrarSolicitudInscripcionAgente"]["id"];
              agentRegistration.requestDate=data["registrarSolicitudInscripcionAgente"]["fecha_solicitud"];
            }
          }
        },
        onError: (error){
          completed=false;
        }
      )
    );
    map["completed"]=completed;
    map["agent_registration"]=agentRegistration;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registerUserPropertySearched(
    User user,
    UserPropertySearched searched
  ) async{
    UserPropertySearched userPropertySearched=UserPropertySearched.empty();
    Map<String,dynamic> map={};
    bool completed=false;
    Map<String,dynamic> mapPropertySearched={};
    mapPropertySearched.addAll({"id_usuario":user.id});
    mapPropertySearched.addAll(searched.toMap());
    print(mapPropertySearched);
    //print(mapVariables);
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationRegisterUserPropertySearched()),
        variables: (
          mapPropertySearched
        ),
        onCompleted: (data){
          if(data!=null){
            userPropertySearched=UserPropertySearched.fromMap(data["registrarUsuarioInmuebleBuscado"]);
            completed=true;
          }
        },
        onError: (error){
          error!.graphqlErrors.forEach((element) { 
            print(element.message);
          });
          completed=false;
        }
      )
    );
    map["completed"]=completed;
    map["user_property_searched"]=userPropertySearched;
    return map;
  }

  @override
  Future<Map<String, dynamic>> answerUserQualificationRequest(String id,int qualification) async{
    Map<String,dynamic> map={};
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationAnswerUserRequestQualification()),
        variables: (
          {
            "id_solicitud":id,
            "calificacion":qualification
          }
        ),
        onCompleted: (data){
          if(data!=null){
          }
        },
        onError: (error){
          completed=false;
        }
      )
    );
    map["completed"]=completed;
    return map;
  }

  @override
  Future<bool> registerUserPropertyBase(String userId, UserPropertyBase viewedBase, UserPropertyBase viewedDoubleBase, UserPropertyBase favoriteBase) async{
    bool response=false;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationUpdatePropertyBase(),
      ),
      cacheRereadPolicy: graphql.CacheRereadPolicy.mergeOptimistic,
        fetchPolicy: modoOffline?graphql.FetchPolicy.cacheFirst:graphql.FetchPolicy.cacheAndNetwork,
      variables: (
        viewedBase.getMapRegisterPropertyBase(userId, viewedBase,viewedDoubleBase,favoriteBase)
      ),
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

  @override
  Future<void> registerUserShared(User user, Future<SharedPreferences> _prefs) async{
    final SharedPreferences prefs=await _prefs;
    await prefs.setString("id", user.id);
    await prefs.setString("nombres", user.names);
    await prefs.setString("apellidos", user.surnames);
    await prefs.setString("email", user.email);
  }
  
  @override
  Future<void> registerInitialCityShared(String initialCity,Future<SharedPreferences> _prefs) async{
    final SharedPreferences prefs=await _prefs;
    print(initialCity);
    await prefs.setString("initial_city", initialCity);
  }
}