import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/publicidad.dart';
import 'package:inmobiliariaapp/ui/provider/datos_generales_info.dart';
import 'package:provider/provider.dart';
class DropdownTipoContratoPublicidad extends StatefulWidget {
  DropdownTipoContratoPublicidad({Key? key,required this.publicidad}) : super(key: key);
  final Publicidad publicidad;
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
        value: widget.publicidad.tipoContrato,
        onChanged: (String? value){
          widget.publicidad.tipoContrato=value!;
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
  final Publicidad publicidad;
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
        value: widget.publicidad.tipoInmueble,
        onChanged: (String? value){
          widget.publicidad.tipoInmueble=value!;
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
  final Publicidad publicidad;
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
    if(widget.publicidad.precioMax<widget.publicidad.precioMin){
      valor=items[0];
    }else if(widget.publicidad.precioMin==widget.publicidad.precioMax){
      valor=items[items.length-1];
    }else{
      for(int i=1;i<precios.length-1;i++){
        if(precios[i]==widget.publicidad.precioMin){
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
                  widget.publicidad.precioMin=precios[index]*1000;
                  widget.publicidad.precioMax=(precios[index+1]-1)*1000;
                }else{
                  widget.publicidad.precioMin=precios[index]*1000;
                  widget.publicidad.precioMax=precios[index]*1000;
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
  final Publicidad publicidad;
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
    final _datosGenerales=Provider.of<DatosGeneralesInfo>(context);
    if(ciudades.length==0){
      _datosGenerales.ciudades.forEach((element) { 
        ciudades.add(element.nombreCiudad);
        
      });
    }
    if(widget.publicidad.ciudad==""){
      widget.publicidad.ciudad=ciudades[0];
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
              value: widget.publicidad.ciudad,
              onChanged: (String? value){
                widget.publicidad.ciudad=value!;
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