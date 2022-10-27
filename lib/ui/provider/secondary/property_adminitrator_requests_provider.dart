import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/administrator_request.dart';
import 'package:inmobiliariaapp/domain/entities/property_reported.dart';
import 'package:inmobiliariaapp/domain/usecases/property/usecase_property_sale.dart';
import 'package:inmobiliariaapp/domain/usecases/user/usecase_administrator.dart';
import 'package:inmobiliariaapp/domain/usecases/user/usecase_super_user.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_provider.dart';
import 'package:provider/provider.dart';
import '../home/properties_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:inmobiliariaapp/ui/pages/utils/generate_property_info_all_pdf.dart';
import 'package:dio/dio.dart';

class PropertyAdministratorRequestsProvider extends ChangeNotifier{
  List<AdministratorRequest> _administratorRequests=[];
  AdministratorRequest _requestCopy=AdministratorRequest.empty();
  UseCaseAdministrator _useCaseAdministrator=UseCaseAdministrator();
  UseCaseSuperUser _useCaseSuperUser=UseCaseSuperUser();
  void loadAdministratorsRequests({required BuildContext context}) async{
    final administratorRequest=context.read<PropertiesProvider>().propertyTotalLast.administratorRequest;
    _administratorRequests=[];
    await _useCaseAdministrator.getAdministratorsRequests(administratorRequest.id)
    .then((response) {
      if(response["completed"]){
        _administratorRequests=response["administrators_requests"];
      }
    });
    notifyListeners();
  }

  void loadAdministratorsRequestsSuperUser({required BuildContext context}) async{
    final administratorRequest=context.read<PropertiesProvider>().propertyTotalLast.administratorRequest;
    _administratorRequests=[];
    await _useCaseSuperUser.getAdministratorsRequestsSuperUser(administratorRequest.id)
    .then((response) {
      if(response["completed"]){
        _administratorRequests=response["administrators_requests"];
      }
    });
    notifyListeners();
  }

  List<AdministratorRequest> get administratorRequests => _administratorRequests;

  void setRequestCopy(AdministratorRequest request){
    _requestCopy=AdministratorRequest.copyWith(request);
  }

  AdministratorRequest get requestCopy => _requestCopy;

  void answerAdministratorRequest({required BuildContext context})async{
    final user=context.read<UserProvider>().user;
    final propertiesProvider=context.read<PropertiesProvider>();
    final administratorProperty=propertiesProvider.propertyTotalLast.administratorRequest;
    await _useCaseAdministrator.answerAdministratorRequest(user, administratorProperty, _requestCopy)
    .then((response) {
      if(response["completed"]){
        if(response["message"]=="Correcto"){
          if(administratorProperty.requestDate==_requestCopy.requestDate){
            String idAux=propertiesProvider.propertyTotalLast.administratorRequest.id;
            propertiesProvider.propertyTotalLast.administratorRequest=AdministratorRequest.copyWith(_requestCopy);
            propertiesProvider.propertyTotalLast.administratorRequest.id=idAux;
            propertiesProvider.notify();
            int index=_administratorRequests.lastIndexWhere((element) => element.id==_requestCopy.id);
            _administratorRequests.replaceRange(index,index+1,[AdministratorRequest.copyWith(_requestCopy)]);
            if(_requestCopy.response=="Rechazado"&&_requestCopy.requestType=="Bajar precio"){
              propertiesProvider.propertyTotalLast.property.pricesHistory.removeLast();
              propertiesProvider.propertyTotalLast.property.price=propertiesProvider.propertyTotalLast.property.pricesHistory.last;
              context.read<PropertiesProvider>().updatePropertiesGeneral(propertyTotal: propertiesProvider.propertyTotalLast,context: context);
            }else if(_requestCopy.response=="Confirmado"&&_requestCopy.requestType=="Vendido"){
              propertiesProvider.propertyTotalLast.property.authorization="Activo";
              propertiesProvider.propertyTotalLast.property.negotiationStatus="Vendido";
              context.read<PropertiesProvider>().updatePropertiesGeneral(propertyTotal: propertiesProvider.propertyTotalLast,context: context);
            }
            notifyListeners();
            Navigator.pop(context);
          }
        }
      }else{
        print(response);
        if(response["message"]=="El inmueble está a cargo de otro administrador"){
          if(propertiesProvider.propertyTotalLast.administratorRequest.userResponding.id==""){
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            context.read<PropertiesProvider>().deleteWherePropertiesGeneralLast(context: context);
          }else{
            print("errror");
          }
        }else{
          print(response);
        }
      }
    });
  }

  void answerAdministratorRequestSuperUser({required BuildContext context})async{
    final user=context.read<UserProvider>().user;
    final propertiesProvider=context.read<PropertiesProvider>();
    final administratorProperty=propertiesProvider.propertyTotalLast.administratorRequest;
    await _useCaseSuperUser.answerAdministratorRequestSuperUser(user, administratorProperty, _requestCopy)
    .then((response) {
      if(response["completed"]){
        if(response["message"]=="Correcto"){
          if(administratorProperty.requestDate==_requestCopy.requestDate){
            String idAux=propertiesProvider.propertyTotalLast.administratorRequest.id;
            propertiesProvider.propertyTotalLast.administratorRequest=AdministratorRequest.copyWith(_requestCopy);
            propertiesProvider.propertyTotalLast.administratorRequest.id=idAux;
            propertiesProvider.notify();
            int index=_administratorRequests.lastIndexWhere((element) => element.id==_requestCopy.id);
            _administratorRequests.replaceRange(index,index+1,[AdministratorRequest.copyWith(_requestCopy)]);
            if(_requestCopy.responseSuperUser=="Rechazado"&&_requestCopy.requestType=="Bajar precio"){
              propertiesProvider.propertyTotalLast.property.pricesHistory.removeLast();
              propertiesProvider.propertyTotalLast.property.price=propertiesProvider.propertyTotalLast.property.pricesHistory.last;
              context.read<PropertiesProvider>().updatePropertiesGeneral(propertyTotal: propertiesProvider.propertyTotalLast,context: context);
            }
            notifyListeners();
            Navigator.pop(context);
          }
        }
      }else{
        if(response["message"]=="El inmueble está a cargo de otro super usuario"){
          if(propertiesProvider.propertyTotalLast.administratorRequest.userResponding.id==""){
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            context.read<PropertiesProvider>().deleteWherePropertiesGeneralLast(context: context);
          }else{
            print("errror");
          }
        }else{
          print(response);
        }
      }
    });
  }

  Future<bool> generatePropertyInfoAllPdf(BuildContext context)async{
    bool completed=false;
    final propertyTotal=context.read<PropertiesProvider>().propertyTotalLast;
    UseCasePropertySale useCasePropertySale=UseCasePropertySale();
    List<PropertyComplaint> propertyComplaints=[];
    List<PropertyReported> propertyReports=[];
    await useCasePropertySale.getComplaintsReportsProperty(propertyTotal.property.id)
    .then((response) {
      if(response["completed"]){
        propertyComplaints.addAll(response["property_complaints"]);
        propertyReports.addAll(response["property_reports"]);
      }
    });
    Map<String,dynamic> mapImagenesFile={};
    List imagenesCategoria=[];
    for(int i=0;i<propertyTotal.property.mapImages["principales"].length;i++){
      var datetime=DateTime.now();
      String nameFile="${datetime.year}${datetime.month}${datetime.day}${datetime.hour}${datetime.minute}${datetime.second}${datetime.millisecond}";
      final tempDir=await getTemporaryDirectory();
      final path='${tempDir.path}/$nameFile.jpg';
      await Dio().download(propertyTotal.property.mapImages["principales"][i], path);
      final imagen = pw.MemoryImage(
        (await readFileByte(path))
      );
      imagenesCategoria.add(imagen);
    }
    mapImagenesFile["principales"]=imagenesCategoria;
    List<AdministratorRequest> administratorRequestsAux=[];
    for(int i=0;i<_administratorRequests.length;i++){
      print(i);
      final ar=AdministratorRequest.copyWith(_administratorRequests[i]);
      final tempDir=await getTemporaryDirectory();
      
      if(ar.propertyVoucher.depositImageLink!=""){
          var datetime=DateTime.now();
        String nameFile="${datetime.year}${datetime.month}${datetime.day}${datetime.hour}${datetime.minute}${datetime.second}${datetime.millisecond}";
        final path='${tempDir.path}/$nameFile.jpg';
        await Dio().download(ar.propertyVoucher.depositImageLink, path);
        ar.propertyVoucher.depositImageLink=pw.MemoryImage(await readFileByte(path));
      }
      if(ar.propertyVoucher.agentDNIImageLink!=""){
          var datetime=DateTime.now();
        String nameFile="${datetime.year}${datetime.month}${datetime.day}${datetime.hour}${datetime.minute}${datetime.second}${datetime.millisecond}";
        final path='${tempDir.path}/$nameFile.jpg';
        await Dio().download(ar.propertyVoucher.agentDNIImageLink, path);
        ar.propertyVoucher.agentDNIImageLink=pw.MemoryImage(await readFileByte(path));
      }
      if(ar.propertyVoucher.ownerDNIImageLink!=""){
          var datetime=DateTime.now();
        String nameFile="${datetime.year}${datetime.month}${datetime.day}${datetime.hour}${datetime.minute}${datetime.second}${datetime.millisecond}";
        final path='${tempDir.path}/$nameFile.jpg';
        await Dio().download(ar.propertyVoucher.ownerDNIImageLink, path);
        ar.propertyVoucher.ownerDNIImageLink=pw.MemoryImage(await readFileByte(path));
      }
      if(ar.propertyVoucher.documentPropertyImageLink!=""){
          var datetime=DateTime.now();
        String nameFile="${datetime.year}${datetime.month}${datetime.day}${datetime.hour}${datetime.minute}${datetime.second}${datetime.millisecond}";
        final path='${tempDir.path}/$nameFile.jpg';
        await Dio().download(ar.propertyVoucher.documentPropertyImageLink, path);
        ar.propertyVoucher.documentPropertyImageLink=pw.MemoryImage(await readFileByte(path));
      }
      if(ar.propertyVoucher.documentSalesImageLink!=""){
          var datetime=DateTime.now();
        String nameFile="${datetime.year}${datetime.month}${datetime.day}${datetime.hour}${datetime.minute}${datetime.second}${datetime.millisecond}";
        final path='${tempDir.path}/$nameFile.jpg';
        await Dio().download(ar.propertyVoucher.documentSalesImageLink, path);
        ar.propertyVoucher.documentSalesImageLink=pw.MemoryImage(await readFileByte(path));
      }
      administratorRequestsAux.add(ar);
    }
    administratorRequestsAux.forEach((a){
      print("imagen ${a.propertyVoucher.depositImageLink}");
    });

    generatePropertyInfoAll(propertyTotal,administratorRequestsAux,propertyReports,propertyComplaints,mapImagenesFile,)
    .then((value) {
      archivoPdf=value;
      Printing.sharePdf(
      bytes: archivoPdf!, filename: 'Documento${propertyTotal.property.id}.pdf')
      .then((completado){
        if(completado){
          completed=true;
          print("exportado");
        }
      });
    });
    return completed;
  }
}