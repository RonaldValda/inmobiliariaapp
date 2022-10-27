import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/publicity.dart';
import 'package:inmobiliariaapp/ui/provider/generals/general_data_provider.dart';
import 'package:provider/provider.dart';
class DropdownTipoContratoPublicidad extends StatefulWidget {
  DropdownTipoContratoPublicidad({Key? key,required this.publicidad}) : super(key: key);
  final Publicity publicidad;
  @override
  _DropdownTipoContratoPublicidadState createState() => _DropdownTipoContratoPublicidadState();
}

class _DropdownTipoContratoPublicidadState extends State<DropdownTipoContratoPublicidad> {
  List<String> items=[];
  String valor="Venta";
  bool dropdownActivado=false;
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.transparent,
      child: DropdownButton(
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
        value: widget.publicidad.contractType,
        onChanged: (String? value){
          widget.publicidad.contractType=value!;
          setState(() {
            valor=value;
            dropdownActivado=false;
          });
        },
        items: <String>["Todos","Venta","Alquiler","Anticrético"]
        .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Container(
              child: Text(value,textAlign: TextAlign.center),
            )
          );
        }).toList()
      ),
    );
  }
}
class DropdownTipoInmueblePublicidad extends StatefulWidget {
  DropdownTipoInmueblePublicidad({Key? key,required this.publicidad}) : super(key: key);
  final Publicity publicidad;
  @override
  _DropdownTipoInmueblePublicidadState createState() => _DropdownTipoInmueblePublicidadState();
}

class _DropdownTipoInmueblePublicidadState extends State<DropdownTipoInmueblePublicidad> {
  List<String> items=[];
  bool dropdownActivado=false;
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.transparent,
      child: DropdownButton(
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
        value: widget.publicidad.propertyType,
        onChanged: (String? value){
          widget.publicidad.propertyType=value!;
          setState(() {
            dropdownActivado=false;
          });
        },
        items: <String>["Todos","Casa","Departamento","Terreno","Otros"]
        .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Container(
              child: Text(value,textAlign: TextAlign.center),
            )
          );
        }).toList()
      ),
    );
  }
}
class DropdownPrecioPublicidad extends StatefulWidget {
  DropdownPrecioPublicidad({Key? key,required this.publicidad}) : super(key: key);
  final Publicity publicidad;
  @override
  _DropdownPrecioPublicidadState createState() => _DropdownPrecioPublicidadState();
}

class _DropdownPrecioPublicidadState extends State<DropdownPrecioPublicidad> {
  List<String> items=["Cualquiera","0-99K","100K-149K","150K-199K","200K-250K","250K a más"];
  List<int> precios=[0,0,100,150,200,250];
  String valor="Cualquiera";
  final color=Colors.white;
  final colorFill=Colors.white12;
  bool dropdownActivado=false;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(widget.publicidad.maxPrice<widget.publicidad.minPrice){
      valor=items[0];
    }else if(widget.publicidad.minPrice==widget.publicidad.maxPrice){
      valor=items[items.length-1];
    }else{
      for(int i=1;i<precios.length-1;i++){
        if(precios[i]==widget.publicidad.minPrice){
          valor=items[i];
          break;
        }
      }
    }
    return Container(
      //color: Colors.red,
      width: 100,
       child: Row(
         children: [
           //Icon(Icons.monetization_on_outlined),
           Container(
             child: DropdownButton(
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
                int index=items.indexOf(value!);
                if(index<precios.length-1){
                  widget.publicidad.minPrice=precios[index]*1000;
                  widget.publicidad.maxPrice=(precios[index+1]-1)*1000;
                }else{
                  widget.publicidad.minPrice=precios[index]*1000;
                  widget.publicidad.maxPrice=precios[index]*1000;
                }
                setState(() {
                  valor=value;
                  dropdownActivado=false;
                });
              },
              items: items
              .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Container(
                    child: Text(value,textAlign: TextAlign.end,),
                  )
                );
              }).toList()
            ),
           ),
         ],
       ) 
    );
  }
}
class DropdownCiudadPublicidad extends StatefulWidget {
  DropdownCiudadPublicidad({Key? key,required this.publicidad}) : super(key: key);
  final Publicity publicidad;
  @override
  _DropdownCiudadPublicidadState createState() => _DropdownCiudadPublicidadState();
}

class _DropdownCiudadPublicidadState extends State<DropdownCiudadPublicidad> {
  List<String> ciudades=[];
  final color=Colors.white;
  final colorFill=Colors.white12;
  bool dropdownActivado=false;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final _datosGenerales=Provider.of<GeneralDataProvider>(context);
    if(ciudades.length==0){
      _datosGenerales.cities.forEach((element) { 
        ciudades.add(element.cityName);
        
      });
    }
    if(widget.publicidad.city==""){
      widget.publicidad.city=ciudades[0];
    }
    return Container(
       //width: widget.publicidad.ciudad.length*11,
       child: Row(
         children: [
           Container(
             child: DropdownButton(
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
              value: widget.publicidad.city,
              onChanged: (String? value){
                widget.publicidad.city=value!;
                setState(() {
                  dropdownActivado=false;
                });
              },
              items: ciudades
              .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Container(
                    child: Text(value,textAlign: TextAlign.end,),
                  )
                );
              }).toList()
            ),
           ),
         ],
       ) 
    );
  }
}