import 'package:inmobiliariaapp/data/configuration/graphql_configuration.dart';
import 'package:inmobiliariaapp/data/repositories/user/super_user_repository_gql.dart';
import 'package:inmobiliariaapp/domain/entities/administrator_request.dart';
import 'package:inmobiliariaapp/domain/entities/agent_registration.dart';
import 'package:inmobiliariaapp/domain/entities/membership_payment.dart';
import 'package:inmobiliariaapp/domain/entities/user.dart';
import 'package:inmobiliariaapp/domain/entities/property_reported.dart';
import 'package:inmobiliariaapp/domain/entities/user_property_favorite.dart';
import 'package:inmobiliariaapp/domain/repositories/abstract_user.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;

class SuperUserRepository extends AbstractSuperUserRepository{
  @override
  Future<Map<String, dynamic>> assignAdministratorZone(String administradorId, String zoneId) async{
    bool completed=true;
    Map<String,dynamic> map={};
    String id="";
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationAssignAdministratorZone(),
      
      ),
      variables: ({"id_administrador":administradorId,"id_zona":zoneId}),
      onCompleted: (dynamic data){
        if(data!=null){
          if(data["asignarAdministradorZona"]!=null){
            id=data["asignarAdministradorZona"];
          }
        }
      },
      onError: (error){
        completed=false;
      }
    ));
    map["completed"]=completed;
    map["id"]=id;
    return map;
  }

  @override
  Future<bool> enableAdministrator(String usuarioId) async{
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationEnableAdministrator(),
      
      ),
      variables: ({"id_usuario":usuarioId}),
      onCompleted: (dynamic data){
        if(data!=null){
          if(data["habilitarAdministrador"]!=null){
            
          }
        }
      },
      onError: (error){
        completed=false;
      }
    ));
    return completed;
  }

  @override
  Future<bool> disableAdministrator(String usuarioId) async{
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationDisableAdministrator(),
      
      ),
      variables: ({"id_usuario":usuarioId}),
      onCompleted: (dynamic data){
        if(data!=null){
          if(data["inhabilitarAdministrador"]!=null){
            
          }
        }
      },
      onError: (error){
        completed=false;
      }
    ));
    return completed;
  }

  @override
  Future<Map<String, dynamic>> getAdministrators() async{
   Map<String,dynamic> map={};
    List<User> administrators=[];
    List administratorsD=[];
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(queryGetAdministrators()),
        fetchPolicy: graphql.FetchPolicy.noCache,
      ),
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
        if(result.data!["obtenerAdministradores"]!=null){
          administratorsD=result.data!["obtenerAdministradores"];
          administratorsD.forEach((element) {
            administrators.add(User.fromMap(element));
          });
      }
    }

    map["completed"]=completed;
    map["administrators"]=administrators;
    return map;
  }

  @override
  Future<Map<String, dynamic>> getNotificationsExistsSuperUser(User user) async{
    Map<String,dynamic> map={};
    bool completed=true;
    bool existsNotifications=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(queryGetNotificationsExistsSuperUser()),
        variables: ({
          "id":user.id
        }),
        fetchPolicy: graphql.FetchPolicy.noCache,
      ),
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
        if(result.data!["obtenerNotificacionesExisteSuperUsuario"]!=null){
          existsNotifications=result.data!["obtenerNotificacionesExisteSuperUsuario"];
      }
    }

    map["completed"]=completed;
    map["exists_notifications"]=existsNotifications;
    return map;
  }

  @override
  Future<Map<String, dynamic>> getNotificationsSuperUser(User user, String sessionType) async{
    Map<String,dynamic> map={};
    List<PropertyReported> propertiesReporteds=[];
    List<PropertyComplaint> propertiesComplaints=[];
    List<MembershipPayment> membershipsPayments=[];
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(queryGetNotificationsSuperUser()),
        variables: ({
          "id":user.id
        }),
        fetchPolicy: graphql.FetchPolicy.noCache,
      ),
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
        if(result.data!["obtenerNotificacionesSuperUsuario"]!=null){
          result.data!["obtenerNotificacionesSuperUsuario"]["reportar_inmueble"]
          .forEach((element) {
            propertiesReporteds.add(PropertyReported.fromMap(element, sessionType));
          });
          result.data!["obtenerNotificacionesSuperUsuario"]["inmuebles_quejas"]
          .forEach((element) {
            propertiesComplaints.add(PropertyComplaint.fromMap(element));
          });
          result.data!["obtenerNotificacionesSuperUsuario"]["membresias_pagos"]
          .forEach((element) {
            membershipsPayments.add(MembershipPayment.fromMap(element));
          });
      }
    }

    map["completed"]=completed;
    map["properties_reporteds"]=propertiesReporteds;
    map["properties_complaints"]=propertiesComplaints;
    map["memberships_payments"]=membershipsPayments;
    return map;
  }

  @override
  Future<Map<String, dynamic>> getUsersPropertiesSearchedsCity(String city) async{
     Map<String,dynamic> map={};
    List propertiesSearcheds=[];
    List<int> landSurface=[0,0,150,200,250,300];
    List<int> constructionSurface=[0,0,100,200,300,400];
    List<int> constructionAntiquity=[0,0,10,20,30];
    List<int> frontSize=[0,0,5,10,15,20];
    double datasQuantity=0;
    Map<String,dynamic> mapLandSurface={"Cualquiera":0, "0-149":0, "150-199":0, "200-249":0, "250-299":0, "300 a más":0};
    Map<String,dynamic> mapConstructionSurface={"Cualquiera":0, "0-99":0, "100-199":0, "200-299":0, "300-399":0, "400 a más":0};
    Map<String,dynamic> mapFrontSize={"Cualquiera":0, "0-4":0, "5-9":0, "10-14":0, "15-19":0, "20 a más":0};
    Map<String,dynamic> mapConstructionAntiquity={"Cualquiera":0, "0-9":0, "10-19":0, "20-29":0, "30 a más":0};
    Map<String,dynamic> mapEnablePets={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapNoMortgage={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapNewConstruction={"Requerido":0,"No requerido":0};
    Map<String,dynamic> mapPremiumMaterials={"Requerido":0,"No requerido":0};
    Map<String,dynamic> mapPreSaleProject={ "Requerido":0,};
    Map<String,dynamic> mapSharedProperty={"Requerido":0,"No requerido":0};
    Map<String,dynamic> mapOwnersNumber={"1":0, "2":0, "3":0, "4":0, "5+":0};
    Map<String,dynamic> mapBasicServices={"Requerido":0,"No requerido":0};
    Map<String,dynamic> mapHouseholdGas={"Requerido":0,"No requerido":0};
    Map<String,dynamic> mapWifi={"Requerido":0,"No requerido":0};
    Map<String,dynamic> mapIndependentMeter={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapHotWaterTank={ "Requerido":0,"No requerido":0};
    Map<String,dynamic> mapPavedStreet={"Requerido":0,"No requerido":0};
    Map<String,dynamic> mapTransport={"Requerido":0,"No requerido":0};
    Map<String,dynamic> mapDisabilityPrepared={"Requerido":0,"No requerido":0};
    Map<String,dynamic> mapOrderPapers={"Requerido":0,"No requerido":0};
    Map<String,dynamic> mapEnabledCredit={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapFloors={"Cualquiera":0, "1":0, "2":0, "3":0, "4":0, "5+":0};
    Map<String,dynamic> mapRooms={"Cualquiera":0, "1":0, "2":0, "3":0, "4":0, "5+":0};
    Map<String,dynamic> mapBedrooms={"Cualquiera":0, "1":0, "2":0, "3":0, "4":0, "5+":0};
    Map<String,dynamic> mapBathrooms={"Cualquiera":0, "1":0, "2":0, "3":0, "4":0, "5+":0};
    Map<String,dynamic> mapGarages={"Cualquiera":0, "1":0, "2":0, "3":0, "4":0, "5+":0};
    Map<String,dynamic> mapFurnished={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapLaundry={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapLaundryRoom={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapGrill={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapRooftop={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapPrivateCondominium={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapCourt={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapPool={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapSauna={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapJacuzzi={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapStudio={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapGarden={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapElectricGate={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapAirConditioning={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapHeating={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapElevator={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapWarehouse={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapBasement={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapBalcony={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapStore={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapLandWalled={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapChurch={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapPlayground={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapSchool={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapUniversity={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapSmallSquare={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapPoliceModule={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapPublicSaunaPool={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapPublicGym={ "Requerido":0,"No requerido":0};
    Map<String,dynamic> mapSportCenter={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapPostHealth={"Requerido":0, "No requerido":0};
    Map<String,dynamic> mapShoopingZone={"Requerido":0, "No requerido":0};
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document: graphql.gql(queryGetUsersPropertiesSearchedsCity()),
        fetchPolicy: graphql.FetchPolicy.noCache,
        variables: {
          "ciudad":city
        }
      )
    );
    if(result.hasException){
      completed=false;
    }else if(!result.hasException){
      propertiesSearcheds=[];
        if(result.data!["obtenerUsuariosInmuebleBuscadosCiudad"]!=null){
          propertiesSearcheds=result.data!["obtenerUsuariosInmuebleBuscadosCiudad"];
          //print(inmuebles);
          propertiesSearcheds.forEach((map) {
            datasQuantity=datasQuantity+1;
            UserPropertySearched searched=UserPropertySearched.fromMap(map);
            String selected=getSelectedValue(landSurface,searched.landSurfaceMin,searched.landSurfaceMax);
            mapLandSurface[selected]=mapLandSurface[selected]+1;
            selected=getSelectedValue(constructionSurface, searched.constructionSurfaceMin, searched.constructionSurfaceMax);
            mapConstructionSurface[selected]=mapConstructionSurface[selected]+1;
            selected=getSelectedValue(frontSize, searched.frontSizeMin, searched.frontSizeMax);
            mapFrontSize[selected]=mapFrontSize[selected]+1;
            selected=getSelectedValue(constructionAntiquity, searched.constructionAntiquityMin, searched.constructionAntiquityMax);
            mapConstructionAntiquity[selected]=mapConstructionAntiquity[selected]+1;
            if(searched.enablePets) mapEnablePets["Requerido"]++;
            if(searched.noMortgage) mapNoMortgage["Requerido"]++;
            if(searched.newConstruction) mapNewConstruction["Requerido"]++;
            if(searched.premiumMaterials) mapPremiumMaterials["Requerido"]++;
            if(searched.preSaleProject) mapPreSaleProject["Requerido"]++;
            if(searched.sharedProperty) mapSharedProperty["Requerido"]++;
            searched.ownersNumber>=5?mapOwnersNumber["5+"]++:mapOwnersNumber[searched.ownersNumber.toString()]++;
            if(searched.basicServices) mapBasicServices["Requerido"]++;
            if(searched.householdGas) mapHouseholdGas["Requerido"]++;
            if(searched.wifi) mapWifi["Requerido"]++;
            if(searched.independentMeter) mapIndependentMeter["Requerido"]++;
            if(searched.hotWaterTank) mapHotWaterTank["Requerido"]++;
            if(searched.pavedStreet) mapPavedStreet["Requerido"]++;
            if(searched.transport) mapTransport["Requerido"]++;
            if(searched.disabilityPrepared) mapDisabilityPrepared["Requerido"]++;
            if(searched.orderPapers) mapOrderPapers["Requerido"]++;
            if(searched.enabledCredit) mapEnabledCredit["habilitado_credito"]++;
            if(searched.floorsNumber>=5){
              mapFloors["5+"]++;
            }else if(searched.floorsNumber==0){
                mapFloors["Cualquiera"]++;
            }else{
              mapFloors[searched.floorsNumber.toString()]++;
            }
            if(searched.roomsNumber>=5){
              mapRooms["5+"]++;
            }else if(searched.roomsNumber==0){
                mapRooms["Cualquiera"]++;
            }else{
              mapRooms[searched.roomsNumber.toString()]++;
            }
            if(searched.bedroomsNumber>=5){
              mapBedrooms["5+"]++;
            }else if(searched.bedroomsNumber==0){
                mapBedrooms["Cualquiera"]++;
            }else{
              mapBedrooms[searched.bedroomsNumber.toString()]++;
            }
            if(searched.bathroomsNumber>=5){
              mapBathrooms["5+"]++;
            }else if(searched.bathroomsNumber==0){
                mapBathrooms["Cualquiera"]++;
            }else{
              mapBathrooms[searched.bathroomsNumber.toString()]++;
            }
            if(searched.garagesNumber>=5){
              mapGarages["5+"]++;
            }else if(searched.garagesNumber==0){
                mapGarages["Cualquiera"]++;
            }else{
              mapGarages[searched.garagesNumber.toString()]++;
            }
            if(searched.furnished) mapFurnished["Requerido"]++;
            if(searched.laundry) mapLaundry["Requerido"]++;
            if(searched.laundryRoom) mapLaundryRoom["Requerido"]++;
            if(searched.grill) mapGrill["Requerido"]++;
            if(searched.rooftop) mapRooftop["Requerido"]++;
            if(searched.privateCondominium) mapPrivateCondominium["Requerido"]++;
            if(searched.court) mapCourt["Requerido"]++;
            if(searched.pool) mapPool["Requerido"]++;
            if(searched.sauna) mapSauna["Requerido"]++;
            if(searched.jacuzzi) mapJacuzzi["Requerido"]++;
            if(searched.studio) mapStudio["Requerido"]++;
            if(searched.garden) mapGarden["Requerido"]++;
            if(searched.electricGate) mapElectricGate["Requerido"]++;
            if(searched.airConditioning) mapAirConditioning["Requerido"]++;
            if(searched.heating) mapHeating["Requerido"]++;
            if(searched.elevator) mapElevator["Requerido"]++;
            if(searched.warehouse) mapWarehouse["Requerido"]++;
            if(searched.basement) mapBasement["Requerido"]++;
            if(searched.balcony) mapBalcony["Requerido"]++;
            if(searched.store) mapStore["Requerido"]++;
            if(searched.landWalled) mapLandWalled["Requerido"]++;
            if(searched.church) mapChurch["Requerido"]++;
            if(searched.playground) mapPlayground["Requerido"]++;
            if(searched.school) mapSchool["Requerido"]++;
            if(searched.university) mapUniversity["Requerido"]++;
            if(searched.smallSquare) mapSmallSquare["Requerido"]++;
            if(searched.policeModule)mapPoliceModule["Requerido"]++;
            if(searched.publicSaunaPool) mapPublicSaunaPool["Requerido"]++;
            if(searched.publicGym) mapPublicGym["Requerido"]++;
            if(searched.sportCenter) mapSportCenter["Requerido"]++;
            if(searched.postHeath) mapPostHealth["Requerido"]++;
            if(searched.shoopingZone) mapShoopingZone["Requerido"]++;
          });
        }
    }
    mapEnablePets["No requerido"]=datasQuantity.toInt()-mapEnablePets["Requerido"];
    mapNoMortgage["No requerido"]=datasQuantity.toInt()-mapNoMortgage["Requerido"];
    mapNewConstruction["No requerido"]=datasQuantity.toInt()-mapNewConstruction["Requerido"];
    mapPremiumMaterials["No requerido"]=datasQuantity.toInt()-mapPremiumMaterials["Requerido"];
    mapPreSaleProject["No requerido"]=datasQuantity.toInt()-mapPreSaleProject["Requerido"];
    mapSharedProperty["No requerido"]=datasQuantity.toInt()-mapSharedProperty["Requerido"];
    mapBasicServices["No requerido"]=datasQuantity.toInt()-mapBasicServices["Requerido"];
    mapHouseholdGas["No requerido"]=datasQuantity.toInt()-mapHouseholdGas["Requerido"];
    mapWifi["No requerido"]=datasQuantity.toInt()-mapWifi["Requerido"];
    mapIndependentMeter["No requerido"]=datasQuantity.toInt()-mapIndependentMeter["Requerido"];
    mapHotWaterTank["No requerido"]=datasQuantity.toInt()-mapHotWaterTank["Requerido"];
    mapPavedStreet["No requerido"]=datasQuantity.toInt()-mapPavedStreet["Requerido"];
    mapTransport["No requerido"]=datasQuantity.toInt()-mapTransport["Requerido"];
    mapDisabilityPrepared["No requerido"]=datasQuantity.toInt()-mapDisabilityPrepared["Requerido"];
    mapOrderPapers["No requerido"]=datasQuantity.toInt()-mapOrderPapers["Requerido"];
    mapEnabledCredit["No requerido"]=datasQuantity.toInt()-mapEnabledCredit["Requerido"];
    mapFurnished["No requerido"]=datasQuantity.toInt()-mapFurnished["Requerido"];
    mapLaundry["No requerido"]=datasQuantity.toInt()-mapLaundry["Requerido"];
    mapLaundryRoom["No requerido"]=datasQuantity.toInt()-mapLaundryRoom["Requerido"];
    mapGrill["No requerido"]=datasQuantity.toInt()-mapGrill["Requerido"];
    mapRooftop["No requerido"]=datasQuantity.toInt()-mapRooftop["Requerido"];
    mapPrivateCondominium["No requerido"]=datasQuantity.toInt()-mapPrivateCondominium["Requerido"];
    mapCourt["No requerido"]=datasQuantity.toInt()-mapCourt["Requerido"];
    mapPool["No requerido"]=datasQuantity.toInt()-mapPool["Requerido"];
    mapSauna["No requerido"]=datasQuantity.toInt()-mapSauna["Requerido"];
    mapJacuzzi["No requerido"]=datasQuantity.toInt()-mapJacuzzi["Requerido"];
    mapStudio["No requerido"]=datasQuantity.toInt()-mapStudio["Requerido"];
    mapGarden["No requerido"]=datasQuantity.toInt()-mapGarden["Requerido"];
    mapElectricGate["No requerido"]=datasQuantity.toInt()-mapElectricGate["Requerido"];
    mapAirConditioning["No requerido"]=datasQuantity.toInt()-mapAirConditioning["Requerido"];
    mapHeating["No requerido"]=datasQuantity.toInt()-mapHeating["Requerido"];
    mapElevator["No requerido"]=datasQuantity.toInt()-mapElevator["Requerido"];
    mapWarehouse["No requerido"]=datasQuantity.toInt()-mapWarehouse["Requerido"];
    mapBasement["No requerido"]=datasQuantity.toInt()-mapBasement["Requerido"];
    mapBalcony["No requerido"]=datasQuantity.toInt()-mapBalcony["Requerido"];
    mapStore["No requerido"]=datasQuantity.toInt()-mapStore["Requerido"];
    mapLandWalled["No requerido"]=datasQuantity.toInt()-mapLandWalled["Requerido"];
    mapChurch["No requerido"]=datasQuantity.toInt()-mapChurch["Requerido"];
    mapPlayground["No requerido"]=datasQuantity.toInt()-mapPlayground["Requerido"];
    mapSchool["No requerido"]=datasQuantity.toInt()-mapSchool["Requerido"];
    mapUniversity["No requerido"]=datasQuantity.toInt()-mapUniversity["Requerido"];
    mapSmallSquare["No requerido"]=datasQuantity.toInt()-mapSmallSquare["Requerido"];
    mapPoliceModule["No requerido"]=datasQuantity.toInt()-mapPoliceModule["Requerido"];
    mapPublicSaunaPool["No requerido"]=datasQuantity.toInt()-mapPublicSaunaPool["Requerido"];
    mapPublicGym["No requerido"]=datasQuantity.toInt()-mapPublicGym["Requerido"];
    mapSportCenter["No requerido"]=datasQuantity.toInt()-mapSportCenter["Requerido"];
    mapPostHealth["No requerido"]=datasQuantity.toInt()-mapPostHealth["Requerido"];
    mapShoopingZone["No requerido"]=datasQuantity.toInt()-mapShoopingZone["Requerido"];
    map["completed"]=completed;
    map["map_land_surface"]=mapLandSurface;
    map["map_construction_surface"]=mapConstructionSurface;
    map["map_front_size"]=mapFrontSize;
    map["map_construction_antiquity"]=mapConstructionAntiquity;
    map["map_enable_pets"]=mapEnablePets;
    map["map_no_mortgage"]=mapNoMortgage;
    map["map_new_construction"]=mapNewConstruction;
    map["map_premium_materials"]=mapPremiumMaterials;
    map["map_pre_sale_project"]=mapPreSaleProject;
    map["map_shared_property"]=mapSharedProperty;
    map["map_owners_number"]=mapOwnersNumber;
    map["map_basic_services"]=mapBasicServices;
    map["map_household_gas"]=mapHouseholdGas;
    map["map_wifi"]=mapWifi;
    map["map_medidor_independiente"]=mapIndependentMeter;
    map["map_hot_water_tank"]=mapHotWaterTank;
    map["map_paved_street"]=mapPavedStreet;
    map["map_transport"]=mapTransport;
    map["map_disability_prepared"]=mapDisabilityPrepared;
    map["map_order_papers"]=mapOrderPapers;
    map["map_enables_credit"]=mapEnabledCredit;
    map["map_floors"]=mapFloors;
    map["map_rooms"]=mapRooms;
    map["map_bedrooms"]=mapBedrooms;
    map["map_bathrooms"]=mapBathrooms;
    map["map_garages"]=mapGarages;
    map["map_furnished"]=mapFurnished;
    map["map_laundry"]=mapLaundry;
    map["map_laundry_room"]=mapLaundryRoom;
    map["map_grill"]=mapGrill;
    map["map_rooftop"]=mapRooftop;
    map["map_private_condominium"]=mapPrivateCondominium;
    map["map_court"]=mapCourt;
    map["map_pool"]=mapPool;
    map["map_sauna"]=mapSauna;
    map["map_jacuzzi"]=mapJacuzzi;
    map["map_studio"]=mapStudio;
    map["map_garden"]=mapGarden;
    map["map_electric_gate"]=mapElectricGate;
    map["map_air_conditioning"]=mapAirConditioning;
    map["map_heating"]=mapHeating;
    map["map_elevator"]=mapElevator;
    map["map_warehouse"]=mapWarehouse;
    map["map_basement"]=mapBasement;
    map["map_balcony"]=mapBalcony;
    map["map_store"]=mapStore;
    map["map_land_walled"]=mapLandWalled;
    map["map_church"]=mapChurch;
    map["map_playground"]=mapPlayground;
    map["map_school"]=mapSchool;
    map["map_university"]=mapUniversity;
    map["map_small_square"]=mapSmallSquare;
    map["map_police_module"]=mapPoliceModule;
    map["map_public_sauna_pool"]=mapPublicSaunaPool;
    map["map_public_gym"]=mapPublicGym;
    map["map_sport_center"]=mapSportCenter;
    map["map_post_health"]=mapPostHealth;
    map["map_shooping_zone"]=mapShoopingZone;

    map["datas_quantity"]=datasQuantity;
    return map;
  }

  @override
  Future<bool> removeAdministratorZone(String id) async{
    bool completed=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationRemoveAdministratorZone(),
      
      ),
      variables: ({"id":id}),
      onCompleted: (dynamic data){
        if(data!=null){
          if(data["quitarAdministradorZona"]!=null){
            id=data["quitarAdministradorZona"];
          }
        }
      },
      onError: (error){
        print(error);
        completed=false;
      }
    ));
    return completed;
  }

  @override
  Future<bool> answerPropertyComplaint(PropertyComplaint propertyComplaint, String superUserId) async{
    bool respuesta=false;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    Map<String,dynamic> mapVariables=propertyComplaint.toMap();
    mapVariables.addAll({"id_super_usuario":superUserId});
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationAnswerPropertyComplaint(),
      ),
      variables: (mapVariables),
      onCompleted: (dynamic data){
        if(data!=null){
          respuesta=true;
          if(data["responderInmuebleQuejaSuperUsuario"]!=null){
            propertyComplaint.responseDate=data["responderInmuebleQuejaSuperUsuario"]["fecha_respuesta"];
          }
        }
      },
      onError: (error){
        print(error);
        respuesta=false;
      }
    ));
    return respuesta;
  }

  @override
  Future<bool> answerMembershipPaymentSuperUser(MembershipPayment membershipPayment, String superUserId) async{
    bool response=false;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    Map<String,dynamic> mapVariables=membershipPayment.toMap();
    mapVariables.addAll({"id_super_usuario":superUserId});
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(mutationAnswerMembershipPaymentSuperUser(),
      ),
      variables: (mapVariables),
      onCompleted: (dynamic data){
        if(data!=null){
          response=true;
          if(data["responderMembresiaPagoSuperUsuario"]!=null){
            membershipPayment.responseDateSuperUser=data["responderMembresiaPagoSuperUsuario"]["fecha_respuesta_super_usuario"];
          }
        }
      },
      onError: (error){
        print(error);
        response=false;
      }
    ));
    return response;
  }

  @override
  Future<bool> answerPropertyReport(PropertyReported propertyReported) async{
    bool response=false;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      
      graphql.MutationOptions(
        document: graphql.gql(mutationAnswerPropertyReport(),
      
      ),
      variables: (propertyReported.toMap()),
      onCompleted: (dynamic data){
        if(data!=null){
          response=true;
          if(data["responderReporteInmueble"]!=null){
            propertyReported.responseDate=data["responderReporteInmueble"]["fecha_respuesta"];
          }
        }
      },
      onError: (error){
        print(error);
        response=false;
      }
    ));
    return response;
  }

  @override
  Future<Map<String, dynamic>> getAdministratorsRequestsSuperUser(String id) async{
    Map<String,dynamic> map={};
    List<AdministratorRequest> administratorsRequests=[];
    bool completed=true;
    String errorMessage="";
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(queryGetAdministratorsRequestsSuperUser()),
        fetchPolicy: graphql.FetchPolicy.noCache,
        variables: ({
          "id":id
        })
      ),
    );
    if(result.hasException){
      result.exception!.graphqlErrors.forEach((element) { 
        errorMessage=element.message;
      });
      completed=false;
    }else if(!result.hasException){
        if(result.data!["obtenerSolicitudesAdministradoresSuperUsuario"]!=null){
          result.data!["obtenerSolicitudesAdministradoresSuperUsuario"]
          .forEach((element) {
            administratorsRequests.add(AdministratorRequest.fromMap(element));
          });
      }
    }
    administratorsRequests.sort((b,a)=>a.requestDate.compareTo(b.requestDate));
    map["error_message"]=errorMessage;
    map["completed"]=completed;
    map["administrators_requests"]=administratorsRequests;
    return map;
  }

  @override
  Future<Map<String,dynamic>> answerAdministratorRequestSuperUser(User user, AdministratorRequest administratorProperty, AdministratorRequest administratorRequest)async{
    Map<String,dynamic> map={};
    bool completed=false;
    String message="";
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql((mutationAnswerAdministratorRequestSuperUser()),
      ),
      variables: (
      {
        "id":administratorProperty.id,
        "id_super_usuario":user.id,
        "tipo_solicitud":administratorRequest.requestType,
        "respuesta":administratorRequest.responseSuperUser,
        "observaciones":administratorRequest.observationsSuperUser,
        "solicitud_terminada":true,
        "id_solicitud":administratorRequest.id
      } 
      ),
      onCompleted: (dynamic data){
        if(data!=null){
          message=data["responderSolicitudAdministradorSuperUsuario"].toString();
          completed=true;
        }
      },
      onError: (error){
        var ms=error!.graphqlErrors;
        ms.forEach((element) {
          message=element.message;
        });
        completed=false;
      }
    ));
    map["completed"]=completed;
    map["message"]=message;
    return map;
  }

  @override
  Future<Map<String, dynamic>> answerAgentRegistrationRequestSuperUser(AgentRegistration agentRegistration) {
    throw UnimplementedError();
  }
}



String getSelectedValue(List<int> numbers,int valueMin,int valueMax){
  String selectedValue="";
  if(valueMax>0&&valueMin>0){
    for(int i=1;i<numbers.length;i++){
      if(numbers[i]==valueMin){
        if(i<numbers.length-1){
          selectedValue=numbers[i].toString()+"-"+(numbers[i+1]-1).toString();
        }else{
          selectedValue=numbers[i].toString()+" a más";
        }
      }
    }
  }else{
    selectedValue="Cualquiera";
  }
  return selectedValue;
}