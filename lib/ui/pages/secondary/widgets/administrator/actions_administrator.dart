
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/administrator_request.dart';
import 'package:inmobiliariaapp/ui/common/buttons.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/f_show_modal_bottom_sheet.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/pages/secondary/widgets/common/button_icon_notification_requests.dart';

import 'package:inmobiliariaapp/ui/provider/home/properties_provider.dart';
import 'package:inmobiliariaapp/ui/provider/secondary/property_adminitrator_requests_provider.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'container_administrator_requests.dart';
import 'package:provider/provider.dart';

class ActionsAdminitrator extends StatefulWidget {
  ActionsAdminitrator({Key? key}) : super(key: key);
  
  @override
  _ActionsAdminitratorState createState() => _ActionsAdminitratorState();
}

class _ActionsAdminitratorState extends State<ActionsAdminitrator> {
  int _notificationIndex=-1;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final sessionType=context.read<UserProvider>().sessionType;
    final administratorRequests=context.watch<PropertyAdministratorRequestsProvider>().administratorRequests;
    if(sessionType=="Administrar") _notificationIndex=administratorRequests.lastIndexWhere((element) => !element.requestFinished);
    else _notificationIndex=administratorRequests.lastIndexWhere((element) => !element.requestFinishedSuperUser);

    final propertyTotal=context.read<PropertiesProvider>().propertyTotalLast;
    return Container(
      margin: EdgeInsets.only(left:10*SizeDefault.scaleHeight,bottom: 20*SizeDefault.scaleHeight),
      padding: EdgeInsets.all(10*SizeDefault.scaleWidth),
      height: 60*SizeDefault.scaleWidth,
      width: SizeDefault.swidth*0.75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: ColorsDefault.colorBackgroud,
        boxShadow: [
          BoxShadow(
            color: ColorsDefault.colorShadowCardImage,
            blurRadius: 20,
            offset: Offset(10,10)
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /*Container(
            width: 90*SizeDefault.scaleWidth,
            child: ButtonPrimary(
              text: "Dar alta",
              fontSize: 13*SizeDefault.scaleHeight,
              onPressed: (){

              },
            ),
          ),*/
          Container(
            width: 230*SizeDefault.scaleWidth,
            child: ButtonPrimary(
              color: ColorsDefault.colorPrimary,
              fontSize: 13*SizeDefault.scaleHeight,
              text: "Generar informe y compartir",
              onPressed: ()async{
                var status=await Permission.storage.request();
                if(status.isGranted){
                  bool responseOK=await context.read<PropertyAdministratorRequestsProvider>().generatePropertyInfoAllPdf(context);
                }
              },
            ),
          ),
          ButtonIconNotificationRequests(
            existsNotification: _notificationIndex>=0, 
            onTap: ()async{
              await fShowModalBottomSheet(
                context: context, 
                widget: ContainerAdministratorRequests()
              );
            }
          ),
          
        ],
      ),
    );
  }
}