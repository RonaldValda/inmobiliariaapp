import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/provider/inmueble_info.dart';
import 'package:provider/provider.dart';
class DropdownTipoInmueble extends StatefulWidget {
  DropdownTipoInmueble({Key? key}) : super(key: key);
  @override
  _DropdownTipoInmuebleState createState() => _DropdownTipoInmuebleState();
}

class _DropdownTipoInmuebleState extends State<DropdownTipoInmueble> {
  List<String> items=[];
  String valor="Casa";
  bool dropdownActivado=false;
  final color=Colors.grey;
  final colorFill=Colors.white12;
  @override
  Widget build(BuildContext context) {
    final inmuebleInfo=Provider.of<InmuebleInfo>(context);
    if(inmuebleInfo.inmuebleTotalCopia.inmueble.tipoInmueble==""){
      inmuebleInfo.inmuebleTotalCopia.inmueble.tipoInmueble="Casa";
    }
    valor=inmuebleInfo.inmuebleTotalCopia.inmueble.tipoInmueble;
    return  Container(
      padding: EdgeInsets.zero,
      height:70,
      child: Column(
        children: [
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Tipo inmueble",
                style: TextStyle(
                  color:Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.w400,
                  fontSize: 14
                ),
              )
            )
          ),
          Expanded(
            child: Container(
              height: 35,
              padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
              margin: EdgeInsets.fromLTRB(0, 2, 0, 2),
              //color: Colors.amberAccent,
              decoration: BoxDecoration(
                border: Border.all(color: color.withOpacity(0.7),width: 1),
                borderRadius: BorderRadius.circular(5),
                color: colorFill
              ),
              //color: Colors.transparent,
              child: Row(
                children: [
                  DropdownButton(
                    icon: Icon(Icons.arrow_drop_down,color: Colors.black,),
                    style: dropdownActivado?TextStyle(
                      color:  Colors.black
                    ):TextStyle(
                      color: Colors.black
                    ),
                    
                    onTap: (){
                      setState(() {
                        dropdownActivado=true;
                      });
                      
                    },
                    dropdownColor: Colors.white.withOpacity(0.8),
                    value: valor,
                    onChanged: (String? value){
                      inmuebleInfo.inmuebleTotalCopia.inmueble.tipoInmueble=value!;
                      setState(() {
                        valor=value;
                        dropdownActivado=false;
                      });
                    },
                    items: <String>["Casa","Departamento","Terreno constructivo","Terreno agrícola","Habitaciones","Condominio abierto","Condominio privado","Local comercial","Local eventual","Oficinas","Garajes","Galpones"]
                    .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          child: Text(value),
                        )
                        
                      );
                    }).toList()
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}