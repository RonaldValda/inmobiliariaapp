import 'package:device_information/device_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inmobiliariaapp/auxiliares/version_app.dart';
import 'package:inmobiliariaapp/domain/entities/publicidad.dart';
import 'package:inmobiliariaapp/domain/entities/usuario.dart';
import 'package:inmobiliariaapp/domain/entities/usuarios_inmuebles_favoritos.dart';
import 'package:inmobiliariaapp/domain/usecases/generales/usecase_generales.dart';
import 'package:inmobiliariaapp/domain/usecases/inmueble/usecase_inmueble_base.dart';
import 'package:inmobiliariaapp/domain/usecases/usuario/usecase_super_usuario.dart';
import 'package:inmobiliariaapp/domain/usecases/usuario/usecase_usuario.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/body_principal.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/app_bar.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/drawer_menu.dart';
import 'package:inmobiliariaapp/ui/provider/datos_generales_info.dart';
import 'package:inmobiliariaapp/ui/provider/estado_widgets.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
String email="";
bool respuesta=false;
int paginaActual=0;
List<Publicidad> publicidades=[];
bool modoOffline=true;
class PageHome extends StatefulWidget {
  PageHome({Key? key}) : super(key: key);
  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  String _platformVersion = 'Unknown',
      _imeiNo = "",
      _modelName = "",
      _manufacturerName = "",
      _deviceName = "",
      _productName = "",
      _cpuType = "",
      _hardware = "";
  var _apiLevel;
  // ignore: unused_field
  int _selectedDrawerItem=0;
  Usuario  usuario1=Usuario.vacio();
  UsuarioInmuebleBase baseVisto=UsuarioInmuebleBase.vacio();
  UsuarioInmuebleBase baseDobleVisto=UsuarioInmuebleBase.vacio();
  UsuarioInmuebleBase baseFavorito=UsuarioInmuebleBase.vacio();
  VersionAPP versionAPP=VersionAPP.vacio();
  Future<SharedPreferences> _prefs=SharedPreferences.getInstance();
  UseCaseGenerales useCaseGenerales=UseCaseGenerales();
  UseCaseSuperUsuario useCaseSuperUsuario=UseCaseSuperUsuario();
  UseCaseUsuario useCaseUsuario=UseCaseUsuario();
  UseCaseInmuebleBase useCaseInmuebleBase=UseCaseInmuebleBase();
  late Future<int> _counter;
  late Future<Usuario> usuario;
  late UsuariosInfo usuariosInfo;
  late DatosGeneralesInfo datosGeneralesInfo;
  late ListadoInmueblesFiltrado inmueblesFiltrado;
  bool error=false;
  bool versionCorrecta=true;
  String texto="";
  @override
  void initState() {
    super.initState();
    _counter=_prefs.then((SharedPreferences prefs){
      return (prefs.getInt("counter")??0);
    });
    initPlatformState();
    useCaseGenerales.obtenerVersionApp().then((value){
      error=value["error"];
      if(!error){
        versionAPPActual=value["versionApp"];
        versionCorrecta=!versionAPP.verificarVersion(versionAPPActual);
        modoOffline=false;
      }else{
        modoOffline=true;
      }
      print("TERMINA VERSIION");
      useCaseInmuebleBase.buscarInmuebleBaseShared(_prefs)
      .then((resultado){
        baseVisto=resultado["base_visto"];
        baseDobleVisto=resultado["base_doble_visto"];
        baseFavorito=resultado["base_favorito"];
        email=resultado["email"];
        if(email!=""){
          setState(() {
            
          });
        }
      })
      .whenComplete(() {
        print("termina buscar");
       useCaseUsuario.autenticarUsuarioAutomatico(email,_imeiNo,baseVisto,baseDobleVisto,baseFavorito).then((value) {
         Map<String,dynamic> map=value;
         print("termina auntenticar");
         WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
           print("termina auntenticar");
            usuariosInfo = Provider.of<UsuariosInfo>(context, listen: false);
            //inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context,listen: false);
            //inmueblesFiltrado.consultarBD=true;
            usuariosInfo.usuario=(map["usuario"]);
            if(usuariosInfo.usuario.tipoUsuario=="Super Usuario"){
              useCaseSuperUsuario.obtenerNotificacionesExisteSuperUsuario(usuariosInfo.usuario).then((value) {
                if(value["completado"]){
                  usuariosInfo.existeNotificacion=value["existe_notificacion"];
                }

              });
            }
            if(usuariosInfo.usuario.getCorreo!=""){
              usuariosInfo.sesionIniciada=true;
              usuariosInfo.setTipoSesion(usuariosInfo.usuario, false);
            }
            usuariosInfo.setMembresiaPagos(map["agentePagos"]);
            usuariosInfo.setMembresiaPagoActual(map["agentePagoActual"]);
            //print(map["usuarioInmuebleBases"]);
            usuariosInfo.setUsuarioInmuebleBases(map["usuarioInmuebleBases"]);
            if(usuariosInfo.getSuscrito()=="Suscrito"){
              useCaseUsuario.obtenerUsuarioInmueblesBuscados(usuariosInfo.usuario).then((value) {
                if(value["completado"]){
                  usuariosInfo.setUsuarioInmueblesBuscados(value["usuario_inmuebles_buscados"]);
                }
              });
            }
          });
          useCaseGenerales.obtenerGeneralesLugares().then((value) {
            datosGeneralesInfo=Provider.of<DatosGeneralesInfo>(context,listen:false);
            if(value["completado"]){
              datosGeneralesInfo.setCiudades(value["ciudades"]);
              datosGeneralesInfo.setZonas(value["zonas"]);
              
            }
            final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context,listen: false);
            _inmueblesFiltrado.consultarBD=true;
            _inmueblesFiltrado.filtrar=true;
            print("llega");
            setState(() {
              
            });
         });
       });
     });
    });
  }
  Future<void> initPlatformState() async {
    late String platformVersion,
        imeiNo = '',
        modelName = '',
        manufacturer = '',
        deviceName = '',
        productName = '',
        cpuType = '',
        hardware = '';
    var apiLevel;
    // Platform messages may fail,
    // so we use a try/catch PlatformException.
    try {
      print("hasta aqui");
      platformVersion = await DeviceInformation.platformVersion;
      imeiNo = await DeviceInformation.deviceIMEINumber;
      print("imei ${imeiNo.toString()}");
      modelName = await DeviceInformation.deviceModel;
      manufacturer = await DeviceInformation.deviceManufacturer;
      apiLevel = await DeviceInformation.apiLevel;
      deviceName = await DeviceInformation.deviceName;
      productName = await DeviceInformation.productName;
      cpuType = await DeviceInformation.cpuName;
      hardware = await DeviceInformation.hardware;
    } on PlatformException catch (e) {
      print("eroror ${e.message}");
      platformVersion = '${e.message}';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = "Running on :$platformVersion";
      _imeiNo = imeiNo;
      _modelName = modelName;
      _manufacturerName = manufacturer;
      _apiLevel = apiLevel;
      _deviceName = deviceName;
      _productName = productName;
      _cpuType = cpuType;
      _hardware = hardware;
    });
  }
  Future<void> _incrementCounter()async{
    final SharedPreferences prefs=await _prefs;
    
    final int counter=(prefs.getInt("counter")??0)+1;
    setState(() {
      _counter=prefs.setInt("counter", counter).then((bool success) {
        return counter;
      });
    });
  }
  Future<void> _buscarRegistro()async{
    final SharedPreferences prefs=await _prefs;
    final Usuario usuario=Usuario(
      id: (prefs.getString("id")??""),
      linkFoto: (prefs.getString("link_foto")??""),
      apellidos: (prefs.getString("apellidos")??""),
      nombres: (prefs.getString("nombres")??""),
      correo: (prefs.getString("email")??""),
      contrasenia: "",
      estadoCuenta: (prefs.getBool("estado_cuenta")??false),
      numeroTelefono: (prefs.getString("telefono")??""),
      tipoUsuario: (prefs.getString("tipo_usuario")??""),
      ciudad: (prefs.getString("ciudad")??""),
      nombreAgencia: (prefs.getString("nombre_agencia")??""),
      web: (prefs.getString("web")??""),
      verificado: (prefs.getBool("verificado")??false),
      metodoAutenticacion: (prefs.getString("metodo_autenticacion")??""),
      cantidadInmueblesCalificados: 0,
      fechaUltimoIngreso: "",
      fechaPenultimoIngreso: "",
      sumatoriaCalificacion: 0
    );
  }
  @override
  Widget build(BuildContext context) {
    //  _buscar();
    _imeiNo="16165162";
    final _estadoWidgets=Provider.of<EstadoWidgets>(context,);
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context); 
    //final usuariosInfo=Provider.of<UsuariosInfo>(context);
    //print("akdjakdas ${usuariosInfo.usuario.id}");
    return 
    !versionCorrecta?Scaffold(
        appBar:AppBar(
          title:Text(""+texto)
        ),
        body: Container(
          child: Center(child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              Text("Actualice la APP",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                height:10
              ),
              ElevatedButton(
                onPressed: (){
                  _incrementCounter();
                //launch(versionAPP.linkDescarga);
                }, child: Text("Descargar actualización")
              ),
              ElevatedButton(
                onPressed: ()async{
                  _prefs.then((value){ 
                    print(value.get("counter"));
                    value.remove("counter");});
                  final SharedPreferences prefs=await _prefs;
                  print(prefs.getInt("counter"));
                  final int counter=(prefs.getInt("counter")??0)+1;
                  setState(() {
                    _counter=prefs.setInt("counter", counter).then((bool success) {
                        return counter;
                      });
                  });
                //launch(versionAPP.linkDescarga);
                }, child: Text("Limpiar")
              )
            ],
          )),
        ),
      ):
      WillPopScope(
        onWillPop: () async {
          if(!_estadoWidgets.isVerMapa){
            if(_estadoWidgets.scrollControllerListaInmueble.offset==0){
              return true;
            }
            _inmueblesFiltrado.setConsultarBD(false);
            _inmueblesFiltrado.setFiltrar(true);
            _estadoWidgets.reiniciarScroll();
            return false;
          }else{
            _estadoWidgets.setVerMapa(false);
            return false;
          }
        },
        child: Scaffold(
          appBar: AppBarPzd(),
          drawer: DrawerMenu(),
          body:BodyPrincipal(),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          //floatingActionButton: ButtonFlotante(),
        ),
      );
  }
}