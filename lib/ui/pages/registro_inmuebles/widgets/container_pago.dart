
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/data/configuration/graphql_configuration.dart';
import 'package:inmobiliariaapp/data/repositories/usuario/super_usuario_repository_gql.dart';
import 'package:inmobiliariaapp/domain/entities/banco.dart';
import 'package:inmobiliariaapp/domain/usecases/generales/usecase_banco.dart';
import 'package:inmobiliariaapp/ui/pages/registro_inmuebles/widgets/grilla_imagenes.dart';
import 'package:inmobiliariaapp/ui/pages/registro_inmuebles/widgets/operaciones_imagenes.dart';
import 'package:inmobiliariaapp/widgets/popup_menu_cuenta_banco.dart';
import 'package:inmobiliariaapp/ui/provider/inmueble_info.dart';
import 'package:inmobiliariaapp/widgets/textField_modelos.dart';
import 'package:provider/provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
class ContainerPago extends StatefulWidget {
  ContainerPago({Key? key}) : super(key: key);
  @override
  _ContainerPagoState createState() => _ContainerPagoState();
}

class _ContainerPagoState extends State<ContainerPago> {
  bool uploading=false;
  final picker=ImagePicker();
  double heigthImagen=0;
  double widthImagen=0;
  bool isGallery=true;
  bool loadingImage=false;
  TextEditingController? controllerNumeroDeposito;
  TextEditingController? controllerNombreDepositante;
  List<CuentaBanco> bancos=[];
  dynamic imagen="";
  UseCaseBanco useCaseBanco=UseCaseBanco();
  @override
  void initState() {
    super.initState();
    controllerNumeroDeposito=TextEditingController(text: "");
    controllerNombreDepositante=TextEditingController(text: "");
    useCaseBanco.obtenerCuentasBanco()
    .then((resultado){
      if(resultado["completado"]){
        bancos=resultado["cuentas_bancos"];
        setState(() {
          
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final inmuebleInfo=Provider.of<InmuebleInfo>(context);
    //print(imagen);
    if(imagen.toString()==""){
      imagen=inmuebleInfo.inmuebleTotalCopia.inmuebleComprobante.linkImagenDeposito;
    }
    heigthImagen=MediaQuery.of(context).size.height/1.7;
    widthImagen=MediaQuery.of(context).size.width/1.1;
    return Container(
      //color: Colors.blueGrey.withOpacity(0.1),
      child:Expanded(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  inmuebleInfo.inmuebleTotalCopia.inmueble.categoria.toUpperCase()=="PRO"?Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "- Se permiten imágenes ilimitadas."
                      ),
                      Text(
                        "- No se permiten video 2D."
                      ),
                      Text(
                        "- No se permiten tour virtual 360."
                      ),
                      Text(
                        "- No se permiten video tour 360."
                      ),
                    ],
                  ):Text("Sin restricciones"),
                  SizedBox(height: 10,),
                  TextFFBasico(
                    controller: controllerNumeroDeposito!, 
                    labelText: "Número de transacción", 
                    onChanged: (x){
                      inmuebleInfo.inmuebleTotalCopia.inmuebleComprobante.numeroTransaccion=x.toString();
                    }
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFFBasico(
                    controller: controllerNombreDepositante!, 
                    labelText: "Nombre depositante", 
                    onChanged: (x){
                      inmuebleInfo.inmuebleTotalCopia.inmuebleComprobante.nombreDepositante=x.toString();
                    }
                  ),
                  SizedBox(height: 5,),
                  PopupMenuCuentaBanco(cuentaBanco: inmuebleInfo.inmuebleTotal.inmuebleComprobante.cuentaBanco,bancos: bancos,
                    heightContainer: 70,
                    widthEtiqueta: MediaQuery.of(context).size.width,
                    widthContainer: MediaQuery.of(context).size.width
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Stack(
              //fit: StackFit.passthrough,
              alignment: Alignment.center,
              children: [
                (imagen as String)!=""?Container(
                  height: heigthImagen,
                  width:widthImagen,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.3),
                    image: DecorationImage(
                      image: NetworkImage(imagen),
                      fit: BoxFit.cover,
                      scale: 1.5
                    )
                  ),
                ):Container(
                  height: heigthImagen,
                  width:widthImagen,
                  color: Colors.grey.withOpacity(.3),
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
                      onPressed: (){onPressedUploadImage(inmuebleInfo);},
                      icon: Icon(Icons.upload,color: Colors.white,)
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      )
    );
  }
  void onPressedUploadImage(InmuebleInfo inmuebleInfo) async{
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
      inmuebleInfo.inmuebleTotalCopia.inmuebleComprobante.linkImagenDeposito=value;
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