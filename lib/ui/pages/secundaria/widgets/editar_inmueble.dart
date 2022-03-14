import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/domain/usecases/inmueble/usecase_inmueble_venta.dart';
import 'package:inmobiliariaapp/ui/pages/registro_inmuebles/page_registro_inmueble.dart';
import 'package:inmobiliariaapp/ui/provider/inmueble_info.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_otros_info.dart';
import 'package:provider/provider.dart';
class EditarInmueble extends StatefulWidget {
  EditarInmueble({Key? key}) : super(key: key);
  @override
  _EditarInmuebleState createState() => _EditarInmuebleState();
}

class _EditarInmuebleState extends State<EditarInmueble> {
  InmuebleTotal inmuebleTotal=InmuebleTotal.vacio();
  UseCaseInmuebleVenta useCaseInmuebleVenta=UseCaseInmuebleVenta();
  @override
  Widget build(BuildContext context) {
    final _mapaFiltroOtros=Provider.of<MapaFiltroOtrosInfo>(context);
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    final inmuebleInfo=Provider.of<InmuebleInfo>(context);
    return Container(
       child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           OutlinedButton(
              style: OutlinedButton.styleFrom(
                //shape: StadiumBorder()
              ),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context){
                      return PageRegistroInmueble(
                      );
                    }
                  )
                );
              }, 
              child: Text("Modificar Datos")
            ),
            SizedBox(
              width: 10,
            ),
            OutlinedButton(
            style: OutlinedButton.styleFrom(
              //shape: StadiumBorder()
            ),
            onPressed: ()async{
              inmuebleTotal=await dialogCambiarPrecio(context,inmuebleInfo.inmuebleTotalCopia);
                print(inmuebleTotal.getInmueble.getPrecio);
                //widget.inmuebleTotal.getInmueble.setPrecio(505);
                //_inmueblesFiltrado.setInmueblesItem(widget.inmuebleTotal, _mapaFiltroOtros.getMapaFiltroOrden, "Modificar");
                if(inmuebleTotal.getInmueble.getPrecio!=inmuebleTotal.getInmueble.historialPrecios[inmuebleInfo.inmuebleTotalCopia.getInmueble.historialPrecios.length-1]){
                  inmuebleTotal.getInmueble.getHistorialPrecios.add(inmuebleTotal.getInmueble.getPrecio);
                  useCaseInmuebleVenta.actualizarPrecioInmueble(inmuebleInfo.inmuebleTotalCopia.getInmueble.id, inmuebleInfo.inmuebleTotalCopia.getInmueble.precio)
                  .then((resultado){
                    if(resultado["completado"]){
                      _inmueblesFiltrado.setInmueblesItem(inmuebleTotal, _mapaFiltroOtros.getMapaFiltroOrden,"Modificar");
                    }
                  });
                }
            }, 
            child: Text("Bajar Precio")
          ),
            
         ],
       ),
    );
  }
}
Future<InmuebleTotal> dialogCambiarPrecio(
  BuildContext context,
  InmuebleTotal inmuebleTotal
)async{
  TextEditingController _controller=TextEditingController();
 return await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext ctx){
      return StatefulBuilder(
        builder: (BuildContext ctx,StateSetter setState){
          return SimpleDialog(
            contentPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
            title: const Center(child: Text("Cambio de precio",style: TextStyle(fontSize: 20)),),
            children: [
              Container(
                width: 250,
                height: 150,
                child: Column(
                  children:[
                    SizedBox(height:10),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nuevo Precio:",
                            style:TextStyle(
                              color:Colors.black54,
                              fontWeight: FontWeight.w600
                            )
                          ),
                          TextField(
                            controller: _controller,
                          ),
                          
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            InmuebleTotal inmueble=inmuebleTotal;
                            inmueble.getInmueble.setPrecio(int.parse(_controller.text));
                            //inmuebleTotal.getInmueble.setPrecio();
                            //inmuebleTotal.getInmueble.precio=int.parse(_controller.text);
                            Navigator.pop(context,inmuebleTotal);
                          }, 
                          child: Text("Confirmar"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green
                          ),
                        ),
                      ],
                    )
                  ]
                ),
              )
            ],
          );
        }
      );
    }
  ); 
}
class DialogBajaPrecio extends StatelessWidget {
  const DialogBajaPrecio({Key? key,required this.inmuebleTotal}) : super(key: key);
  final InmuebleTotal inmuebleTotal;
  
  @override
  Widget build(BuildContext context) {
    return Container();
    
  }
}