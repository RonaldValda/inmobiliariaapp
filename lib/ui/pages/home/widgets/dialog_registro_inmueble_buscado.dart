import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/user_property_favorite.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:inmobiliariaapp/ui/common/buttons.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/f_list_tile.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_properties_searcheds.dart';
import 'package:inmobiliariaapp/widgets/f_text_fields.dart';
import 'package:provider/provider.dart';

import '../../../../domain/usecases/user/usecase_user.dart';
Future dialogRegistroInmuebleBuscado(
  BuildContext context,
)async{
  
 return await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext ctx){
      return StatefulBuilder(
        builder: (BuildContext ctx,StateSetter setState){
          return SimpleDialog(
            contentPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            children: [
              _ContainerSaveSearched()
            ],
          );
        }
      );
    }
  ); 
}
class _ContainerSaveSearched extends StatefulWidget {
  _ContainerSaveSearched({Key? key}) : super(key: key);

  @override
  __ContainerSaveSearchedState createState() => __ContainerSaveSearchedState();
}

class __ContainerSaveSearchedState extends State<_ContainerSaveSearched> {
  bool nuevoRegistro=false;
  TextEditingController? controller;
  TextEditingController? controllerTelefono;
  String error="";
  int seleccionado=-1;
  UseCaseUser useCaseUsuario=UseCaseUser();
  int _step=0;
  @override
  void initState() {
    super.initState();
    controller=TextEditingController(text:"");
    controllerTelefono=TextEditingController(text: "");
  }
  @override
  Widget build(BuildContext context) {
    final userPropertiesSearchedsProvider=context.watch<UserPropertiesSearchedsProvider>();
    final userPropertiesSearcheds=userPropertiesSearchedsProvider.userPropertiesSearcheds;
  
    return _step==0?_wSelectOption(context, userPropertiesSearcheds):_step==1?_wNew(context):_wSearcheds(context, userPropertiesSearcheds);
  }

  Widget _wSelectOption(BuildContext context, List<UserPropertySearched> userPropertiesSearcheds) {
    return Container(
    padding: EdgeInsets.symmetric(horizontal: SizeDefault.paddingHorizontalBody),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20*SizeDefault.scaleWidth,bottom: 30*SizeDefault.scaleWidth),
          child: TextStandard(
            text: "Guardar filtros", 
            color: ColorsDefault.colorPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 16*SizeDefault.scaleWidth
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 30*SizeDefault.scaleWidth),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 120*SizeDefault.scaleWidth,
                height: 45*SizeDefault.scaleWidth,
                child: ButtonPrimary(
                  text: "Nuevo", 
                  onPressed: (){
                    context.read<UserPropertiesSearchedsProvider>().setUserPropertySearchedSelected(UserPropertySearched.empty());
                    setState(() {
                      _step=1;
                    });
                  }
                ),
              ),
              SizedBox(width: 10*SizeDefault.scaleWidth,),
              SizedBox(
                width: 120*SizeDefault.scaleWidth,
                height: 45*SizeDefault.scaleWidth,
                child: ButtonPrimary(
                  text: "Existente", 
                  onPressed: (){
                    setState(() {
                      _step=2;
                    });
                  }
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  }

  Widget _wNew(BuildContext context) {
    final searched=context.read<UserPropertiesSearchedsProvider>().userPropertySearchedSelected;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: SizeDefault.paddingHorizontalBody),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20*SizeDefault.scaleWidth,bottom: 30*SizeDefault.scaleWidth),
            child: TextStandard(
              text: "Nuevo", 
              color: ColorsDefault.colorPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 16*SizeDefault.scaleWidth
            ),
          ),
          FTextFieldBasico(
            controller: controller!, 
            labelText: "Nombre configuración", 
            onChanged: (x){
              searched.configurationName=x;
            }
          ),
          SizedBox(height: 5,),
          FTextFieldBasico(
            controller: controllerTelefono!, 
            labelText: "Número de contacto", 
            onChanged: (x){
              searched.phoneNumber=x;
            }
          ),
          Container(
            padding: EdgeInsets.only(top: 20*SizeDefault.scaleWidth,bottom: 30*SizeDefault.scaleWidth),
            child: ButtonPrimary(
              text: "Registrar", 
              onPressed: ()async{
                bool responseOk=await context.read<UserPropertiesSearchedsProvider>().registerUserPropertySearched(context: context);
                if(responseOk){
                  Navigator.pop(context);
                }
              }
            )
          ),
        ],
      ),
    );
  }

  Widget _wSearcheds(BuildContext context, List<UserPropertySearched> userPropertiesSearcheds) {
    final searchedSelected=context.read<UserPropertiesSearchedsProvider>().userPropertySearchedSelected;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: SizeDefault.paddingHorizontalBody),
      height: 350*SizeDefault.scaleWidth,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20*SizeDefault.scaleWidth,bottom: 30*SizeDefault.scaleWidth),
            child: TextStandard(
              text: "Existente", 
              color: ColorsDefault.colorPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 16*SizeDefault.scaleWidth
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: userPropertiesSearcheds.length,
              itemBuilder: (context, index) {
                UserPropertySearched searched=userPropertiesSearcheds[index];
                return _wListTile(searched,context: context);
              },
              separatorBuilder: (context,index){
                return Container(
                  height: 1*SizeDefault.scaleWidth,
                  color: ColorsDefault.colorSeparated,
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20*SizeDefault.scaleWidth,bottom: 30*SizeDefault.scaleWidth),
            child: ButtonPrimary(
              text: "Actualizar", 
              onPressed: ()async{
                if(searchedSelected.id!=""){
                  bool responseOk=await context.read<UserPropertiesSearchedsProvider>().updateUserPropertySearched(context: context);
                  if(responseOk){
                    Navigator.pop(context);
                  }
                }
              }
            )
          ),
        ],
      ),
    );
  }
  FListTileFull _wListTile(UserPropertySearched searched, {required BuildContext context}) {
    final searchedSelected=context.read<UserPropertiesSearchedsProvider>().userPropertySearchedSelected;
    return FListTileFull(
      colorBackground: searchedSelected.id==searched.id?ColorsDefault.colorBackgroundListTileSelected:ColorsDefault.colorBackgroud,
      onTap: (){
        context.read<UserPropertiesSearchedsProvider>().setUserPropertySearchedSelected(searched);
      }, 
      widgetContent: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextStandard(
              color: ColorsDefault.colorText,
              fontWeight: FontWeight.w500,
              text: searched.configurationName, 
              fontSize: 11*SizeDefault.scaleWidth
            ),
            TextStandard(
              color: ColorsDefault.colorText,
              fontWeight: FontWeight.w300,
              text: searched.phoneNumber, 
              fontSize: 11*SizeDefault.scaleWidth
            ),
          ],
        ),
      ),
    );
  }
}


class PropertiesSearcheds extends StatefulWidget {
  PropertiesSearcheds({Key? key}) : super(key: key);

  @override
  _PropertiesSearchedsState createState() => _PropertiesSearchedsState();
}

class _PropertiesSearchedsState extends State<PropertiesSearcheds> {
  //int seleccionado=-1;
  TextEditingController? _controllerConfigurationName;
  TextEditingController? _controllerPhoneNumber;
  UseCaseUser useCaseUsuario=UseCaseUser();
  bool _editMode=false;
  @override
  void initState() {
    _controllerPhoneNumber=TextEditingController(text:  "");
    _controllerConfigurationName=TextEditingController(text: "");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    /*final userProvider=context.watch<UserProvider>();
    final filterGeneralProvider=context.watch<FilterGeneralProvider>();
    final filterInternalProvider=context.watch<FilterInternalProvider>();
    final filterComunityProvider=context.watch<FilterComunityProvider>();
    final filterOthersProvider=context.watch<FilterOthersProvider>();
    final filterMainProvider=context.watch<FilterMainProvider>();
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);*/
    final userPropertiesSearchedsProvider=context.watch<UserPropertiesSearchedsProvider>();
    final userPropertiesSearcheds=userPropertiesSearchedsProvider.userPropertiesSearcheds;
    final searchedSelected=userPropertiesSearchedsProvider.userPropertySearchedSelected;
    return Container(
      //padding: EdgeInsets.all(20),
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height/2,
      child: Column(
        children: [
          userPropertiesSearcheds.length>0?
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context,index){
                return Container(
                  height: 1*SizeDefault.scaleWidth,
                  color: ColorsDefault.colorSeparated,
                );
              },
              padding: EdgeInsets.zero,
              itemCount: userPropertiesSearcheds.length,
              itemBuilder: (context, index) {
                final searched=userPropertiesSearcheds[index];
                return Column(
                  children: [
                    _wListTile(searched, context: context),
                    if(_editMode&&searched.id==searchedSelected.id)_wFormEdit(searched,context: context)
                  ],
                );
              },
            )
          )
          :
          Text("No tiene filtros guardados"),
          SizedBox(height: 10*SizeDefault.scaleWidth,),
          //DropdownUsuarioInmueblesBuscados():,
          SizedBox(
            width: 150*SizeDefault.scaleWidth,
            height: 45*SizeDefault.scaleWidth,
            child: ButtonPrimary(
              text: "Aplicar filtros", 
              onPressed: (){
                if(context.read<UserPropertiesSearchedsProvider>().userPropertySearchedSelected.id!=""){
                  context.read<UserPropertiesSearchedsProvider>().applyFilters(context);
                }
              }
            ),
          ),
        ],
      ),
    );
  }

  /*
  if(buscado.foundQuantity>0)
                          IconoNumeroNotificacion(numeroNotificaciones: buscado.foundQuantity.toString(), size: Size(25,25)),
                          Text("${buscado.configurationName}",style: TextStyle(fontSize: 13),),
   */

  Container _wFormEdit(UserPropertySearched searched,{required BuildContext context}) {
    final userPropertiesSearchedsProvider=context.watch<UserPropertiesSearchedsProvider>();
    final searchedSelected=userPropertiesSearchedsProvider.userPropertySearchedSelected;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: SizeDefault.paddingHorizontalBody,vertical: 10*SizeDefault.scaleWidth),
      //
      decoration: BoxDecoration(
        color: ColorsDefault.colorBackgroud,
        /*border: Border(
          bottom: BorderSide(
            color: ColorsDefault.colorSeparated,
            width: 1*SizeDefault.scaleWidth
          )
        )*/
      ),
      child: Column(
        children: [
          FTextFieldBasico(
            controller: _controllerConfigurationName!, 
            labelText: "Nombre configuración", 
            onChanged: (x){
              searchedSelected.configurationName=x;
            }
          ),
          SizedBox(height: 5*SizeDefault.scaleWidth,),
          FTextFieldBasico(
            controller: _controllerPhoneNumber!, 
            labelText: "Número de teléfono", 
            onChanged: (x){
              searchedSelected.phoneNumber=x;
            }
          ),
          SizedBox(height: 10*SizeDefault.scaleWidth,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100*SizeDefault.scaleWidth,
                height: 40*SizeDefault.scaleWidth,
                child: ButtonOutlinedPrimary(
                  text: "Cancelar",
                  color: ColorsDefault.colorTextError,
                  onPressed: (){
                    setState(() {
                      _editMode=false;
                     });
                  },
                ),
              ),
              SizedBox(width: 5*SizeDefault.scaleWidth,),
              SizedBox(
                width: 100*SizeDefault.scaleWidth,
                height: 40*SizeDefault.scaleWidth,
                child: ButtonPrimary(
                  text: "Guardar", 
                  onPressed: ()async{
                    bool responseOk=await context.read<UserPropertiesSearchedsProvider>()
                    .updateUserPropertySearchedPersonalInformation();
                  }
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  FListTileFull _wListTile(UserPropertySearched searched, {required BuildContext context}) {
    final searchedSelected=context.read<UserPropertiesSearchedsProvider>().userPropertySearchedSelected;
    return FListTileFull(
      colorBackground: searchedSelected.id==searched.id?ColorsDefault.colorBackgroundListTileSelected:ColorsDefault.colorBackgroud,
      onTap: (){
        _editMode=false;
        context.read<UserPropertiesSearchedsProvider>().setUserPropertySearchedSelected(searched);
      }, 
      onLongPress: (){  
        if(!_editMode){
          if(searchedSelected.id!=searched.id){
            context.read<UserPropertiesSearchedsProvider>().setUserPropertySearchedSelected(searched);
          }
          _controllerConfigurationName!.text=searchedSelected.configurationName;
          _controllerPhoneNumber!.text=searchedSelected.phoneNumber;
          setState(() {
            _editMode=true;
          });
        }
      },
      widgetContent: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextStandard(
              color: ColorsDefault.colorText,
              fontWeight: FontWeight.w500,
              text: searched.configurationName, 
              fontSize: 11*SizeDefault.scaleWidth
            ),
            TextStandard(
              color: ColorsDefault.colorText,
              fontWeight: FontWeight.w300,
              text: searched.phoneNumber, 
              fontSize: 11*SizeDefault.scaleWidth
            ),
          ],
        ),
      ),
      widgetTrailing: SizedBox(
        width: 60*SizeDefault.scaleWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _wIconButton(
              icon: Icon(Icons.whatsapp,color: ColorsDefault.colorIcon,size: SizeDefault.sizeIconButton,),
              onPressed: 
              (){}
            ),
            _wIconButton(
              icon: Icon(Icons.phone,color: ColorsDefault.colorIcon,size: SizeDefault.sizeIconButton,),
              onPressed: 
              ()async{
                String number = searched.phoneNumber; //set the number here
                await FlutterPhoneDirectCaller.callNumber(number);
              },
            ),
          ],
        ),
      ),
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
