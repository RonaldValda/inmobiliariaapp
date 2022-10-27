import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inmobiliariaapp/domain/entities/publication_plan_payment.dart';
import 'package:inmobiliariaapp/ui/common/buttons.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/f_list_tile.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/pages/administration_management/plans_payment/screen_registration_publication_plan_payment.dart';
import 'package:inmobiliariaapp/ui/provider/generals/publication_plan_payment_provider.dart';
import 'package:inmobiliariaapp/widgets/utils.dart';
import 'package:provider/provider.dart';

import '../../../../domain/usecases/general/usecase_publication_plan_payment.dart';
class ScreenPublicationPlansPayment extends StatefulWidget {
  ScreenPublicationPlansPayment({Key? key}) : super(key: key);

  @override
  _ScreenPublicationPlansPaymentState createState() => _ScreenPublicationPlansPaymentState();
}

class _ScreenPublicationPlansPaymentState extends State<ScreenPublicationPlansPayment> {
  TextEditingController? controllerNombrePlan;
  TextEditingController? controllerCosto;
  PublicationPlanPayment planSeleccionado=PublicationPlanPayment.empty();
  UseCasePublicationPlanPayment useCasePlanesPagoPublicacion=UseCasePublicationPlanPayment();
  int selected=-1;
  @override
  void initState() {
    super.initState();
    controllerNombrePlan=TextEditingController(text: "");
    controllerCosto=TextEditingController(text: "0");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<PublicationPlanPaymentProvider>().loadPublicationPlansPayment();
    });
  }
  @override
  Widget build(BuildContext context) {
    final publicationPlanPaymentProvider=context.watch<PublicationPlanPaymentProvider>();
    final plans=publicationPlanPaymentProvider.publicationPlansPayment;
    return Scaffold(
      backgroundColor: ColorsDefault.colorBackgroud,
      appBar: AppBar(
        title: TextTitle(
          fontSize: SizeDefault.fSizeTitle,
          text: "Planes de pago de publicación",
        ),
        leading: FBackButton(),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: SizeDefault.paddingHorizontalBody,vertical: 10*SizeDefault.scaleWidth),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context,index){
                  return Container(
                    height: 1*SizeDefault.scaleWidth,
                    color: ColorsDefault.colorSeparated,
                  );
                },
                itemCount: plans.length,
                itemBuilder: (context, index) {
                  final plan=plans[index];
                  final selected=publicationPlanPaymentProvider.publicationPlanPaymentSelected.id==plan.id;
                  return FListTileFull(
                    onTap: (){
                      context.read<PublicationPlanPaymentProvider>().setPublicationPlanPayment(plan);
                    },
                    colorBackground: selected?ColorsDefault.colorBackgroundListTileSelected:ColorsDefault.colorBackgroud,
                    height: 70*SizeDefault.scaleWidth,
                    widgetContent: Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _wRichTextInfo(label: "Nombre del plan: ",data: plan.planName),
                          _wRichTextInfo(label: "Tipo: ",data: plan.planType),
                          _wRichTextInfo(label: "Costo: ",data: "${plan.cost.toString()} Bs."),
                          _wRichTextInfo(label: "Modificaciones permitidas: ",data: plan.modificationsAllowed.toString())
                        ],
                      )
                    ),
                    widgetTrailing: selected
                    ?SizedBox(
                      width: 50*SizeDefault.scaleWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _wIconButton(
                            icon: Icon(
                              Icons.edit,
                              color: ColorsDefault.colorIcon,
                              size: SizeDefault.sizeIconButton,
                            ), 
                            onPressed: ()async{
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context){
                                    return ScreenRegistrationPublicationPlanPayment();
                                  }
                                )
                              );
                            }
                          ),
                          _wIconButton(
                            icon: Icon(
                              Icons.delete,
                              color: ColorsDefault.colorTextError,
                              size: SizeDefault.sizeIconButton,
                            ), 
                            onPressed: ()async{
                              bool responseOk=await context.read<PublicationPlanPaymentProvider>().deletePublicactionPlanPayment();
                              if(responseOk){
                                ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Proceso realizado exitósamente"));
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Error"));
                              }
                            }
                          ),
                        ],
                      ),
                    ):SizedBox(),
                  ); 
                },
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FIconButton(
                  icon: Icon(
                    Icons.add,
                    size: SizeDefault.sizeIconButton*1.5,
                    color: ColorsDefault.colorBackgroud,
                  ), 
                  onTap: (){
                    context.read<PublicationPlanPaymentProvider>().setPublicationPlanPayment(PublicationPlanPayment.empty());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context){
                          return ScreenRegistrationPublicationPlanPayment();
                        }
                      )
                    );
                  }
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  RichText _wRichTextInfo({required String label,required String data}) {
    return RichText(
      text: TextSpan(
        text: label,
        style: GoogleFonts.notoSans(
          color: ColorsDefault.colorText,
          fontSize: 11*SizeDefault.scaleWidth,
          fontWeight: FontWeight.w300
        ),
        children: [
          TextSpan(
            text: data,
              style: GoogleFonts.notoSans(
              color: ColorsDefault.colorText,
              fontSize: 11*SizeDefault.scaleWidth,
              fontWeight: FontWeight.w400
            ),
          )
        ]
      )
    );
  }

  Widget _wIconButton({required Icon icon,required Function onPressed}){
    return IconButton(
      constraints: BoxConstraints(maxWidth: SizeDefault.sizeIconButton,maxHeight: SizeDefault.sizeIconButton),
      padding: EdgeInsets.zero,
      splashRadius: SizeDefault.sizeIconButton,
      onPressed:() => onPressed(), 
      icon: icon
    );
  }
}