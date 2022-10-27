import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/common/buttons.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/pages/home/widgets/drawer/drawer_menu.dart';
import 'package:inmobiliariaapp/ui/pages/home/widgets/filters/drop_down_selectable_data_filter_city.dart';
import 'package:inmobiliariaapp/ui/pages/home/widgets/home/app_bar.dart';
import 'package:inmobiliariaapp/ui/pages/home/widgets/home/body_main.dart';
import 'package:inmobiliariaapp/ui/provider/generals/bank_account_provider.dart';
import 'package:inmobiliariaapp/ui/provider/generals/general_data_provider.dart';
import 'package:inmobiliariaapp/ui/provider/generals/publication_plan_payment_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/widget_status_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_general_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_others_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_main_provider.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../auxiliares/global_variables.dart';
String email="";
bool respuesta=false;

class PageHome extends StatefulWidget {
  PageHome({Key? key}) : super(key: key);
  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  SizeDefault sizeDefault=SizeDefault();
  bool _loading=true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<FilterGeneralProvider>().init();
      context.read<FilterOthersProvider>().init();
      context.read<PublicationPlanPaymentProvider>().loadPublicationPlansPayment();
      context.read<BankAccountProvider>().init();
      context.read<GeneralDataProvider>().init()
      .then((completed) {
        if(completed){
          context.read<UserProvider>().loginUserAutomatic(mounted,context: context)
          .then((completed){
            if(completed){
              setState(() {
                context.read<FilterMainProvider>().mapFilter["city"]=initialCityDefault;
                _loading=false;
              });
            }else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Container(child: Text("Algo salió mal, reinicie la aplicación"),)));
            }
          });
        }else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Container(child: Text("Algo salió mal, reinicie la aplicación"),)));
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    //  _buscar();
    final widgetStatusProvider=Provider.of<WidgetStatusProvider>(context,);
    final filterMainProvider=context.watch<FilterMainProvider>();
    sizeDefault.setWidth=MediaQuery.of(context).size.width;
    sizeDefault.setHeight=MediaQuery.of(context).size.height;
    if(_loading)
      return Scaffold(
        body: Container(
          child: Center(
            child: CupertinoActivityIndicator(
              radius: SizeDefault.scaleHeight==0?40:40*SizeDefault.scaleHeight,
            ),
          ),
        ),
      );
    return 
      !context.read<UserProvider>().appVersion.checkVersion()
      ?Scaffold(
        body: wAppUpdate(),
      ):
      WillPopScope(
        onWillPop: () async {
          if(!widgetStatusProvider.seeMap){
            if(widgetStatusProvider.scrollControllerProperties.offset==0){
              return true;
            }
            widgetStatusProvider.reiniciarScroll();
            return false;
          }else{
            widgetStatusProvider.setSeeMap(false);
            return false;
          }
        },
        child: initialCityDefault!=""?Scaffold(
          appBar: AppBarPzd(),
          drawer: DrawerMenu(),
          body:BodyMain(),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          //floatingActionButton: ButtonFlotante(),
        ):Scaffold(
          body: wSelectedInitialConfig(filterMainProvider, context),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          //floatingActionButton: ButtonFlotante(),
        ),
      );
  }

  Container wSelectedInitialConfig(FilterMainProvider filterMainProvider, BuildContext context)  {
    return Container(
      child: Column(
        mainAxisAlignment:MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: SizeDefault.paddingHorizontalBody, vertical: 20*SizeDefault.scaleHeight),
            margin: EdgeInsets.all(0),
            alignment: Alignment.center,
            child: DropDownSelectableDataFilterCity(text: "Seleccione su ciudad preferida para poder continuar:",dropDownItemsCount: 5,),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeDefault.paddingHorizontalBody),
            child: ButtonPrimary(
              text: "Guardar y continuar", 
              onPressed: ()async{
                initialCityDefault=filterMainProvider.mapFilter["city"];
                await context.read<UserProvider>().registerInitialCityShared();
                setState(() {
                  
                });
              }
            ),
          )
        ],
      ),
    );
  }

  Container wAppUpdate() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: SizeDefault.paddingHorizontalBody),
        child: Center(child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            TextInfo(
              text: "La aplicación requiere una actualización", 
              fontSize: 20*SizeDefault.scaleHeight
            ),
            SizedBox(
              height:10*SizeDefault.scaleHeight
            ),
            ButtonPrimary(
              text: "Descargar actualización", 
              onPressed: (){

              }
            )
          ],
        )),
      );
  }
}