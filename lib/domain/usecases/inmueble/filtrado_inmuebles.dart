
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/domain/entities/usuarios_inmuebles_favoritos.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_otros_info.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_principales_info.dart';
List<UsuarioInmuebleBase> generarInmuebleBase(String idUsuario,List<InmuebleTotal> _inmueblesTotal){
  List<UsuarioInmuebleBase> usuarioInmuebleBases=[];
  
  List<InmuebleTotal> inmueblesAux=[];
  inmueblesAux.addAll(_inmueblesTotal);
  List<InmuebleTotal> inmueblesFavorito=[];
  List<InmuebleTotal> inmueblesVisto=[];
  List<InmuebleTotal> inmueblesDobleVisto=[];
  int precioMin=0;
  int precioMax=0;
  int dormitoriosMin=0;
  int dormitoriosMax=0;
  int baniosMin=0;
  int baniosMax=0;
  int garajeMin=0;
  int garajeMax=0;
  int superficieTerrenoMin=0,superficieTerrenoMax=0;
  int superficieConstruccionMin=0,superficieConstruccionMax=0;
  int tiempoConstruccionMin=0,tiempoConstruccionMax=0;
  int cantidadInmuebles=0,amoblado=0,lavanderia=0,cuartoLavado=0,churrasquero=0, azotea=0;
  int condominioPrivado=0,cancha=0,piscina=0,sauna=0,jacuzzi=0,estudio=0;
  int jardin=0,portonElectrico=0,aireAcondicionado=0,calefaccion=0;
  int ascensor=0,deposito=0,sotano=0,balcon=0,tienda=0,amuralladoTerreno=0;
  inmueblesFavorito.addAll(inmueblesAux.where((element) => element.getUsuarioFavorito.isFavorito));
  //inmueblesAux.removeWhere((element) => element.getUsuarioFavorito.isFavorito);
  
    if(inmueblesFavorito.length>0){
      inmueblesFavorito.sort((a,b)=>a.getInmueble.getPrecio.compareTo(b.getInmueble.getPrecio));
      precioMin=inmueblesFavorito.elementAt(0).getInmueble.getPrecio;
      precioMax=inmueblesFavorito.elementAt(inmueblesFavorito.length-1).getInmueble.getPrecio;
      inmueblesFavorito.sort((a,b)=>a.getInmueble.getSuperficieConstruccion.compareTo(b.getInmueble.getSuperficieConstruccion));
      superficieConstruccionMin=inmueblesFavorito.elementAt(0).getInmueble.getSuperficieConstruccion;
      superficieConstruccionMax=inmueblesFavorito.elementAt(inmueblesFavorito.length-1).getInmueble.getSuperficieConstruccion;
      inmueblesFavorito.sort((a,b)=>a.getInmueble.getSuperficieTerreno.compareTo(b.getInmueble.getSuperficieTerreno));
      superficieTerrenoMin=inmueblesFavorito.elementAt(0).getInmueble.getSuperficieTerreno;
      superficieTerrenoMax=inmueblesFavorito.elementAt(inmueblesFavorito.length-1).getInmueble.getSuperficieTerreno;
      inmueblesFavorito.sort((a,b)=>a.getInmueble.antiguedadConstruccion.compareTo(b.getInmueble.antiguedadConstruccion));
      tiempoConstruccionMin=inmueblesFavorito.elementAt(0).getInmueble.antiguedadConstruccion;
      tiempoConstruccionMax=inmueblesFavorito.elementAt(inmueblesFavorito.length-1).getInmueble.antiguedadConstruccion;
      inmueblesFavorito.sort((a,b)=>a.getInmuebleInternas.getDormitorios.compareTo(b.getInmuebleInternas.getDormitorios));
      dormitoriosMin=inmueblesFavorito.elementAt(0).getInmuebleInternas.getDormitorios;
      dormitoriosMax=inmueblesFavorito.elementAt(inmueblesFavorito.length-1).getInmuebleInternas.getDormitorios;
      inmueblesFavorito.sort((a,b)=>a.getInmuebleInternas.getBanios.compareTo(b.getInmuebleInternas.getBanios));
      baniosMin=inmueblesFavorito.elementAt(0).getInmuebleInternas.getBanios;
      baniosMax=inmueblesFavorito.elementAt(inmueblesFavorito.length-1).getInmuebleInternas.getBanios;
      inmueblesFavorito.sort((a,b)=>a.getInmuebleInternas.getGaraje.compareTo(b.getInmuebleInternas.getGaraje));
      garajeMin=inmueblesFavorito.elementAt(0).getInmuebleInternas.getGaraje;
      garajeMax=inmueblesFavorito.elementAt(inmueblesFavorito.length-1).getInmuebleInternas.getGaraje;
      cantidadInmuebles=inmueblesFavorito.length;
      inmueblesFavorito.sort((a,b)=>a.getInmuebleInternas.amoblado.toString().compareTo(b.getInmuebleInternas.amoblado.toString()));
      amoblado=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.amoblado);
      if(amoblado>cantidadInmuebles) amoblado=0;
      inmueblesFavorito.sort((a,b)=>a.getInmuebleInternas.lavanderia.toString().compareTo(b.getInmuebleInternas.lavanderia.toString()));
      lavanderia=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.lavanderia);
      if(lavanderia>cantidadInmuebles) lavanderia=0;
      inmueblesFavorito.sort((a,b)=>a.getInmuebleInternas.cuartoLavado.toString().compareTo(b.getInmuebleInternas.cuartoLavado.toString()));
      cuartoLavado=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.cuartoLavado);
      if(cuartoLavado>cantidadInmuebles) cuartoLavado=0;
      inmueblesFavorito.sort((a,b)=>a.getInmuebleInternas.churrasquero.toString().compareTo(b.getInmuebleInternas.churrasquero.toString()));
      churrasquero=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.churrasquero); 
      if(churrasquero>cantidadInmuebles) churrasquero=0;
      inmueblesFavorito.sort((a,b)=>a.getInmuebleInternas.azotea.toString().compareTo(b.getInmuebleInternas.azotea.toString()));
      azotea=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.azotea);
      if(azotea>cantidadInmuebles) azotea=0;
      inmueblesFavorito.sort((a,b)=>a.getInmuebleInternas.condominioPrivado.toString().compareTo(b.getInmuebleInternas.condominioPrivado.toString()));
      condominioPrivado=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.condominioPrivado);
      if(condominioPrivado>cantidadInmuebles) condominioPrivado=0;
      inmueblesFavorito.sort((a,b)=>a.getInmuebleInternas.cancha.toString().compareTo(b.getInmuebleInternas.cancha.toString()));
      cancha=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.cancha);
      if(cancha>cantidadInmuebles) cancha=0;
      inmueblesFavorito.sort((a,b)=>a.getInmuebleInternas.piscina.toString().compareTo(b.getInmuebleInternas.piscina.toString()));
      piscina=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.piscina);
      if(piscina>cantidadInmuebles) piscina=0;
      inmueblesFavorito.sort((a,b)=>a.getInmuebleInternas.sauna.toString().compareTo(b.getInmuebleInternas.sauna.toString()));
      sauna=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.sauna);
      if(sauna>cantidadInmuebles) sauna=0;
      inmueblesFavorito.sort((a,b)=>a.getInmuebleInternas.jacuzzi.toString().compareTo(b.getInmuebleInternas.jacuzzi.toString()));
      jacuzzi=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.jacuzzi);
      if(jacuzzi>cantidadInmuebles) jacuzzi=0;
      inmueblesFavorito.sort((a,b)=>a.getInmuebleInternas.estudio.toString().compareTo(b.getInmuebleInternas.estudio.toString()));
      estudio=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.estudio);
      if(estudio>cantidadInmuebles) estudio=0;
      inmueblesFavorito.sort((a,b)=>a.getInmuebleInternas.jardin.toString().compareTo(b.getInmuebleInternas.jardin.toString()));
      jardin=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.jardin);
      if(jardin>cantidadInmuebles) jardin=0;
      inmueblesFavorito.sort((a,b)=>a.getInmuebleInternas.portonElectrico.toString().compareTo(b.getInmuebleInternas.portonElectrico.toString()));
      portonElectrico=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.portonElectrico);
      if(portonElectrico>cantidadInmuebles) portonElectrico=0;
      inmueblesFavorito.sort((a,b)=>a.getInmuebleInternas.aireAcondicionado.toString().compareTo(b.getInmuebleInternas.aireAcondicionado.toString()));
      aireAcondicionado=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.aireAcondicionado);
      if(aireAcondicionado>cantidadInmuebles) aireAcondicionado=0;
      inmueblesFavorito.sort((a,b)=>a.getInmuebleInternas.calefaccion.toString().compareTo(b.getInmuebleInternas.calefaccion.toString()));
      calefaccion=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.calefaccion);
      if(calefaccion>cantidadInmuebles) calefaccion=0;
      inmueblesFavorito.sort((a,b)=>a.getInmuebleInternas.ascensor.toString().compareTo(b.getInmuebleInternas.ascensor.toString()));
      ascensor=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.ascensor);
      if(ascensor>cantidadInmuebles) ascensor=0;
      inmueblesFavorito.sort((a,b)=>a.getInmuebleInternas.deposito.toString().compareTo(b.getInmuebleInternas.deposito.toString()));
      deposito=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.deposito);
      if(deposito>cantidadInmuebles) deposito=0;
      inmueblesFavorito.sort((a,b)=>a.getInmuebleInternas.sotano.toString().compareTo(b.getInmuebleInternas.sotano.toString()));
      sotano=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.sotano);
      if(sotano>cantidadInmuebles) sotano=0;
      inmueblesFavorito.sort((a,b)=>a.getInmuebleInternas.balcon.toString().compareTo(b.getInmuebleInternas.balcon.toString()));
      balcon=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.balcon);
      if(balcon>cantidadInmuebles) balcon=0;
      inmueblesFavorito.sort((a,b)=>a.getInmuebleInternas.tienda.toString().compareTo(b.getInmuebleInternas.tienda.toString()));
      tienda=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.tienda);
      if(tienda>cantidadInmuebles) tienda=0;
      inmueblesFavorito.sort((a,b)=>a.getInmuebleInternas.amuralladoTerreno.toString().compareTo(b.getInmuebleInternas.amuralladoTerreno.toString()));
      amuralladoTerreno=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.amuralladoTerreno);
      if(amuralladoTerreno>cantidadInmuebles) amuralladoTerreno=0;
    }
    if(inmueblesFavorito.length>0){
      usuarioInmuebleBases.add(UsuarioInmuebleBase(
        id: idUsuario, dormitoriosMin:dormitoriosMin,tipo: "favorito",dormitoriosMax:dormitoriosMax,
        baniosMin:baniosMin,baniosMax:baniosMax,garajeMin:garajeMin,garajeMax:garajeMax,
        superficieTerrenoMin: superficieTerrenoMin,superficieTerrenoMax:superficieTerrenoMax,
        superficieConstruccionMin:superficieConstruccionMin,superficieConstruccionMax: superficieConstruccionMax,
        antiguedadConstruccionMin:tiempoConstruccionMin,antiguedadConstruccionMax:tiempoConstruccionMax,
        precioMin:precioMin,precioMax:precioMax,cantidadInmuebles: cantidadInmuebles,amoblado: amoblado,
        lavanderia: lavanderia,cuartoLavado: cuartoLavado,churrasquero: churrasquero,azotea: azotea,
        condominioPrivado: condominioPrivado,cancha: cancha,piscina: piscina,sauna: sauna,jacuzzi: jacuzzi,
        estudio: estudio,jardin: jardin, portonElectrico: portonElectrico, aireAcondicionado: aireAcondicionado,
        calefaccion: calefaccion, ascensor:ascensor, deposito: deposito, sotano: sotano, balcon: balcon,
        tienda: tienda,amuralladoTerreno: amuralladoTerreno,
        fechaInicio: "",fechaCache: "",fechaUltimoGuardado: ""));
    }else{
      usuarioInmuebleBases.add(UsuarioInmuebleBase.vacio(
      ));
      usuarioInmuebleBases[0].id=idUsuario;
    }
    inmueblesDobleVisto.addAll(inmueblesAux.where((element) => element.getUsuarioFavorito.isDobleVisto));
    //inmueblesAux.removeWhere((element) => element.getUsuarioFavorito.dobleVisto);
    if(inmueblesDobleVisto.length>0){
      inmueblesDobleVisto.sort((a,b)=>a.getInmueble.getPrecio.compareTo(b.getInmueble.getPrecio));
      precioMin=inmueblesDobleVisto.elementAt(0).getInmueble.getPrecio;
      precioMax=inmueblesDobleVisto.elementAt(inmueblesDobleVisto.length-1).getInmueble.getPrecio;
      inmueblesDobleVisto.sort((a,b)=>a.getInmueble.getSuperficieConstruccion.compareTo(b.getInmueble.getSuperficieConstruccion));
      superficieConstruccionMin=inmueblesDobleVisto.elementAt(0).getInmueble.getSuperficieConstruccion;
      superficieConstruccionMax=inmueblesDobleVisto.elementAt(inmueblesDobleVisto.length-1).getInmueble.getSuperficieConstruccion;
      inmueblesDobleVisto.sort((a,b)=>a.getInmueble.getSuperficieTerreno.compareTo(b.getInmueble.getSuperficieTerreno));
      superficieTerrenoMin=inmueblesDobleVisto.elementAt(0).getInmueble.getSuperficieTerreno;
      superficieTerrenoMax=inmueblesDobleVisto.elementAt(inmueblesDobleVisto.length-1).getInmueble.getSuperficieTerreno;
      inmueblesDobleVisto.sort((a,b)=>a.getInmueble.antiguedadConstruccion.compareTo(b.getInmueble.antiguedadConstruccion));
      tiempoConstruccionMin=inmueblesDobleVisto.elementAt(0).getInmueble.antiguedadConstruccion;
      tiempoConstruccionMax=inmueblesDobleVisto.elementAt(inmueblesDobleVisto.length-1).getInmueble.antiguedadConstruccion;
      inmueblesDobleVisto.sort((a,b)=>a.getInmuebleInternas.getDormitorios.compareTo(b.getInmuebleInternas.getDormitorios));
      dormitoriosMin=inmueblesDobleVisto.elementAt(0).getInmuebleInternas.getDormitorios;
      dormitoriosMax=inmueblesDobleVisto.elementAt(inmueblesDobleVisto.length-1).getInmuebleInternas.getDormitorios;
      inmueblesDobleVisto.sort((a,b)=>a.getInmuebleInternas.getBanios.compareTo(b.getInmuebleInternas.getBanios));
      baniosMin=inmueblesDobleVisto.elementAt(0).getInmuebleInternas.getBanios;
      baniosMax=inmueblesDobleVisto.elementAt(inmueblesDobleVisto.length-1).getInmuebleInternas.getBanios;
      inmueblesDobleVisto.sort((a,b)=>a.getInmuebleInternas.getGaraje.compareTo(b.getInmuebleInternas.getGaraje));
      garajeMin=inmueblesDobleVisto.elementAt(0).getInmuebleInternas.getGaraje;
      garajeMax=inmueblesDobleVisto.elementAt(inmueblesDobleVisto.length-1).getInmuebleInternas.getGaraje;
      cantidadInmuebles=inmueblesDobleVisto.length;
      inmueblesDobleVisto.sort((a,b)=>a.getInmuebleInternas.amoblado.toString().compareTo(b.getInmuebleInternas.amoblado.toString()));
      amoblado=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.amoblado);
      if(amoblado>cantidadInmuebles) amoblado=0;
      inmueblesDobleVisto.sort((a,b)=>a.getInmuebleInternas.lavanderia.toString().compareTo(b.getInmuebleInternas.lavanderia.toString()));
      lavanderia=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.lavanderia);
      if(lavanderia>cantidadInmuebles) lavanderia=0;
      inmueblesDobleVisto.sort((a,b)=>a.getInmuebleInternas.cuartoLavado.toString().compareTo(b.getInmuebleInternas.cuartoLavado.toString()));
      cuartoLavado=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.cuartoLavado);
      if(cuartoLavado>cantidadInmuebles) cuartoLavado=0;
      inmueblesDobleVisto.sort((a,b)=>a.getInmuebleInternas.churrasquero.toString().compareTo(b.getInmuebleInternas.churrasquero.toString()));
      churrasquero=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.churrasquero); 
      if(churrasquero>cantidadInmuebles) churrasquero=0;
      inmueblesDobleVisto.sort((a,b)=>a.getInmuebleInternas.azotea.toString().compareTo(b.getInmuebleInternas.azotea.toString()));
      azotea=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.azotea);
      if(azotea>cantidadInmuebles) azotea=0;
      inmueblesDobleVisto.sort((a,b)=>a.getInmuebleInternas.condominioPrivado.toString().compareTo(b.getInmuebleInternas.condominioPrivado.toString()));
      condominioPrivado=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.condominioPrivado);
      if(condominioPrivado>cantidadInmuebles) condominioPrivado=0;
      inmueblesDobleVisto.sort((a,b)=>a.getInmuebleInternas.cancha.toString().compareTo(b.getInmuebleInternas.cancha.toString()));
      cancha=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.cancha);
      if(cancha>cantidadInmuebles) cancha=0;
      inmueblesDobleVisto.sort((a,b)=>a.getInmuebleInternas.piscina.toString().compareTo(b.getInmuebleInternas.piscina.toString()));
      piscina=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.piscina);
      if(piscina>cantidadInmuebles) piscina=0;
      inmueblesDobleVisto.sort((a,b)=>a.getInmuebleInternas.sauna.toString().compareTo(b.getInmuebleInternas.sauna.toString()));
      sauna=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.sauna);
      if(sauna>cantidadInmuebles) sauna=0;
      inmueblesDobleVisto.sort((a,b)=>a.getInmuebleInternas.jacuzzi.toString().compareTo(b.getInmuebleInternas.jacuzzi.toString()));
      jacuzzi=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.jacuzzi);
      if(jacuzzi>cantidadInmuebles) jacuzzi=0;
      inmueblesDobleVisto.sort((a,b)=>a.getInmuebleInternas.estudio.toString().compareTo(b.getInmuebleInternas.estudio.toString()));
      estudio=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.estudio);
      if(estudio>cantidadInmuebles) estudio=0;
      inmueblesDobleVisto.sort((a,b)=>a.getInmuebleInternas.jardin.toString().compareTo(b.getInmuebleInternas.jardin.toString()));
      jardin=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.jardin);
      if(jardin>cantidadInmuebles) jardin=0;
      inmueblesDobleVisto.sort((a,b)=>a.getInmuebleInternas.portonElectrico.toString().compareTo(b.getInmuebleInternas.portonElectrico.toString()));
      portonElectrico=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.portonElectrico);
      if(portonElectrico>cantidadInmuebles) portonElectrico=0;
      inmueblesDobleVisto.sort((a,b)=>a.getInmuebleInternas.aireAcondicionado.toString().compareTo(b.getInmuebleInternas.aireAcondicionado.toString()));
      aireAcondicionado=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.aireAcondicionado);
      if(aireAcondicionado>cantidadInmuebles) aireAcondicionado=0;
      inmueblesDobleVisto.sort((a,b)=>a.getInmuebleInternas.calefaccion.toString().compareTo(b.getInmuebleInternas.calefaccion.toString()));
      calefaccion=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.calefaccion);
      if(calefaccion>cantidadInmuebles) calefaccion=0;
      inmueblesDobleVisto.sort((a,b)=>a.getInmuebleInternas.ascensor.toString().compareTo(b.getInmuebleInternas.ascensor.toString()));
      ascensor=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.ascensor);
      if(ascensor>cantidadInmuebles) ascensor=0;
      inmueblesDobleVisto.sort((a,b)=>a.getInmuebleInternas.deposito.toString().compareTo(b.getInmuebleInternas.deposito.toString()));
      deposito=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.deposito);
      if(deposito>cantidadInmuebles) deposito=0;
      inmueblesDobleVisto.sort((a,b)=>a.getInmuebleInternas.sotano.toString().compareTo(b.getInmuebleInternas.sotano.toString()));
      sotano=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.sotano);
      if(sotano>cantidadInmuebles) sotano=0;
      inmueblesDobleVisto.sort((a,b)=>a.getInmuebleInternas.balcon.toString().compareTo(b.getInmuebleInternas.balcon.toString()));
      balcon=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.balcon);
      if(balcon>cantidadInmuebles) balcon=0;
      inmueblesDobleVisto.sort((a,b)=>a.getInmuebleInternas.tienda.toString().compareTo(b.getInmuebleInternas.tienda.toString()));
      tienda=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.tienda);
      if(tienda>cantidadInmuebles) tienda=0;
      inmueblesDobleVisto.sort((a,b)=>a.getInmuebleInternas.amuralladoTerreno.toString().compareTo(b.getInmuebleInternas.amuralladoTerreno.toString()));
      amuralladoTerreno=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.amuralladoTerreno);
      if(amuralladoTerreno>cantidadInmuebles) amuralladoTerreno=0;
    }
    if(inmueblesDobleVisto.length>0){
      usuarioInmuebleBases.add(UsuarioInmuebleBase(
        id: idUsuario, dormitoriosMin:dormitoriosMin,tipo: "doble_visto",dormitoriosMax:dormitoriosMax,
        baniosMin:baniosMin,baniosMax:baniosMax,garajeMin:garajeMin,garajeMax:garajeMax,
        superficieTerrenoMin: superficieTerrenoMin,superficieTerrenoMax:superficieTerrenoMax,
        superficieConstruccionMin:superficieConstruccionMin,superficieConstruccionMax: superficieConstruccionMax,
        antiguedadConstruccionMin:tiempoConstruccionMin,antiguedadConstruccionMax:tiempoConstruccionMax,
        precioMin:precioMin,precioMax:precioMax,cantidadInmuebles: cantidadInmuebles,amoblado: amoblado,
        lavanderia: lavanderia,cuartoLavado: cuartoLavado,churrasquero: churrasquero,azotea: azotea,
        condominioPrivado: condominioPrivado,cancha: cancha,piscina: piscina,sauna: sauna,jacuzzi: jacuzzi,
        estudio: estudio,jardin: jardin, portonElectrico: portonElectrico, aireAcondicionado: aireAcondicionado,
        calefaccion: calefaccion, ascensor:ascensor, deposito: deposito, sotano: sotano, balcon: balcon,
        tienda: tienda,amuralladoTerreno: amuralladoTerreno,
        fechaInicio: "",fechaCache: "",fechaUltimoGuardado: ""));
    }else{
      usuarioInmuebleBases.add(UsuarioInmuebleBase.vacio(
      ));
      usuarioInmuebleBases[1].id=idUsuario;
    }
   
    inmueblesVisto.addAll(inmueblesAux.where((element) => element.getUsuarioFavorito.isVisto));
    //inmueblesAux.removeWhere((element) => element.getUsuarioFavorito.visto);
    if(inmueblesVisto.length>0){
      inmueblesVisto.sort((a,b)=>a.getInmueble.getPrecio.compareTo(b.getInmueble.getPrecio));
      precioMin=inmueblesVisto.elementAt(0).getInmueble.getPrecio;
      precioMax=inmueblesVisto.elementAt(inmueblesVisto.length-1).getInmueble.getPrecio;
      inmueblesVisto.sort((a,b)=>a.getInmueble.getSuperficieConstruccion.compareTo(b.getInmueble.getSuperficieConstruccion));
      superficieConstruccionMin=inmueblesVisto.elementAt(0).getInmueble.getSuperficieConstruccion;
      superficieConstruccionMax=inmueblesVisto.elementAt(inmueblesVisto.length-1).getInmueble.getSuperficieConstruccion;
      inmueblesVisto.sort((a,b)=>a.getInmueble.getSuperficieTerreno.compareTo(b.getInmueble.getSuperficieTerreno));
      superficieTerrenoMin=inmueblesVisto.elementAt(0).getInmueble.getSuperficieTerreno;
      superficieTerrenoMax=inmueblesVisto.elementAt(inmueblesVisto.length-1).getInmueble.getSuperficieTerreno;
      inmueblesVisto.sort((a,b)=>a.getInmueble.antiguedadConstruccion.compareTo(b.getInmueble.antiguedadConstruccion));
      tiempoConstruccionMin=inmueblesVisto.elementAt(0).getInmueble.antiguedadConstruccion;
      tiempoConstruccionMax=inmueblesVisto.elementAt(inmueblesVisto.length-1).getInmueble.antiguedadConstruccion;
      inmueblesVisto.sort((a,b)=>a.getInmuebleInternas.getDormitorios.compareTo(b.getInmuebleInternas.getDormitorios));
      dormitoriosMin=inmueblesVisto.elementAt(0).getInmuebleInternas.getDormitorios;
      dormitoriosMax=inmueblesVisto.elementAt(inmueblesVisto.length-1).getInmuebleInternas.getDormitorios;
      inmueblesVisto.sort((a,b)=>a.getInmuebleInternas.getBanios.compareTo(b.getInmuebleInternas.getBanios));
      baniosMin=inmueblesVisto.elementAt(0).getInmuebleInternas.getBanios;
      baniosMax=inmueblesVisto.elementAt(inmueblesVisto.length-1).getInmuebleInternas.getBanios;
      inmueblesVisto.sort((a,b)=>a.getInmuebleInternas.getGaraje.compareTo(b.getInmuebleInternas.getGaraje));
      garajeMin=inmueblesVisto.elementAt(0).getInmuebleInternas.getGaraje;
      garajeMax=inmueblesVisto.elementAt(inmueblesVisto.length-1).getInmuebleInternas.getGaraje;
      cantidadInmuebles=inmueblesVisto.length;
      inmueblesVisto.sort((a,b)=>a.getInmuebleInternas.amoblado.toString().compareTo(b.getInmuebleInternas.amoblado.toString()));
      amoblado=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.amoblado);
      if(amoblado>cantidadInmuebles) amoblado=0;
      inmueblesVisto.sort((a,b)=>a.getInmuebleInternas.lavanderia.toString().compareTo(b.getInmuebleInternas.lavanderia.toString()));
      lavanderia=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.lavanderia);
      if(lavanderia>cantidadInmuebles) lavanderia=0;
      inmueblesVisto.sort((a,b)=>a.getInmuebleInternas.cuartoLavado.toString().compareTo(b.getInmuebleInternas.cuartoLavado.toString()));
      cuartoLavado=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.cuartoLavado);
      if(cuartoLavado>cantidadInmuebles) cuartoLavado=0;
      inmueblesVisto.sort((a,b)=>a.getInmuebleInternas.churrasquero.toString().compareTo(b.getInmuebleInternas.churrasquero.toString()));
      churrasquero=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.churrasquero); 
      if(churrasquero>cantidadInmuebles) churrasquero=0;
      inmueblesVisto.sort((a,b)=>a.getInmuebleInternas.azotea.toString().compareTo(b.getInmuebleInternas.azotea.toString()));
      azotea=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.azotea);
      if(azotea>cantidadInmuebles) azotea=0;
      inmueblesVisto.sort((a,b)=>a.getInmuebleInternas.condominioPrivado.toString().compareTo(b.getInmuebleInternas.condominioPrivado.toString()));
      condominioPrivado=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.condominioPrivado);
      if(condominioPrivado>cantidadInmuebles) condominioPrivado=0;
      inmueblesVisto.sort((a,b)=>a.getInmuebleInternas.cancha.toString().compareTo(b.getInmuebleInternas.cancha.toString()));
      cancha=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.cancha);
      if(cancha>cantidadInmuebles) cancha=0;
      inmueblesVisto.sort((a,b)=>a.getInmuebleInternas.piscina.toString().compareTo(b.getInmuebleInternas.piscina.toString()));
      piscina=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.piscina);
      if(piscina>cantidadInmuebles) piscina=0;
      inmueblesVisto.sort((a,b)=>a.getInmuebleInternas.sauna.toString().compareTo(b.getInmuebleInternas.sauna.toString()));
      sauna=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.sauna);
      if(sauna>cantidadInmuebles) sauna=0;
      inmueblesVisto.sort((a,b)=>a.getInmuebleInternas.jacuzzi.toString().compareTo(b.getInmuebleInternas.jacuzzi.toString()));
      jacuzzi=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.jacuzzi);
      if(jacuzzi>cantidadInmuebles) jacuzzi=0;
      inmueblesVisto.sort((a,b)=>a.getInmuebleInternas.estudio.toString().compareTo(b.getInmuebleInternas.estudio.toString()));
      estudio=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.estudio);
      if(estudio>cantidadInmuebles) estudio=0;
      inmueblesVisto.sort((a,b)=>a.getInmuebleInternas.jardin.toString().compareTo(b.getInmuebleInternas.jardin.toString()));
      jardin=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.jardin);
      if(jardin>cantidadInmuebles) jardin=0;
      inmueblesVisto.sort((a,b)=>a.getInmuebleInternas.portonElectrico.toString().compareTo(b.getInmuebleInternas.portonElectrico.toString()));
      portonElectrico=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.portonElectrico);
      if(portonElectrico>cantidadInmuebles) portonElectrico=0;
      inmueblesVisto.sort((a,b)=>a.getInmuebleInternas.aireAcondicionado.toString().compareTo(b.getInmuebleInternas.aireAcondicionado.toString()));
      aireAcondicionado=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.aireAcondicionado);
      if(aireAcondicionado>cantidadInmuebles) aireAcondicionado=0;
      inmueblesVisto.sort((a,b)=>a.getInmuebleInternas.calefaccion.toString().compareTo(b.getInmuebleInternas.calefaccion.toString()));
      calefaccion=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.calefaccion);
      if(calefaccion>cantidadInmuebles) calefaccion=0;
      inmueblesVisto.sort((a,b)=>a.getInmuebleInternas.ascensor.toString().compareTo(b.getInmuebleInternas.ascensor.toString()));
      ascensor=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.ascensor);
      if(ascensor>cantidadInmuebles) ascensor=0;
      inmueblesVisto.sort((a,b)=>a.getInmuebleInternas.deposito.toString().compareTo(b.getInmuebleInternas.deposito.toString()));
      deposito=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.deposito);
      if(deposito>cantidadInmuebles) deposito=0;
      inmueblesVisto.sort((a,b)=>a.getInmuebleInternas.sotano.toString().compareTo(b.getInmuebleInternas.sotano.toString()));
      sotano=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.sotano);
      if(sotano>cantidadInmuebles) sotano=0;
      inmueblesVisto.sort((a,b)=>a.getInmuebleInternas.balcon.toString().compareTo(b.getInmuebleInternas.balcon.toString()));
      balcon=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.balcon);
      if(balcon>cantidadInmuebles) balcon=0;
      inmueblesVisto.sort((a,b)=>a.getInmuebleInternas.tienda.toString().compareTo(b.getInmuebleInternas.tienda.toString()));
      tienda=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.tienda);
      if(tienda>cantidadInmuebles) tienda=0;
      inmueblesVisto.sort((a,b)=>a.getInmuebleInternas.amuralladoTerreno.toString().compareTo(b.getInmuebleInternas.amuralladoTerreno.toString()));
      amuralladoTerreno=cantidadInmuebles-inmueblesVisto.indexWhere((element) => element.inmuebleInternas.amuralladoTerreno);
      if(amuralladoTerreno>cantidadInmuebles) amuralladoTerreno=0;
    }
    if(inmueblesVisto.length>0){
      usuarioInmuebleBases.add(UsuarioInmuebleBase(
        id: idUsuario, dormitoriosMin:dormitoriosMin,tipo: "visto",dormitoriosMax:dormitoriosMax,
        baniosMin:baniosMin,baniosMax:baniosMax,garajeMin:garajeMin,garajeMax:garajeMax,
        superficieTerrenoMin: superficieTerrenoMin,superficieTerrenoMax:superficieTerrenoMax,
        superficieConstruccionMin:superficieConstruccionMin,superficieConstruccionMax: superficieConstruccionMax,
        antiguedadConstruccionMin:tiempoConstruccionMin,antiguedadConstruccionMax:tiempoConstruccionMax,
        precioMin:precioMin,precioMax:precioMax,cantidadInmuebles: cantidadInmuebles,amoblado: amoblado,
        lavanderia: lavanderia,cuartoLavado: cuartoLavado,churrasquero: churrasquero,azotea: azotea,
        condominioPrivado: condominioPrivado,cancha: cancha,piscina: piscina,sauna: sauna,jacuzzi: jacuzzi,
        estudio: estudio,jardin: jardin, portonElectrico: portonElectrico, aireAcondicionado: aireAcondicionado,
        calefaccion: calefaccion, ascensor:ascensor, deposito: deposito, sotano: sotano, balcon: balcon,
        tienda: tienda,amuralladoTerreno: amuralladoTerreno,
        fechaInicio: "",fechaCache:"",fechaUltimoGuardado:""));
    }else{
      usuarioInmuebleBases.add(UsuarioInmuebleBase.vacio(
      ));
      usuarioInmuebleBases[2].id=idUsuario;
    }
    /*print(usuarioInmuebleBases[0].usuarioInmuebleBaseToMap());
    print(usuarioInmuebleBases[1].usuarioInmuebleBaseToMap());
    print(usuarioInmuebleBases[2].usuarioInmuebleBaseToMap());*/
    return usuarioInmuebleBases;
}
List<InmuebleTotal> modificarListaInmuebleTotal(List<InmuebleTotal> inmueblesTotal,InmuebleTotal _inmuebleTotal,String accion){
  int superior=0;
  int inferior=0;
  int mitad=0;
  int contador=0;
  List<InmuebleTotal> _inmueblesTotal=[];
  _inmueblesTotal.addAll(inmueblesTotal);
  if(_inmueblesTotal.length>0){
    _inmueblesTotal.sort((a,b)=>a.getInmueble.getIndice.compareTo(b.getInmueble.getIndice));
    inferior=0;
    superior=_inmueblesTotal.length-1;
    while(superior<=inferior){
      mitad=((inferior+superior)/2).floor();
      if(_inmueblesTotal.elementAt(mitad).getInmueble.getIndice==_inmuebleTotal.getInmueble.getIndice){
        break;
      }else{
        if(_inmueblesTotal.elementAt(mitad).getInmueble.getIndice>_inmuebleTotal.getInmueble.getIndice){
          superior=mitad;
        }else{
          inferior=mitad;
        }
      }
      contador++;
      if(contador>200){
        break;
      }
    }
    if(accion.toLowerCase()=="insertar"){
      _inmueblesTotal.add(_inmuebleTotal);
    }
    else if(accion.toLowerCase()=="modificar"){
      _inmueblesTotal.removeWhere((element) => element.getInmueble.indice==_inmuebleTotal.getInmueble.indice);
      _inmueblesTotal.add(_inmuebleTotal);
    }else if(accion.toLowerCase()=="eliminar"){
      _inmueblesTotal.removeRange(mitad, mitad+1);
    }
    
  }
  return _inmueblesTotal;
}
List<InmuebleTotal> filtrarInmuebles(List<InmuebleTotal> _inmueblesTotal,Map<String,dynamic> mapFiltro){
  List<InmuebleTotal> inmueblesAux=[];
    inmueblesAux.addAll(_inmueblesTotal);
    /*print("tamaño  de lista ${_inmuebles.length}");
    List<int> enteros=[0,1,2,3,4,5,6,7,8,9];
    print(enteros);
    enteros.removeRange(0, enteros.length);
    print(enteros);*/
    //Buscando el ultimo true por el metodo binario
    
    int mitad=0;
    int inferior=0;
    int superior=inmueblesAux.length-1;
    
    if(mapFiltro["tipo_sesion"]!="Comprar"){
      if(mapFiltro["fecha_inicio"]!=null&&mapFiltro["fecha_inicio"]!=""){
        //print(DateTime.parse(mapFiltrosu["fecha_inicio"]));
        try{
          inmueblesAux.removeWhere((element) => (DateTime.parse(element.inmueble.ultimaModificacion).difference(DateTime.parse(mapFiltro["fecha_inicio"].toString())).inSeconds>0));
        }catch(e){}
      }
    }
    if(mapFiltro["fecha_penultimo_ingreso"]!=null){
      
      inmueblesAux.removeWhere((element) => (DateTime.parse(element.inmueble.fechaPublicacion).difference(DateTime.parse(mapFiltro["fecha_penultimo_ingreso"].toString())).inSeconds<0));
    }
    if(mapFiltro["precio_min"]>0&&mapFiltro["precio_max"]>0&&inmueblesAux.length>0){
      inmueblesAux.sort((a,b)=>a.getInmueble.getPrecio.compareTo(b.getInmueble.getPrecio));
      int contador=0;
      mitad=0;
      inferior=0;
      superior=inmueblesAux.length-1;
      if(mapFiltro["precio_min"]>inmueblesAux.elementAt(0).getInmueble.getPrecio){
        if(mapFiltro["precio_min"]<=inmueblesAux.elementAt(superior).getInmueble.getPrecio){
          if(inmueblesAux.elementAt(0).getInmueble.getPrecio<inmueblesAux.elementAt(superior).getInmueble.getPrecio){
            while(inferior<=superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmueble.getPrecio<mapFiltro["precio_min"]){
                if(inmueblesAux.elementAt(mitad+1).getInmueble.getPrecio>=mapFiltro["precio_min"]){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad).getInmueble.getPrecio>mapFiltro["precio_min"]){
                  superior=mitad;
                }else{
                  if(inmueblesAux.elementAt(mitad-1).getInmueble.getPrecio<mapFiltro["precio_min"]){
                    mitad=mitad-1;
                    break;
                  }else{
                    superior=mitad-1;
                  }
                }
              }
              contador++;
              if(contador>=100){
                break;
              }
            }
            
            inmueblesAux.removeRange(0, mitad+1);
          }
        }else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    
    if(mapFiltro["precio_min"]<mapFiltro["precio_max"]){
      if(inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmueble.getPrecio.compareTo(b.getInmueble.getPrecio));
        int contador=0;
        mitad=0;
        inferior=0;
        superior=inmueblesAux.length-1;
        if(mapFiltro["precio_max"]<inmueblesAux.elementAt(superior).getInmueble.getPrecio){
          if(mapFiltro["precio_max"]>=inmueblesAux.elementAt(0).getInmueble.getPrecio){
            if(inmueblesAux.elementAt(0).getInmueble.getPrecio<inmueblesAux.elementAt(superior).getInmueble.getPrecio){
              while(inferior<=superior){
                mitad=((inferior+superior)/2).floor();
                if(inmueblesAux.elementAt(mitad).getInmueble.getPrecio>mapFiltro["precio_max"]){
                  if(inmueblesAux.elementAt(mitad-1).getInmueble.getPrecio<=mapFiltro["precio_max"]){
                    mitad=mitad-1;
                    break;
                  }else{
                    superior=mitad-1;
                  }
                }else{
                  if(inmueblesAux.elementAt(mitad).getInmueble.getPrecio<mapFiltro["precio_max"]){
                    if(inmueblesAux.elementAt(mitad+1).getInmueble.getPrecio>mapFiltro["precio_max"]){
                      break;
                    }else{
                      inferior=mitad+1;
                    }
                    inferior=mitad;
                  }else{
                    if(inmueblesAux.elementAt(mitad+1).getInmueble.getPrecio>mapFiltro["precio_max"]){
                      mitad=mitad+1;
                      break;
                    }else{
                      inferior=mitad+1;
                    }
                  } 
                }
                contador++;
                if(contador>=100){
                  break;
                }
              }
              inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
            }
          }else{
            inmueblesAux.removeRange(0, inmueblesAux.length);
          }
        }
      }
    }
    if(mapFiltro["tipo_contrato"]!="Todos"&&inmueblesAux.length>0){
        inmueblesAux.removeWhere((element) => element.inmueble.tipoContrato!=mapFiltro["tipo_contrato"]);
    }
    if(mapFiltro["tipo_inmueble"]!="Todos"&&inmueblesAux.length>0){
        inmueblesAux.removeWhere((element) => element.inmueble.tipoInmueble!=mapFiltro["tipo_inmueble"]);
    }
    if(mapFiltro["zona"]!="Cualquiera"){
      inmueblesAux.removeWhere((element) => element.inmueble.nombreZona!=mapFiltro["zona"]);
    }
    if(mapFiltro["mascotas_permitidas"]!=null){
      if(mapFiltro["mascotas_permitidas"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmueble.mascotasPermitidas.toString().length.compareTo(b.getInmueble.mascotasPermitidas.toString().length));
      
        if(inmueblesAux.elementAt(0).getInmueble.mascotasPermitidas){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmueble.mascotasPermitidas){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmueble.mascotasPermitidas){
                if(!inmueblesAux.elementAt(mitad+1).getInmueble.mascotasPermitidas){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmueble.mascotasPermitidas){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["sin_hipoteca"]!=null){
      if(mapFiltro["sin_hipoteca"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmueble.isSinHipoteca.toString().length.compareTo(b.getInmueble.isSinHipoteca.toString().length));
        if(inmueblesAux.elementAt(0).getInmueble.isSinHipoteca){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmueble.isSinHipoteca){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmueble.isSinHipoteca){
                if(!inmueblesAux.elementAt(mitad+1).getInmueble.isSinHipoteca){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmueble.isSinHipoteca){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["construccion_estrenar"]!=null){
      if(mapFiltro["construccion_estrenar"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmueble.construccionEstrenar.toString().length.compareTo(b.getInmueble.construccionEstrenar.toString().length));
        mitad=0;
        inferior=0;
        superior=inmueblesAux.length-1;
        if(inmueblesAux.elementAt(0).getInmueble.construccionEstrenar){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmueble.construccionEstrenar){
            while(inferior<=superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmueble.construccionEstrenar){
                if(!inmueblesAux.elementAt(mitad+1).getInmueble.construccionEstrenar){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmueble.construccionEstrenar){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["materiales_primera"]!=null){
      if(mapFiltro["materiales_primera"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmueble.materialesPrimera.toString().length.compareTo(b.getInmueble.materialesPrimera.toString().length));
        mitad=0;
        inferior=0;
        superior=inmueblesAux.length-1;
        if(inmueblesAux.elementAt(0).getInmueble.materialesPrimera){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmueble.materialesPrimera){
            while(inferior<=superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmueble.materialesPrimera){
                if(!inmueblesAux.elementAt(mitad+1).getInmueble.materialesPrimera){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmueble.materialesPrimera){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["superficie_terreno_min"]>0&&mapFiltro["superficie_terreno_max"]>0&&inmueblesAux.length>0){
      inmueblesAux.sort((a,b)=>a.getInmueble.getSuperficieTerreno.compareTo(b.getInmueble.getSuperficieTerreno));
      int contador=0;
      mitad=0;
      inferior=0;
      superior=inmueblesAux.length-1;
      if(mapFiltro["superficie_terreno_min"]>inmueblesAux.elementAt(0).getInmueble.getSuperficieTerreno){
        if(mapFiltro["superficie_terreno_min"]<=inmueblesAux.elementAt(superior).getInmueble.getSuperficieTerreno){
          if(inmueblesAux.elementAt(0).getInmueble.getSuperficieTerreno<inmueblesAux.elementAt(superior).getInmueble.getSuperficieTerreno){
            while(inferior<=superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmueble.getSuperficieTerreno<mapFiltro["superficie_terreno_min"]){
                if(inmueblesAux.elementAt(mitad+1).getInmueble.getSuperficieTerreno>=mapFiltro["superficie_terreno_min"]){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad).getInmueble.getSuperficieTerreno>mapFiltro["superficie_terreno_min"]){
                  superior=mitad;
                }else{
                  if(inmueblesAux.elementAt(mitad-1).getInmueble.getSuperficieTerreno<mapFiltro["superficie_terreno_min"]){
                    mitad=mitad-1;
                    break;
                  }else{
                    superior=mitad-1;
                  }
                }
              }
              contador++;
              if(contador>=100){
                break;
              }
            }
            
            inmueblesAux.removeRange(0, mitad+1);
          }
        }else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    
    if(mapFiltro["superficie_terreno_min"]<mapFiltro["superficie_terreno_max"]){
      if(inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmueble.getSuperficieTerreno.compareTo(b.getInmueble.getSuperficieTerreno));
        int contador=0;
        mitad=0;
        inferior=0;
        superior=inmueblesAux.length-1;
        if(mapFiltro["superficie_terreno_max"]<inmueblesAux.elementAt(superior).getInmueble.getSuperficieTerreno){
          if(mapFiltro["superficie_terreno_max"]>=inmueblesAux.elementAt(0).getInmueble.getSuperficieTerreno){
            if(inmueblesAux.elementAt(0).getInmueble.getSuperficieTerreno<inmueblesAux.elementAt(superior).getInmueble.getSuperficieTerreno){
              while(inferior<=superior){
                mitad=((inferior+superior)/2).floor();
                if(inmueblesAux.elementAt(mitad).getInmueble.getSuperficieTerreno>mapFiltro["superficie_terreno_max"]){
                  if(inmueblesAux.elementAt(mitad-1).getInmueble.getSuperficieTerreno<=mapFiltro["superficie_terreno_max"]){
                    mitad=mitad-1;
                    break;
                  }else{
                    superior=mitad-1;
                  }
                }else{
                  if(inmueblesAux.elementAt(mitad).getInmueble.getSuperficieTerreno<mapFiltro["superficie_terreno_max"]){
                    if(inmueblesAux.elementAt(mitad+1).getInmueble.getSuperficieTerreno>mapFiltro["superficie_terreno_max"]){
                      break;
                    }else{
                      inferior=mitad+1;
                    }
                    inferior=mitad;
                  }else{
                    if(inmueblesAux.elementAt(mitad+1).getInmueble.getSuperficieTerreno>mapFiltro["superficie_terreno_max"]){
                      mitad=mitad+1;
                      break;
                    }else{
                      inferior=mitad+1;
                    }
                  } 
                }
                contador++;
                if(contador>=100){
                  break;
                }
              }
              inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
            }
          }else{
            inmueblesAux.removeRange(0, inmueblesAux.length);
          }
        }
      }
    }
    if(mapFiltro["superficie_construccion_min"]>0&&mapFiltro["superficie_construccion_max"]>0&&inmueblesAux.length>0){
      inmueblesAux.sort((a,b)=>a.getInmueble.getSuperficieConstruccion.compareTo(b.getInmueble.getSuperficieConstruccion));
      int contador=0;
      mitad=0;
      inferior=0;
      superior=inmueblesAux.length-1;
      if(mapFiltro["superficie_construccion_min"]>inmueblesAux.elementAt(0).getInmueble.getSuperficieConstruccion){
        if(mapFiltro["superficie_construccion_min"]<=inmueblesAux.elementAt(superior).getInmueble.getSuperficieConstruccion){
          if(inmueblesAux.elementAt(0).getInmueble.getSuperficieConstruccion<inmueblesAux.elementAt(superior).getInmueble.getSuperficieConstruccion){
            while(inferior<=superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmueble.getSuperficieConstruccion<mapFiltro["superficie_construccion_min"]){
                if(inmueblesAux.elementAt(mitad+1).getInmueble.getSuperficieConstruccion>=mapFiltro["superficie_construccion_min"]){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad).getInmueble.getSuperficieConstruccion>mapFiltro["superficie_construccion_min"]){
                  superior=mitad;
                }else{
                  if(inmueblesAux.elementAt(mitad-1).getInmueble.getSuperficieConstruccion<mapFiltro["superficie_construccion_min"]){
                    mitad=mitad-1;
                    break;
                  }else{
                    superior=mitad-1;
                  }
                }
              }
              contador++;
              if(contador>=100){
                break;
              }
            }
            
            inmueblesAux.removeRange(0, mitad+1);
          }
        }else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["superficie_construccion_min"]<mapFiltro["superficie_construccion_max"]){
      if(inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmueble.getSuperficieConstruccion.compareTo(b.getInmueble.getSuperficieConstruccion));
        
        int contador=0;
        mitad=0;
        inferior=0;
        superior=inmueblesAux.length-1;
        if(mapFiltro["superficie_construccion_max"]<inmueblesAux.elementAt(superior).getInmueble.getSuperficieConstruccion){
          if(mapFiltro["superficie_construccion_max"]>=inmueblesAux.elementAt(0).getInmueble.getSuperficieConstruccion){
            if(inmueblesAux.elementAt(0).getInmueble.getSuperficieConstruccion<inmueblesAux.elementAt(superior).getInmueble.getSuperficieConstruccion){
              while(inferior<=superior){
                mitad=((inferior+superior)/2).floor();
                if(inmueblesAux.elementAt(mitad).getInmueble.getSuperficieConstruccion>mapFiltro["superficie_construccion_max"]){
                  if(inmueblesAux.elementAt(mitad-1).getInmueble.getSuperficieConstruccion<=mapFiltro["superficie_construccion_max"]){
                    mitad=mitad-1;
                    break;
                  }else{
                    superior=mitad-1;
                  }
                }else{
                  if(inmueblesAux.elementAt(mitad).getInmueble.getSuperficieConstruccion<mapFiltro["superficie_construccion_max"]){
                    if(inmueblesAux.elementAt(mitad+1).getInmueble.getSuperficieConstruccion>mapFiltro["superficie_construccion_max"]){
                      break;
                    }else{
                      inferior=mitad+1;
                    }
                  }else{
                    if(inmueblesAux.elementAt(mitad+1).getInmueble.getSuperficieConstruccion>mapFiltro["superficie_construccion_max"]){
                      mitad=mitad+1;
                      break;
                    }else{
                      inferior=mitad+1;
                    }
                  } 
                }
                contador++;
                if(contador>=100){
                  break;
                }
              }
              inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
            }
          }else{
            inmueblesAux.removeRange(0, inmueblesAux.length);
          }
        }
      }
    }
    if(mapFiltro["antiguedad_construccion_min"]>0&&mapFiltro["antiguedad_construccion_max"]>0&&inmueblesAux.length>0){
      inmueblesAux.sort((a,b)=>a.getInmueble.antiguedadConstruccion.compareTo(b.getInmueble.antiguedadConstruccion));
      
      int contador=0;
      mitad=0;
      inferior=0;
      superior=inmueblesAux.length-1;
      if(mapFiltro["antiguedad_construccion_min"]>inmueblesAux.elementAt(0).getInmueble.antiguedadConstruccion){
        if(mapFiltro["antiguedad_construccion_min"]<=inmueblesAux.elementAt(superior).getInmueble.antiguedadConstruccion){
          if(inmueblesAux.elementAt(0).getInmueble.antiguedadConstruccion<inmueblesAux.elementAt(superior).getInmueble.antiguedadConstruccion){
            while(inferior<=superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmueble.antiguedadConstruccion<mapFiltro["antiguedad_construccion_min"]){
                if(inmueblesAux.elementAt(mitad+1).getInmueble.antiguedadConstruccion>=mapFiltro["antiguedad_construccion_min"]){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad).getInmueble.antiguedadConstruccion>mapFiltro["antiguedad_construccion_min"]){
                  superior=mitad;
                }else{
                  if(inmueblesAux.elementAt(mitad-1).getInmueble.antiguedadConstruccion<mapFiltro["tiempo_construccion_min"]){
                    mitad=mitad-1;
                    break;
                  }else{
                    superior=mitad-1;
                  }
                }
              }
              contador++;
              if(contador>=100){
                break;
              }
            }
            
            inmueblesAux.removeRange(0, mitad+1);
          }
        }else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["antiguedad_construccion_min"]<mapFiltro["antiguedad_construccion_max"]){
      if(inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmueble.antiguedadConstruccion.compareTo(b.getInmueble.antiguedadConstruccion));
        
        int contador=0;
        mitad=0;
        inferior=0;
        superior=inmueblesAux.length-1;
        if(mapFiltro["antiguedad_construccion_max"]<inmueblesAux.elementAt(superior).getInmueble.antiguedadConstruccion){
          if(mapFiltro["antiguedad_construccion_max"]>=inmueblesAux.elementAt(0).getInmueble.antiguedadConstruccion){
            if(inmueblesAux.elementAt(0).getInmueble.antiguedadConstruccion<inmueblesAux.elementAt(superior).getInmueble.antiguedadConstruccion){
              while(inferior<=superior){
                mitad=((inferior+superior)/2).floor();
                if(inmueblesAux.elementAt(mitad).getInmueble.antiguedadConstruccion>mapFiltro["antiguedad_construccion_max"]){
                  if(inmueblesAux.elementAt(mitad-1).getInmueble.antiguedadConstruccion<=mapFiltro["antiguedad_construccion_max"]){
                    mitad=mitad-1;
                    break;
                  }else{
                    superior=mitad-1;
                  }
                }else{
                  if(inmueblesAux.elementAt(mitad).getInmueble.antiguedadConstruccion<mapFiltro["antiguedad_construccion_max"]){
                    if(inmueblesAux.elementAt(mitad+1).getInmueble.antiguedadConstruccion>mapFiltro["antiguedad_construccion_max"]){
                      break;
                    }else{
                      inferior=mitad+1;
                    }
                  }else{
                    if(inmueblesAux.elementAt(mitad+1).getInmueble.antiguedadConstruccion>mapFiltro["antiguedad_construccion_max"]){
                      mitad=mitad+1;
                      break;
                    }else{
                      inferior=mitad+1;
                    }
                  } 
                }
                contador++;
                if(contador>=100){
                  break;
                }
              }
              inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
            }
          }else{
            inmueblesAux.removeRange(0, inmueblesAux.length);
          }
        }
      }
    }
    if(mapFiltro["tamanio_frente_min"]!=null){
      if(mapFiltro["tamanio_frente_min"]>0&&mapFiltro["tamanio_frente_max"]>0&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmueble.tamanioFrente.compareTo(b.getInmueble.tamanioFrente));
        
        int contador=0;
        mitad=0;
        inferior=0;
        superior=inmueblesAux.length-1;
        if(mapFiltro["tamanio_frente_min"]>inmueblesAux.elementAt(0).getInmueble.tamanioFrente){
          if(mapFiltro["tamanio_frente_min"]<=inmueblesAux.elementAt(superior).getInmueble.tamanioFrente){
            if(inmueblesAux.elementAt(0).getInmueble.tamanioFrente<inmueblesAux.elementAt(superior).getInmueble.tamanioFrente){
              while(inferior<=superior){
                mitad=((inferior+superior)/2).floor();
                if(inmueblesAux.elementAt(mitad).getInmueble.tamanioFrente<mapFiltro["tamanio_frente_min"]){
                  if(inmueblesAux.elementAt(mitad+1).getInmueble.tamanioFrente>=mapFiltro["tamanio_frente_min"]){
                    break;
                  }else{
                    inferior=mitad+1;
                  }
                }else{
                  if(inmueblesAux.elementAt(mitad).getInmueble.tamanioFrente>mapFiltro["tamanio_frente_min"]){
                    superior=mitad;
                  }else{
                    if(inmueblesAux.elementAt(mitad-1).getInmueble.tamanioFrente<mapFiltro["tamanio_frente_min"]){
                      mitad=mitad-1;
                      break;
                    }else{
                      superior=mitad-1;
                    }
                  }
                }
                contador++;
                if(contador>=100){
                  break;
                }
              }
              
              inmueblesAux.removeRange(0, mitad+1);
            }
          }else{
            inmueblesAux.removeRange(0, inmueblesAux.length);
          }
        }
      }
      if(mapFiltro["tamanio_frente_min"]<mapFiltro["tamanio_frente_max"]){
        if(inmueblesAux.length>0){
          inmueblesAux.sort((a,b)=>a.getInmueble.tamanioFrente.compareTo(b.getInmueble.tamanioFrente));
          
          int contador=0;
          mitad=0;
          inferior=0;
          superior=inmueblesAux.length-1;
          if(mapFiltro["tamanio_frente_max"]<inmueblesAux.elementAt(superior).getInmueble.tamanioFrente){
            if(mapFiltro["tamanio_frente_max"]>=inmueblesAux.elementAt(0).getInmueble.tamanioFrente){
              if(inmueblesAux.elementAt(0).getInmueble.tamanioFrente<inmueblesAux.elementAt(superior).getInmueble.tamanioFrente){
                while(inferior<=superior){
                  mitad=((inferior+superior)/2).floor();
                  if(inmueblesAux.elementAt(mitad).getInmueble.tamanioFrente>mapFiltro["tamanio_frente_max"]){
                    if(inmueblesAux.elementAt(mitad-1).getInmueble.tamanioFrente<=mapFiltro["tamanio_frente_max"]){
                      mitad=mitad-1;
                      break;
                    }else{
                      superior=mitad-1;
                    }
                  }else{
                    if(inmueblesAux.elementAt(mitad).getInmueble.tamanioFrente<mapFiltro["tamanio_frente_max"]){
                      if(inmueblesAux.elementAt(mitad+1).getInmueble.tamanioFrente>mapFiltro["tamanio_frente_max"]){
                        break;
                      }else{
                        inferior=mitad+1;
                      }
                    }else{
                      if(inmueblesAux.elementAt(mitad+1).getInmueble.tamanioFrente>mapFiltro["tamanio_frente_max"]){
                        mitad=mitad+1;
                        break;
                      }else{
                        inferior=mitad+1;
                      }
                    } 
                  }
                  contador++;
                  if(contador>=100){
                    break;
                  }
                }
                inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
              }
            }else{
              inmueblesAux.removeRange(0, inmueblesAux.length);
            }
          }
        }
      }
    }
    if(mapFiltro["proyecto_preventa"]!=null){
      if(mapFiltro["proyecto_preventa"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmueble.proyectoPreventa.toString().length.compareTo(b.getInmueble.proyectoPreventa.toString().length));
        if(inmueblesAux.elementAt(0).getInmueble.proyectoPreventa){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmueble.proyectoPreventa){
            int contador=0;
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmueble.proyectoPreventa){
                if(!inmueblesAux.elementAt(mitad+1).getInmueble.proyectoPreventa){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmueble.proyectoPreventa){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
              contador++;
              if(contador>=100){
                break;
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["inmueble_compartido"]!=null){
      if(mapFiltro["inmueble_compartido"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmueble.isInmuebleCompartido.toString().length.compareTo(b.getInmueble.isInmuebleCompartido.toString().length));
        if(inmueblesAux.elementAt(0).getInmueble.isInmuebleCompartido){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmueble.isInmuebleCompartido){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmueble.isInmuebleCompartido){
                if(!inmueblesAux.elementAt(mitad+1).getInmueble.isInmuebleCompartido){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmueble.isInmuebleCompartido){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
        if(mapFiltro["numero_duenios"]>0&&inmueblesAux.length>0){
          inmueblesAux.sort((a,b)=>a.getInmueble.getNumeroDuenios.compareTo(b.getInmueble.getNumeroDuenios));
          
          int contador=0;
          mitad=0;
          inferior=0;
          superior=inmueblesAux.length-1;
          if(mapFiltro["numero_duenios"]>inmueblesAux.elementAt(0).getInmueble.getNumeroDuenios){
            if(mapFiltro["numero_duenios"]<=inmueblesAux.elementAt(superior).getInmueble.getNumeroDuenios){
              if(inmueblesAux.elementAt(0).getInmueble.getNumeroDuenios<inmueblesAux.elementAt(superior).getInmueble.getNumeroDuenios){
                while(inferior<=superior){
                  mitad=((inferior+superior)/2).floor();
                  if(inmueblesAux.elementAt(mitad).getInmueble.getNumeroDuenios<mapFiltro["numero_duenios"]){
                    if(inmueblesAux.elementAt(mitad+1).getInmueble.getNumeroDuenios>=mapFiltro["numero_duenios"]){
                      break;
                    }else{
                      inferior=mitad+1;
                    }
                  }else{
                    if(inmueblesAux.elementAt(mitad).getInmueble.getNumeroDuenios>mapFiltro["numero_duenios"]){
                      superior=mitad;
                    }else{
                      if(inmueblesAux.elementAt(mitad-1).getInmueble.getNumeroDuenios<mapFiltro["numero_duenios"]){
                        mitad=mitad-1;
                        break;
                      }else{
                        superior=mitad-1;
                      }
                    }
                  }
                  contador++;
                  if(contador>=100){
                    break;
                  }
                }
                
                inmueblesAux.removeRange(0, mitad+1);
              }
            }else{
              inmueblesAux.removeRange(0, inmueblesAux.length);
            }
          }
        }
        if(mapFiltro["numero_duenios"]<5){
          if(inmueblesAux.length>0){
            inmueblesAux.sort((a,b)=>a.getInmueble.getNumeroDuenios.compareTo(b.getInmueble.getNumeroDuenios));
            
            int contador=0;
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            if(mapFiltro["numero_duenios"]<inmueblesAux.elementAt(superior).getInmueble.getNumeroDuenios){
              if(mapFiltro["numero_duenios"]>=inmueblesAux.elementAt(0).getInmueble.getNumeroDuenios){
                if(inmueblesAux.elementAt(0).getInmueble.getNumeroDuenios<inmueblesAux.elementAt(superior).getInmueble.getNumeroDuenios){
                  while(inferior<=superior){
                    mitad=((inferior+superior)/2).floor();
                    if(inmueblesAux.elementAt(mitad).getInmueble.getNumeroDuenios>mapFiltro["numero_duenios"]){
                      if(inmueblesAux.elementAt(mitad-1).getInmueble.getNumeroDuenios<=mapFiltro["numero_duenios"]){
                        mitad=mitad-1;
                        break;
                      }else{
                        superior=mitad-1;
                      }
                    }else{
                      if(inmueblesAux.elementAt(mitad).getInmueble.getNumeroDuenios<mapFiltro["numero_duenios"]){
                        if(inmueblesAux.elementAt(mitad+1).getInmueble.getNumeroDuenios>mapFiltro["numero_duenios"]){
                          break;
                        }else{
                          inferior=mitad+1;
                        }
                      }else{
                        if(inmueblesAux.elementAt(mitad+1).getInmueble.getNumeroDuenios>mapFiltro["numero_duenios"]){
                          mitad=mitad+1;
                          break;
                        }else{
                          inferior=mitad+1;
                        }
                      } 
                    }
                    contador++;
                    if(contador>=100){
                      break;
                    }
                  }
                  inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
                }
              }else{
                inmueblesAux.removeRange(0, inmueblesAux.length);
              }
            }
          }
        }
      }
    }
    if(mapFiltro["servicios_basicos"]!=null){
      if(mapFiltro["servicios_basicos"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmueble.serviciosBasicos.toString().length.compareTo(b.getInmueble.serviciosBasicos.toString().length));
        
        if(inmueblesAux.elementAt(0).getInmueble.serviciosBasicos){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmueble.serviciosBasicos){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmueble.serviciosBasicos){
                if(!inmueblesAux.elementAt(mitad+1).getInmueble.serviciosBasicos){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmueble.serviciosBasicos){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["gas_domiciliario"]!=null){
      if(mapFiltro["gas_domiciliario"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmueble.gasDomiciliario.toString().length.compareTo(b.getInmueble.gasDomiciliario.toString().length));
        
        if(inmueblesAux.elementAt(0).getInmueble.gasDomiciliario){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmueble.gasDomiciliario){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmueble.gasDomiciliario){
                if(!inmueblesAux.elementAt(mitad+1).getInmueble.gasDomiciliario){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmueble.gasDomiciliario){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["wifi"]!=null){
      if(mapFiltro["wifi"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmueble.wifi.toString().length.compareTo(b.getInmueble.wifi.toString().length));
        
        if(inmueblesAux.elementAt(0).getInmueble.wifi){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmueble.wifi){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmueble.wifi){
                if(!inmueblesAux.elementAt(mitad+1).getInmueble.wifi){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmueble.wifi){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["medidor_independiente"]!=null){
      if(mapFiltro["medidor_independiente"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmueble.medidorIndependiente.toString().length.compareTo(b.getInmueble.medidorIndependiente.toString().length));
        
        if(inmueblesAux.elementAt(0).getInmueble.medidorIndependiente){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmueble.medidorIndependiente){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmueble.medidorIndependiente){
                if(!inmueblesAux.elementAt(mitad+1).getInmueble.medidorIndependiente){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmueble.medidorIndependiente){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["termotanque"]!=null){
      if(mapFiltro["termotanque"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmueble.termotanque.toString().length.compareTo(b.getInmueble.termotanque.toString().length));
        
        if(inmueblesAux.elementAt(0).getInmueble.termotanque){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmueble.termotanque){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmueble.termotanque){
                if(!inmueblesAux.elementAt(mitad+1).getInmueble.termotanque){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmueble.termotanque){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["calle_asfaltada"]!=null) {
      if(mapFiltro["calle_asfaltada"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmueble.calleAsfaltada.toString().length.compareTo(b.getInmueble.calleAsfaltada.toString().length));
        
        if(inmueblesAux.elementAt(0).getInmueble.calleAsfaltada){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmueble.calleAsfaltada){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmueble.calleAsfaltada){
                if(!inmueblesAux.elementAt(mitad+1).getInmueble.calleAsfaltada){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmueble.calleAsfaltada){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["transporte"]!=null){
      if(mapFiltro["transporte"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmueble.transporte.toString().length.compareTo(b.getInmueble.transporte.toString().length));
        
        if(inmueblesAux.elementAt(0).getInmueble.transporte){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmueble.transporte){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmueble.transporte){
                if(!inmueblesAux.elementAt(mitad+1).getInmueble.transporte){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmueble.transporte){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["preparado_discapacidad"]!=null){
      if(mapFiltro["preparado_discapacidad"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmueble.preparadoDiscapacidad.toString().length.compareTo(b.getInmueble.preparadoDiscapacidad.toString().length));
        
        if(inmueblesAux.elementAt(0).getInmueble.preparadoDiscapacidad){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmueble.preparadoDiscapacidad){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmueble.preparadoDiscapacidad){
                if(!inmueblesAux.elementAt(mitad+1).getInmueble.preparadoDiscapacidad){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmueble.preparadoDiscapacidad){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["papeles_orden"]!=null) {
      if(mapFiltro["papeles_orden"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmueble.papelesOrden.toString().length.compareTo(b.getInmueble.papelesOrden.toString().length));
        
        if(inmueblesAux.elementAt(0).getInmueble.papelesOrden){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmueble.papelesOrden){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmueble.papelesOrden){
                if(!inmueblesAux.elementAt(mitad+1).getInmueble.papelesOrden){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmueble.papelesOrden){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["habilitado_credito"]!=null){
      if(mapFiltro["habilitado_credito"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmueble.habilitadoCredito.toString().length.compareTo(b.getInmueble.habilitadoCredito.toString().length));
        mitad=0;
        inferior=0;
        superior=inmueblesAux.length-1;
        if(inmueblesAux.elementAt(0).getInmueble.habilitadoCredito){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmueble.habilitadoCredito){
            while(inferior<=superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmueble.habilitadoCredito){
                if(!inmueblesAux.elementAt(mitad+1).getInmueble.habilitadoCredito){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmueble.habilitadoCredito){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        }else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    //-----------------------------------------------------------------------------
    //FILTRO INTERNAS
    if(mapFiltro["plantas"]!=null){
      if(mapFiltro["plantas"]>0&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleInternas.plantas.compareTo(b.getInmuebleInternas.plantas));
        
        int contador=0;
        mitad=0;
        inferior=0;
        superior=inmueblesAux.length-1;
        if(mapFiltro["plantas"]>inmueblesAux.elementAt(0).getInmuebleInternas.plantas){
          if(mapFiltro["plantas"]<=inmueblesAux.elementAt(superior).getInmuebleInternas.plantas){
            if(inmueblesAux.elementAt(0).getInmuebleInternas.plantas<inmueblesAux.elementAt(superior).getInmuebleInternas.plantas){
              while(inferior<=superior){
                mitad=((inferior+superior)/2).floor();
                if(inmueblesAux.elementAt(mitad).getInmuebleInternas.plantas<mapFiltro["plantas"]){
                  if(inmueblesAux.elementAt(mitad+1).getInmuebleInternas.plantas>=mapFiltro["plantas"]){
                    break;
                  }else{
                    inferior=mitad+1;
                  }
                }else{
                  if(inmueblesAux.elementAt(mitad).getInmuebleInternas.plantas>mapFiltro["plantas"]){
                    superior=mitad;
                  }else{
                    if(inmueblesAux.elementAt(mitad-1).getInmuebleInternas.plantas<mapFiltro["plantas"]){
                      mitad=mitad-1;
                      break;
                    }else{
                      superior=mitad-1;
                    }
                  }
                }
                contador++;
                if(contador>=100){
                  break;
                }
              }
              
              inmueblesAux.removeRange(0, mitad+1);
            }
          }else{
            inmueblesAux.removeRange(0, inmueblesAux.length);
          }
        }
      }
      if(mapFiltro["plantas"]>0 && mapFiltro["plantas"]<5){
        if(inmueblesAux.length>0){
          inmueblesAux.sort((a,b)=>a.getInmuebleInternas.plantas.compareTo(b.getInmuebleInternas.plantas));
          
          int contador=0;
          mitad=0;
          inferior=0;
          superior=inmueblesAux.length-1;
          if(mapFiltro["plantas"]<inmueblesAux.elementAt(superior).getInmuebleInternas.plantas){
            if(mapFiltro["plantas"]>=inmueblesAux.elementAt(0).getInmuebleInternas.plantas){
              if(inmueblesAux.elementAt(0).getInmuebleInternas.plantas<inmueblesAux.elementAt(superior).getInmuebleInternas.plantas){
                while(inferior<=superior){
                  mitad=((inferior+superior)/2).floor();
                  if(inmueblesAux.elementAt(mitad).getInmuebleInternas.plantas>mapFiltro["plantas"]){
                    if(inmueblesAux.elementAt(mitad-1).getInmuebleInternas.plantas<=mapFiltro["plantas"]){
                      mitad=mitad-1;
                      break;
                    }else{
                      superior=mitad-1;
                    }
                  }else{
                    if(inmueblesAux.elementAt(mitad).getInmuebleInternas.plantas<mapFiltro["plantas"]){
                      if(inmueblesAux.elementAt(mitad+1).getInmuebleInternas.plantas>mapFiltro["plantas"]){
                        break;
                      }else{
                        inferior=mitad+1;
                      }
                    }else{
                      if(inmueblesAux.elementAt(mitad+1).getInmuebleInternas.plantas>mapFiltro["plantas"]){
                        break;
                      }else{
                        inferior=mitad+1;
                      }
                    } 
                  }
                  contador++;
                  if(contador>=100){
                    break;
                  }
                }
                inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
              }
            }else{
              inmueblesAux.removeRange(0, inmueblesAux.length);
            }
          }
        }
      }
    }
    if(mapFiltro["ambientes"]!=null){
      if(mapFiltro["ambientes"]>0&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleInternas.ambientes.compareTo(b.getInmuebleInternas.ambientes));
        
        int contador=0;
        mitad=0;
        inferior=0;
        superior=inmueblesAux.length-1;
        if(mapFiltro["ambientes"]>inmueblesAux.elementAt(0).getInmuebleInternas.ambientes){
          if(mapFiltro["ambientes"]<=inmueblesAux.elementAt(superior).getInmuebleInternas.ambientes){
            if(inmueblesAux.elementAt(0).getInmuebleInternas.ambientes<inmueblesAux.elementAt(superior).getInmuebleInternas.ambientes){
              while(inferior<=superior){
                mitad=((inferior+superior)/2).floor();
                if(inmueblesAux.elementAt(mitad).getInmuebleInternas.ambientes<mapFiltro["ambientes"]){
                  if(inmueblesAux.elementAt(mitad+1).getInmuebleInternas.ambientes>=mapFiltro["ambientes"]){
                    break;
                  }else{
                    inferior=mitad+1;
                  }
                }else{
                  if(inmueblesAux.elementAt(mitad).getInmuebleInternas.ambientes>mapFiltro["ambientes"]){
                    superior=mitad;
                  }else{
                    if(inmueblesAux.elementAt(mitad-1).getInmuebleInternas.ambientes<mapFiltro["ambientes"]){
                      mitad=mitad-1;
                      break;
                    }else{
                      superior=mitad-1;
                    }
                  }
                }
                contador++;
                if(contador>=100){
                  break;
                }
              }
              
              inmueblesAux.removeRange(0, mitad+1);
            }
          }else{
            inmueblesAux.removeRange(0, inmueblesAux.length);
          }
        }
      }
      if(mapFiltro["ambientes"]>0 && mapFiltro["ambientes"]<5){
        if(inmueblesAux.length>0){
          inmueblesAux.sort((a,b)=>a.getInmuebleInternas.ambientes.compareTo(b.getInmuebleInternas.ambientes));
          
          int contador=0;
          mitad=0;
          inferior=0;
          superior=inmueblesAux.length-1;
          if(mapFiltro["ambientes"]<inmueblesAux.elementAt(superior).getInmuebleInternas.ambientes){
            if(mapFiltro["ambientes"]>=inmueblesAux.elementAt(0).getInmuebleInternas.ambientes){
              if(inmueblesAux.elementAt(0).getInmuebleInternas.ambientes<inmueblesAux.elementAt(superior).getInmuebleInternas.ambientes){
                while(inferior<=superior){
                  mitad=((inferior+superior)/2).floor();
                  if(inmueblesAux.elementAt(mitad).getInmuebleInternas.ambientes>mapFiltro["ambientes"]){
                    if(inmueblesAux.elementAt(mitad-1).getInmuebleInternas.ambientes<=mapFiltro["ambientes"]){
                      mitad=mitad-1;
                      break;
                    }else{
                      superior=mitad-1;
                    }
                  }else{
                    if(inmueblesAux.elementAt(mitad).getInmuebleInternas.ambientes<mapFiltro["ambientes"]){
                      if(inmueblesAux.elementAt(mitad+1).getInmuebleInternas.ambientes>mapFiltro["ambientes"]){
                        break;
                      }else{
                        inferior=mitad+1;
                      }
                    }else{
                      if(inmueblesAux.elementAt(mitad+1).getInmuebleInternas.ambientes>mapFiltro["ambientes"]){
                        break;
                      }else{
                        inferior=mitad+1;
                      }
                    } 
                  }
                  contador++;
                  if(contador>=100){
                    break;
                  }
                }
                inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
              }
            }else{
              inmueblesAux.removeRange(0, inmueblesAux.length);
            }
          }
        }
      }
    }
    if(mapFiltro["dormitorios"]!=null){
      if(mapFiltro["dormitorios"]>0&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleInternas.getDormitorios.compareTo(b.getInmuebleInternas.getDormitorios));
        int contador=0;
        mitad=0;
        inferior=0;
        superior=inmueblesAux.length-1;
        if(mapFiltro["dormitorios"]>inmueblesAux.elementAt(0).getInmuebleInternas.getDormitorios){
          if(mapFiltro["dormitorios"]<=inmueblesAux.elementAt(superior).getInmuebleInternas.getDormitorios){
            if(inmueblesAux.elementAt(0).getInmuebleInternas.getDormitorios<inmueblesAux.elementAt(superior).getInmuebleInternas.getDormitorios){
              while(inferior<=superior){
                mitad=((inferior+superior)/2).floor();
                if(inmueblesAux.elementAt(mitad).getInmuebleInternas.getDormitorios<mapFiltro["dormitorios"]){
                  if(inmueblesAux.elementAt(mitad+1).getInmuebleInternas.getDormitorios>=mapFiltro["dormitorios"]){
                    break;
                  }else{
                    inferior=mitad+1;
                  }
                }else{
                  if(inmueblesAux.elementAt(mitad).getInmuebleInternas.getDormitorios>mapFiltro["dormitorios"]){
                    superior=mitad;
                  }else{
                    if(inmueblesAux.elementAt(mitad-1).getInmuebleInternas.getDormitorios<mapFiltro["dormitorios"]){
                      mitad=mitad-1;
                      break;
                    }else{
                      superior=mitad-1;
                    }
                  }
                }
                contador++;
                if(contador>=100){
                  break;
                }
              }
              
              inmueblesAux.removeRange(0, mitad+1);
            }
          }else{
            inmueblesAux.removeRange(0, inmueblesAux.length);
          }
        }
      }
      if(mapFiltro["dormitorios"]>0&&mapFiltro["dormitorios"]<5){
        if(inmueblesAux.length>0){
          inmueblesAux.sort((a,b)=>a.getInmuebleInternas.getDormitorios.compareTo(b.getInmuebleInternas.getDormitorios));
          
          int contador=0;
          mitad=0;
          inferior=0;
          superior=inmueblesAux.length-1;
          if(mapFiltro["dormitorios"]<inmueblesAux.elementAt(superior).getInmuebleInternas.getDormitorios){
            if(mapFiltro["dormitorios"]>=inmueblesAux.elementAt(0).getInmuebleInternas.getDormitorios){
              if(inmueblesAux.elementAt(0).getInmuebleInternas.getDormitorios<inmueblesAux.elementAt(superior).getInmuebleInternas.getDormitorios){
                while(inferior<=superior){
                  mitad=((inferior+superior)/2).floor();
                  if(inmueblesAux.elementAt(mitad).getInmuebleInternas.getDormitorios>mapFiltro["dormitorios"]){
                    if(inmueblesAux.elementAt(mitad-1).getInmuebleInternas.getDormitorios<mapFiltro["dormitorios"]){
                      mitad=mitad-1;
                      break;
                    }else{
                      superior=mitad-1;
                    }
                  }else{
                    if(inmueblesAux.elementAt(mitad).getInmuebleInternas.getDormitorios<mapFiltro["dormitorios"]){
                      if(inmueblesAux.elementAt(mitad+1).getInmuebleInternas.getDormitorios>mapFiltro["dormitorios"]){
                        break;
                      }else{
                        inferior=mitad+1;
                      }
                    }else{
                      if(inmueblesAux.elementAt(mitad+1).getInmuebleInternas.getDormitorios>mapFiltro["dormitorios"]){
                        break;
                      }else{
                        inferior=mitad+1;
                      }
                    } 
                  }
                  contador++;
                  if(contador>=100){
                    break;
                  }
                }
                inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
              }
            }else{
              inmueblesAux.removeRange(0, inmueblesAux.length);
            }
          }
        }
      }
    }
    if(mapFiltro["banios"]!=null){
      if(mapFiltro["banios"]>0&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleInternas.getBanios.compareTo(b.getInmuebleInternas.getBanios));
        mitad=0;
        inferior=0;
        superior=inmueblesAux.length-1;
        if(mapFiltro["banios"]>inmueblesAux.elementAt(0).getInmuebleInternas.getBanios){
          if(mapFiltro["banios"]<=inmueblesAux.elementAt(superior).getInmuebleInternas.getBanios){
            if(inmueblesAux.elementAt(0).getInmuebleInternas.getBanios<inmueblesAux.elementAt(superior).getInmuebleInternas.getBanios){
              while(inferior<=superior){
                mitad=((inferior+superior)/2).floor();
                if(inmueblesAux.elementAt(mitad).getInmuebleInternas.getBanios<mapFiltro["banios"]){
                  if(inmueblesAux.elementAt(mitad+1).getInmuebleInternas.getBanios>=mapFiltro["banios"]){
                    break;
                  }else{
                    inferior=mitad+1;
                  }
                }else{
                  if(inmueblesAux.elementAt(mitad).getInmuebleInternas.getBanios>mapFiltro["banios"]){
                    superior=mitad;
                  }else{
                    if(inmueblesAux.elementAt(mitad-1).getInmuebleInternas.getBanios<mapFiltro["banios"]){
                      mitad=mitad-1;
                      break;
                    }else{
                      superior=mitad-1;
                    }
                  }
                }
              }
              inmueblesAux.removeRange(0, mitad+1);
            }
          }else{
            inmueblesAux.removeRange(0, inmueblesAux.length);
          }
        }
      }
      if(mapFiltro["banios"]>0&&mapFiltro["banios"]<5){
        if(inmueblesAux.length>0){
          inmueblesAux.sort((a,b)=>a.getInmuebleInternas.getBanios.compareTo(b.getInmuebleInternas.getBanios));
          
          int contador=0;
          mitad=0;
          inferior=0;
          superior=inmueblesAux.length-1;
          if(mapFiltro["banios"]<inmueblesAux.elementAt(superior).getInmuebleInternas.getBanios){
            if(mapFiltro["banios"]>=inmueblesAux.elementAt(0).getInmuebleInternas.getBanios){
              if(inmueblesAux.elementAt(0).getInmuebleInternas.getBanios<inmueblesAux.elementAt(superior).getInmuebleInternas.getBanios){
                while(inferior<=superior){
                  mitad=((inferior+superior)/2).floor();
                  if(inmueblesAux.elementAt(mitad).getInmuebleInternas.getBanios>mapFiltro["banios"]){
                    if(inmueblesAux.elementAt(mitad-1).getInmuebleInternas.getBanios<=mapFiltro["banios"]){
                      mitad=mitad-1;
                      break;
                    }else{
                      superior=mitad-1;
                    }
                  }else{
                    if(inmueblesAux.elementAt(mitad).getInmuebleInternas.getBanios<mapFiltro["banios"]){
                      if(inmueblesAux.elementAt(mitad+1).getInmuebleInternas.getBanios>mapFiltro["banios"]){
                        break;
                      }else{
                        inferior=mitad+1;
                      }
                    }else{
                      if(inmueblesAux.elementAt(mitad+1).getInmuebleInternas.getBanios>mapFiltro["banios"]){
                        break;
                      }else{
                        inferior=mitad+1;
                      }
                    } 
                  }
                  contador++;
                  if(contador>=100){
                    break;
                  }
                }
                inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
              }
            }else{
              inmueblesAux.removeRange(0, inmueblesAux.length);
            }
          }
        }
      }
    }
    if(mapFiltro["garaje"]!=null){
      if(mapFiltro["garaje"]>0&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleInternas.getGaraje.compareTo(b.getInmuebleInternas.getGaraje));
        
        mitad=0;
        inferior=0;
        superior=inmueblesAux.length-1;
        if(mapFiltro["garaje"]>inmueblesAux.elementAt(0).getInmuebleInternas.getGaraje){
          if(mapFiltro["garaje"]<=inmueblesAux.elementAt(superior).getInmuebleInternas.getGaraje){
            if(inmueblesAux.elementAt(0).getInmuebleInternas.getGaraje<inmueblesAux.elementAt(superior).getInmuebleInternas.getGaraje){
              while(inferior<=superior){
                mitad=((inferior+superior)/2).floor();
                if(inmueblesAux.elementAt(mitad).getInmuebleInternas.getGaraje<mapFiltro["garaje"]){
                  if(inmueblesAux.elementAt(mitad+1).getInmuebleInternas.getGaraje>=mapFiltro["garaje"]){
                    break;
                  }else{
                    inferior=mitad+1;
                  }
                }else{
                  if(inmueblesAux.elementAt(mitad).getInmuebleInternas.getGaraje>mapFiltro["garaje"]){
                    superior=mitad;
                  }else{
                    if(inmueblesAux.elementAt(mitad-1).getInmuebleInternas.getGaraje<mapFiltro["garaje"]){
                      mitad=mitad-1;
                      break;
                    }else{
                      superior=mitad-1;
                    }
                  }
                }
              }
              inmueblesAux.removeRange(0, mitad+1);
            }
          }else{
            inmueblesAux.removeRange(0, inmueblesAux.length);
          }
        }
      }
      if(mapFiltro["garaje"]>0&&mapFiltro["garaje"]<5){
        if(inmueblesAux.length>0){
          inmueblesAux.sort((a,b)=>a.getInmuebleInternas.getGaraje.compareTo(b.getInmuebleInternas.getGaraje));
          
          int contador=0;
          mitad=0;
          inferior=0;
          superior=inmueblesAux.length-1;
          if(mapFiltro["garaje"]<inmueblesAux.elementAt(superior).getInmuebleInternas.getGaraje){
            if(mapFiltro["garaje"]>=inmueblesAux.elementAt(0).getInmuebleInternas.getGaraje){
              if(inmueblesAux.elementAt(0).getInmuebleInternas.getGaraje<inmueblesAux.elementAt(superior).getInmuebleInternas.getGaraje){
                while(inferior<=superior){
                  mitad=((inferior+superior)/2).floor();
                  if(inmueblesAux.elementAt(mitad).getInmuebleInternas.getGaraje>mapFiltro["garaje"]){
                    if(inmueblesAux.elementAt(mitad-1).getInmuebleInternas.getGaraje<=mapFiltro["garaje"]){
                      mitad=mitad-1;
                      break;
                    }else{
                      superior=mitad-1;
                    }
                  }else{
                    if(inmueblesAux.elementAt(mitad).getInmuebleInternas.getGaraje<mapFiltro["garaje"]){
                      if(inmueblesAux.elementAt(mitad+1).getInmuebleInternas.getGaraje>mapFiltro["garaje"]){
                        break;
                      }else{
                        inferior=mitad+1;
                      }
                    }else{
                      if(inmueblesAux.elementAt(mitad+1).getInmuebleInternas.getGaraje>mapFiltro["garaje"]){
                        break;
                      }else{
                        inferior=mitad+1;
                      }
                    } 
                  }
                  contador++;
                  if(contador>=100){
                    break;
                  }
                }
                inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
              }
            }else{
              inmueblesAux.removeRange(0, inmueblesAux.length);
            }
          }
        }
      }
    }
    if(mapFiltro["amoblado"]!=null){
      if(mapFiltro["amoblado"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleInternas.amoblado.toString().length.compareTo(b.getInmuebleInternas.amoblado.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleInternas.amoblado){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleInternas.amoblado){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleInternas.amoblado){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleInternas.amoblado){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleInternas.amoblado){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["lavanderia"]!=null){
      if(mapFiltro["lavanderia"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleInternas.isLavanderia.toString().length.compareTo(b.getInmuebleInternas.isLavanderia.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleInternas.isLavanderia){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleInternas.isLavanderia){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleInternas.isLavanderia){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleInternas.isLavanderia){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleInternas.isLavanderia){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["cuarto_lavado"]!=null){
      if(mapFiltro["cuarto_lavado"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleInternas.cuartoLavado.toString().length.compareTo(b.getInmuebleInternas.cuartoLavado.toString().length));
        
        if(inmueblesAux.elementAt(0).getInmuebleInternas.cuartoLavado){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleInternas.cuartoLavado){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleInternas.cuartoLavado){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleInternas.cuartoLavado){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleInternas.cuartoLavado){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["churrasquero"]!=null){
      if(mapFiltro["churrasquero"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleInternas.isChurrasquero.toString().length.compareTo(b.getInmuebleInternas.isChurrasquero.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleInternas.isChurrasquero){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleInternas.isChurrasquero){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleInternas.isChurrasquero){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleInternas.isChurrasquero){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleInternas.isChurrasquero){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["azotea"]!=null){
      if(mapFiltro["azotea"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleInternas.isAzotea.toString().length.compareTo(b.getInmuebleInternas.isAzotea.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleInternas.isAzotea){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleInternas.isAzotea){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleInternas.isAzotea){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleInternas.isAzotea){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleInternas.isAzotea){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["condominio_privado"]!=null){
      if(mapFiltro["condominio_privado"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleInternas.condominioPrivado.toString().length.compareTo(b.getInmuebleInternas.condominioPrivado.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleInternas.condominioPrivado){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleInternas.condominioPrivado){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleInternas.condominioPrivado){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleInternas.condominioPrivado){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleInternas.condominioPrivado){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["cancha"]!=null){
      if(mapFiltro["cancha"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleInternas.isCancha.toString().length.compareTo(b.getInmuebleInternas.isCancha.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleInternas.isCancha){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleInternas.isCancha){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleInternas.isCancha){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleInternas.isCancha){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleInternas.isCancha){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["piscina"]!=null){
      if(mapFiltro["piscina"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleInternas.isPiscina.toString().length.compareTo(b.getInmuebleInternas.isPiscina.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleInternas.isPiscina){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleInternas.isPiscina){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleInternas.isPiscina){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleInternas.isPiscina){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleInternas.isPiscina){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["sauna"]!=null){
      if(mapFiltro["sauna"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleInternas.isSauna.toString().length.compareTo(b.getInmuebleInternas.isSauna.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleInternas.isSauna){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleInternas.isSauna){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleInternas.isSauna){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleInternas.isSauna){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleInternas.isSauna){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["jacuzzi"]!=null){
      if(mapFiltro["jacuzzi"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleInternas.jacuzzi.toString().length.compareTo(b.getInmuebleInternas.jacuzzi.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleInternas.jacuzzi){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleInternas.jacuzzi){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleInternas.jacuzzi){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleInternas.jacuzzi){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleInternas.jacuzzi){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["estudio"]!=null){
      if(mapFiltro["estudio"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleInternas.isEstudio.toString().length.compareTo(b.getInmuebleInternas.isEstudio.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleInternas.isEstudio){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleInternas.isEstudio){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleInternas.isEstudio){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleInternas.isEstudio){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleInternas.isEstudio){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["jardin"]!=null){
      if(mapFiltro["jardin"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleInternas.isJardin.toString().length.compareTo(b.getInmuebleInternas.isJardin.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleInternas.isJardin){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleInternas.isJardin){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleInternas.isJardin){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleInternas.isJardin){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleInternas.isJardin){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["porton_electrico"]!=null){
      if(mapFiltro["porton_electrico"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleInternas.portonElectrico.toString().length.compareTo(b.getInmuebleInternas.portonElectrico.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleInternas.portonElectrico){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleInternas.portonElectrico){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleInternas.portonElectrico){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleInternas.portonElectrico){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleInternas.portonElectrico){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["aire_acondicionado"]!=null){
      if(mapFiltro["aire_acondicionado"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleInternas.aireAcondicionado.toString().length.compareTo(b.getInmuebleInternas.aireAcondicionado.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleInternas.aireAcondicionado){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleInternas.aireAcondicionado){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleInternas.aireAcondicionado){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleInternas.aireAcondicionado){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleInternas.aireAcondicionado){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["calefaccion"]!=null){
      if(mapFiltro["calefaccion"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleInternas.calefaccion.toString().length.compareTo(b.getInmuebleInternas.calefaccion.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleInternas.calefaccion){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleInternas.calefaccion){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleInternas.calefaccion){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleInternas.calefaccion){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleInternas.calefaccion){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["ascensor"]!=null){
      if(mapFiltro["ascensor"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleInternas.isAscensor.toString().length.compareTo(b.getInmuebleInternas.isAscensor.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleInternas.isAscensor){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleInternas.isAscensor){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleInternas.isAscensor){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleInternas.isAscensor){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleInternas.isAscensor){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["deposito"]!=null){
      if(mapFiltro["deposito"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleInternas.isDeposito.toString().length.compareTo(b.getInmuebleInternas.isDeposito.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleInternas.isSotano){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleInternas.isDeposito){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleInternas.isDeposito){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleInternas.isDeposito){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleInternas.isDeposito){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["sotano"]!=null){
      if(mapFiltro["sotano"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleInternas.isSotano.toString().length.compareTo(b.getInmuebleInternas.isSotano.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleInternas.isSotano){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleInternas.isSotano){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleInternas.isSotano){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleInternas.isSotano){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleInternas.isSotano){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["balcon"]!=null){
      if(mapFiltro["balcon"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleInternas.isBalcon.toString().length.compareTo(b.getInmuebleInternas.isBalcon.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleInternas.isBalcon){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleInternas.isBalcon){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleInternas.isBalcon){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleInternas.isBalcon){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleInternas.isBalcon){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["tienda"]!=null){
      if(mapFiltro["tienda"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleInternas.isTienda.toString().length.compareTo(b.getInmuebleInternas.isTienda.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleInternas.isTienda){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleInternas.isTienda){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleInternas.isSauna){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleInternas.isTienda){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleInternas.isTienda){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["amurallado_terreno"]!=null){
      if(mapFiltro["amurallado_terreno"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleInternas.amuralladoTerreno.toString().length.compareTo(b.getInmuebleInternas.amuralladoTerreno.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleInternas.amuralladoTerreno){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleInternas.amuralladoTerreno){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleInternas.amuralladoTerreno){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleInternas.amuralladoTerreno){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleInternas.amuralladoTerreno){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["iglesia"]!=null){
      if(mapFiltro["iglesia"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleComunidad.isIglesia.toString().length.compareTo(b.getInmuebleComunidad.isIglesia.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleComunidad.isIglesia){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleComunidad.isIglesia){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleComunidad.isIglesia){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleComunidad.isIglesia){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleComunidad.isIglesia){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["parque_infantil"]!=null){
      if(mapFiltro["parque_infantil"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleComunidad.parqueInfantil.toString().length.compareTo(b.getInmuebleComunidad.parqueInfantil.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleComunidad.parqueInfantil){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleComunidad.parqueInfantil){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleComunidad.parqueInfantil){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleComunidad.parqueInfantil){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleComunidad.parqueInfantil){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["escuela"]!=null){
      if(mapFiltro["escuela"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleComunidad.escuela.toString().length.compareTo(b.getInmuebleComunidad.escuela.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleComunidad.escuela){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleComunidad.escuela){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleComunidad.escuela){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleComunidad.escuela){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleComunidad.escuela){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["universidad"]!=null){
      if(mapFiltro["universidad"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleComunidad.universidad.toString().length.compareTo(b.getInmuebleComunidad.universidad.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleComunidad.universidad){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleComunidad.universidad){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleComunidad.universidad){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleComunidad.universidad){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleComunidad.universidad){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["plazuela"]!=null){
      if(mapFiltro["plazuela"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleComunidad.plazuela.toString().length.compareTo(b.getInmuebleComunidad.plazuela.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleComunidad.plazuela){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleComunidad.plazuela){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleComunidad.plazuela){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleComunidad.plazuela){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleComunidad.plazuela){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["modulo_policial"]!=null){
      if(mapFiltro["modulo_policial"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleComunidad.moduloPolicial.toString().length.compareTo(b.getInmuebleComunidad.moduloPolicial.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleComunidad.moduloPolicial){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleComunidad.moduloPolicial){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleComunidad.moduloPolicial){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleComunidad.moduloPolicial){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleComunidad.moduloPolicial){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["sauna_piscina_publica"]!=null){
      if(mapFiltro["sauna_piscina_publica"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleComunidad.saunaPiscinaPublica.toString().length.compareTo(b.getInmuebleComunidad.saunaPiscinaPublica.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleComunidad.saunaPiscinaPublica){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleComunidad.saunaPiscinaPublica){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleComunidad.saunaPiscinaPublica){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleComunidad.saunaPiscinaPublica){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleComunidad.saunaPiscinaPublica){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["gym_publico"]!=null){
      if(mapFiltro["gym_publico"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleComunidad.gymPublico.toString().length.compareTo(b.getInmuebleComunidad.gymPublico.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleComunidad.gymPublico){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleComunidad.gymPublico){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleComunidad.gymPublico){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleComunidad.gymPublico){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleComunidad.gymPublico){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["centro_deportivo"]!=null){
      if(mapFiltro["centro_deportivo"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleComunidad.centroDeportivo.toString().length.compareTo(b.getInmuebleComunidad.centroDeportivo.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleComunidad.centroDeportivo){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleComunidad.centroDeportivo){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleComunidad.centroDeportivo){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleComunidad.centroDeportivo){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleComunidad.centroDeportivo){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["puesto_salud"]!=null){
      if(mapFiltro["puesto_salud"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleComunidad.puestoSalud.toString().length.compareTo(b.getInmuebleComunidad.puestoSalud.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleComunidad.puestoSalud){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleComunidad.puestoSalud){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleComunidad.puestoSalud){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleComunidad.puestoSalud){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleComunidad.puestoSalud){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["zona_comercial"]!=null){
      if(mapFiltro["zona_comercial"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleComunidad.zonaComercial.toString().length.compareTo(b.getInmuebleComunidad.zonaComercial.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleComunidad.zonaComercial){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleComunidad.zonaComercial){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleComunidad.zonaComercial){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleComunidad.zonaComercial){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleComunidad.zonaComercial){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["rebajados"]!=null){
      if(mapFiltro["rebajados"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmueble.isRebajado.toString().length.compareTo(b.getInmueble.isRebajado.toString().length));
        if(inmueblesAux.elementAt(0).getInmueble.isRebajado){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmueble.isRebajado){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmueble.isRebajado){
                if(!inmueblesAux.elementAt(mitad+1).getInmueble.isRebajado){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmueble.isRebajado){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["vistos"]!=null){
      if(mapFiltro["vistos"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getUsuarioFavorito.visto.toString().length.compareTo(b.getUsuarioFavorito.visto.toString().length));
        if(inmueblesAux.elementAt(0).getUsuarioFavorito.visto){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getUsuarioFavorito.visto){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getUsuarioFavorito.visto){
                if(!inmueblesAux.elementAt(mitad+1).getUsuarioFavorito.visto){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getUsuarioFavorito.visto){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["doble_visto"]!=null){
      if(mapFiltro["doble_visto"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getUsuarioFavorito.dobleVisto.toString().length.compareTo(b.getUsuarioFavorito.dobleVisto.toString().length));
        if(inmueblesAux.elementAt(0).getUsuarioFavorito.dobleVisto){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getUsuarioFavorito.dobleVisto){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getUsuarioFavorito.dobleVisto){
                if(!inmueblesAux.elementAt(mitad+1).getUsuarioFavorito.dobleVisto){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getUsuarioFavorito.dobleVisto){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["favoritos"]!=null){
      if(mapFiltro["favoritos"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getUsuarioFavorito.favorito.toString().length.compareTo(b.getUsuarioFavorito.favorito.toString().length));
        if(inmueblesAux.elementAt(0).getUsuarioFavorito.favorito){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getUsuarioFavorito.favorito){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getUsuarioFavorito.favorito){
                if(!inmueblesAux.elementAt(mitad+1).getUsuarioFavorito.favorito){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getUsuarioFavorito.favorito){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["verificados"]!=null){
      if(mapFiltro["verificados"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getCreador.verificado.toString().length.compareTo(b.getCreador.verificado.toString().length));
        if(inmueblesAux.elementAt(0).getCreador.verificado){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getCreador.verificado){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getCreador.verificado){
                if(!inmueblesAux.elementAt(mitad+1).getCreador.verificado){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getCreador.verificado){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["remates_judiciales"]!=null){
      if(mapFiltro["remates_judiciales"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleOtros.isRematesJudiciales.toString().length.compareTo(b.getInmuebleOtros.isRematesJudiciales.toString().length));
        if(inmueblesAux.elementAt(0).getInmuebleOtros.isRematesJudiciales){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleOtros.isRematesJudiciales){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleOtros.isRematesJudiciales){
                if(!inmueblesAux.elementAt(mitad+1).getInmuebleOtros.isRematesJudiciales){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleOtros.isRematesJudiciales){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["dias_P360_min"]!=null){
      if(mapFiltro["dias_P360_min"]>0&&mapFiltro["dias_P360_max"]>0&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmueble.getDiasEntreFechas.compareTo(b.getInmueble.getDiasEntreFechas));
        int contador=0;
        mitad=0;
        inferior=0;
        superior=inmueblesAux.length-1;
        if(mapFiltro["dias_P360_min"]>inmueblesAux.elementAt(0).getInmueble.getDiasEntreFechas){
          if(mapFiltro["dias_P360_min"]<=inmueblesAux.elementAt(superior).getInmueble.getDiasEntreFechas){
            if(inmueblesAux.elementAt(0).getInmueble.getDiasEntreFechas<inmueblesAux.elementAt(superior).getInmueble.getDiasEntreFechas){
              while(inferior<=superior){
                mitad=((inferior+superior)/2).floor();
                if(inmueblesAux.elementAt(mitad).getInmueble.getDiasEntreFechas<mapFiltro["dias_P360_min"]){
                  if(inmueblesAux.elementAt(mitad+1).getInmueble.getDiasEntreFechas>=mapFiltro["dias_P360_min"]){
                    break;
                  }else{
                    inferior=mitad+1;
                  }
                }else{
                  if(inmueblesAux.elementAt(mitad).getInmueble.getDiasEntreFechas>mapFiltro["dias_P360_min"]){
                    superior=mitad;
                  }else{
                    if(inmueblesAux.elementAt(mitad-1).getInmueble.getDiasEntreFechas<mapFiltro["dias_P360_min"]){
                      mitad=mitad-1;
                      break;
                    }else{
                      superior=mitad-1;
                    }
                  }
                }
                contador++;
                if(contador>=100){
                  break;
                }
              }
              
              inmueblesAux.removeRange(0, mitad+1);
            }
          }else{
            inmueblesAux.removeRange(0, inmueblesAux.length);
          }
        }
      }
      if(mapFiltro["dias_P360_min"]<mapFiltro["dias_P360_max"]){
        if(inmueblesAux.length>0){
          inmueblesAux.sort((a,b)=>a.getInmueble.getDiasEntreFechas.compareTo(b.getInmueble.getDiasEntreFechas));
          
          int contador=0;
          mitad=0;
          inferior=0;
          superior=inmueblesAux.length-1;
          if(mapFiltro["dias_P360_max"]<inmueblesAux.elementAt(superior).getInmueble.getDiasEntreFechas){
            if(mapFiltro["dias_P360_max"]>=inmueblesAux.elementAt(0).getInmueble.getDiasEntreFechas){
              if(inmueblesAux.elementAt(0).getInmueble.getDiasEntreFechas<inmueblesAux.elementAt(superior).getInmueble.getDiasEntreFechas){
                while(inferior<=superior){
                  mitad=((inferior+superior)/2).floor();
                  if(inmueblesAux.elementAt(mitad).getInmueble.getDiasEntreFechas>mapFiltro["dias_P360_max"]){
                    if(inmueblesAux.elementAt(mitad-1).getInmueble.getDiasEntreFechas<=mapFiltro["dias_P360_max"]){
                      mitad=mitad-1;
                      break;
                    }else{
                      superior=mitad-1;
                    }
                  }else{
                    if(inmueblesAux.elementAt(mitad).getInmueble.getDiasEntreFechas<mapFiltro["dias_P360_max"]){
                      if(inmueblesAux.elementAt(mitad+1).getInmueble.getDiasEntreFechas>mapFiltro["dias_P360_max"]){
                        break;
                      }else{
                        inferior=mitad+1;
                      }
                      inferior=mitad;
                    }else{
                      if(inmueblesAux.elementAt(mitad+1).getInmueble.getDiasEntreFechas>mapFiltro["dias_P360_max"]){
                        mitad=mitad+1;
                        break;
                      }else{
                        inferior=mitad+1;
                      }
                    } 
                  }
                  contador++;
                  if(contador>=100){
                    break;
                  }
                }
                inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
              }
            }else{
              inmueblesAux.removeRange(0, inmueblesAux.length);
            }
          }
        }
      }
    }
    if(mapFiltro["negociado_inicial"]!=null){
      if(mapFiltro["negociado_inicial"]&&inmueblesAux.length>0){
        inmueblesAux.removeWhere((element) => element.getInmueble.estadoNegociacion!="Negociado inicial");
      }
    }
    if(mapFiltro["negociado_avanzado"]!=null){
      if(mapFiltro["negociado_avanzado"]&&inmueblesAux.length>0){
        inmueblesAux.removeWhere((element) => element.getInmueble.estadoNegociacion.length<17);
      }
    }
    if(mapFiltro["imagenes_2D"]!=null){
      if(mapFiltro["imagenes_2D"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleOtros.getImagenes2DLink.length.compareTo(b.getInmuebleOtros.getImagenes2DLink.length));
        
        if(inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleOtros.getImagenes2DLink.length>0){
          if(inmueblesAux.elementAt(0).getInmuebleOtros.getImagenes2DLink.length==0){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleOtros.getImagenes2DLink.length==0){
                if(inmueblesAux.elementAt(mitad+1).getInmuebleOtros.getImagenes2DLink.length>0){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleOtros.getImagenes2DLink.length==0){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(0, mitad+1);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["video_2D"]!=null){
      if(mapFiltro["video_2D"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleOtros.getVideo2DLink.length.compareTo(b.getInmuebleOtros.getVideo2DLink.length));
        if(inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleOtros.getVideo2DLink.length>0){
          if(inmueblesAux.elementAt(0).getInmuebleOtros.getVideo2DLink.length==0){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleOtros.getVideo2DLink.length==0){
                if(inmueblesAux.elementAt(mitad+1).getInmuebleOtros.getVideo2DLink.length>0){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleOtros.getVideo2DLink.length==0){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(0, mitad+1);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["tour_virtual_360"]!=null){
      if(mapFiltro["tour_virtual_360"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleOtros.getTourVirtual360Link.length.compareTo(b.getInmuebleOtros.getTourVirtual360Link.length));
        if(inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleOtros.getTourVirtual360Link.length>0){
          if(inmueblesAux.elementAt(0).getInmuebleOtros.getTourVirtual360Link.length==0){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleOtros.getTourVirtual360Link.length==0){
                if(inmueblesAux.elementAt(mitad+1).getInmuebleOtros.getTourVirtual360Link.length>0){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleOtros.getTourVirtual360Link.length==0){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(0, mitad+1);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["video_tour_360"]!=null){
      if(mapFiltro["video_tour_360"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getInmuebleOtros.getVideoTour360Link.length.compareTo(b.getInmuebleOtros.getVideoTour360Link.length));
        if(inmueblesAux.elementAt(inmueblesAux.length-1).getInmuebleOtros.getVideoTour360Link.length>0){
          if(inmueblesAux.elementAt(0).getInmuebleOtros.getVideoTour360Link.length==0){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getInmuebleOtros.getVideoTour360Link.length==0){
                if(inmueblesAux.elementAt(mitad+1).getInmuebleOtros.getVideoTour360Link.length>0){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getInmuebleOtros.getVideoTour360Link.length==0){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(0,mitad+1);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["favoritos"]!=null){
      if(mapFiltro["favoritos"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getUsuarioFavorito.isFavorito.toString().length.compareTo(b.getUsuarioFavorito.isFavorito.toString().length));
        
        if(inmueblesAux.elementAt(0).getUsuarioFavorito.isFavorito){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getUsuarioFavorito.isFavorito){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getUsuarioFavorito.isFavorito){
                if(!inmueblesAux.elementAt(mitad+1).getUsuarioFavorito.isFavorito){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getUsuarioFavorito.isFavorito){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["vistos"]!=null){
      if(mapFiltro["vistos"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getUsuarioFavorito.isVisto.toString().length.compareTo(b.getUsuarioFavorito.isVisto.toString().length));
        
        if(inmueblesAux.elementAt(0).getUsuarioFavorito.isVisto){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getUsuarioFavorito.isVisto){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getUsuarioFavorito.isVisto){
                if(!inmueblesAux.elementAt(mitad+1).getUsuarioFavorito.isVisto){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getUsuarioFavorito.isVisto){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["doble_visto"]!=null){
      if(mapFiltro["doble_visto"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getUsuarioFavorito.isDobleVisto.toString().length.compareTo(b.getUsuarioFavorito.isDobleVisto.toString().length));
        
        if(inmueblesAux.elementAt(0).getUsuarioFavorito.isDobleVisto){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getUsuarioFavorito.isDobleVisto){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getUsuarioFavorito.isDobleVisto){
                if(!inmueblesAux.elementAt(mitad+1).getUsuarioFavorito.isDobleVisto){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getUsuarioFavorito.isDobleVisto){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    if(mapFiltro["contactados"]!=null){
      if(mapFiltro["contactados"]&&inmueblesAux.length>0){
        inmueblesAux.sort((a,b)=>a.getUsuarioFavorito.isContactado.toString().length.compareTo(b.getUsuarioFavorito.isContactado.toString().length));
        if(inmueblesAux.elementAt(0).getUsuarioFavorito.isContactado){
          if(!inmueblesAux.elementAt(inmueblesAux.length-1).getUsuarioFavorito.isContactado){
            mitad=0;
            inferior=0;
            superior=inmueblesAux.length-1;
            while(inferior<superior){
              mitad=((inferior+superior)/2).floor();
              if(inmueblesAux.elementAt(mitad).getUsuarioFavorito.isContactado){
                if(!inmueblesAux.elementAt(mitad+1).getUsuarioFavorito.isContactado){
                  break;
                }else{
                  inferior=mitad+1;
                }
              }else{
                if(inmueblesAux.elementAt(mitad-1).getUsuarioFavorito.isContactado){
                  mitad=mitad-1;
                  break;
                }else{
                  superior=mitad-1;
                }
              }
            }
            inmueblesAux.removeRange(mitad+1, inmueblesAux.length);
          }
        } else{
          inmueblesAux.removeRange(0, inmueblesAux.length);
        }
      }
    }
    return inmueblesAux;
}
List<InmuebleTotal> filtrarInmueblesOrdenarBase(List<InmuebleTotal> inmueblesAux,
                              MapaFiltroOtrosInfo _mapaFiltroOtros,
                              List<UsuarioInmuebleBase> usuarioInmuebleBases,
                              MapaFiltroPrincipalesInfo _mapaFiltroPrincipales
                              ){
  
    
    //print("tamanio  "+usuarioInmuebleBases.length.toString());
    usuarioInmuebleBases.sort((a,b)=>a.tipo.compareTo(b.tipo));
    List<InmuebleTotal> inmueblesPromocionados360=seleccionarPromocionados360(inmueblesAux,_mapaFiltroOtros,usuarioInmuebleBases[2],_mapaFiltroPrincipales.getMapaFiltro["tipo_contrato"]);
    List<InmuebleTotal> inmueblesPromocionados=seleccionarPromocionados(inmueblesAux,_mapaFiltroOtros,usuarioInmuebleBases[0],_mapaFiltroPrincipales.getMapaFiltro["tipo_contrato"]);
    //List<InmuebleTotal> inmueblesRebajados=seleccionarRebajados(inmueblesAux,_mapaFiltroOtros,usuarioInmuebleBases[1],_mapaFiltroPrincipales.getMapaFiltro["tipo_contrato"]);
   // print(usuarioInmuebleBases[1].usuarioInmuebleBaseToMap());
    Map<String,dynamic> interesesMap=ordenarListaPorIntereses(inmueblesAux,_mapaFiltroOtros,usuarioInmuebleBases[1],_mapaFiltroPrincipales.getMapaFiltro["tipo_contrato"]);
    List<InmuebleTotal> inmueblesOrganico=interesesMap["organicos"];
    List<InmuebleTotal> inmueblesResidual=interesesMap["residuales"];
    List<String> secuencia=["pro360","pro","orgánico"];
    // ignore: unused_local_variable
    int contadorPublicidad=0;
    int posicionPublicidad=0;
    inmueblesAux=[];
    int i=0;
    while(true){
      if(inmueblesPromocionados.length==0&&inmueblesPromocionados360.length==0&&inmueblesOrganico.length==0){
        break;
      }
      if(secuencia[i]=="orgánico"){
        print("inmuebles organico ${inmueblesOrganico.length}");
        if(inmueblesOrganico.length>=5){
          List<InmuebleTotal> inmueblesTemporal=[];
          inmueblesTemporal.addAll(inmueblesOrganico.getRange(0, 5));
          if(contadorPublicidad<3){
            InmuebleTotal inmuebleTotal=InmuebleTotal.vacio();
            inmuebleTotal.inmueble.indice=-1;
            inmuebleTotal.inmueble.categoria="Cuadrado";
            inmueblesTemporal.add(inmuebleTotal);
            posicionPublicidad=3;
            inmueblesAux.addAll(inmueblesTemporal);
            inmueblesOrganico.removeRange(0, 5);
            contadorPublicidad++;
          }else{
            break;
          }
          
        }else{
          inmueblesResidual.addAll(inmueblesOrganico);
          inmueblesOrganico=[];
        }
      }else if(secuencia[i]=="pro"){
        if(inmueblesPromocionados.length>=10){
          List<InmuebleTotal> inmueblesTemporal=[];
          inmueblesTemporal.addAll(inmueblesPromocionados.getRange(0, 10));
          if(contadorPublicidad<3){
            InmuebleTotal inmuebleTotal=InmuebleTotal.vacio();
            inmuebleTotal.inmueble.indice=-1;
            inmuebleTotal.inmueble.categoria="Cuadrado";
            inmueblesTemporal.add(inmuebleTotal);
            posicionPublicidad=3;
            inmueblesAux.addAll(inmueblesTemporal);
            inmueblesPromocionados.removeRange(0, 10);
            contadorPublicidad++;
          }else{
            break;
          }
          
        }else{
          inmueblesResidual.addAll(inmueblesPromocionados);
          inmueblesPromocionados=[];
        }
      }else if(secuencia[i]=="pro360"){
        if(inmueblesPromocionados360.length>=10){
          List<InmuebleTotal> inmueblesTemporal=[];
          inmueblesTemporal.addAll(inmueblesPromocionados360.getRange(0, 10));
          if(contadorPublicidad<3){
            InmuebleTotal inmuebleTotal=InmuebleTotal.vacio();
            inmuebleTotal.inmueble.indice=-1;
            inmuebleTotal.inmueble.categoria="Cuadrado";
            inmueblesTemporal.add(inmuebleTotal);
            posicionPublicidad=3;
            inmueblesAux.addAll(inmueblesTemporal);
            inmueblesPromocionados360.removeRange(0, 10);
            contadorPublicidad++;
          }else{
            break;
          }
          
        }else{
          inmueblesResidual.addAll(inmueblesPromocionados360);
          inmueblesPromocionados360=[];
        }
      }
      if(i<secuencia.length-1){
        i++;
      }else{
        i=0;
      }
      //print("i : "+i.toString());
    }
    inmueblesResidual.addAll(inmueblesPromocionados360);
    inmueblesResidual.addAll(inmueblesPromocionados);
    inmueblesResidual.addAll(inmueblesOrganico);
    ordenarLista(inmueblesResidual,_mapaFiltroOtros.getMapaFiltroOrden);
    int limite=inmueblesResidual.length;
    
    for(int i=3;i<limite;i=i+3){
      //i==0&&inmueblesAux.length==0){}
      //else{
        InmuebleTotal inmuebleTotal=InmuebleTotal.vacio();
        inmuebleTotal.inmueble.indice=-1;
        inmuebleTotal.inmueble.categoria="Rectángulo";
        inmueblesResidual.insertAll(i, [inmuebleTotal]);
        i++;
        limite++;
      //W}
    }
    inmueblesAux.addAll(inmueblesResidual);
    return inmueblesAux;
  }
  void ordenarLista(List<InmuebleTotal> inmueblesAux ,Map<String,dynamic> mapaFiltroOrden){
     
     if(mapaFiltroOrden["parametro"]==getParametroOrden.precio.index){
      if(mapaFiltroOrden["orden"]==getOrden.descendente.index){
        inmueblesAux.sort((b,a)=>int.parse(a.getInmueble.historialPrecios[a.inmueble.historialPrecios.length-1].toString()).compareTo(int.parse(b.getInmueble.historialPrecios[b.inmueble.historialPrecios.length-1].toString())),);
      }else{
        inmueblesAux.sort((a,b)=>int.parse(a.getInmueble.historialPrecios[a.inmueble.historialPrecios.length-1].toString()).compareTo(int.parse(b.getInmueble.historialPrecios[b.inmueble.historialPrecios.length-1].toString())),);
      }
    }
    if(mapaFiltroOrden["parametro"]==getParametroOrden.superficieTerreno.index){

      if(mapaFiltroOrden["orden"]==getOrden.descendente.index){
        inmueblesAux.sort((b,a)=>a.getInmueble.getSuperficieTerreno.compareTo(b.getInmueble.getSuperficieTerreno),);
      }else{
        inmueblesAux.sort((a,b)=>a.getInmueble.getSuperficieTerreno.compareTo(b.getInmueble.getSuperficieTerreno),);
      }
    }
    if(mapaFiltroOrden["parametro"]==getParametroOrden.superficieConstruccion.index){
      if(mapaFiltroOrden["orden"]==getOrden.descendente.index){
        inmueblesAux.sort((b,a)=>a.getInmueble.getSuperficieConstruccion.compareTo(b.getInmueble.getSuperficieConstruccion),);
      }else{
        inmueblesAux.sort((a,b)=>a.getInmueble.getSuperficieConstruccion.compareTo(b.getInmueble.getSuperficieConstruccion),);
      }
    }
    if(mapaFiltroOrden["parametro"]==getParametroOrden.tiempoConstruccion.index){
      if(mapaFiltroOrden["orden"]==getOrden.descendente.index){
        inmueblesAux.sort((b,a)=>a.getInmueble.antiguedadConstruccion.compareTo(b.getInmueble.antiguedadConstruccion),);
      }else{
        inmueblesAux.sort((a,b)=>a.getInmueble.antiguedadConstruccion.compareTo(b.getInmueble.antiguedadConstruccion),);
      }
    }
    if(mapaFiltroOrden["parametro"]==getParametroOrden.dormitorios.index){
      if(mapaFiltroOrden["orden"]==getOrden.descendente.index){
        inmueblesAux.sort((b,a)=>a.getInmuebleInternas.getDormitorios.compareTo(b.getInmuebleInternas.getDormitorios),);
      }else{
        inmueblesAux.sort((a,b)=>a.getInmuebleInternas.getDormitorios.compareTo(b.getInmuebleInternas.getDormitorios),);
      }
    }
    if(mapaFiltroOrden["parametro"]==getParametroOrden.vistos.index){
      if(mapaFiltroOrden["orden"]==getOrden.descendente.index){
        inmueblesAux.sort((b,a)=>a.getInmueble.cantidadVistos.compareTo(b.getInmueble.cantidadVistos),);
      }else{
        inmueblesAux.sort((a,b)=>a.getInmueble.cantidadVistos.compareTo(b.getInmueble.cantidadVistos),);
      }
    }
    if(mapaFiltroOrden["parametro"]==getParametroOrden.doble_vistos.index){
      if(mapaFiltroOrden["orden"]==getOrden.descendente.index){
        inmueblesAux.sort((b,a)=>a.getInmueble.cantidadDobleVistos.compareTo(b.getInmueble.cantidadDobleVistos),);
      }else{
        inmueblesAux.sort((a,b)=>a.getInmueble.cantidadDobleVistos.compareTo(b.getInmueble.cantidadDobleVistos),);
      }
    }
    if(mapaFiltroOrden["parametro"]==getParametroOrden.favoritos.index){
      if(mapaFiltroOrden["orden"]==getOrden.descendente.index){
        inmueblesAux.sort((b,a)=>a.getInmueble.cantidadFavoritos.compareTo(b.getInmueble.cantidadFavoritos),);
      }else{
        inmueblesAux.sort((a,b)=>a.getInmueble.cantidadFavoritos.compareTo(b.getInmueble.cantidadFavoritos),);
      }
    }
  }
  Map<String,dynamic> ordenarListaPorIntereses(
    List<InmuebleTotal> inmueblesTotal,
    MapaFiltroOtrosInfo _mapaFiltroOtros,
    UsuarioInmuebleBase usuarioInmuebleBase,
    String tipoContrato
  ){
    List<InmuebleTotal> inmueblesOrganico=[];
    List<InmuebleTotal> inmueblesResidual=[];
    if(usuarioInmuebleBase.precioMax==0){
      
      //print(inmueblesTotal);
      ordenarLista(inmueblesTotal, _mapaFiltroOtros.getMapaFiltroOrden);
      //print(inmueblesTotal);
      return {"residuales":inmueblesTotal,"organicos":inmueblesOrganico};
    }
    //inmueblesAux.addAll(inmueblesTotal);
    List<List<InmuebleTotal>> inmueblesinmueblesTotal=[];
    List<InmuebleBaseParametros> parametros=[];
    parametros=usuarioInmuebleBase.getParametros(tipoContrato);
    for(int i=0;i<parametros.length;i++){
      //print(parametros.elementAt(i).parametro);
      List<InmuebleTotal> it=[];
      inmueblesinmueblesTotal.add(it);
    }
    inmueblesinmueblesTotal.elementAt(0).addAll(inmueblesTotal);
    for(int i=0;i<parametros.length-1;i++){
      inmueblesinmueblesTotal.elementAt(i+1).addAll(seleccionarElementosLista(inmueblesinmueblesTotal.elementAt(i), parametros[i]));
    }
    
    for(int i=parametros.length-1;i>=0;i--){
      if(i==0){
        inmueblesResidual.addAll(inmueblesinmueblesTotal.elementAt(i));
      }else{
        inmueblesOrganico.addAll(inmueblesinmueblesTotal.elementAt(i));
      }
    }
    
    //print("tamanio antes ${inmueblesTotal.length}");
    ordenarLista(inmueblesOrganico, _mapaFiltroOtros.getMapaFiltroOrden);
    return {"residuales":inmueblesResidual,"organicos":inmueblesOrganico};
  }
  List<InmuebleTotal> seleccionarPromocionados(List<InmuebleTotal> inmueblesAux,MapaFiltroOtrosInfo _mapaFiltroOtros,UsuarioInmuebleBase usuarioInmuebleBase,String tipoContrato){
    List<InmuebleTotal> inmueblesTotalFiltrado=[];
    inmueblesTotalFiltrado.addAll(inmueblesAux.where((element) => element.getInmueble.categoria=="Pro"));
    inmueblesAux.removeWhere((element) => element.getInmueble.categoria=="Pro");
    Map<String,dynamic> im= ordenarListaPorIntereses(inmueblesTotalFiltrado,_mapaFiltroOtros,usuarioInmuebleBase,tipoContrato);
    inmueblesTotalFiltrado=[];
    inmueblesTotalFiltrado.addAll(im["organicos"]);
    inmueblesTotalFiltrado.addAll(im["residuales"]);
    return inmueblesTotalFiltrado;
  }
  List<InmuebleTotal> seleccionarPromocionados360(List<InmuebleTotal> inmueblesAux,MapaFiltroOtrosInfo _mapaFiltroOtros,UsuarioInmuebleBase usuarioInmuebleBase,String tipoContrato){
    List<InmuebleTotal> inmueblesTotalFiltrado=[];
    inmueblesTotalFiltrado.addAll(inmueblesAux.where((element) => element.getInmueble.categoria=="Pro360"));
    inmueblesAux.removeWhere((element) => element.getInmueble.categoria=="Pro360");
    Map<String,dynamic> im= ordenarListaPorIntereses(inmueblesTotalFiltrado,_mapaFiltroOtros,usuarioInmuebleBase,tipoContrato);
    inmueblesTotalFiltrado=[];
    inmueblesTotalFiltrado.addAll(im["organicos"]);
    inmueblesTotalFiltrado.addAll(im["residuales"]);
    return inmueblesTotalFiltrado;
  }
  List<InmuebleTotal> seleccionarRebajados(List<InmuebleTotal> inmueblesAux,MapaFiltroOtrosInfo _mapaFiltroOtros,UsuarioInmuebleBase usuarioInmuebleBase,String tipoContrato){
    List<InmuebleTotal> inmueblesTotalFiltrado=[];
    inmueblesTotalFiltrado.addAll(inmueblesAux.where((element) => element.getInmueble.isRebajado));
    inmueblesAux.removeWhere((element)=>element.getInmueble.isRebajado);
    Map<String,dynamic> im= ordenarListaPorIntereses(inmueblesTotalFiltrado,_mapaFiltroOtros,usuarioInmuebleBase,tipoContrato);
    inmueblesTotalFiltrado=[];
    inmueblesTotalFiltrado.addAll(im["organicos"]);
    inmueblesTotalFiltrado.addAll(im["residuales"]);
    return inmueblesTotalFiltrado;
  }

  List<InmuebleTotal> seleccionarElementosLista(List<InmuebleTotal> inmueblesAux,InmuebleBaseParametros parametro){
    List<InmuebleTotal> inmueblesTotalFiltrado=[];

    if(parametro.parametro=="precio"){
      inmueblesTotalFiltrado.addAll(inmueblesAux.where((element) =>  element.getInmueble.getPrecio>=parametro.min&&element.getInmueble.getPrecio<=parametro.max));
      inmueblesAux.removeWhere((element) => element.getInmueble.getPrecio>=parametro.min&&element.getInmueble.getPrecio<=parametro.max);
    }
    else if(parametro.parametro=="superficie_construccion"){
      inmueblesTotalFiltrado.addAll(inmueblesAux.where((element) =>  element.getInmueble.getSuperficieConstruccion>=parametro.min&&element.getInmueble.getSuperficieConstruccion<=parametro.max));
      inmueblesAux.removeWhere((element) => element.getInmueble.getSuperficieConstruccion>=parametro.min&&element.getInmueble.getSuperficieConstruccion<=parametro.max);
    }else if(parametro.parametro=="superficie_terreno"){
      inmueblesTotalFiltrado.addAll(inmueblesAux.where((element) =>  element.getInmueble.getSuperficieTerreno>=parametro.min&&element.getInmueble.getSuperficieTerreno<=parametro.max));
      inmueblesAux.removeWhere((element) => element.getInmueble.getSuperficieTerreno>=parametro.min&&element.getInmueble.getSuperficieTerreno<=parametro.max);
    }else if(parametro.parametro=="tiempo_construccion"){
      inmueblesTotalFiltrado.addAll(inmueblesAux.where((element) =>  element.getInmueble.antiguedadConstruccion>=parametro.min&&element.getInmueble.antiguedadConstruccion<=parametro.max));
      inmueblesAux.removeWhere((element) => element.getInmueble.antiguedadConstruccion>=parametro.min&&element.getInmueble.antiguedadConstruccion<=parametro.max);
    }else if(parametro.parametro=="dormitorios"){
      inmueblesTotalFiltrado.addAll(inmueblesAux.where((element) =>  element.getInmuebleInternas.getDormitorios>=parametro.min&&element.getInmuebleInternas.getDormitorios<=parametro.max));
      inmueblesAux.removeWhere((element) => element.getInmuebleInternas.getDormitorios>=parametro.min&&element.getInmuebleInternas.getDormitorios<=parametro.max);
    }else if(parametro.parametro=="banios"){
      inmueblesTotalFiltrado.addAll(inmueblesAux.where((element) =>  element.getInmuebleInternas.getBanios>=parametro.min&&element.getInmuebleInternas.getBanios<=parametro.max));
      inmueblesAux.removeWhere((element) => element.getInmuebleInternas.getBanios>=parametro.min&&element.getInmuebleInternas.getBanios<=parametro.max);
    }else if(parametro.parametro=="garaje"){
      inmueblesTotalFiltrado.addAll(inmueblesAux.where((element) =>  element.getInmuebleInternas.getBanios>=parametro.min&&element.getInmuebleInternas.getBanios<=parametro.max));
      inmueblesAux.removeWhere((element) => element.getInmuebleInternas.getBanios>=parametro.min&&element.getInmuebleInternas.getBanios<=parametro.max);
    }
    //print("parametro ${parametro.parametro} ${inmueblesTotalFiltrado[0].getInmueble.getSuperficieConstruccion}" );
    return inmueblesTotalFiltrado;
  }
List<InmuebleTotal> seleccionarInmuebleSimilares(List<InmuebleTotal> inmueblesAux,InmuebleTotal inmueble){
  
  UsuarioInmuebleBase base=UsuarioInmuebleBase(
    id: "", 
    tipo: inmueble.inmueble.tipoContrato, 
    precioMin: inmueble.inmueble.precio-1000,
     precioMax: inmueble.inmueble.precio+1000, 
     dormitoriosMin: inmueble.inmuebleInternas.dormitorios-1, 
     dormitoriosMax: inmueble.inmuebleInternas.dormitorios+1, 
     baniosMin: inmueble.inmuebleInternas.banios-1, 
     baniosMax: inmueble.inmuebleInternas.banios+1, 
     garajeMin: inmueble.inmuebleInternas.garaje-1, 
     garajeMax: inmueble.inmuebleInternas.garaje+1, 
     superficieTerrenoMin: inmueble.inmueble.superficieTerreno-20, 
     superficieTerrenoMax: inmueble.inmueble.superficieTerreno+20,
     superficieConstruccionMin: inmueble.inmueble.superficieConstruccion-20, 
     superficieConstruccionMax: inmueble.inmueble.superficieConstruccion+20,
    antiguedadConstruccionMin: inmueble.inmueble.antiguedadConstruccion-2, 
    antiguedadConstruccionMax: inmueble.inmueble.antiguedadConstruccion+2, 
    cantidadInmuebles: 0, 
    amoblado: 0, 
    lavanderia: 0, 
    cuartoLavado: 0, 
    churrasquero: 0, 
    azotea: 0, condominioPrivado: 0, 
    cancha: 0, piscina: 0, sauna: 0,
     jacuzzi: 0, estudio: 0, jardin: 0, 
     portonElectrico: 0, aireAcondicionado: 0, 
     calefaccion: 0, ascensor: 0, 
     deposito: 0, sotano: 0, balcon: 0, 
     tienda: 0, amuralladoTerreno: 0, 
     fechaInicio: "", fechaUltimoGuardado: "", 
     fechaCache: ""
    );
  List<List<InmuebleTotal>> inmueblesinmueblesTotal=[];
  List<InmuebleBaseParametros> parametros=[];
  parametros=base.getParametros(inmueble.inmueble.tipoContrato);
  for(int i=0;i<parametros.length;i++){
    //print(parametros.elementAt(i).parametro);
    List<InmuebleTotal> it=[];
    inmueblesinmueblesTotal.add(it);
  }
  inmueblesinmueblesTotal.elementAt(0).addAll(inmueblesAux);
  for(int i=0;i<parametros.length-1;i++){
    inmueblesinmueblesTotal.elementAt(i+1).addAll(seleccionarElementosLista(inmueblesinmueblesTotal.elementAt(i), parametros[i]));
  }
  
  List<InmuebleTotal> inmuebleTotalFiltrado=[];
  for(int i=parametros.length-1;i>=0;i--){
    if(i>0){
      inmuebleTotalFiltrado.addAll(inmueblesinmueblesTotal.elementAt(i));
    }
  }
 inmuebleTotalFiltrado.removeWhere((element) => element.inmueble.id==inmueble.inmueble.id);
  return inmuebleTotalFiltrado;
}