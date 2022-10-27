
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/ui/common/buttons.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/pages/home/widgets/home/properties_mode_list.dart';
import 'package:inmobiliariaapp/ui/pages/home/widgets/home/properties_mode_map.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/widget_status_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../auxiliares/global_variables.dart';
List<PropertyTotal> inmueblesTotalGeneral=[];
class ContainerProperties extends StatefulWidget {
  ContainerProperties();

  @override
  _ContainerPropertiesState createState() => _ContainerPropertiesState();
}

class _ContainerPropertiesState extends State<ContainerProperties> {
  //final usuariosInfo=Provider.of<UsuariosInfo>(context);
 
  // ignore: unused_field
 //List<InmuebleTotal> _inmueblesTotal=[];
  ScrollController scrollController=ScrollController(initialScrollOffset: 100,keepScrollOffset: true,debugLabel: "Hola");
  List inmuebles=[];
  
  ScrollController? sc;
   InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  @override
  void initState() {
    print("iniciado.....");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<PropertiesProvider>().init(context: context)
      .whenComplete(() {
        setState(() {});
      }).catchError((error){
        setState(() {});
      });
    });
     super.initState();
    // if(!modoOffline)
    // _createInterstitialAd();
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
    final propertiesProvider=context.watch<PropertiesProvider>();
    final widgetStatusProvider=context.watch<WidgetStatusProvider>();
    if(propertiesProvider.loadingQueryDB){
       if(!modoOffline)_showInterstitialAd();
       return _wLoading();
    }
    if(propertiesProvider.errorQueryDB){
      return _widgetError();
    }
    return Container(
      child: Column(
        children: [
          if(widgetStatusProvider.seeMap) Expanded(child: MapaListado()),
          Visibility(
            visible: !widgetStatusProvider.seeMap,
            child:  Expanded(child: PropertiesModeList())
          ),
        ],
      ),
    );
  }

  Widget _wLoading(){
    return Container(
      color: ColorsDefault.colorBackgroud,
      child: Center(
        child: CupertinoActivityIndicator(
          radius: 40*SizeDefault.scaleHeight,
        ),
      ),
    );
  }

  Widget _widgetError(){
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 120*SizeDefault.scaleWidth,
              child: ButtonOutlinedPrimary(
                text: "Ver modo offline", 
                onPressed: (){

                }
              )
            ),
            Container(
              width: 120*SizeDefault.scaleWidth,
              child: ButtonPrimary(
                text: "Recargar", 
                onPressed: (){

                }
              )
            ),
          ],
        )
      ),
    );
  }
}
