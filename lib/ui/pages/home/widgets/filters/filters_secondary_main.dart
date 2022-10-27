import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/common/buttons.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_general_provider.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../../provider/home/filter_main_provider.dart';
import '../dialog_registro_inmueble_buscado.dart';
import 'filter_secondary_general.dart';
import 'filters_secondary_comunity.dart';
import 'filters_secondary_internal.dart';
import 'filters_secondary_others.dart';
class FiltersSecondaryMain extends StatefulWidget {
  FiltersSecondaryMain({Key? key}) : super(key: key);

  @override
  _FiltersSecondaryMainState createState() => _FiltersSecondaryMainState();
}

class _FiltersSecondaryMainState extends State<FiltersSecondaryMain> {
  bool activadoGenerales=true;
  bool activadoInternas=true;
  bool activadoComunidad=true;
  bool activadoOtros=true;
  double altura=300;
  @override
  Widget build(BuildContext context) {
    final filterGeneralProvider=context.watch<FilterGeneralProvider>();
    final filterMainProvider=context.watch<FilterMainProvider>();
    final userProvider=Provider.of<UserProvider>(context);
    return Container(
      padding: EdgeInsets.all(0),
      width: 600,
      height: MediaQuery.of(context).size.height*0.7,
      //color: Colors.yellow.withOpacity(0.8),
       child: Column(
         children: [
           Expanded(
             child: ListView(
               scrollDirection: Axis.vertical,
               children: [
                 /*Material(
                   borderOnForeground: true,
                   shadowColor: Colors.red,
                   elevation: 10,
                   color: Colors.amberAccent,
                   child: Text("data"),
                 ),*/
                 ElevatedButton(
                   child: Row(
                     children:[
                      Text("Generales",style: TextStyle(color:Colors.indigo),),
                     ],
                   ),
                   onPressed: (){
                     setState(() {
                       activadoGenerales=!activadoGenerales;
                       altura=activadoGenerales?500:300;
                     });
                   },
                   style: ElevatedButton.styleFrom(
                      primary:Colors.white,
                      shadowColor: Colors.indigo,
                      textStyle: TextStyle(
                        color: Colors.white,
                        decorationColor: Colors.red,
                        fontStyle: FontStyle.normal
                      ),
                      elevation: 0,
                      shape: StadiumBorder(side: BorderSide(color: Colors.orange))
                    ),
                 ),
                 activadoGenerales?FiltersSecondaryGeneral(mapFiltro: filterGeneralProvider.mapFilter,):Container(),
                 ElevatedButton(
                   child: Row(
                     children:[
                      Text("Características internas",style: TextStyle(color:Colors.blueGrey),),
                     ],
                   ),
                   onPressed: (){
                     setState(() {
                       activadoInternas=!activadoInternas;
                       altura=activadoInternas?500:300;
                     });
                   },
                   style: ElevatedButton.styleFrom(
                      primary:Colors.white,
                      shadowColor: Colors.indigo,
                      textStyle: TextStyle(
                        color: Colors.white,
                        decorationColor: Colors.red,
                        fontStyle: FontStyle.normal
                      ),
                      elevation: 0,
                      shape: StadiumBorder(side: BorderSide(color: Colors.orange))
                    ),
                 ),
                 activadoInternas?FiltersSecondaryInternal():Container(),
                 ElevatedButton(
                   child: Row(
                     children:[
                      Text("Comunidad",style: TextStyle(color:Colors.blueGrey),),
                     ],
                   ),
                   onPressed: (){
                     setState(() {
                       activadoComunidad=!activadoComunidad;
                     });
                   },
                   style: ElevatedButton.styleFrom(
                      primary:Colors.white,
                      shadowColor: Colors.indigo,
                      textStyle: TextStyle(
                        color: Colors.white,
                        decorationColor: Colors.red,
                        fontStyle: FontStyle.normal
                      ),
                      elevation: 0,
                      shape: StadiumBorder(side: BorderSide(color: Colors.orange))
                    ),
                 ),
                 activadoComunidad?FiltersSecondaryComunity():Container(),
                 ElevatedButton(
                   child: Row(
                     children:[
                      Text("Otros",style: TextStyle(color:Colors.blueGrey),),
                     ],
                   ),
                   onPressed: (){
                     setState(() {
                       activadoOtros=!activadoOtros;
                     });
                   },
                   style: ElevatedButton.styleFrom(
                      primary:Colors.white,
                      shadowColor: Colors.indigo,
                      textStyle: TextStyle(
                        color: Colors.white,
                        decorationColor: Colors.red,
                        fontStyle: FontStyle.normal
                      ),
                      elevation: 0,
                      shape: StadiumBorder(side: BorderSide(color: Colors.orange))
                    ),
                 ),
                 activadoOtros?FiltersSecondaryOthers():Container(),
               ],
             ),
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
              SizedBox(
                height: 40*SizeDefault.scaleWidth,
                width: 100*SizeDefault.scaleWidth,
                child: ButtonPrimary(
                  text: "Limpiar", 
                  onPressed: ()async{
                    filterMainProvider.cleanAllFilters(context: context);
                    /*filterMainProvider.mapFilter["zone"]="Cualquiera";
                    filterGeneralProvider.init();
                    filterInternalProvider.init();
                    filterComunityProvider.init();
                    filterOthersProvider.init(); 
                    filterUserProvider.init();
                    _inmueblesFiltrado.filtroBuscadoSeleccionado=-1;*/
                 },
                ),
              ),
              if(userProvider.getSubscribed()=="Suscrito")
              Container(
                margin: EdgeInsets.only(left: 10*SizeDefault.scaleWidth),
                height: 40*SizeDefault.scaleWidth,
                width: 100*SizeDefault.scaleWidth,
                child: ButtonPrimary(
                  text: "Guardar", 
                  onPressed: ()async{
                   await dialogRegistroInmuebleBuscado(context);
                 },
                ),
              ),
             ],
           ),
            
         ],
       )
    );
  }
}
