import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/usecases/generales/usecase_generales.dart';
import 'package:inmobiliariaapp/domain/entities/generales.dart';
import 'package:inmobiliariaapp/ui/pages/registro_zona/page_registro_zona.dart';
import 'package:inmobiliariaapp/widgets/textField_modelos.dart';
class PageRegistroCiudades extends StatefulWidget {
  PageRegistroCiudades({Key? key}) : super(key: key);

  @override
  _PageRegistroCiudadesState createState() => _PageRegistroCiudadesState();
}

class _PageRegistroCiudadesState extends State<PageRegistroCiudades> {
  List<Ciudad> ciudades=[];
  List<Departamento> departamentos=[];
  int dSelected=-1;
  int cSelected=-1;
  UseCaseGenerales useCaseGenerales=UseCaseGenerales();
  @override
  void initState() {
    super.initState();
    useCaseGenerales.obtenerDepartamentos().then((value) {
      if(value["completed"]){
        departamentos=value["departamentos"];
        departamentos.sort((a,b)=>a.nombreDepartamento.compareTo(b.nombreDepartamento));
        setState(() {
          
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de ciudades"),
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children:[
            Text("Departamentos",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: departamentos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    selected: dSelected==index,
                    tileColor: (index+1)%2==0?Colors.black.withOpacity(0.04):Colors.transparent,
                    title: Text(departamentos[index].nombreDepartamento),
                    trailing: IconButton(
                      onPressed: (){
                        if(ciudades.length==0){
                          useCaseGenerales.eliminarDepartamento(departamentos[index].id).then((value) {
                            if(value){
                              departamentos.removeAt(index);
                              departamentos.sort((a,b)=>a.nombreDepartamento.compareTo(b.nombreDepartamento));
                              setState(() {
                                
                              });
                            }
                          });
                        }
                      }, 
                      icon: Icon(Icons.delete,color:Colors.redAccent)
                    ),
                    onTap: (){
                      if(index==dSelected){
                        dSelected=-1;
                        cSelected=-1;
                        ciudades=[];
                        setState(() {
                          
                        });
                      }else{
                        dSelected=index;
                        cSelected=-1;
                        useCaseGenerales.obtenerCiudades(departamentos[index].id).then((value){
                          if(value["completed"]){
                            ciudades=value["ciudades"];
                            ciudades.sort((a,b)=>a.nombreCiudad.compareTo(b.nombreCiudad));
                            setState(() {
                              
                            });
                          }else{
                            ciudades=[];
                            setState(() {
                              
                            });
                          }
                        });
                      }
                    },
                  ); 
                },
              )
            ),
            Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: ()async{
                    try{
                      Map<String,dynamic> respuesta=await dialogRegistroCiudadDepartamento(context, "Departamento",dSelected>=0?"Modificar":"Registrar"); 
                      if(respuesta["confirmar"]){
                        if(dSelected>=0){
                          useCaseGenerales.modificarDepartamento(departamentos[dSelected].id,respuesta["nombre"]).then((value){
                            if(value){
                              departamentos[dSelected].nombreDepartamento=respuesta["nombre"];
                              departamentos.sort((a,b)=>a.nombreDepartamento.compareTo(b.nombreDepartamento));
                              setState(() {
                                
                              });
                            }
                          });
                        }else{
                          useCaseGenerales.registrarDepartamento(respuesta["nombre"]).then((value){
                            if(value["completed"]){
                              departamentos.add(value["departamento"]);
                              departamentos.sort((a,b)=>a.nombreDepartamento.compareTo(b.nombreDepartamento));
                              setState(() {
                                
                              });
                            }
                          });
                        }
                      }
                    }catch(e){

                    }
                  }, 
                  child: dSelected>=0?Text("Modificar"):Text("Registrar")
                )
              ],
            ),
            Divider(thickness: 2,),
            Text("Ciudades",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: ciudades.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    selected: cSelected==index,
                    tileColor: (index+1)%2==0?Colors.black.withOpacity(0.04):Colors.transparent,
                    title: Text(ciudades[index].nombreCiudad),
                    trailing: Container(
                      //color: Colors.red,
                      width: 100,
                      height:100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context){
                                    return PageRegistroZona(
                                      ciudad: ciudades[index]
                                    );
                                  }
                                )
                              );
                            }, 
                            icon: Icon(Icons.public,color: Colors.blue,)
                          ),
                          IconButton(
                            onPressed: (){
                              useCaseGenerales.eliminarCiudad(ciudades[index].id).then((value) {
                                if(value){
                                  ciudades.removeAt(index);
                                  ciudades.sort((a,b)=>a.nombreCiudad.compareTo(b.nombreCiudad));
                                  setState(() {
                                    
                                  });
                                }
                              });
                            }, 
                            icon: Icon(Icons.delete,color: Colors.redAccent,)
                          ),
                        ],
                      ),
                    ),
                    onTap: (){
                      if(cSelected==index){
                        cSelected=-1;
                      }else{
                        cSelected=index;
                      }
                      setState(() {
                        
                      });
                    },
                  ); 
                },
              )
            ),
            Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: ()async{
                    try{
                      Map<String,dynamic> respuesta=await dialogRegistroCiudadDepartamento(context, "Ciudad",cSelected>=0?"Modificar":"Registrar"); 
                      if(respuesta["confirmar"]){
                        if(cSelected>=0){
                          useCaseGenerales.modificarCiudad(ciudades[cSelected].id,respuesta["nombre"]).then((value){
                            if(value){
                              ciudades[cSelected].nombreCiudad=respuesta["nombre"];
                              ciudades.sort((a,b)=>a.nombreCiudad.compareTo(b.nombreCiudad));
                              setState(() {
                                
                              });
                            }
                          });
                        }else{
                          useCaseGenerales.registrarCiudad(departamentos[dSelected].id,respuesta["nombre"]).then((value){
                            if(value["completed"]){
                              ciudades.add(value["ciudad"]);
                              ciudades.sort((a,b)=>a.nombreCiudad.compareTo(b.nombreCiudad));
                              setState(() {
                                
                              });
                            }
                          });
                        }
                      }
                    }catch(e){

                    }
                  }, 
                  child: cSelected>=0?Text("Modificar"):Text("Registrar")
                )
              ],
            ),
            Divider(thickness: 2,),
          ]
        ),
      ),
    );
  }
}
Future<Map<String,dynamic>> dialogRegistroCiudadDepartamento(
  BuildContext context,
  String tipo,
  String operacion,
)async{
  Map<String,dynamic> map={};
  TextEditingController controller=TextEditingController(text:"");
 return await showDialog(
    barrierLabel: "",
    barrierDismissible: true,
    context: context,

    builder: (BuildContext ctx){
      return StatefulBuilder(

        builder: (BuildContext ctx,StateSetter setState){
          return SimpleDialog(
            //insetPadding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height/2, 0, 0),
            contentPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
            title: Center(child: Text(operacion+" "+tipo,style: TextStyle(fontSize: 20)),),
            children: [
              Container(
                padding: EdgeInsets.all(5),
                //width: 300,
                //height: 600,
                child: Column(
                  children:[
                    SizedBox(height:10),
                    TextFFBasico(
                      controller: controller, 
                      labelText: tipo,
                      onChanged: (x){
                        map["nombre"]=x;
                      }
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: (){
                            map["confirmar"]=true;
                            Navigator.pop(context,map);
                          }, 
                          child: Text(operacion)
                        ),
                        SizedBox(width: 10,),
                        OutlinedButton(
                          onPressed: (){
                            map["confirmar"]=false;
                            Navigator.pop(context,map);
                          }, 
                          child: Text("Cancelar",style: TextStyle(color: Colors.red),),
                        )
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