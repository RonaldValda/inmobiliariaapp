
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/administrator_request.dart';
import 'package:inmobiliariaapp/domain/entities/property_reported.dart';
import 'package:inmobiliariaapp/domain/usecases/property/usecase_property_sale.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_provider.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../domain/usecases/property/usecase_property_reported.dart';
class PropertyReportedComplaintProvider extends ChangeNotifier{
  List<AdministratorRequest> _administratorRequestsReports=[AdministratorRequest.empty(),AdministratorRequest.empty(),AdministratorRequest.empty()];
  List<AdministratorRequest> _administratorRequestsComplaint=[AdministratorRequest.empty(),AdministratorRequest.empty(),AdministratorRequest.empty()]; 
  
  void loadReportsProperty({required BuildContext context})async{
    final propertyTotal=context.read<PropertiesProvider>().propertyTotalLast;
    final user=context.read<UserProvider>().user;
    UseCasePropertyReported userCasePropertyReported=UseCasePropertyReported();
    await userCasePropertyReported.getReportsProperty(user, propertyTotal, false, false)
    .then((respose){
      if(respose["completed"]){
        List<AdministratorRequest> administratorRequests=respose["requests"];
        for(int i=0;i<administratorRequests.length;i++){
          if(administratorRequests[i].requestType=="Reporté imágenes"){
            _administratorRequestsReports[0]=administratorRequests[i];
          }else if(administratorRequests[i].requestType=="Reporté datos"){
            _administratorRequestsReports[1]=administratorRequests[i];
          }else{
            _administratorRequestsReports[2]=administratorRequests[i];
          }
        }
        notifyListeners();
      }
    });
  }
  List<AdministratorRequest> get administratorRequestsReports => _administratorRequestsReports;

  Future<bool> reportProperty(PropertyReported propertyReported)async{
    bool responseOk=false;
    UseCasePropertyReported userCasePropertyReported=UseCasePropertyReported();
    await userCasePropertyReported.reportProperty(propertyReported)
    .then((completed) {
      responseOk=completed;
    });
    return responseOk;
  }

  Future<bool> registerComplaintProperty(PropertyComplaint propertyComplaint)async{
    bool responseOk=false;
    UseCasePropertySale useCasePropertySale=UseCasePropertySale();
    await useCasePropertySale.registerPropertyComplaint(propertyComplaint)
    .then((response) {
      if(response["completed"]){
        responseOk=true;
      }
    });
    return responseOk;
  }
}