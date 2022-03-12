import 'package:flutter/cupertino.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'dart:math';

import 'package:inmobiliariaapp/domain/entities/usuario.dart';

class DatosAutomaticosInmueble{
  Inmueble inmueble;
  InmuebleInternas inmuebleInternas;
  InmuebleComunidad inmuebleComunidad;
  InmueblesOtros inmueblesOtros;
  Usuario creador;
  Usuario propietario;
  DatosAutomaticosInmueble({
    required this.inmueble,
    required this.inmuebleInternas,
    required this.inmuebleComunidad,
    required this.inmueblesOtros,
    required this.creador,
    required this.propietario
  });
  factory DatosAutomaticosInmueble.vacio(){
    return DatosAutomaticosInmueble(
      inmueble: Inmueble.vacio(), 
      inmuebleInternas: InmuebleInternas.vacio(), 
      inmuebleComunidad: InmuebleComunidad.vacio(), 
      inmueblesOtros: InmueblesOtros.vacio(), 
      creador: Usuario.vacio(), 
      propietario: Usuario.vacio()
    );
  }
  void generarDatosAleatorios(
    TextEditingController? _controllerNombrePropietario,
    TextEditingController? _controllerNombreZona,
    TextEditingController? _controllerDireccion,
    TextEditingController? _controllerSuperficieTerreno,
    TextEditingController? _controllerSuperficieConstruccion,
    TextEditingController? _controllerPrecio,
    TextEditingController? _controllerTiempoConstruccion,
    TextEditingController? _controllerNumeroDuenios,
    TextEditingController? _controllerNumeroPisos,
    TextEditingController? _controllerNumeroDormitorios,
    TextEditingController? _controllerNumeroBanios,
    TextEditingController? _controllerNumeroGaraje,
    TextEditingController? _controllerImagenes2D,
    TextEditingController? _controllerVideo2D,
    TextEditingController? _controllerTourVirtual360,
    TextEditingController? _controllerVideoTour360,
    InmuebleTotal inmuebleTotal,
  ){
    List<String> zona=["Zona 1","Zona 2","Zona 3","Zona 4","Zona 5","Zona 6","Zona 7","Zona 8","Zona ","Zona 10"];
    List<String> tipoInmueble=["Casa","Departamento","Terreno"];
    List<String> tipoContrato=["Venta","Alquiler","Anticrético"];
    List<String> imagenes2D=["","www.linkimagenes"];
    List<String> video2D=["","www.linkvideo"];
    List<String> tourvirtual=["","www.linktourvirtual"];
    List<String> videoTour=["","www.linkvideotour"];
    List<bool> valoresBooleanos=[true,false];
    


  var rng = new Random();
  
    
    inmuebleTotal.getInmueble.setCiudad("Sucre");
    int numeroAleatorio=rng.nextInt(zona.length);
    inmuebleTotal.getInmueble.setNombreZona(zona[numeroAleatorio]);
    numeroAleatorio=rng.nextInt(50);
    inmuebleTotal.getInmueble.setDireccion("Dirección "+numeroAleatorio.toString());
    numeroAleatorio=rng.nextInt(tipoInmueble.length);
    inmuebleTotal.getInmueble.setTipoInmueble(tipoInmueble[numeroAleatorio]);
    numeroAleatorio=rng.nextInt(tipoContrato.length);
    inmuebleTotal.getInmueble.setTipoContrato(tipoContrato[numeroAleatorio]);
    numeroAleatorio=20+rng.nextInt(400);
    inmuebleTotal.getInmueble.setPrecio(inmuebleTotal.getInmueble.tipoContrato=="Alquiler"?numeroAleatorio*10:inmuebleTotal.getInmueble.tipoContrato=="Anticrético"?numeroAleatorio*100:numeroAleatorio*1000);
    inmuebleTotal.getInmueble.setEstadoInmueble("");
    inmuebleTotal.getInmueble.autorizacion="Pendiente";
    numeroAleatorio=rng.nextInt(valoresBooleanos.length);
    inmuebleTotal.getInmueble.setPapelesOrden(valoresBooleanos[numeroAleatorio]);
    numeroAleatorio=rng.nextInt(valoresBooleanos.length);
    inmuebleTotal.getInmueble.setConstruccionEstrenar(inmuebleTotal.getInmueble.tipoInmueble=="Terreno"?false:valoresBooleanos[numeroAleatorio]);
    numeroAleatorio=rng.nextInt(valoresBooleanos.length);
    inmuebleTotal.getInmueble.setHabilitadoCredito(valoresBooleanos[numeroAleatorio]);
    numeroAleatorio=5+rng.nextInt(40);
    inmuebleTotal.getInmueble.setSuperficieTerreno(inmuebleTotal.getInmueble.tipoInmueble=="Departamento"?numeroAleatorio*2:numeroAleatorio*10);
    numeroAleatorio=5+rng.nextInt(40);
    inmuebleTotal.getInmueble.setSuperficieConstruccion(inmuebleTotal.getInmueble.tipoInmueble=="Departamento"?numeroAleatorio*2:inmuebleTotal.getInmueble.tipoInmueble=="Casa"?numeroAleatorio*10:0);
    inmuebleTotal.getInmueble.setPreoyectoPreventa(inmuebleTotal.getInmueble.tipoInmueble=="Terreno"?true:false);
    numeroAleatorio=0+rng.nextInt(20);
    inmuebleTotal.getInmueble.setAntiguedadConstruccion(numeroAleatorio);
    numeroAleatorio=rng.nextInt(valoresBooleanos.length);
    inmuebleTotal.getInmueble.setInmuebleCompartido(valoresBooleanos[numeroAleatorio]);
    numeroAleatorio=2+rng.nextInt(10);
    inmuebleTotal.getInmueble.setNumeroDuenios(inmuebleTotal.getInmueble.isInmuebleCompartido?numeroAleatorio:1);
    numeroAleatorio=1+rng.nextInt(15);
    inmuebleTotal.getInmuebleInternas.plantas=inmuebleTotal.getInmueble.tipoInmueble=="Terreno"?0:numeroAleatorio;
    numeroAleatorio=rng.nextInt(valoresBooleanos.length);
    inmuebleTotal.getInmueble.setSinHipoteca(valoresBooleanos[numeroAleatorio]);
    var longitud=-65.22562;
    var latitud=-18.98654;
    inmuebleTotal.getInmueble.coordenadas=[];
    numeroAleatorio=1+rng.nextInt(11);
    inmuebleTotal.getInmueble.coordenadas.add(((latitud-1/numeroAleatorio)*10000).floor()/10000);
    numeroAleatorio=1+rng.nextInt(80);
    inmuebleTotal.getInmueble.coordenadas.add(((longitud-1/numeroAleatorio)*10000).floor()/10000);
    print(inmuebleTotal.getInmueble.coordenadas);
    if(!(inmuebleTotal.getInmueble.tipoInmueble=="Casa"||inmuebleTotal.getInmueble.tipoInmueble=="Departamento")){
      numeroAleatorio=1+rng.nextInt(15);
      inmuebleTotal.getInmuebleInternas.setDormitorios(numeroAleatorio);
      numeroAleatorio=1+rng.nextInt(15);
      inmuebleTotal.getInmuebleInternas.setBanios(numeroAleatorio);
      numeroAleatorio=1+rng.nextInt(15);
      inmuebleTotal.getInmuebleInternas.setGaraje(numeroAleatorio);
      numeroAleatorio=rng.nextInt(valoresBooleanos.length);
      numeroAleatorio=rng.nextInt(valoresBooleanos.length);
      inmuebleTotal.getInmuebleInternas.setLavanderia(valoresBooleanos[numeroAleatorio]);
      numeroAleatorio=rng.nextInt(valoresBooleanos.length);
      inmuebleTotal.getInmuebleInternas.setCuartoLavado(valoresBooleanos[numeroAleatorio]);
      numeroAleatorio=rng.nextInt(valoresBooleanos.length);
      inmuebleTotal.getInmuebleInternas.setChurrasquero(valoresBooleanos[numeroAleatorio]);
      numeroAleatorio=rng.nextInt(valoresBooleanos.length);
      inmuebleTotal.getInmuebleInternas.setAzotea(valoresBooleanos[numeroAleatorio]);
      numeroAleatorio=rng.nextInt(valoresBooleanos.length);
      inmuebleTotal.getInmuebleInternas.setCancha(valoresBooleanos[numeroAleatorio]);
      numeroAleatorio=rng.nextInt(valoresBooleanos.length);
      inmuebleTotal.getInmuebleInternas.setPiscina(valoresBooleanos[numeroAleatorio]);
      numeroAleatorio=rng.nextInt(valoresBooleanos.length);
      inmuebleTotal.getInmuebleInternas.setSauna(valoresBooleanos[numeroAleatorio]);
      numeroAleatorio=rng.nextInt(valoresBooleanos.length);
      inmuebleTotal.getInmuebleInternas.setTienda(valoresBooleanos[numeroAleatorio]);
      numeroAleatorio=rng.nextInt(valoresBooleanos.length);
      inmuebleTotal.getInmuebleInternas.setEstudio(valoresBooleanos[numeroAleatorio]);
      numeroAleatorio=rng.nextInt(valoresBooleanos.length);
      inmuebleTotal.getInmuebleInternas.setJardin(valoresBooleanos[numeroAleatorio]);
      numeroAleatorio=rng.nextInt(valoresBooleanos.length);
      inmuebleTotal.getInmuebleInternas.setBalcon(valoresBooleanos[numeroAleatorio]);
      numeroAleatorio=rng.nextInt(valoresBooleanos.length);
      inmuebleTotal.getInmuebleInternas.setAscensor(valoresBooleanos[numeroAleatorio]);
      numeroAleatorio=rng.nextInt(valoresBooleanos.length);
      inmuebleTotal.getInmuebleInternas.setSotano(valoresBooleanos[numeroAleatorio]);
      numeroAleatorio=rng.nextInt(valoresBooleanos.length);
      inmuebleTotal.getInmuebleInternas.setDeposito(valoresBooleanos[numeroAleatorio]);
    }else{
      inmuebleTotal.inmuebleInternas=InmuebleInternas.vacio();
    }
    numeroAleatorio=rng.nextInt(valoresBooleanos.length);
    inmuebleTotal.getInmuebleComunidad.setIglesia(valoresBooleanos[numeroAleatorio]);
    numeroAleatorio=rng.nextInt(valoresBooleanos.length);
    inmuebleTotal.getInmuebleComunidad.setParqueInfantil(valoresBooleanos[numeroAleatorio]);
    numeroAleatorio=rng.nextInt(valoresBooleanos.length);
    inmuebleTotal.getInmuebleComunidad.setCentroDeportivo(valoresBooleanos[numeroAleatorio]);
    numeroAleatorio=rng.nextInt(valoresBooleanos.length);
    inmuebleTotal.getInmuebleComunidad.setModuloPolicial(valoresBooleanos[numeroAleatorio]);
    numeroAleatorio=rng.nextInt(valoresBooleanos.length);
    inmuebleTotal.getInmuebleComunidad.gymPublico=valoresBooleanos[numeroAleatorio];
    numeroAleatorio=rng.nextInt(valoresBooleanos.length);
    inmuebleTotal.getInmuebleComunidad.escuela=valoresBooleanos[numeroAleatorio];
    numeroAleatorio=rng.nextInt(valoresBooleanos.length);
    inmuebleTotal.getInmuebleComunidad.setZonaComercial(valoresBooleanos[numeroAleatorio]);
    numeroAleatorio=rng.nextInt(valoresBooleanos.length);
    inmuebleTotal.getInmuebleOtros.setRematesJudiciales(valoresBooleanos[numeroAleatorio]);
    numeroAleatorio=rng.nextInt(imagenes2D.length);
    inmuebleTotal.getInmuebleOtros.setImagenes2DLink(imagenes2D[numeroAleatorio]);
    numeroAleatorio=rng.nextInt(video2D.length);
    inmuebleTotal.getInmuebleOtros.setImagenes2DLink(video2D[numeroAleatorio]);
    numeroAleatorio=rng.nextInt(tourvirtual.length);
    inmuebleTotal.getInmuebleOtros.setImagenes2DLink(tourvirtual[numeroAleatorio]);
    numeroAleatorio=rng.nextInt(videoTour.length);
    inmuebleTotal.getInmuebleOtros.setImagenes2DLink(videoTour[numeroAleatorio]);
    _controllerNombreZona!.text=inmuebleTotal.getInmueble.nombreZona;
    _controllerDireccion!.text=inmuebleTotal.getInmueble.direccion;
    _controllerPrecio!.text=inmuebleTotal.getInmueble.precio.toString();
    _controllerSuperficieTerreno!.text=inmuebleTotal.getInmueble.superficieTerreno.toString();
    _controllerSuperficieConstruccion!.text=inmuebleTotal.getInmueble.superficieConstruccion.toString();
    _controllerTiempoConstruccion!.text=inmuebleTotal.getInmueble.antiguedadConstruccion.toString();
    _controllerNumeroDuenios!.text=inmuebleTotal.getInmueble.numeroDuenios.toString();
    _controllerNumeroPisos!.text=inmuebleTotal.getInmuebleInternas.plantas.toString();
    _controllerNumeroDormitorios!.text=inmuebleTotal.getInmuebleInternas.dormitorios.toString();
    _controllerNumeroBanios!.text=inmuebleTotal.getInmuebleInternas.banios.toString();
    _controllerNumeroGaraje!.text=inmuebleTotal.getInmuebleInternas.garaje.toString();
    _controllerImagenes2D!.text=inmuebleTotal.getInmuebleOtros.imagenes2DLink;
    _controllerVideo2D!.text=inmuebleTotal.getInmuebleOtros.video2DLink;
    _controllerTourVirtual360!.text=inmuebleTotal.getInmuebleOtros.tourVirtual360Link;
    _controllerVideoTour360!.text=inmuebleTotal.getInmuebleOtros.videoTour360Link;
  }
}