import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/pages/home/page_home.dart';
import 'package:inmobiliariaapp/ui/pages/registration_property/property_data/screen_registration_property.dart';
import 'package:inmobiliariaapp/ui/pages/registration_property/choise_plan/screen_registration_property_choise_plan.dart';
import 'package:inmobiliariaapp/ui/pages/registration_property/property_data/screen_update_property_choose_plan.dart';
import 'package:inmobiliariaapp/ui/pages/secondary/screen_property_request.dart';
import 'package:inmobiliariaapp/ui/provider/generals/bank_account_provider.dart';
import 'package:inmobiliariaapp/ui/provider/generals/general_data_provider.dart';
import 'package:inmobiliariaapp/ui/provider/generals/publicities_provider.dart';
import 'package:inmobiliariaapp/ui/provider/generals/registration_places_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/widget_status_provider.dart';
import 'package:inmobiliariaapp/ui/provider/generals/publication_plan_payment_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_widget_provider.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_comunity_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_general_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_internal_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_others_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_user_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_main_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_super_user_provider.dart';
import 'package:inmobiliariaapp/ui/provider/registration_property/registration_property_plan_provider.dart';
import 'package:inmobiliariaapp/ui/provider/registration_property/registration_property_provider.dart';
import 'package:inmobiliariaapp/ui/provider/registration_property/registration_property_widget_provider.dart';
import 'package:inmobiliariaapp/ui/provider/secondary/property_adminitrator_requests_provider.dart';
import 'package:inmobiliariaapp/ui/provider/secondary/property_notification_user_requests_provider.dart';
import 'package:inmobiliariaapp/ui/provider/secondary/property_reported_complaint_provider.dart';
import 'package:inmobiliariaapp/ui/provider/user/account_user_registration_provider.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_properties_searcheds.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:device_preview/device_preview.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await initHiveForFlutter();
  await Firebase.initializeApp();
  runApp(
    MyApp()
  );
}
/*void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await initHiveForFlutter();
  await Firebase.initializeApp();
    runApp(
      DevicePreview(
        enabled: true,

        builder: (context) =>  MyApp()
      )
    );
  }*/
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
        ChangeNotifierProvider(create: (_)=>WidgetStatusProvider()),
        ChangeNotifierProvider(create: (_)=>UserProvider()),
        ChangeNotifierProvider(create: (_)=>UserPropertiesSearchedsProvider()),
        ChangeNotifierProvider(create: (_)=>AccountUserRegistrationProvider()),
        ChangeNotifierProvider(create: (_)=>FilterMainProvider()),
        ChangeNotifierProvider(create: (_)=>FilterGeneralProvider()),
        ChangeNotifierProvider(create: (_)=>FilterInternalProvider()),
        ChangeNotifierProvider(create: (_)=>FilterComunityProvider(),),
        ChangeNotifierProvider(create: (_)=>FilterOthersProvider()),
        ChangeNotifierProvider(create: (_)=>FilterUserProvider()),
        ChangeNotifierProvider(create: (_)=>FilterSuperUserProvider()),
        ChangeNotifierProvider(create: (_)=>ListadoInmueblesFiltrado()),
        ChangeNotifierProvider(create: (_)=>PropertiesProvider()),
        ChangeNotifierProvider(create: (_)=>PropertiesWidgetProvider()),
        ChangeNotifierProvider(create: (_)=>GeneralDataProvider()),
        ChangeNotifierProvider(create: (_)=>BankAccountProvider()),
        ChangeNotifierProvider(create: (_)=>PublicitiesProvider()),
        ChangeNotifierProvider(create: (_)=>RegistrationPlacesProvider()),
        //Registration Property
        ChangeNotifierProvider(create: (_)=>RegistrationPropertyWidgetProvider()),
        ChangeNotifierProvider(create: (_)=>RegistrationPropertyProvider()),
        ChangeNotifierProvider(create: (_)=>RegistrationPropertyPlanProvider()),
        //Secondary
        ChangeNotifierProvider(create: (_)=>PropertyAdministratorRequestsProvider()),
        ChangeNotifierProvider(create: (_)=>PropertyReportedComplaintProvider()),
        ChangeNotifierProvider(create: (_)=>PropertyNotificationUserRequestsProvider()),
        //Generals
        ChangeNotifierProvider(create: (_)=>PublicationPlanPaymentProvider()),
      ],
      child: MaterialApp(
          
          /*
          home: PageRegistroInmueble(Inmueble.vacio(),InmuebleInternas.vacio(),InmuebleComunidad.vacio(),InmueblesOtros.vacio(),
          AgenciaInmobiliaria(id: "",nombreAgencia: "",nombrePropietario: "",telefono: "",web: "")),*/
          //home: PageHome(),
          /*locale:DevicePreview.locale(context),
          useInheritedMediaQuery: true,
          builder: DevicePreview.appBuilder,*/
          
          initialRoute: '/',
          routes: {
            '/': (context) => PageHome(),
            '/screen_registration_property': (context) => ScreenRegistrationProperty(),
            '/screen_registration_property_choise_plan':(context) => ScreenRegistrationPropertyChoisePlan(),
            '/screen_update_property_choose_plan':(context) => ScreenUpdatePropertyChoosePlan(),
            '/screen_property_request':(context) => ScreenPropertyRequest(),
          },
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.white,
            
            appBarTheme: AppBarTheme(
              color: Colors.white,
              titleTextStyle: TextStyle(
                color: Colors.black,
                
              ),
              iconTheme: IconThemeData(
                color: Colors.black
              ),
              actionsIconTheme: IconThemeData(
                color: Colors.black
              )
            )
            //accentColor: Colors.blueAccent
          )
      )
    );
  }

  
}


