import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/domain/entities/usuario.dart';
import 'package:inmobiliariaapp/domain/usecases/usuario/usecase_usuario.dart';
import 'package:inmobiliariaapp/ui/provider/inmueble_info.dart';
import 'package:inmobiliariaapp/widgets/textField_modelos.dart';
import 'package:provider/provider.dart';
class InkWellPropietario extends StatefulWidget {
  InkWellPropietario({Key? key}) : super(key: key);

  @override
  _InkWellPropietarioState createState() => _InkWellPropietarioState();
}

class _InkWellPropietarioState extends State<InkWellPropietario> {
  final color=Colors.grey;
  final colorFill=Colors.white12;
  @override
  Widget build(BuildContext context) {
    final inmuebleInfo=Provider.of<InmuebleInfo>(context);
    return  InkWell(
      child: Container(
        padding: EdgeInsets.zero,
        height:140,
        child: Column(
          children: [
            Container(
              //padding: EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Email (Propietario)",
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
                    Text(inmuebleInfo.getInmuebleTotalCopia.getPropietario.correo),
                  ],
                ),
              ),
            ),
            Container(
              //padding: EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Nombres y apellidos (Propietario)",
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
                    Text(inmuebleInfo.getInmuebleTotalCopia.getPropietario.nombres+" "+inmuebleInfo.getInmuebleTotalCopia.getPropietario.apellidos),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap:()async{
        Usuario usuario=Usuario.vacio();
        usuario=await dialogBuscarUsuario(context, "Buscar propietario del inmueble");
        if(usuario.id!=""){
          InmuebleTotal inmuebleTotal=inmuebleInfo.getInmuebleTotalCopia;
          inmuebleTotal.propietario=usuario;
          inmuebleInfo.setInmuebleTotalCopia(inmuebleTotal);
          print(inmuebleInfo.getInmuebleTotalCopia.propietario.nombres);
          print(inmuebleInfo.getInmuebleTotal.propietario.nombres);
        }
      }
    );
  }
}
Future<Usuario> dialogBuscarUsuario(
  BuildContext context,
  String titulo
)async{
  TextEditingController _controller=TextEditingController();
  String texto="";
  Usuario usuario=Usuario.vacio();
  UseCaseUsuario useCaseUsuario=UseCaseUsuario();
 return await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext ctx){
      return StatefulBuilder(
        builder: (BuildContext ctx,StateSetter setState){
          return SimpleDialog(
            contentPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
            title: Center(child: Text(titulo,style: TextStyle(fontSize: 20)),),
            children: [
              Container(
                width: 250,
                //height: 200,
                child: Column(
                  children:[
                    SizedBox(height:10),
                    Text(texto,
                      style: TextStyle(
                        color: Colors.red,
                        fontStyle: FontStyle.italic
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFFBasico(
                            controller: _controller, 
                            labelText: "Email", 
                            onChanged: (x){
                              
                            }
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OutlinedButton(
                                onPressed: (){
                                  useCaseUsuario.buscarUsuarioEmail(_controller.text)
                                  .then((resultado){
                                    if(resultado["completado"]){
                                      usuario=resultado["usuario"];
                                      Navigator.pop(context,usuario);
                                    }else{
                                      texto=resultado["memsaje_error"];
                                    }
                                  });
                                }, 
                                child: Row(
                                  children: [
                                    Text("Buscar"),
                                    Icon(Icons.search,color:Colors.blue)
                                  ],
                                )
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              OutlinedButton(
                                onPressed: (){
                                  Navigator.pop(context,Usuario.vacio());
                                }, 
                                child: Row(
                                  children: [
                                    Text("Cancelar",style: TextStyle(color: Colors.red),),
                                    Icon(Icons.cancel,color:Colors.red)
                                  ],
                                )
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
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