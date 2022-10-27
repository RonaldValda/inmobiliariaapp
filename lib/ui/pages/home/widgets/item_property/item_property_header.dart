import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/domain/entities/user.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/provider/home/widget_status_provider.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_provider.dart';
import 'package:provider/provider.dart';
class ItemPropertyHeader extends StatefulWidget {
  final PropertyTotal propertyTotal;
  final int index;
  ItemPropertyHeader({Key? key,required this.propertyTotal,required this.index}) : super(key: key);

  @override
  _ItemPropertyHeaderState createState() => _ItemPropertyHeaderState();
}

class _ItemPropertyHeaderState extends State<ItemPropertyHeader> {
  double width=0;
  bool modoVertical=false;
  double _fontSizeRequest=12*SizeDefault.scaleHeight;
  @override
  Widget build(BuildContext context) {
    final widgetStatusProvider=Provider.of<WidgetStatusProvider>(context);
    final usuario=Provider.of<UserProvider>(context);
    final administratorRequest=widget.propertyTotal.administratorRequest;
    final creator=widget.propertyTotal.creator;
    if(widgetStatusProvider.seeMap){
      width=250;
      modoVertical=true;
    }else{
      if(MediaQuery.of(context).size.height>MediaQuery.of(context).size.width){
        width=MediaQuery.of(context).size.width;
        modoVertical=true;
      }else{
        width=MediaQuery.of(context).size.width*0.6;
        modoVertical=false;
      }
    }
    
    return Container(
      
      padding: modoVertical?EdgeInsets.only(bottom: 0):EdgeInsets.only(bottom: 0),
       child: Column(
         children: [
            Container(
              width: width,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      usuario.sessionType=="Administrar"
                      ?_wStatusRequest(statusRequest:administratorRequest.response==""
                      ?"Pendiente - ${administratorRequest.requestType}":"${administratorRequest.response} - ${administratorRequest.requestType}")
                      :usuario.sessionType=="Supervisar"
                      ?_wStatusRequest(statusRequest:administratorRequest.responseSuperUser==""
                      ?"Pendiente - ${administratorRequest.requestType}":"${administratorRequest.responseSuperUser} - ${administratorRequest.requestType}")
                      :usuario.sessionType=="Vender"?
                      _wStatusRequest(statusRequest:widget.propertyTotal.property.authorization)
                      :Container(),
                      usuario.sessionType=="Comprar"
                      ?_wAgency(creator):Container(),
                      
                      Container(
                        child:Row(
                          children: [
                            Text(creator.agencyName,style: TextStyle(color: Colors.black,fontSize: 15),),
                            SizedBox(
                              width:10
                            )
                          ],
                        )
                      )
                      
                    ],
                  ),
                ],
              ),
            ),
         ],
       ),
    );
  }

  Container _wAgency(User creator) {
    return Container(
      height: 20*SizeDefault.scaleHeight,
      padding:EdgeInsets.only(left: 20*SizeDefault.scaleWidth,right: 20*SizeDefault.scaleWidth,),
      child: creator.verified
      ?TextStandard(
        text:creator.agencyName!=""?
        "${creator.agencyName} -> Verificado":"${creator.namesSurnames} -> Verificado",
        fontSize: _fontSizeRequest,
        color: ColorsDefault.colorTextError,fontWeight: FontWeight.w600,
      ):TextStandard(
        text: "No verificado",
        fontSize: _fontSizeRequest,
        color: ColorsDefault.colorTextApproved,fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color:ColorsDefault.colorBackgroundRequestStatus,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight:Radius.circular(20)),
      ),
    );
  }

  Container _wStatusRequest({required String statusRequest}) {
    return Container(
      height: 20*SizeDefault.scaleHeight,
      padding:EdgeInsets.only(left: 20*SizeDefault.scaleWidth,right: 20*SizeDefault.scaleWidth,),
      alignment: Alignment.center,
      child: TextStandard(
        text: statusRequest,
        fontSize: _fontSizeRequest,
        fontWeight: FontWeight.w600,
        color: ColorsDefault.mapColorStatusRequests[statusRequest]
      ),
      decoration: BoxDecoration(
        color:ColorsDefault.colorBackgroundRequestStatus,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight:Radius.circular(20)),
      ),
    );
  }
}