import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/pages/principal/page_home.dart';
import 'package:inmobiliariaapp/ui/provider/datos_generales_info.dart';
import 'package:inmobiliariaapp/ui/provider/estado_widgets.dart';
import 'package:inmobiliariaapp/ui/provider/inmueble_info.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_comunidad_info.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_generales_info.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_info.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_internas_info.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_otros_info.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_por_usuario.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_principales_info.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_super_usuario_info.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:provider/provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await initHiveForFlutter();
  await Firebase.initializeApp();
  runApp(
    MyApp()
  );
}
class MyApp extends StatelessWidget{
  //final HttpLink httpLink=new HttpLink("http://192.168.100.5:4000/");
  //final WebSocketLink webSocketLink=WebSocketLink("wss://192.168.100.5:4000/");
  //final HttpLink httpLink=new HttpLink("https://inmobiliaria-app-v1.herokuapp.com/");
  //final WebSocketLink webSocketLink=WebSocketLink("ws://inmobiliaria-app-v1.herokuapp.com/");
  @override
  Widget build(BuildContext context) {
    /*final Link link=httpLink.concat(webSocketLink);
    final ValueNotifier<GraphQLClient> client=ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: link,
        cache:  GraphQLCache(store: HiveStore()),

      // The default store is the InMemoryStore, which does NOT persist to disk

      )
    );
   */ 
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>EstadoWidgets()),
        ChangeNotifierProvider(create: (_)=>UsuariosInfo()),
        ChangeNotifierProvider(create: (_)=>MapaFiltroPrincipalesInfo()),
        ChangeNotifierProvider(create: (_)=>MapaFiltrosInfo()),
        ChangeNotifierProvider(create: (_)=>MapaFiltroGeneralesInfo()),
        ChangeNotifierProvider(create: (_)=>MapaFiltroInternasInfo()),
        ChangeNotifierProvider(create: (_)=>MapaFiltroOtrosInfo(),),
        ChangeNotifierProvider(create: (_)=>MapaFiltroComunidadInfo()),
        ChangeNotifierProvider(create: (_)=>MapaFiltroPorUsuario()),
        ChangeNotifierProvider(create: (_)=>MapaFiltroSuperUsuarioInfo()),
        ChangeNotifierProvider(create: (_)=>ListadoInmueblesFiltrado()),
        ChangeNotifierProvider(create: (_)=>InmuebleInfo()),
        ChangeNotifierProvider(create: (_)=>DatosGeneralesInfo())
      ],
      child: MaterialApp(
          /*
          home: PageRegistroInmueble(Inmueble.vacio(),InmuebleInternas.vacio(),InmuebleComunidad.vacio(),InmueblesOtros.vacio(),
          AgenciaInmobiliaria(id: "",nombreAgencia: "",nombrePropietario: "",telefono: "",web: "")),*/
          home: PageHome(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.white,
            accentColor: Colors.blueAccent
          )
      )
    );
  }
}


