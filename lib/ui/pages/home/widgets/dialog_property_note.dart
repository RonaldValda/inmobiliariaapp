import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/property.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/domain/entities/user.dart';
import 'package:inmobiliariaapp/domain/usecases/property/usecase_property_note.dart';
import 'package:inmobiliariaapp/ui/common/buttons.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/widgets/f_text_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
Future dialogPropertyNote(
  BuildContext context,
  PropertyTotal propertyTotal,
  User user
)async{
  
 return await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext ctx){
      return StatefulBuilder(
        builder: (BuildContext ctx,StateSetter setState){
          return SimpleDialog(
            contentPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.fromLTRB(0,0,0,0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(SizeDefault.radiusDialog)
            ),
            children: [
              _NoteProperty(propertyTotal: propertyTotal,user: user,)
            ],
          );
        }
      );
    }
  ); 
}
class _NoteProperty extends StatefulWidget {
  _NoteProperty({Key? key,required this.propertyTotal,required this.user}) : super(key: key);
  final PropertyTotal propertyTotal;
  final User user;

  @override
  State<_NoteProperty> createState() => __NotePropertyState();
}

class __NotePropertyState extends State<_NoteProperty> {
  Future<SharedPreferences> _prefs=SharedPreferences.getInstance();
  TextEditingController? controller;
  PropertyClientNote clientNote=PropertyClientNote.empty();
  UseCasePropertyNote useCasePropertyNote=UseCasePropertyNote();
  @override
  void initState() {
    super.initState();
    controller=TextEditingController(text: "");
    useCasePropertyNote.searchPropertyNote(widget.propertyTotal.property.id,widget.user.id)
    .then((response){
      if(response["completed"]){
        clientNote=response["property_client_note"];
        controller!.text=clientNote.note;
        setState(() {
          
        });
      }
    });
    /*_buscarNota().then((value){
      setState(() {
        controller!.text=notaCliente.nota;
      });
    });*/
    
  }
  Future<void> _buscarNota()async{
    final SharedPreferences prefs=await _prefs;
    clientNote.id=widget.propertyTotal.property.id;
    clientNote.note=(prefs.getString(widget.propertyTotal.property.id)??"");
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20*SizeDefault.scaleWidth),
      child: Column(
        children: [
          TextTitle(
            text: "Nota", 
            fontSize: 20*SizeDefault.scaleWidth
          ),
          SizedBox(
            height: 20*SizeDefault.scaleWidth,
          ),
          FTextFieldBasico(
            controller: controller!, 
            labelText: "", onChanged: (x){}
          ),
          SizedBox(
            height: 15*SizeDefault.scaleWidth,
          ),
          SizedBox(
            height: 45*SizeDefault.scaleWidth,
            child: ButtonPrimary(
              text: "Guardar",
              onPressed: ()async{
                clientNote.note=controller!.text;
                //await registrarInmuebleNotaClienteShared(notaCliente, _prefs);*/
                await useCasePropertyNote.savePropertyNote(widget.propertyTotal.property.id,widget.user.id, clientNote);
                Navigator.pop(context);
              }
            ),
          ),
        ],
      ),
    );
  }
  Future<void> registrarInmuebleNotaClienteShared(PropertyClientNote notaCliente,Future<SharedPreferences> _prefs) async{
    final SharedPreferences prefs=await _prefs;
    await prefs.setString(notaCliente.id, notaCliente.note);
  }
}