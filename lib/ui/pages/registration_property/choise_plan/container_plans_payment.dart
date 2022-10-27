import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/provider/generals/publication_plan_payment_provider.dart';
import 'package:inmobiliariaapp/ui/provider/registration_property/registration_property_plan_provider.dart';
import 'package:inmobiliariaapp/ui/provider/registration_property/registration_property_provider.dart';
import 'package:provider/provider.dart';

import 'container_plan_payment_free.dart';
import 'container_plan_payment_paid.dart';
enum GetPlan{
  gratuito,
  pago
}
class ContainerPlansPayment extends StatefulWidget {
  ContainerPlansPayment({Key? key}) : super(key: key);
  @override
  _ContainerPlansPaymentState createState() => _ContainerPlansPaymentState();
}

class _ContainerPlansPaymentState extends State<ContainerPlansPayment> {
  int plan=0;
  List<dynamic>? imagenComprobante=[""];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<RegistrationPropertyPlanProvider>().init(context: context);
      setState(() {
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final registrationPropertyProvider=context.watch<RegistrationPropertyProvider>();
    final publicationPlanSelected=context.watch<RegistrationPropertyPlanProvider>().publicationPlanPayment(context);
    final property=registrationPropertyProvider.propertyTotalCopy.property;
    final request=registrationPropertyProvider.propertyTotalCopy.administratorRequest;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: SizeDefault.paddingHorizontalBody),
      color: ColorsDefault.colorBackgroud,
      child: Column(
        children: [
          if(property.authorization=="Pendiente - Corregir datos")
          Padding(
            padding: EdgeInsets.only(top: 10*SizeDefault.scaleHeight,bottom: 10*SizeDefault.scaleHeight,right: 30*SizeDefault.scaleWidth,left: 30*SizeDefault.scaleWidth),
            child: TextStandard(
              text: request.observations!=""?"${request.observations}":"${request.observationsSuperUser}", 
              fontSize: 12*SizeDefault.scaleWidth,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
              color: ColorsDefault.colorTextError,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10*SizeDefault.scaleHeight,bottom: 10*SizeDefault.scaleHeight,right: 30*SizeDefault.scaleWidth,left: 30*SizeDefault.scaleWidth),
            child: TextStandard(
              text: "Seleccione el plan que más se acomode a sus necesidades", 
              fontSize: SizeDefault.fSizeStandard,
              textAlign: TextAlign.center,
              color: ColorsDefault.colorTextInfo,
            ),
          ),
          Container(
             //color: Colors.amber,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: context.read<PublicationPlanPaymentProvider>().publicationPlansPaymentPublish.map((plan){
                return Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          TextStandard(
                            text: plan.planName, 
                            fontSize: 14*SizeDefault.scaleHeight,
                            fontWeight: FontWeight.w600,
                            color: ColorsDefault.colorPrimary,
                          ),
                          TextStandard(
                            text: plan.cost.toString()+r" Bs.",
                            fontSize: 17*SizeDefault.scaleHeight,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                    
                    Checkbox(
                      value: publicationPlanSelected.id==plan.id, 
                      activeColor: ColorsDefault.colorPrimary,
                      onChanged: (selected){
                        registrationPropertyProvider.propertyTotalCopy.administratorRequest.propertyVoucher.publicationPlanPayment.id=plan.id;
                        registrationPropertyProvider.propertyTotalCopy.property.category=plan.planName;
                        registrationPropertyProvider.notify();
                      }
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          property.category.toUpperCase()=="GRATUITO"
          ?ContainerPlanPaymentFree()
          :ContainerPlanPaymentPaid()
        ],
      )
    );
  }
}