import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_generales_info.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_internas_info.dart';
import 'package:provider/provider.dart';

class WidgetsSelectoresSimples extends StatefulWidget {
  final String texto;
  final String clave;
  final double heightContainerTexto;
  final double widthContainerTexto;
  final mapaFiltro;
  WidgetsSelectoresSimples({Key? key,required this.texto,required this.mapaFiltro,required this.clave,required this.heightContainerTexto,required this.widthContainerTexto}) : super(key: key);
  @override
  _WidgetsSelectoresSimplesState createState() => _WidgetsSelectoresSimplesState();
}

class _WidgetsSelectoresSimplesState extends State<WidgetsSelectoresSimples> {
  
  @override
  Widget build(BuildContext context) {
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    return Container(
      height: widget.heightContainerTexto,
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: widget.heightContainerTexto,
            width: widget.widthContainerTexto,
            child: Text(widget.texto,style: TextStyle(fontSize: 13),),
          ),
          Container(
            child: Switch(
              value: widget.mapaFiltro.getMapaFiltro[widget.clave],
              onChanged: (bool value){
                _inmueblesFiltrado.setFiltrar(true);
                widget.mapaFiltro.setMapaFiltroItem(widget.clave, value);
                
              },
            ),
          ),
        ],
      ),
    );
  }
}
class WidgetsSelectoresSimplesMas extends StatefulWidget {
  final String texto;
  final String clave;
  final double heightContainerTexto;
  final double widthContainerTexto;
  final mapaFiltro;
  WidgetsSelectoresSimplesMas({Key? key,required this.texto,required this.mapaFiltro,required this.clave,required this.heightContainerTexto,required this.widthContainerTexto}) : super(key: key);
  @override
  _WidgetsSelectoresSimplesMasState createState() => _WidgetsSelectoresSimplesMasState();
}

class _WidgetsSelectoresSimplesMasState extends State<WidgetsSelectoresSimplesMas> {
  @override
  Widget build(BuildContext context) {
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    return Container(
      height: widget.heightContainerTexto,
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: widget.heightContainerTexto,
            width: widget.widthContainerTexto,
            child: Text(widget.texto,style: TextStyle(fontSize: 13),),
          ),
          Container(
            child: Switch(
              value: widget.mapaFiltro.getMapaFiltroMas[widget.clave],
              onChanged: (bool value){
                _inmueblesFiltrado.setFiltrar(true);
                widget.mapaFiltro.setMapaFiltroMasItem(widget.clave, value);
                
              },
            ),
          ),
        ],
      ),
    );
  }
}
class WidgetsSelectoresBotones extends StatefulWidget {
  final String texto;
  final String clave;
  final double heightContainerTexto;
  final double widthContainerTexto;
  WidgetsSelectoresBotones({Key? key,required this.texto,required this.clave,required this.heightContainerTexto,required this.widthContainerTexto}) : super(key: key);

  @override
  _WidgetsSelectoresBotonesState createState() => _WidgetsSelectoresBotonesState();
}

class _WidgetsSelectoresBotonesState extends State<WidgetsSelectoresBotones> {
  
  @override
  Widget build(BuildContext context) {
    final mapaFiltro=Provider.of<MapaFiltroInternasInfo>(context);
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    return Container(
      height: widget.heightContainerTexto,
      child:Row(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: widget.heightContainerTexto,
            width: widget.widthContainerTexto,
            child: Text(widget.texto,style: TextStyle(fontSize: 13),),
          ),
          Container(
            width: 150,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 25,
                  height: 25,
                  child:ElevatedButton(
                    onPressed: (){
                      _inmueblesFiltrado.setFiltrar(true);
                      if(mapaFiltro.getMapaFiltro[widget.clave]==1){
                        mapaFiltro.setMapaFiltroItem(widget.clave, 0);
                      }else{
                        mapaFiltro.setMapaFiltroItem(widget.clave, 1);
                      }
                    },
                    child: Text("1",style: TextStyle(fontSize: 13,color: mapaFiltro.getMapaFiltro[widget.clave]==1?Colors.white:Colors.blue),textAlign: TextAlign.right,),
                    style: ElevatedButton.styleFrom(
                        primary:mapaFiltro.getMapaFiltro[widget.clave]==1?Colors.blue:Colors.white,
                        elevation: 0,
                        shape: StadiumBorder(side: BorderSide(color:Colors.blue))
                    ),
                  ),
                ),
                SizedBox(
                  width: 25,
                  height: 25,
                  child: ElevatedButton(
                    onPressed: (){
                      _inmueblesFiltrado.setFiltrar(true);
                      if(mapaFiltro.getMapaFiltro[widget.clave]==2){
                        mapaFiltro.setMapaFiltroItem(widget.clave, 0);
                      }else{
                        mapaFiltro.setMapaFiltroItem(widget.clave, 2);
                      }
                    },
                    child: Text("2",style: TextStyle(fontSize: 13,color: mapaFiltro.getMapaFiltro[widget.clave]==2?Colors.white:Colors.blue),textAlign: TextAlign.right,),
                    style: ElevatedButton.styleFrom(
                        primary:mapaFiltro.getMapaFiltro[widget.clave]==2?Colors.blue:Colors.white,
                        elevation: 0,
                        shape: StadiumBorder(side: BorderSide(color:Colors.blue))
                    ),
                  ),
                ),
                SizedBox(
                  width: 25,
                  height: 25,
                  child: ElevatedButton(
                    onPressed: (){
                      _inmueblesFiltrado.setFiltrar(true);
                      if(mapaFiltro.getMapaFiltro[widget.clave]==3){
                        mapaFiltro.setMapaFiltroItem(widget.clave, 0);
                      }else{
                        mapaFiltro.setMapaFiltroItem(widget.clave, 3);
                      }
                    },
                    child: Text("3",style: TextStyle(fontSize: 13,color: mapaFiltro.getMapaFiltro[widget.clave]==3?Colors.white:Colors.blue),textAlign: TextAlign.right,),
                    style: ElevatedButton.styleFrom(
                        primary:mapaFiltro.getMapaFiltro[widget.clave]==3?Colors.blue:Colors.white,
                        elevation: 0,
                        shape: StadiumBorder(side: BorderSide(color:Colors.blue))
                    ),
                  ),
                ),
                SizedBox(
                  width: 25,
                  height: 25,
                  child: ElevatedButton(
                    onPressed: (){
                      _inmueblesFiltrado.setFiltrar(true);
                      if(mapaFiltro.getMapaFiltro[widget.clave]==4){
                        mapaFiltro.setMapaFiltroItem(widget.clave, 0);
                      }else{
                        mapaFiltro.setMapaFiltroItem(widget.clave, 4);
                      }
                    },
                    child: Text("4",style: TextStyle(fontSize: 13,color: mapaFiltro.getMapaFiltro[widget.clave]==4?Colors.white:Colors.blue),textAlign: TextAlign.right,),
                    style: ElevatedButton.styleFrom(
                        primary:mapaFiltro.getMapaFiltro[widget.clave]==4?Colors.blue:Colors.white,
                        elevation: 0,
                        shape: StadiumBorder(side: BorderSide(color:Colors.blue))
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                  height: 25,
                  child: ElevatedButton(
                    onPressed: (){
                      _inmueblesFiltrado.setFiltrar(true);
                      if(mapaFiltro.getMapaFiltro[widget.clave]==5){
                        mapaFiltro.setMapaFiltroItem(widget.clave, 0);
                      }else{
                        mapaFiltro.setMapaFiltroItem(widget.clave, 5);
                      }
                    },
                    child: Text("5+",style: TextStyle(fontSize: 13,color:mapaFiltro.getMapaFiltro[widget.clave]==5?Colors.white:Colors.blue),textAlign: TextAlign.right,),
                    style: ElevatedButton.styleFrom(
                        primary:mapaFiltro.getMapaFiltro[widget.clave]==5?Colors.blue:Colors.white,
                        elevation: 0,
                        shape: StadiumBorder(side: BorderSide(color:Colors.blue))
                    ),
                  ),
                ),
                
              ],
            )
          ),
        ],
      ),
    );
  }
}
class WidgetsSelectoresBotonesMas extends StatefulWidget {
  final String texto;
  final String clave;
  final double heightContainerTexto;
  final double widthContainerTexto;
  WidgetsSelectoresBotonesMas({Key? key,required this.texto,required this.clave,required this.heightContainerTexto,required this.widthContainerTexto}) : super(key: key);

  @override
  _WidgetsSelectoresBotonesMasState createState() => _WidgetsSelectoresBotonesMasState();
}

class _WidgetsSelectoresBotonesMasState extends State<WidgetsSelectoresBotonesMas> {
  
  @override
  Widget build(BuildContext context) {
    final mapaFiltro=Provider.of<MapaFiltroGeneralesInfo>(context);
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    return Container(
      height: widget.heightContainerTexto,
      child:Row(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: widget.heightContainerTexto,
            width: widget.widthContainerTexto,
            child: Text(widget.texto,style: TextStyle(fontSize: 13),),
          ),
          Container(
            width: 150,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 25,
                  height: 25,
                  child:ElevatedButton(
                    onPressed: (){
                      _inmueblesFiltrado.setFiltrar(true);
                      if(mapaFiltro.getMapaFiltroMas[widget.clave]==1){
                        mapaFiltro.setMapaFiltroMasItem(widget.clave, 0);
                      }else{
                        mapaFiltro.setMapaFiltroMasItem(widget.clave, 1);
                      }
                    },
                    child: Text("1",style: TextStyle(fontSize: 13,color: mapaFiltro.getMapaFiltroMas[widget.clave]==1?Colors.white:Colors.blue),textAlign: TextAlign.right,),
                    style: ElevatedButton.styleFrom(
                        primary:mapaFiltro.getMapaFiltroMas[widget.clave]==1?Colors.blue:Colors.white,
                        elevation: 0,
                        shape: StadiumBorder(side: BorderSide(color:Colors.blue))
                    ),
                  ),
                ),
                SizedBox(
                  width: 25,
                  height: 25,
                  child: ElevatedButton(
                    onPressed: (){
                      _inmueblesFiltrado.setFiltrar(true);
                      if(mapaFiltro.getMapaFiltroMas[widget.clave]==2){
                        mapaFiltro.setMapaFiltroMasItem(widget.clave, 0);
                      }else{
                        mapaFiltro.setMapaFiltroMasItem(widget.clave, 2);
                      }
                    },
                    child: Text("2",style: TextStyle(fontSize: 13,color: mapaFiltro.getMapaFiltroMas[widget.clave]==2?Colors.white:Colors.blue),textAlign: TextAlign.right,),
                    style: ElevatedButton.styleFrom(
                        primary:mapaFiltro.getMapaFiltroMas[widget.clave]==2?Colors.blue:Colors.white,
                        elevation: 0,
                        shape: StadiumBorder(side: BorderSide(color:Colors.blue))
                    ),
                  ),
                ),
                SizedBox(
                  width: 25,
                  height: 25,
                  child: ElevatedButton(
                    onPressed: (){
                      _inmueblesFiltrado.setFiltrar(true);
                      if(mapaFiltro.getMapaFiltroMas[widget.clave]==3){
                        mapaFiltro.setMapaFiltroMasItem(widget.clave, 0);
                      }else{
                        mapaFiltro.setMapaFiltroMasItem(widget.clave, 3);
                      }
                    },
                    child: Text("3",style: TextStyle(fontSize: 13,color: mapaFiltro.getMapaFiltroMas[widget.clave]==3?Colors.white:Colors.blue),textAlign: TextAlign.right,),
                    style: ElevatedButton.styleFrom(
                        primary:mapaFiltro.getMapaFiltroMas[widget.clave]==3?Colors.blue:Colors.white,
                        elevation: 0,
                        shape: StadiumBorder(side: BorderSide(color:Colors.blue))
                    ),
                  ),
                ),
                SizedBox(
                  width: 25,
                  height: 25,
                  child: ElevatedButton(
                    onPressed: (){
                      _inmueblesFiltrado.setFiltrar(true);
                      if(mapaFiltro.getMapaFiltroMas[widget.clave]==4){
                        mapaFiltro.setMapaFiltroMasItem(widget.clave, 0);
                      }else{
                        mapaFiltro.setMapaFiltroMasItem(widget.clave, 4);
                      }
                    },
                    child: Text("4",style: TextStyle(fontSize: 13,color: mapaFiltro.getMapaFiltroMas[widget.clave]==4?Colors.white:Colors.blue),textAlign: TextAlign.right,),
                    style: ElevatedButton.styleFrom(
                        primary:mapaFiltro.getMapaFiltroMas[widget.clave]==4?Colors.blue:Colors.white,
                        elevation: 0,
                        shape: StadiumBorder(side: BorderSide(color:Colors.blue))
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                  height: 25,
                  child: ElevatedButton(
                    onPressed: (){
                      _inmueblesFiltrado.setFiltrar(true);
                      if(mapaFiltro.getMapaFiltroMas[widget.clave]==5){
                        mapaFiltro.setMapaFiltroMasItem(widget.clave, 0);
                      }else{
                        mapaFiltro.setMapaFiltroMasItem(widget.clave, 5);
                      }
                    },
                    child: Text("5+",style: TextStyle(fontSize: 13,color:mapaFiltro.getMapaFiltroMas[widget.clave]==5?Colors.white:Colors.blue),textAlign: TextAlign.right,),
                    style: ElevatedButton.styleFrom(
                        primary:mapaFiltro.getMapaFiltroMas[widget.clave]==5?Colors.blue:Colors.white,
                        elevation: 0,
                        shape: StadiumBorder(side: BorderSide(color:Colors.blue))
                    ),
                  ),
                ),
                
              ],
            )
          ),
        ],
      ),
    );
  }
}