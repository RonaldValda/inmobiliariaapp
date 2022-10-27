import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/generals.dart';
import 'package:inmobiliariaapp/ui/common/f_list_tile.dart';
import 'package:inmobiliariaapp/ui/pages/administration_management/widgets/dialog_registration_places.dart';
import 'package:inmobiliariaapp/ui/pages/administration_management/screen_registration_zone.dart';
import 'package:inmobiliariaapp/ui/provider/generals/general_data_provider.dart';
import 'package:inmobiliariaapp/ui/provider/generals/registration_places_provider.dart';
import 'package:inmobiliariaapp/widgets/f_text_fields.dart';
import 'package:provider/provider.dart';

import '../../../domain/usecases/general/usecase_generals.dart';
import '../../common/buttons.dart';
import '../../common/colors_default.dart';
import '../../common/size_default.dart';
import '../../common/texts.dart';
class ScreenRegistrationPlaces extends StatefulWidget {
  ScreenRegistrationPlaces({Key? key}) : super(key: key);

  @override
  _ScreenRegistrationPlacesState createState() => _ScreenRegistrationPlacesState();
}

class _ScreenRegistrationPlacesState extends State<ScreenRegistrationPlaces> {
  int dSelected=-1;
  int cSelected=-1;
  double _heightListTile=50*SizeDefault.scaleHeight;
  UseCaseGenerals useCaseGenerales=UseCaseGenerals();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<RegistrationPlacesProvider>().loadDepartaments();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsDefault.colorBackgroud,
      appBar: AppBar(
        title: TextTitle(
          fontSize: 17*SizeDefault.scaleWidth,
          text: "Departamentos, ciudades y zonas",
        ),
        leadingWidth:40*SizeDefault.scaleWidth,
        leading: FBackButton(),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: SizeDefault.paddingHorizontalBody,vertical: 10*SizeDefault.scaleWidth),
        child: Column(
          children:[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextStandard(
                  text:"Departamentos",
                  fontSize: 16*SizeDefault.scaleWidth,
                  fontWeight: FontWeight.w600,
                  color: ColorsDefault.colorPrimary,
                ),
              ],
            ),
            SizedBox(height: 10*SizeDefault.scaleWidth,),
            _wDepartaments(context: context),
            SizedBox(height: 10*SizeDefault.scaleWidth,),
            Row(
              mainAxisAlignment:MainAxisAlignment.end,
              children: [
                FIconButton(
                  icon: Icon(
                    Icons.add,
                    color: ColorsDefault.colorBackgroud,
                    size: SizeDefault.sizeIconButton,
                  ),
                  onTap: ()async{
                    await dialogRegistrationDepartament(context, Departament.empty());
                  },
                ),
              ],
            ),
            Divider(thickness: 1*SizeDefault.scaleWidth,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextStandard(
                  text:"Ciudades",
                  fontSize: 16*SizeDefault.scaleWidth,
                  fontWeight: FontWeight.w600,
                  color: ColorsDefault.colorPrimary,
                ),
              ],
            ),
            SizedBox(height: 10*SizeDefault.scaleWidth,),
            _wCities(context:context),
            SizedBox(height: 10*SizeDefault.scaleWidth,),
            context.read<RegistrationPlacesProvider>().departamentSelected.id!=""
            ?Row(
              mainAxisAlignment:MainAxisAlignment.end,
              children: [
                FIconButton(
                  icon: Icon(
                    Icons.add,
                    color: ColorsDefault.colorBackgroud,
                    size: SizeDefault.sizeIconButton,
                  ),
                  onTap: ()async{
                    await dialogRegistrationCity(context, City.empty());
                  },
                ),
              ],
            ):SizedBox(),
          ]
        ),
      ),
    );
  }

  Widget _wCities({required BuildContext context}) {
    final registrationPlacesProvider=context.watch<RegistrationPlacesProvider>();
    final cities=registrationPlacesProvider.departamentCities;
    final citySelected=registrationPlacesProvider.citySelected;
    return Expanded(
      child: ListView.builder(
        itemCount: cities.length,
        itemBuilder: (context, index) {
          final city=cities[index];
          final selected=city.id==citySelected.id;
          return FListTileCommon(
            title: city.cityName, 
            colorBackground: selected?ColorsDefault.colorBackgroundListTileSelected:ColorsDefault.colorBackgroud,
            height: _heightListTile,
            widgetTrailing: selected?SizedBox(
              height: _heightListTile,
              width: 90*SizeDefault.scaleWidth,
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
                      await dialogRegistrationCity(context, city);
                    }
                  ),
                  _wIconButton(
                    icon: Icon(
                      Icons.delete,
                      color: ColorsDefault.colorTextError,
                      size: SizeDefault.sizeIconButton,
                    ), 
                    onPressed: ()async{
                      if(registrationPlacesProvider.zonesCity.length==0){
                        bool responseOk=await context.read<RegistrationPlacesProvider>().deleteCity(city);
                      }
                    }
                  ),
                  _wIconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: ColorsDefault.colorIcon,
                      size: SizeDefault.sizeIconButton,
                    ), 
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context){
                            return ScreenRegistrationZone();
                          }
                        )
                      );
                    }
                  ),
                ],
              ),
            ):SizedBox(),
            onTap: (){
              registrationPlacesProvider.setCitySelected(city,context.read<GeneralDataProvider>().zonesAll);
            }
          );
        },
      )
    );
  }

  Expanded _wDepartaments({required BuildContext context}) {
    final registrationPlacesProvider=context.watch<RegistrationPlacesProvider>();
    final departamentSelected=registrationPlacesProvider.departamentSelected;
    final departaments=registrationPlacesProvider.departaments;
    return Expanded(
      child: ListView.builder(
        itemCount: departaments.length,
        itemBuilder: (context, index) {
          final departament=departaments[index];
          final selected=departament.id==departamentSelected.id;
          return FListTileCommon(
            title: departament.departamentName, 
            colorBackground: selected?ColorsDefault.colorBackgroundListTileSelected:ColorsDefault.colorBackgroud,
            height: _heightListTile,
            widgetTrailing: selected
            ?SizedBox(
              width: 60*SizeDefault.scaleWidth,
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
                      await dialogRegistrationDepartament(context, Departament.copyWith(departament));
                    }
                  ),
                  _wIconButton(
                    icon: Icon(
                      Icons.delete,
                      color: ColorsDefault.colorTextError,
                      size: SizeDefault.sizeIconButton,
                    ), 
                    onPressed: ()async{
                      if(registrationPlacesProvider.departamentCities.length==0){
                        bool responseOk=await context.read<RegistrationPlacesProvider>().deleteDepartament(departament);
                      }
                      
                    }
                  ),
                ],
              ),
            ):SizedBox(),
            onTap: (){
              registrationPlacesProvider.setDepartamentSelected(departament);
            }
          );
        },
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
Future<Map<String,dynamic>> dialogRegistroCiudadDepartamento(
  BuildContext context,
  String tipo,
  String operacion,
)async{
  Map<String,dynamic> map={};
  TextEditingController controller=TextEditingController(text:"");
 return await showDialog(
    barrierLabel: "",
    barrierDismissible: true,
    context: context,

    builder: (BuildContext ctx){
      return StatefulBuilder(

        builder: (BuildContext ctx,StateSetter setState){
          return SimpleDialog(
            //insetPadding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height/2, 0, 0),
            contentPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
            title: Center(child: Text(operacion+" "+tipo,style: TextStyle(fontSize: 20)),),
            children: [
              Container(
                padding: EdgeInsets.all(5),
                //width: 300,
                //height: 600,
                child: Column(
                  children:[
                    SizedBox(height:10),
                    FTextFieldBasico(
                      controller: controller, 
                      labelText: tipo,
                      onChanged: (x){
                        map["nombre"]=x;
                      }
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: (){
                            map["confirmar"]=true;
                            Navigator.pop(context,map);
                          }, 
                          child: Text(operacion)
                        ),
                        SizedBox(width: 10,),
                        OutlinedButton(
                          onPressed: (){
                            map["confirmar"]=false;
                            Navigator.pop(context,map);
                          }, 
                          child: Text("Cancelar",style: TextStyle(color: Colors.red),),
                        )
                      ],
                    )
                  ]
                ),
              )
            ],
          );
        }
      );
    }
  ); 
}