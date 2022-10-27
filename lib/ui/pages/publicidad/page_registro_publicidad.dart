import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/generals.dart';
import 'package:inmobiliariaapp/domain/entities/publicity.dart';
import 'package:inmobiliariaapp/ui/pages/publicidad/widgets/dropdown_selectores.dart';
import 'package:inmobiliariaapp/widgets/f_text_fields.dart';

import '../../../data/services/images_repository.dart';
import '../../../device/image_utils.dart';
import '../../../domain/usecases/general/usecase_publicity.dart';
class PageRegistroPublicidad extends StatefulWidget {
  PageRegistroPublicidad({Key? key}) : super(key: key);

  @override
  _PageRegistroPublicidadState createState() => _PageRegistroPublicidadState();
}

class _PageRegistroPublicidadState extends State<PageRegistroPublicidad> {
  List<Publicity> publicidades=[];
  Publicity publicidadSeleccionado=Publicity.empty();
  TextEditingController? controllerDescripcion;
  TextEditingController? controllerWeb;
  TextEditingController? controllerMesesVigencia;
  bool isGallery=true;
  bool loadingImage=false;
  int mesesVigencia=0;
  City ciudad=City.empty();
  List<City> ciudades=[];
  UseCasePublicity useCasePublicidad=UseCasePublicity();
  @override
  void initState() {
    super.initState();
    controllerDescripcion=TextEditingController(text: "");
    controllerWeb=TextEditingController(text: "");
    controllerMesesVigencia=TextEditingController(text: "0");
    useCasePublicidad.getPublicities()
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
                                  imageUrl: publicidad.publicityImageLink,
                                  
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    
                                    Text(publicidad.maxPrice<0?
                                    "Precio: Cualquiera":publicidad.maxPrice==publicidad.minPrice?"250000 a más":"Precio: ${publicidad.minPrice} - ${publicidad.maxPrice}"),
                                    Text("Tipo inmueble: ${publicidad.propertyType}"),
                                    Text("Tipo contrato: ${publicidad.contractType}"),
                                    Text("Tipo publicidad: ${publicidad.publicityType}"),
                                    Text("Descripción: ${publicidad.publicityDescription}"),
                                    Text("Link web: ${publicidad.publicityWebLink}"),
                                    Text("Fecha creación: ${publicidad.creationDate}"),
                                    Text("Fecha vencimiento: ${publicidad.expirationDate}"),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            if(publicidadSeleccionado.id==publicidad.id){
                                              publicidadSeleccionado=Publicity.empty();
                                              controllerDescripcion!.text="";
                                              controllerWeb!.text="";
                                              controllerMesesVigencia!.text="0";
                                            }else{
                                              publicidadSeleccionado=Publicity.copyWith(publicidad);
                                              controllerDescripcion!.text=publicidad.publicityDescription;
                                              controllerWeb!.text=publicidad.publicityWebLink;
                                              controllerMesesVigencia!.text=(((DateTime.parse(publicidad.expirationDate).difference(DateTime.parse(publicidad.creationDate)).inDays)~/30).toInt()).toString();
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
                                            useCasePublicidad.deletePublicity(publicidad.id)
                                            .then((resultado){
                                              if(resultado["completado"]){
                                                publicidades.removeWhere((element) => element.id==publicidad.id);
                                                publicidadSeleccionado=Publicity.empty();
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
                                value: publicidadSeleccionado.publicityType=="Cuadrado", 
                                onChanged: (value){
                                  publicidadSeleccionado.publicityType="Cuadrado";
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
                                value: publicidadSeleccionado.publicityType=="Rectángulo", 
                                onChanged: (value){
                                  publicidadSeleccionado.publicityType="Rectángulo";
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
                      FTextFieldBasico(
                        controller: controllerDescripcion!, 
                        labelText: "Descripción publicidad", 
                        onChanged: (x){
                          publicidadSeleccionado.publicityDescription=x;
                        }
                      ),
                      SizedBox(height: 4,),
                      FTextFieldBasico(
                        controller: controllerWeb!, 
                        labelText: "Link web", 
                        onChanged: (x){
                          publicidadSeleccionado.publicityWebLink=x;
                        }
                      ),
                      SizedBox(height: 4,),
                      FTextFieldBasico(
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
                            child: publicidadSeleccionado.publicityImageLink!=""?
                            CachedNetworkImage(
                              width: MediaQuery.of(context).size.width/1.9,
                              height: MediaQuery.of(context).size.width/1.9,
                              imageUrl: publicidadSeleccionado.publicityImageLink,
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
                  useCasePublicidad.registerPublicity(publicidadSeleccionado, mesesVigencia)
                  .then((resultado){
                    if(resultado["completado"]){
                      publicidades.add(resultado["publicidad"]);
                      setState(() {
                        
                      });
                    }
                  });
                }else{
                  useCasePublicidad.updatePublicity(publicidadSeleccionado, mesesVigencia)
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
  void onPressedUploadImage(Publicity publicidad) async{
    /*final file=await ImageUtils.pickMedia(
      isGallery: isGallery,
      cropImage: cropCustomImage,
    );*/

    final file=await ImageUtils.uploadImage();
    if(file==null) return;

    setState(() {
      loadingImage=true;
      //widget.inmuebleTotal.solicitudAdministrador.inmuebleDarBaja.imagenDocumentoPropiedad=file; 
    });
    uploadImagen(file).then((value){
      //print(value);
      publicidad.publicityImageLink=value;
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