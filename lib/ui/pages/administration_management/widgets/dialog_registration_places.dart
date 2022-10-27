import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/generals.dart';
import 'package:inmobiliariaapp/ui/common/buttons.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/provider/generals/registration_places_provider.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/f_text_fields.dart';

Future dialogRegistrationDepartament(
  BuildContext context,
  Departament departament
)async{
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
            titlePadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(SizeDefault.radiusDialog)
            ),
            children: [
              _ContainerRegistrationDepartament(departament: departament,)
            ],
          );
        }
      );
    }
  ); 
}

class _ContainerRegistrationDepartament extends StatefulWidget {
  _ContainerRegistrationDepartament({Key? key,required this.departament}) : super(key: key);
  final Departament departament;

  @override
  State<_ContainerRegistrationDepartament> createState() => __ContainerRegistrationDepartamentState();
}

class __ContainerRegistrationDepartamentState extends State<_ContainerRegistrationDepartament> {
  TextEditingController? _controller;
  bool _newRegistration=false;
  @override
  void initState() {
    _controller=TextEditingController(text: widget.departament.departamentName);
    _newRegistration=widget.departament.id=="";
    super.initState();
  } 
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300*SizeDefault.scaleWidth,
      padding: EdgeInsets.all(20*SizeDefault.scaleWidth),
      child: Column(
        children:[
          TextStandard(
            text: _newRegistration?"Nuevo departamento":"Modificar departamento", 
            fontSize: 16*SizeDefault.scaleWidth,
            color: ColorsDefault.colorPrimary,
          ),
          SizedBox(height: 10*SizeDefault.scaleWidth),
          FTextFieldBasico(
            controller: _controller!, 
            labelText: "Nombre del departamento", 
            onChanged: (x){
              widget.departament.departamentName=x;
            }
          ),
          SizedBox(height: 20*SizeDefault.scaleWidth),
          Row(
            children: [
              Expanded(
                child: ButtonOutlinedPrimary(
                  text: "Cancelar", 
                  onPressed: (){
                    Navigator.pop(context);
                  }
                ),
              ),
              SizedBox(width: 10*SizeDefault.scaleWidth),
              Expanded(
                child: ButtonPrimary(
                  text: _newRegistration?"Registrar":"Modificar",
                  onPressed: ()async{
                    bool responseOk=false;
                    if(_newRegistration){
                      responseOk=await context.read<RegistrationPlacesProvider>().registerDepartament(widget.departament);
                    }else{
                      responseOk=await context.read<RegistrationPlacesProvider>().updateDepartament(widget.departament);
                    }
                    if(responseOk) Navigator.pop(context);
                  },
                )
              )
            ],
          )
        ]
      ),
    );
  }
}

Future dialogRegistrationCity(
  BuildContext context,
  City city
)async{
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
            titlePadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(SizeDefault.radiusDialog)
            ),
            children: [
              _ContainerRegistrationCity(city: city,)
            ],
          );
        }
      );
    }
  ); 
}

class _ContainerRegistrationCity extends StatefulWidget {
  _ContainerRegistrationCity({Key? key,required this.city}) : super(key: key);
  final City city;
  @override
  State<_ContainerRegistrationCity> createState() => __ContainerRegistrationCityState();
}

class __ContainerRegistrationCityState extends State<_ContainerRegistrationCity> {
  TextEditingController? _controller;
  bool _newRegistration=false;
  @override
  void initState() {
    _controller=TextEditingController(text: widget.city.cityName);
    _newRegistration=widget.city.id=="";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300*SizeDefault.scaleWidth,
      padding: EdgeInsets.all(20*SizeDefault.scaleWidth),
      child: Column(
        children:[
          TextStandard(
            text: _newRegistration?"Nueva ciudad":"Modificar ciudad", 
            fontSize: 16*SizeDefault.scaleWidth,
            color: ColorsDefault.colorPrimary,
          ),
          SizedBox(height: 10*SizeDefault.scaleWidth),
          FTextFieldBasico(
            controller: _controller!, 
            labelText: "Nombre de la ciudad", 
            onChanged: (x){
              widget.city.cityName=x;
            }
          ),
          SizedBox(height: 20*SizeDefault.scaleWidth),
          Row(
            children: [
              Expanded(
                child: ButtonOutlinedPrimary(
                  text: "Cancelar", 
                  onPressed: (){
                    Navigator.pop(context);
                  }
                ),
              ),
              SizedBox(width: 10*SizeDefault.scaleWidth),
              Expanded(
                child: ButtonPrimary(
                  text: _newRegistration?"Registrar":"Modificar",
                  onPressed: ()async{
                    bool responseOk=false;
                    if(_newRegistration){
                      responseOk=await context.read<RegistrationPlacesProvider>().registerCity(widget.city);
                    }else{
                      responseOk=await context.read<RegistrationPlacesProvider>().updateCity(widget.city);
                    }
                    if(responseOk) Navigator.pop(context);
                  },
                )
              )
            ],
          )
        ]
      ),
    );
  }
}