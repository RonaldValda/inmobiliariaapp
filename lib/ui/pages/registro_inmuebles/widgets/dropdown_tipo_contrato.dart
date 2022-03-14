import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/provider/inmueble_info.dart';
import 'package:provider/provider.dart';
class DropdownTipoContrato extends StatefulWidget {
  DropdownTipoContrato({Key? key}) : super(key: key);
  @override
  _DropdownTipoContratoState createState() => _DropdownTipoContratoState();
}

class _DropdownTipoContratoState extends State<DropdownTipoContrato> {
  List<String> items=[];
  String valor="Venta";
  bool dropdownActivado=false;
  final color=Colors.grey;
  final colorFill=Colors.white12;
  @override
  Widget build(BuildContext context) {
    final inmuebleInfo=Provider.of<InmuebleInfo>(context);
    if(inmuebleInfo.inmuebleTotalCopia.inmueble.tipoContrato==""){
      inmuebleInfo.inmuebleTotalCopia.inmueble.tipoContrato="Venta";
    }
    valor=inmuebleInfo.inmuebleTotalCopia.inmueble.tipoContrato;
    return  Container(
      padding: EdgeInsets.zero,
      height:70,
      child: Column(
        children: [
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Tipo contrato",
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
              decoration: BoxDecoration(
                border: Border.all(color: color.withOpacity(0.7),width: 1),
                borderRadius: BorderRadius.circular(5),
                color: colorFill
              ),
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
                      inmuebleInfo.inmuebleTotalCopia.inmueble.tipoContrato=value!;
                      setState(() {
                        valor=value;
                        dropdownActivado=false;
                      });
                    },
                    items: <String>["Venta","Alquiler","Anticrético"]
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
