
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/data/configuration/graphql_configuration.dart';
import 'package:inmobiliariaapp/data/repositories/usuario/super_usuario_repository_gql.dart';
import 'package:inmobiliariaapp/domain/usecases/generales/usecase_publicidad.dart';
import 'package:inmobiliariaapp/domain/usecases/usuario/usecase_super_usuario.dart';
import 'package:inmobiliariaapp/widgets/textField_modelos.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
enum getTipoAd{
  banner,
  pantalla
}
class RegistroAds extends StatefulWidget {
  RegistroAds({Key? key}) : super(key: key);

  @override
  _RegistroAdsState createState() => _RegistroAdsState();
}

class _RegistroAdsState extends State<RegistroAds> {
  TextEditingController? controller;
  int tipoAd=0;
  List<List<String>> ads=[];
  UseCaseSuperUsuario useCaseSuperUsuario=UseCaseSuperUsuario();
  UseCasePublicidad useCasePublicidad=UseCasePublicidad();
  @override
  void initState() {
    super.initState();
    controller=TextEditingController(text: "");
    useCasePublicidad.obtenerAds()
    .then((resultado){
      if(resultado["completado"]){
        ads=resultado["ads"];
        setState(() {
          
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    //listarAds();
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de ADS"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 0.5,
                    color: Colors.black54,
                  );
                }, 
                itemCount: ads.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("ID: ${ads[index][0]}"),
                    subtitle: Text("Tipo: ${ads[index][1]}"),
                    trailing: IconButton(
                      onPressed: ()async{
                        useCasePublicidad.eliminarAd(ads[index][0])
                        .then((resultado){
                          if(resultado["completado"]){
                            ads.removeAt(index);
                            setState(() {
                              
                            });
                          }
                        });
                      }, icon: Icon(Icons.delete,color:Colors.red))
                  );
                }, 
              )
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.black38
                  )
                )
              ),
              padding: EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              height: 170,
              //color: Colors.black12,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text("Banner",style: TextStyle(fontSize: 13),),
                          ),
                          Container(
                            child: Radio<int>(
                              groupValue: tipoAd,
                              value: getTipoAd.banner.index,
                              onChanged: (value){
                                setState(() {
                                  tipoAd=value!;
                                });
                              }
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text("Pantalla",style: TextStyle(fontSize: 13),),
                          ),
                          Container(
                            child: Radio<int>(
                              groupValue: tipoAd,
                              value: getTipoAd.pantalla.index,
                              onChanged: (value){
                                setState(() {
                                  tipoAd=value!;
                                });
                              }
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextFFBasico(
                    controller: controller!, 
                    labelText: "ID AD:", 
                    onChanged: (x){

                    }
                  ),
                  ElevatedButton(
                    onPressed: (){
                      String tipoAds="";
                      if(tipoAd==getTipoAd.banner.index) tipoAds="Banner";
                      else tipoAds="Pantalla";
                      useCasePublicidad.registrarAd(controller!.text, tipoAds)
                      .then((resultado){
                        if(resultado["completado"]){
                          List<String> ad=[controller!.text,tipoAds];
                          ads.add(ad);
                          setState(() {
                            
                          });
                        }
                      });
                    }, 
                    child: Text("Registrar")
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}