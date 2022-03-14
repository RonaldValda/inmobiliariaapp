
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/domain/entities/usuarios_inmuebles_favoritos.dart';
import 'package:inmobiliariaapp/domain/usecases/inmueble/usecase_inmueble.dart';
import 'package:inmobiliariaapp/ui/pages/principal/page_home.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/lista_inmuebles.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_principales_info.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:provider/provider.dart';
import 'package:inmobiliariaapp/domain/usecases/inmueble/filtrado_inmuebles.dart' as filtrado_inmuebles;
List<InmuebleTotal> inmueblesTotalGeneral=[];
class PaginaListadoInmuebles extends StatefulWidget {
  PaginaListadoInmuebles();

  @override
  _PaginaListadoInmueblesState createState() => _PaginaListadoInmueblesState();
}

class _PaginaListadoInmueblesState extends State<PaginaListadoInmuebles> {
  //final usuariosInfo=Provider.of<UsuariosInfo>(context);
 
  // ignore: unused_field
 //List<InmuebleTotal> _inmueblesTotal=[];
  ScrollController scrollController=ScrollController(initialScrollOffset: 100,keepScrollOffset: true,debugLabel: "Hola");
  List inmuebles=[];
  
  ScrollController? sc;
   InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  bool error=false;
  bool loading=false;
  UseCaseInmueble useCaseInmueble=UseCaseInmueble();
  @override
  void initState() {
    print("iniciado.....");
    /*sc=new ScrollController();
     sc!.animateTo(12, duration: Duration(seconds: 1), curve: Curves.bounceInOut);
     sc!.addListener(() { 
       print("position ${sc!.offset}");
     });*/
     super.initState();
     if(!modoOffline)
     _createInterstitialAd();
    //_crudInmuebles.listarFavoritos(usuario.getId);
  }
  @override
  void dispose(){
    super.dispose();
  }
  
void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: InterstitialAd.testAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print('$ad loaded');
          _interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
          _interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error.');
          _numInterstitialLoadAttempts += 1;
          _interstitialAd = null;
          /*if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
            _createInterstitialAd();
          }*/
        },
      ));
  }
  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }
  @override
  Widget build(BuildContext context) {
    final _mapaFiltroPrincipales=Provider.of<MapaFiltroPrincipalesInfo>(context);
    final _usuario=Provider.of<UsuariosInfo>(context);
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    if(_inmueblesFiltrado.consultarBD){
      if(!modoOffline)_showInterstitialAd();
      loading=true;
      
      setState(() {
        
      });
      useCaseInmueble.listarInmuebles(_usuario.usuario,_usuario.tipoSesion, _mapaFiltroPrincipales.getMapaFiltro["ciudad"]).then((value) {
        error=value["error"];
        if(!error){
          inmueblesTotalGeneral=[];
          inmueblesTotalGeneral.addAll(value["inmuebles_total"]);
          publicidades=[];
          publicidades.addAll(value["publicidades"]);
          _inmueblesFiltrado.inmueblesBuscados=[];
          
          for(int i=0;i<_usuario.usuarioInmueblesBuscados.length;i++){
            Map<String,dynamic> mapFiltro={};
            mapFiltro.addAll(_usuario.usuarioInmueblesBuscados[i].toMap());
            mapFiltro.addAll({"fecha_penultimo_ingreso":_usuario.usuario.fechaPenultimoIngreso});
            _inmueblesFiltrado.inmueblesBuscados.addAll(filtrado_inmuebles.filtrarInmuebles(inmueblesTotalGeneral, mapFiltro));
          }
           _inmueblesFiltrado.inmueblesNuevos=[];
           UsuarioInmuebleBase base=_usuario.usuarioInmuebleBases.length>1?_usuario.usuarioInmuebleBases[1]:UsuarioInmuebleBase.vacio();
           Map<String,dynamic> mapFiltro={};
           mapFiltro.addAll(base.toMapFiltro());
           mapFiltro.addAll({"tipo_sesion":_usuario.tipoSesion});

          _inmueblesFiltrado.inmueblesNuevos.addAll(filtrado_inmuebles.filtrarInmuebles(inmueblesTotalGeneral, mapFiltro));
          _inmueblesFiltrado.filtrar=true;
          _inmueblesFiltrado.consultarBD=false;
          setState(() {
            loading=false;
          });
        }else{
          print("error");
        }
      });
    }
    return Container(
      child: widgetListadoInmuebleGQL(),
    );
  }
  widgetListadoInmuebleGQL(){
    return 
      loading?Container(
        child: Center(
          child: CircularProgressIndicator(
            
          ),
        ),
      ):
      error?Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),       
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.orange.withOpacity(0.5),
                      Colors.orangeAccent,
                    ],
                  ),
                  ),
                child: ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Text("Ver en modo Offline",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                        Icon(Icons.offline_bolt)
                    ],
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>( 
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  minimumSize: MaterialStateProperty.all(Size(150, 50)),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                    shadowColor:MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: (){
                    
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),       
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.black26,
                    ],
                  ),
                  ),
                child: ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Text("Recargar",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                        Icon(Icons.refresh)
                    ],
                  ),
                
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>( 
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  minimumSize: MaterialStateProperty.all(Size(150, 50)),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                    shadowColor:MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: (){
                    
                  },
                ),
              ),
            ],
          )
        ),
      ): Container(
      child:ListaInmuebles()
    );
  }
  
}
