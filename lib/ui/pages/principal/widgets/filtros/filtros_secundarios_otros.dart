import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/widgets/textField_modelos.dart';
import 'package:intl/intl.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/filtros_widgets.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_otros_info.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_por_usuario.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_super_usuario_info.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:provider/provider.dart';
class FiltrosSecundariosOtros extends StatefulWidget {
  FiltrosSecundariosOtros({Key? key}) : super(key: key);

  @override
  _FiltrosSecundariosOtrosState createState() => _FiltrosSecundariosOtrosState();
}

class _FiltrosSecundariosOtrosState extends State<FiltrosSecundariosOtros> {
  bool verificados=false;
  bool rebajados=false;
  bool guardados=false;
  bool verMas=false;
  double widthContainerTexto=180;
  double heightContainerTexto=25;
  double heightContainerTexto2=35;
  double heightContainerTexto3=60;
  double heightContainerTexto4=100;
  @override
  Widget build(BuildContext context) {
    final mapaFiltroOtros=Provider.of<MapaFiltroOtrosInfo>(context);
    final mapaFiltroPorUsuario=Provider.of<MapaFiltroPorUsuario>(context);
    return Container(
       child: Column(
         children: [
           WidgetsSelectoresSimples(texto: "Rebajados",mapaFiltro: mapaFiltroOtros, clave: "rebajados",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimples(texto: "Vistos",mapaFiltro: mapaFiltroPorUsuario,clave: "vistos",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimples(texto: "Revisados",mapaFiltro: mapaFiltroPorUsuario, clave: "doble_visto",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimples(texto: "Favoritos",mapaFiltro: mapaFiltroPorUsuario, clave: "favoritos",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimples(texto: "Verificados",mapaFiltro: mapaFiltroOtros, clave: "verificados",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
           
           
           Container(
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(0),
              //color: Colors.redAccent,
              //alignment: Alignment.centerRight,
              //width:40,
              height: 30,
              child: TextButton(
                onPressed: (){
                  setState(() {
                  verMas=!verMas;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.arrow_drop_down,color:Colors.black,),
                    //Text("Ver más")
                  ],
                )
              ),
            ),
           verMas?FiltrosSecundariosOtrosMas():Container(),
         ],
       ),
    );
  }
}
class FiltrosSecundariosOtrosMas extends StatefulWidget {
  FiltrosSecundariosOtrosMas({Key? key}) : super(key: key);

  @override
  _FiltrosSecundariosOtrosMasState createState() => _FiltrosSecundariosOtrosMasState();
}

class _FiltrosSecundariosOtrosMasState extends State<FiltrosSecundariosOtrosMas> {
  double widthContainerTexto=180;
  double heightContainerTexto=25;
  double heightContainerTexto2=35;
  double heightContainerTexto3=60;
  double heightContainerTexto4=100;
  // ignore: non_constant_identifier_names
  List<String> items_dias_360=["Cualquiera","0-9","10-19","20-29","30 a más"];
  // ignore: non_constant_identifier_names
  List<int> dias_360=[0,0,10,20,30];

   bool dropdownActivado=false;
   DateTime? pickedDate;
   var inputformat=DateFormat("dd-MM-yyyy");
    TextEditingController? _fechaInicialController;
    TextEditingController? _fechaFinalController;
  @override
  void initState() {
     pickedDate=DateTime.now();
     _fechaInicialController = new TextEditingController(text: "${pickedDate!.day.toString().padLeft(2,'0')}-${pickedDate!.month.toString().padLeft(2,'0')}-${pickedDate!.year.toString()}");
     _fechaFinalController = new TextEditingController(text: "${pickedDate!.day.toString().padLeft(2,'0')}-${pickedDate!.month.toString().padLeft(2,'0')}-${pickedDate!.year.toString()}");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final mapaFiltroOtros=Provider.of<MapaFiltroOtrosInfo>(context);
    final mapaFiltroPorUsuario=Provider.of<MapaFiltroPorUsuario>(context);
    final usuarioInfo=Provider.of<UsuariosInfo>(context);
    final mapaFiltroSuperUsuario=Provider.of<MapaFiltroSuperUsuarioInfo>(context);
    return Container(
       child: Column(
         children: [
           usuarioInfo.getUsuario.getId!=""?WidgetsSelectoresSimplesMas(texto: "Contactados",mapaFiltro: mapaFiltroPorUsuario, clave: "contactados",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto):Container(),
           usuarioInfo.getUsuario.getId!=""? WidgetsSelectoresSimplesMas(texto: "Negociado inicial",mapaFiltro: mapaFiltroOtros, clave: "negociado_inicial",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto):Container(),
           WidgetsSelectoresSimplesMas(texto: "Negociado avanzado",mapaFiltro: mapaFiltroOtros, clave: "negociado_avanzado",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimplesMas(texto: "Remates judiciales",mapaFiltro: mapaFiltroOtros, clave: "remates_judiciales",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
           
           
           WidgetsSelectoresSimplesMas(texto: "Imágenes 2D",mapaFiltro: mapaFiltroOtros, clave: "imagenes_2D",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimplesMas(texto: "Vídeo 2D",mapaFiltro: mapaFiltroOtros, clave: "video_2D",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimplesMas(texto: "Tour virtual 360",mapaFiltro: mapaFiltroOtros, clave: "tour_virtual_360",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimplesMas(texto: "Video tour 360",mapaFiltro: mapaFiltroOtros, clave: "video_tour_360",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
            Container(
             padding: EdgeInsets.all(0),
             height: heightContainerTexto3,
             child:Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(0),
                    margin: EdgeInsets.all(0),
                    alignment: Alignment.centerLeft,
                    height: heightContainerTexto2,
                    width: 120,
                    //color:Colors.greenAccent[100],
                    child: Text("Días en P360",style: TextStyle(fontSize: 13),),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        child: DropdownButton(
                          icon: Icon(Icons.arrow_drop_down,color: Colors.black,),
                          style: dropdownActivado?TextStyle(
                            color:  Colors.black,
                            
                          ):TextStyle(
                            color: Colors.black
                          ),
                          
                          onTap: (){
                            setState(() {
                              print("");
                              dropdownActivado=true;
                            });
                          },
                          dropdownColor: Colors.white70,
                          value: mapaFiltroOtros.getMapaFiltroMas["dias_P360_sel"].toString(),
                          onChanged: (String? value){
                            int index=items_dias_360.indexOf(value!);
                            index<items_dias_360.length-1?mapaFiltroOtros.setMapaFiltroMasItem2("dias_P360_min", dias_360[index],"dias_P360_max", (dias_360[index+1]-1))
                            :mapaFiltroOtros.setMapaFiltroMasItem2("dias_P360_min", dias_360[index],"dias_P360_max", dias_360[index]);
                            mapaFiltroOtros.setMapaFiltroMasItem("dias_P360_sel", value);
                            setState(() {
                              dropdownActivado=false;
                            });
                          },
                          items: items_dias_360
                          .map<DropdownMenuItem<String>>((String value) {
                            print(value);
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
                  ),
                ],
             ),
           ),
           usuarioInfo.usuario.tipoUsuario=="Gerente"?Column(
             children: [
               WidgetsSelectoresSimples(texto: "Vendidos",mapaFiltro: mapaFiltroSuperUsuario, clave: "vendido",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
               WidgetsSelectoresSimples(texto: "No vendidos",mapaFiltro: mapaFiltroSuperUsuario, clave: "no_vendido",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
              TextFFOnTap(
                controller: _fechaInicialController!,
                label: "Desde",
                onTap:(){
                  _pickDate(_fechaInicialController!);
                }
              ),
              SizedBox(
                height: 5,
              ),
              TextFFOnTap(
                controller: _fechaFinalController!,
                label: "Hasta",
                onTap:(){
                  _pickDate(_fechaFinalController!);
                }
              ),
             ],
           ):Container(),
           
         ],
       ),
    );
  }
  _pickDate(TextEditingController controller) async{
    DateTime? date=await showDatePicker(
      context: context, 
      initialDate: pickedDate!, 
      firstDate: DateTime(DateTime.now().year-5), 
      lastDate: DateTime(DateTime.now().year+5),
      //locale : const Locale("fr","FR")
    ); 
    if(date!=null){
     
      setState(() {
        pickedDate=date;
         controller.text="${pickedDate!.day.toString().padLeft(2,'0')}-${pickedDate!.month.toString().padLeft(2,'0')}-${pickedDate!.year.toString()}";
      });
      
    }
  }
}