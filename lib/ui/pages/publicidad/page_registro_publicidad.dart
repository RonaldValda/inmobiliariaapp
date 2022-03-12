import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/generales.dart';
import 'package:inmobiliariaapp/domain/entities/publicidad.dart';
import 'package:inmobiliariaapp/domain/usecases/generales/usecase_publicidad.dart';
import 'package:inmobiliariaapp/ui/pages/registro_inmuebles/widgets/grilla_imagenes.dart';
import 'package:inmobiliariaapp/ui/pages/registro_inmuebles/widgets/operaciones_imagenes.dart';
import 'package:inmobiliariaapp/ui/pages/publicidad/widgets/dropdown_selectores.dart';
import 'package:inmobiliariaapp/widgets/textField_modelos.dart';
class PageRegistroPublicidad extends StatefulWidget {
  PageRegistroPublicidad({Key? key}) : super(key: key);

  @override
  _PageRegistroPublicidadState createState() => _PageRegistroPublicidadState();
}

class _PageRegistroPublicidadState extends State<PageRegistroPublicidad> {
  List<Publicidad> publicidades=[];
  Publicidad publicidadSeleccionado=Publicidad.vacio();
  TextEditingController? controllerDescripcion;
  TextEditingController? controllerWeb;
  TextEditingController? controllerMesesVigencia;
  bool isGallery=true;
  bool loadingImage=false;
  int mesesVigencia=0;
  Ciudad ciudad=Ciudad.vacio();
  List<Ciudad> ciudades=[];
  UseCasePublicidad useCasePublicidad=UseCasePublicidad();
  @override
  void initState() {
    super.initState();
    controllerDescripcion=TextEditingController(text: "");
    controllerWeb=TextEditingController(text: "");
    controllerMesesVigencia=TextEditingController(text: "0");
    useCasePublicidad.obtenerPublicidades()
    .then((resultado){
      if(resultado["completado"]){
        publicidades=resultado["publicidades"];
        setState(() {
          
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de publicidad"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 5,right: 5,left: 5,bottom: 0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount:publicidades.length,
                itemBuilder: (context, index) {
                  var publicidad=publicidades[index];
                  return Card(
                    child: Container(
                      color: publicidadSeleccionado.id==publicidad.id?Colors.blue.withOpacity(0.2):Colors.white,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                color: Colors.grey.withOpacity(0.2),
                                child: CachedNetworkImage(
                                  
                                  width: MediaQuery.of(context).size.width/2,
                                  height: MediaQuery.of(context).size.width/2,
                                  imageUrl: publicidad.linkImagenPublicidad,
                                  
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    
                                    Text(publicidad.precioMax<0?
                                    "Precio: Cualquiera":publicidad.precioMax==publicidad.precioMin?"250000 a más":"Precio: ${publicidad.precioMin} - ${publicidad.precioMax}"),
                                    Text("Tipo inmueble: ${publicidad.tipoInmueble}"),
                                    Text("Tipo contrato: ${publicidad.tipoContrato}"),
                                    Text("Tipo publicidad: ${publicidad.tipoPublicidad}"),
                                    Text("Descripción: ${publicidad.descripcionPublicidad}"),
                                    Text("Link web: ${publicidad.linkWebPublicidad}"),
                                    Text("Fecha creación: ${publicidad.fechaCreacion}"),
                                    Text("Fecha vencimiento: ${publicidad.fechaVencimiento}"),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            if(publicidadSeleccionado.id==publicidad.id){
                                              publicidadSeleccionado=Publicidad.vacio();
                                              controllerDescripcion!.text="";
                                              controllerWeb!.text="";
                                              controllerMesesVigencia!.text="0";
                                            }else{
                                              publicidadSeleccionado=Publicidad.copyWith(publicidad);
                                              controllerDescripcion!.text=publicidad.descripcionPublicidad;
                                              controllerWeb!.text=publicidad.linkWebPublicidad;
                                              controllerMesesVigencia!.text=(((DateTime.parse(publicidad.fechaVencimiento).difference(DateTime.parse(publicidad.fechaCreacion)).inDays)~/30).toInt()).toString();
                                            }
                                            setState(() {
                                              
                                            });
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.blue[900],
                                          ),
                                        ),
                                        SizedBox(width: 20,),
                                        InkWell(
                                          onTap: (){
                                            useCasePublicidad.eliminarPublicidad(publicidad.id)
                                            .then((resultado){
                                              if(resultado["completado"]){
                                                publicidades.removeWhere((element) => element.id==publicidad.id);
                                                publicidadSeleccionado=Publicidad.vacio();
                                                controllerDescripcion!.text="";
                                                controllerWeb!.text="";
                                                controllerMesesVigencia!.text="0";
                                                setState(() {
                                                  
                                                });
                                              }
                                            })
                                            ;
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.redAccent,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            ),
            Container(
              height:MediaQuery.of(context).size.height/3,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1,
                    color: Colors.black26
                  )
                )
              ),
              child: ListView(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                          Row(
                            children: [
                              Text("Cuadrado"),
                              Checkbox(
                                value: publicidadSeleccionado.tipoPublicidad=="Cuadrado", 
                                onChanged: (value){
                                  publicidadSeleccionado.tipoPublicidad="Cuadrado";
                                  setState(() {
                                    
                                  });
                                }
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text("Rectángulo"),
                              Checkbox(
                                value: publicidadSeleccionado.tipoPublicidad=="Rectángulo", 
                                onChanged: (value){
                                  publicidadSeleccionado.tipoPublicidad="Rectángulo";
                                  setState(() {
                                    
                                  });
                                }
                              )
                            ],
                          ),
                        ],
                      ),
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DropdownTipoContratoPublicidad(publicidad: publicidadSeleccionado),
                          SizedBox(width: 5,),
                          DropdownTipoInmueblePublicidad(publicidad: publicidadSeleccionado),
                          SizedBox(width: 5,),
                          DropdownPrecioPublicidad(publicidad: publicidadSeleccionado),
                          SizedBox(width: 5,),
                          DropdownCiudadPublicidad(publicidad: publicidadSeleccionado)
                        ],
                      ),
                      SizedBox(height: 4,),
                      TextFFBasico(
                        controller: controllerDescripcion!, 
                        labelText: "Descripción publicidad", 
                        onChanged: (x){
                          publicidadSeleccionado.descripcionPublicidad=x;
                        }
                      ),
                      SizedBox(height: 4,),
                      TextFFBasico(
                        controller: controllerWeb!, 
                        labelText: "Link web", 
                        onChanged: (x){
                          publicidadSeleccionado.linkWebPublicidad=x;
                        }
                      ),
                      SizedBox(height: 4,),
                      TextFFBasico(
                        controller: controllerMesesVigencia!, 
                        labelText: "Meses vigencia", 
                        onChanged: (x){
                          mesesVigencia=int.parse(x);
                        }
                      ),
                      SizedBox(height: 4,),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width/1.9,
                            height: MediaQuery.of(context).size.width/1.9,
                            color: Colors.grey,
                            child: publicidadSeleccionado.linkImagenPublicidad!=""?
                            CachedNetworkImage(
                              width: MediaQuery.of(context).size.width/1.9,
                              height: MediaQuery.of(context).size.width/1.9,
                              imageUrl: publicidadSeleccionado.linkImagenPublicidad,
                            ):Container(),
                          ),
                          loadingImage?Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,

                            ),
                          ):Container(),
                          Positioned(
                            top: 0,
                            left:20,
                            child: Container(
                              margin: EdgeInsets.all(10),
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.black45,
                                
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: (){
                                  onPressedUploadImage(publicidadSeleccionado);
                                },
                                icon: Icon(Icons.upload,color: Colors.white,)
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: (){
                if(publicidadSeleccionado.id==""){
                  useCasePublicidad.registrarPublicidad(publicidadSeleccionado, mesesVigencia)
                  .then((resultado){
                    if(resultado["completado"]){
                      publicidades.add(resultado["publicidad"]);
                      setState(() {
                        
                      });
                    }
                  });
                }else{
                  useCasePublicidad.modificarPublicidad(publicidadSeleccionado, mesesVigencia)
                  .then((resultado){
                    if(resultado["completado"]){
                      publicidades.removeWhere((element) => element.id==publicidadSeleccionado.id);
                      publicidades.add(resultado["publicidad"]);
                      setState(() {
                        
                      });
                    }else{

                    }
                  });
                }
              }, 
              child: Text(publicidadSeleccionado.id==""?"Registrar":"Modificar")
            )
          ],
        ),
      ),
    );
  }
  void onPressedUploadImage(Publicidad publicidad) async{
    final file=await ImageUtils.pickMedia(
      isGallery: isGallery,
      cropImage: cropCustomImage,
    );
    if(file==null) return;

    setState(() {
      loadingImage=true;
      //widget.inmuebleTotal.solicitudAdministrador.inmuebleDarBaja.imagenDocumentoPropiedad=file; 
    });
    uploadImagen(file).then((value){
      //print(value);
      publicidad.linkImagenPublicidad=value;
    }).onError((error, stackTrace) {
      loadingImage=false;
      setState(() {
        
      });
    }).whenComplete(() {
      setState(() {
        loadingImage=false;
      });
    });
  }
}