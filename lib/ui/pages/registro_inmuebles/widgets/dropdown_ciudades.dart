import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/provider/inmueble_info.dart';
import 'package:provider/provider.dart';
class DropdownCiudades extends StatefulWidget {
  DropdownCiudades({Key? key}) : super(key: key);
  @override
  _DropdownCiudadesState createState() => _DropdownCiudadesState();
}

class _DropdownCiudadesState extends State<DropdownCiudades> {
  List<String> ciudades=["La Paz","Oruro","Potosi","Cochabamba","Sucre","Tarija","Beni","Pando","Santa Cruz"];
  String ciudad="Sucre";
  bool dropdownActivado=false;
  final color=Colors.grey;
  final colorFill=Colors.white12;
  @override
  Widget build(BuildContext context) {
    final inmuebleInfo=Provider.of<InmuebleInfo>(context);
    if(inmuebleInfo.inmuebleTotalCopia.inmueble.ciudad==""){
      inmuebleInfo.inmuebleTotalCopia.inmueble.ciudad="Sucre";
    }
    ciudad=inmuebleInfo.inmuebleTotalCopia.inmueble.ciudad;
    return  Container(
      padding: EdgeInsets.zero,
      height:70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            //color: Colors.amber,
            //width: 70,
            child:Align(
              alignment: Alignment.centerLeft,
              child: Text("Ciudad",
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
              //height: 35,
              padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
              margin: EdgeInsets.fromLTRB(0, 2, 0, 2),
              //color: Colors.amberAccent,
              decoration: BoxDecoration(
                border: Border.all(color: color.withOpacity(0.7),width: 1),
                borderRadius: BorderRadius.circular(5),
                color: colorFill
              ),
              //height: 60,
              //color: Colors.cyan[800],
              child: Row(
                children: [
                  DropdownButton(
                    icon: Icon(Icons.arrow_drop_down,color: color,),
                    style: dropdownActivado?TextStyle(
                      color:  color
                    ):TextStyle(
                      color: color
                    ),
                    
                    onTap: (){
                      setState(() {
                        dropdownActivado=true;
                      });
                      
                    },
                    dropdownColor: Colors.white.withOpacity(0.8),
                    value: ciudad,
                    onChanged: (String? value){
                      inmuebleInfo.inmuebleTotalCopia.inmueble.ciudad=value!;
                      setState(() {
                        ciudad=value;
                        dropdownActivado=false;
                      });
                    },
                    items:ciudades
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