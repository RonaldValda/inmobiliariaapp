import 'package:flutter/cupertino.dart';
import 'package:inmobiliariaapp/domain/entities/administrator_request.dart';
import 'package:inmobiliariaapp/domain/entities/notificacionn.dart';
import 'package:inmobiliariaapp/domain/usecases/property/usecase_property_sale.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_provider.dart';
import 'package:provider/provider.dart';

class PropertyNotificationUserRequestsProvider extends ChangeNotifier{
  List<Notificationn> _notificationsProperty=[];
  AdministratorRequest _administratorProperty=AdministratorRequest.empty();
  int _notificationsNumber=0;
  void loadNotificationUserRequestProperty({required BuildContext context})async{
    final property=context.read<PropertiesProvider>().propertyTotalLast.property;
    UseCasePropertySale useCasePropertySale=UseCasePropertySale();
    _notificationsNumber=0;
    _notificationsProperty=[];
    _administratorProperty=AdministratorRequest.empty();
    await useCasePropertySale.getNotificationsActionsSalesperson(property.id)
    .then((response) {
      if(response["completed"]){
        _notificationsNumber=response["notifications_number"];
        _administratorProperty=response["administrator_property"];
        _notificationsProperty=response["notifications"];
        
      }
    });
    notifyListeners();
  } 



  List<Notificationn> get notificationsProperty => _notificationsProperty;

  void decreaseNotificationsNumber(){
    _notificationsNumber--;
  }

  int get notificationsNumber => _notificationsNumber;

  AdministratorRequest get administratorProperty => _administratorProperty;

  AdministratorRequest administratorRequestLast({required String requestType}) { 
    List<AdministratorRequest> administratorRequests=[];
    _notificationsProperty.forEach((element) { 
      if(element.data is AdministratorRequest){
        administratorRequests.add(element.data);
      }
    });
    administratorRequests.sort((a,b)=> a.requestDate.compareTo(b.requestDate));
    int index=administratorRequests.lastIndexWhere((element) => element.requestType==requestType);
    return administratorRequests[index];
  }

  //*CRUD
  void readNotificationAdministratorRequestUser({required AdministratorRequest request})async{
    UseCasePropertySale useCasePropertySale=UseCasePropertySale();
    await useCasePropertySale.readAdministratorRequestUser(request.id)
    .then((response) {
      if(response["completed"]){
        request.deliveredResponse=true;
        _notificationsNumber--;
        notifyListeners();
      }
    });
  }

}