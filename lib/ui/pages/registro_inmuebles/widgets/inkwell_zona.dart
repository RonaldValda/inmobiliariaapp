import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/pages/registro_inmuebles/widgets/mapa_registro_inmueble.dart';
import 'package:inmobiliariaapp/ui/provider/inmueble_info.dart';
import 'package:provider/provider.dart';
class InkWellZona extends StatefulWidget {
  InkWellZona({Key? key}) : super(key: key);

  @override
  _InkWellZonaState createState() => _InkWellZonaState();
}

class _InkWellZonaState extends State<InkWellZona> {
  final color=Colors.grey;
  final colorFill=Colors.white12;
  @override
  Widget build(BuildContext context) {
    final inmuebleInfo=Provider.of<InmuebleInfo>(context);
    return  InkWell(
      child: Container(
        padding: EdgeInsets.zero,
        height:70,
        child: Column(
          children: [
            Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Zona",
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
                padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
                margin: EdgeInsets.fromLTRB(0, 2, 0, 2),
                decoration: BoxDecoration(
                  border: Border.all(color: color.withOpacity(0.7),width: 1),
                  borderRadius: BorderRadius.circular(5),
                  color: colorFill
                ),
                child:Row(
                  children: [
                    Text(inmuebleInfo.getInmuebleTotalCopia.getInmueble.getNombreZona),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap:(){
        showModalBottomSheet(
          shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20),),
          ),
          elevation: 50,
          context: context,
          isDismissible: true,
          builder: (context) {
            return MapaRegistroInmueble(
              inmueble:inmuebleInfo.getInmuebleTotalCopia.getInmueble
            );
          },
        );
      }
    );
  }
}