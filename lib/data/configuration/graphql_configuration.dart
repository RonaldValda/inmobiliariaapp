import 'package:graphql_flutter/graphql_flutter.dart';
class GraphQLConfiguration{
  final HttpLink httpLink=new HttpLink("https://inmobiliaria-app-v1.herokuapp.com/");
  final WebSocketLink webSocketLink=WebSocketLink("ws://inmobiliaria-app-v1.herokuapp.com/");
  //static HttpLink httpLink=new HttpLink("http://10.0.2.2:4000/");
  //static final WebSocketLink webSocketLink=WebSocketLink("wss://10.0.2.2:4000/");
  //static HttpLink httpLink=new HttpLink("http://192.168.100.13:4000/");
  //static final WebSocketLink webSocketLink=WebSocketLink("wss://192.168.100.13:4000/");
  //final Link link=httpLink.concat(webSocketLink);
  GraphQLClient myGQLClient(){
    return GraphQLClient(
      link: httpLink.concat(webSocketLink), 
      cache:  GraphQLCache(store: HiveStore())
    );
  }
}