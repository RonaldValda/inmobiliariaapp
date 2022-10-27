import 'package:inmobiliariaapp/data/repositories/generals/bank_repository_gql.dart';
import 'package:inmobiliariaapp/domain/entities/bank.dart';
import 'package:inmobiliariaapp/domain/repositories/abstract_generals.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:inmobiliariaapp/data/configuration/graphql_configuration.dart';

class BankRepository extends AbstractBankRepository{
  @override
  Future<Map<String, dynamic>> getBankAccounts() async{
    Map<String,dynamic> map={};
    List<BankAccount> bankAccounts=[];
    List bankAccountsD=[];
    bool completed=true;
    try{
      GraphQLConfiguration configuration=GraphQLConfiguration();
      graphql.GraphQLClient client=configuration.myGQLClient();
      graphql.QueryResult result=await client
      .query(
        graphql.QueryOptions(
          document: graphql.gql(queryGetBankAccounts()),
          cacheRereadPolicy: graphql.CacheRereadPolicy.mergeOptimistic,
          fetchPolicy: graphql.FetchPolicy.cacheAndNetwork,
        ),
      );
      if(result.hasException){
        completed=false;
      }else if(!result.hasException){
        if(result.data!["obtenerCuentasBancos"]!=null){
          bankAccountsD=result.data!["obtenerCuentasBancos"];
          bankAccountsD.forEach((element) { 
            bankAccounts.add(BankAccount.fromMap(element));
          });
        }
      }
    }catch (e){
      completed=false;
    }
    map["bank_accounts"]=bankAccounts;
    map["completed"]=completed;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registerBankAccount(BankAccount accountBank) async{
    bool completed=true;
    Map<String,dynamic> map={};
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationRegisterBankAccount()),
        variables: (accountBank.toMap()),
        onCompleted: (dynamic data){
          if(data!=null){
            if(data["registrarCuentaBanco"]!=null){
              accountBank=BankAccount.fromMap(data["registrarCuentaBanco"]);
            }
          }
        },
        onError: (error){
          error!.graphqlErrors.forEach((element) { 
            print(element);
          });
          completed=false;
        }
    ));
    map["completed"]=completed;
    map["bank_account"]=accountBank;
    return map;
  }

  @override
  Future<Map<String, dynamic>> deleteBank(String bankId) async{
    Map<String,dynamic> map={};
    String errorMessage="";
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationDeleteBank(),
      
      ),
      variables: ({"id":bankId}),
      onCompleted: (dynamic data){
        if(data!=null){
          if(data["eliminarBanco"]!=null){
          }
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
  Future<Map<String, dynamic>> updateBank(Bank bank) async{
    Map<String,dynamic> map={};
    String errorMessage="";
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    print(bank.toMap());
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationUpdateBank(),
      
      ),
      variables: (bank.toMap()),
      onCompleted: (dynamic data){
        if(data!=null){
          if(data["modificarBanco"]!=null){
          }
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
  Future<Map<String, dynamic>> getBanks() async{
    Map<String,dynamic> map={};
    List<Bank> banks=[];
    List banksD=[];
    String errorMessage="";
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(queryGetBanks()),
        
        fetchPolicy: graphql.FetchPolicy.noCache,
      ),
    );
    if(result.hasException){
      result.exception!.graphqlErrors.forEach((element) { 
        errorMessage=element.message;
      });
      completed=false;
    }else if(!result.hasException){
        if(result.data!["obtenerBancos"]!=null){
          banksD=result.data!["obtenerBancos"];
          banksD.forEach((element) {
            banks.add(Bank.fromMap(element));
          });
      }
    }
    map["error_message"]=errorMessage;
    map["completed"]=completed;
    map["banks"]=banks;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registerBank(Bank bank) async{
    bool completed=true;
    String errorMessage="";
    Map<String,dynamic> map={};
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationRegisterBank(),
      
      ),
      variables: (bank.toMap()),
      onCompleted: (dynamic data){
        if(data!=null){
          if(data["registrarBanco"]!=null){
            bank.id=data["registrarBanco"]["id"];
          }
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
    map["bank"]=bank;
    map["error_message"]=errorMessage;
    return map;
  }
  
  @override
  Future<Map<String, dynamic>> deleteBankAccount(BankAccount bankAccount) async{
    bool completed=true;
    Map<String,dynamic> map={};
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationDeleteBankAccount()),
        variables: ({
          "id":bankAccount.id
        }),
        onCompleted: (dynamic data){
          if(data!=null){
            if(data["eliminarCuentaBanco"]!=null){
            }
          }
        },
        onError: (error){
          error!.graphqlErrors.forEach((element) { 
            print(element);
          });
          completed=false;
        }
    ));
    map["completed"]=completed;
    return map;
  }
  
  @override
  Future<Map<String, dynamic>> updateBankAccount(BankAccount bankAccount) async{
    bool completed=true;
    Map<String,dynamic> map={};
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationUpdateBankAccount()),
        variables: (bankAccount.toMap()),
        onCompleted: (dynamic data){
          if(data!=null){
            if(data["modificarCuentaBanco"]!=null){
            }
          }
        },
        onError: (error){
          error!.graphqlErrors.forEach((element) { 
            print(element);
          });
          completed=false;
        }
    ));
    map["completed"]=completed;
    return map;
  }
  

}