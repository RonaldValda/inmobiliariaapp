import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/data/repositories/usuario/super_usuario_repository_gql.dart';
import 'package:inmobiliariaapp/domain/entities/banco.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:inmobiliariaapp/domain/usecases/generales/usecase_banco.dart';
import 'package:inmobiliariaapp/domain/usecases/usuario/usecase_super_usuario.dart';
import 'package:inmobiliariaapp/ui/pages/banco/widgets/bancoItem.dart';
import 'package:inmobiliariaapp/ui/pages/banco/widgets/container_imagen_banco.dart';
import 'package:inmobiliariaapp/ui/pages/registro_inmuebles/widgets/grilla_imagenes.dart';
import 'package:inmobiliariaapp/ui/pages/registro_inmuebles/widgets/operaciones_imagenes.dart';
import 'package:inmobiliariaapp/widgets/textField_modelos.dart';
List<CuentaBanco> bancos=[];
class RegistroCuentasBancos extends StatefulWidget {
  const RegistroCuentasBancos({Key? key}) : super(key: key);

  @override
  _RegistroCuentasBancosState createState() => _RegistroCuentasBancosState();
}

class _RegistroCuentasBancosState extends State<RegistroCuentasBancos> {
   TextEditingController? controllerNumeroCuenta;
   TextEditingController? controllerNombreTitular;
   TextEditingController? controllerNombreBanco;
   List<dynamic> imagenLogo=[""];
   UseCaseSuperUsuario useCaseSuperUsuario=UseCaseSuperUsuario();
   UseCaseBanco useCaseBanco=UseCaseBanco();
  @override
  void initState() {
    super.initState();
    controllerNumeroCuenta=TextEditingController(text: "");
    controllerNombreBanco=TextEditingController(text: "");
    controllerNombreTitular=TextEditingController(text: "");
    useCaseBanco.obtenerCuentasBanco()
    .then((resultado){
      if(resultado["completado"]){
        bancos=resultado["cuentas_bancos"];
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("Registro cuentas de bancos"),
        actions: [
          IconButton(onPressed: (){
            setState(() {
              
            });
          }, icon: Icon(Icons.refresh))
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GridView.builder(
                  itemCount: bancos.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemBuilder: (context,index){
                    return BancoItem(banco: bancos[index]);
                  }
                )
            ),
            Column(
              children: [
                TextFFBasico(controller: controllerNumeroCuenta!, labelText: "Número cuenta", onChanged: (x){}),
                TextFFBasico(controller: controllerNombreTitular!, labelText: "Número titural cuenta", onChanged: (x){}),
                
                TextFFBasico(controller: controllerNombreBanco!, labelText: "Número banco", onChanged: (x){}),
                ContainerImagenBanco(imagenLogo: imagenLogo),
                BotonRegistrarBanco(
                  controllerNumeroCuenta: controllerNumeroCuenta!, 
                  controllerNombreTitular: controllerNombreTitular!, 
                  controllerNombreBanco: controllerNombreBanco!, 
                  imagenLogo: imagenLogo
                )
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
class BotonRegistrarBanco extends StatefulWidget {
  const BotonRegistrarBanco({Key? key,required this.controllerNumeroCuenta,
    required this.controllerNombreTitular,required this.controllerNombreBanco,
    required this.imagenLogo
  }) : super(key: key);
  final TextEditingController controllerNumeroCuenta;
  final TextEditingController controllerNombreTitular;
  final TextEditingController controllerNombreBanco;
  final List<dynamic> imagenLogo;

  @override
  _BotonRegistrarBancoState createState() => _BotonRegistrarBancoState();
}

class _BotonRegistrarBancoState extends State<BotonRegistrarBanco> {
  UseCaseBanco useCaseBanco=UseCaseBanco();
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ()async{
        String linkLogoBanco="";
        linkLogoBanco=await uploadFile(widget.imagenLogo);
        CuentaBanco cuentaBanco=CuentaBanco.vacio();
        cuentaBanco.numeroCuenta=widget.controllerNumeroCuenta.text;
        cuentaBanco.nombreBanco=widget.controllerNombreBanco.text;
        cuentaBanco.titular=widget.controllerNombreTitular.text;
        cuentaBanco.linkImagenLogo=linkLogoBanco;
        cuentaBanco.activo=true;
        useCaseBanco.registrarCuentaBanco(cuentaBanco)
        .then((resultado){
          if(resultado["completado"]){
            bancos.add(CuentaBanco.fromMap(resultado["cuenta_banco"]));
          }
        });
      }, 
      child: Text("Registrar")
    );
  }

  Future<String> uploadFile(List<dynamic> imagenes) async{
    firebase_storage.Reference? ref;
    String linkLogoBanco="";
    for(var img in imagenes){
      if(img is File){
        // ignore: unnecessary_cast
        ref=firebase_storage.FirebaseStorage.instance.ref().child('images/${(img as File).path}');
        await ref.putFile(img).whenComplete(() async{
          await ref!.getDownloadURL().then((value) {
            linkLogoBanco=value;
          });
        });
      }else{
        linkLogoBanco=img as String;
      }
    }
    return linkLogoBanco;
  }
}
class PageRegistroBancos extends StatefulWidget {
  PageRegistroBancos({Key? key}) : super(key: key);

  @override
  _PageRegistroBancosState createState() => _PageRegistroBancosState();
}

class _PageRegistroBancosState extends State<PageRegistroBancos> {
  List<Banco> bancos=[];
  TextEditingController? controllerNombreBanco;
  TextEditingController? controllerApp;
  TextEditingController? controllerWeb;
  TextEditingController? controllerPreAprobacion;
  dynamic imagen="";
  bool isGallery=true;
  bool loadingImage=false;
  int seleccionado=-1;
  Banco bancoSeleccionado=Banco.vacio();
  UseCaseBanco useCaseBanco=UseCaseBanco();
  @override
  void initState() {
    super.initState();
    controllerNombreBanco=TextEditingController(text: "");
    controllerApp=TextEditingController(text: "");
    controllerWeb=TextEditingController(text: "");
    controllerPreAprobacion=TextEditingController(text: "");
    useCaseBanco.obtenerBancos().then((value){
      if(value["completed"]){
        bancos=value["bancos"];
        setState(() {
          
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de bancos"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10,bottom: 0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: bancos.length,
                itemBuilder: (context, index) {
                  Banco banco=bancos[index];
                  return ListTile(
                    tileColor: (index+1)%2==0?Colors.black.withOpacity(0.05):Colors.transparent,
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(banco.linkLogoBanco),
                      minRadius: 30,
                      maxRadius: 30,
                      //radius: 30,
                    ),
                    title: Text("${banco.nombreBanco}"),
                    subtitle: Row(
                      children: [
                        IconButton(
                          onPressed: (){}, 
                          icon: Icon(Icons.apps_outlined)
                        ),
                        IconButton(
                          onPressed: (){}, 
                          icon: Icon(Icons.web)
                        ),
                        IconButton(
                          onPressed: (){}, 
                          icon: Icon(Icons.domain_verification_sharp)
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.delete,color:Colors.red),
                    onTap: (){
                      if(seleccionado==index){
                        seleccionado=-1;
                        bancoSeleccionado=Banco.vacio();
                        controllerNombreBanco!.text="";
                        controllerApp!.text="";
                        controllerWeb!.text="";
                        controllerPreAprobacion!.text="";
                        imagen="";
                      }else{
                        seleccionado=index;
                        bancoSeleccionado=Banco.copyWith(banco);
                        controllerNombreBanco!.text=banco.nombreBanco;
                        controllerApp!.text=banco.app;
                        controllerWeb!.text=banco.web;
                        controllerPreAprobacion!.text=banco.preAprobacion;
                        imagen=banco.linkLogoBanco;
                      }
                      setState(() {
                        
                      });
                    },
                  );
                },
              )
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/1.8,
                    child: Column(
                      children: [
                        TextFFBasico(
                          controller: controllerNombreBanco!, 
                          labelText: "Nombre banco", 
                          onChanged: (x){}
                        ),
                        SizedBox(height: 5,),
                        TextFFBasico(
                          controller: controllerWeb!, 
                          labelText: "Web", 
                          onChanged: (x){}
                        ),
                        SizedBox(height: 5,),
                        TextFFBasico(
                          controller: controllerApp!, 
                          labelText: "App", 
                          onChanged: (x){}
                        ),
                        SizedBox(height: 5,),
                        TextFFBasico(
                          controller: controllerPreAprobacion!, 
                          labelText: "Pre aprobación", 
                          onChanged: (x){}
                        ),
                        SizedBox(height: 5,),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.width/2.5,
                    width: MediaQuery.of(context).size.width/2.5,
                    child: Stack(
                      children: [
                        (imagen as String!="")?Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.3),
                            image: DecorationImage(
                              image: NetworkImage(imagen),
                              fit: BoxFit.fitHeight,
                              scale: 1.5
                            )
                          ),
                        ):Container(
                            color: Colors.grey.withOpacity(.3),
                        ),
                        loadingImage?Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,

                          ),
                        ):Container(),
                        Container(
                          margin: EdgeInsets.all(10),
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.black45,
                            
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: onPressedUploadImage,
                            icon: Icon(Icons.upload,color: Colors.white,)
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: (){
                Banco banco=Banco.vacio();
                banco.id=bancoSeleccionado.id;
                banco.nombreBanco=controllerNombreBanco!.text;
                banco.linkLogoBanco=imagen.toString();
                banco.app=controllerApp!.text;
                banco.web=controllerWeb!.text;
                banco.preAprobacion=controllerPreAprobacion!.text;
                if(seleccionado<0){
                  
                  useCaseBanco.registrarBanco(banco).then((value){
                    
                    if(value["completed"]){
                      banco.id=value["id"];
                      bancos.add(banco);
                      setState(() {
                        
                      });
                    }
                  });
                }else{
                  useCaseBanco.modificarBanco(banco).then((resultado) {
                    if(resultado["completado"]){
                      bancos.removeAt(seleccionado);
                      bancos.add(banco);
                      setState(() {
                        
                      });
                    }
                  });
                }
              }, 
              child: Text(seleccionado<0?"Registrar":"Modificar"))
          ],
        ),
      ),
    );
  }
  void onPressedUploadImage() async{
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
        imagen=value;
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