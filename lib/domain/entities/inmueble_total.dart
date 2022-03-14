import 'package:inmobiliariaapp/domain/entities/inmueble.dart';
import 'package:inmobiliariaapp/domain/entities/solicitud_administrador.dart';
import 'package:inmobiliariaapp/domain/entities/usuario.dart';
import 'package:inmobiliariaapp/domain/entities/usuarios_inmuebles_favoritos.dart';

class InmuebleTotal{
  Inmueble inmueble;
  InmuebleInternas inmuebleInternas;
  InmuebleComunidad inmuebleComunidad;
  InmueblesOtros inmueblesOtros;
  InmuebleComprobante inmuebleComprobante;
  Usuario creador;
  Usuario propietario;
  SolicitudAdministrador solicitudAdministrador;
  UsuariosInmueblesFavoritos usuarioFavorito;
  InmuebleTotal({
    required this.inmueble,
    required this.inmuebleInternas,
    required this.inmuebleComunidad,
    required this.inmueblesOtros,
    required this.inmuebleComprobante,
    required this.propietario,
    required this.creador,
    required this.usuarioFavorito,
    required this.solicitudAdministrador,
  });
  Inmueble get getInmueble=>this.inmueble;
  InmuebleInternas get getInmuebleInternas=>this.inmuebleInternas;
  InmuebleComunidad get getInmuebleComunidad=>this.inmuebleComunidad;
  InmueblesOtros get getInmuebleOtros=>this.inmueblesOtros;
  Usuario get getCreador=>this.creador;
  Usuario get getPropietario=>this.propietario;
  UsuariosInmueblesFavoritos get getUsuarioFavorito=>this.usuarioFavorito;
  SolicitudAdministrador get getSolicitudAdministrador=>this.solicitudAdministrador;
  factory InmuebleTotal.fromMap(String tipoSesion,Map<String,dynamic> mapData){
    //print("map c ${mapData["creador"].toString()}");
    
    if(tipoSesion=="Comprar"||tipoSesion=="Observar"){
      //print("aque ${mapData["usuarios_favorito"]}");
      return InmuebleTotal(
        inmueble: Inmueble.fromMap(mapData), 
        inmuebleInternas: InmuebleInternas.fromMap(mapData),
        inmuebleComunidad: InmuebleComunidad.fromMap(mapData),
        inmueblesOtros: InmueblesOtros.fromMap(mapData),
        inmuebleComprobante: InmuebleComprobante.vacio(),
        propietario: Usuario.fromMap(mapData["propietario"]),
        creador: Usuario.fromMap(mapData["creador"]),
        usuarioFavorito: mapData["usuarios_favorito"].length>0?
          UsuariosInmueblesFavoritos.fromMap(mapData["usuarios_favorito"][0]):
          UsuariosInmueblesFavoritos.vacio(),
        solicitudAdministrador: SolicitudAdministrador.vacio());
    }else if(tipoSesion=="Administrar"){
      /*if(mapData["inmueble"]["precio"]==160000){
        print(mapData["inmueble"]["comprobante"]);
      }*/
      print(mapData);
      return InmuebleTotal(
        inmueble: Inmueble.fromMap(mapData["inmueble"]), 
        inmuebleInternas: InmuebleInternas.fromMap(mapData["inmueble"]),
        inmuebleComunidad: InmuebleComunidad.fromMap(mapData["inmueble"]),
        inmueblesOtros: InmueblesOtros.fromMap(mapData["inmueble"]),
        inmuebleComprobante:  mapData["inmueble"]["comprobante"]!=null?InmuebleComprobante.fromMap(mapData["inmueble"]["comprobante"]):InmuebleComprobante.vacio(),
        propietario: Usuario.fromMap(mapData["inmueble"]["propietario"]),
        creador: Usuario.fromMap(mapData["inmueble"]["creador"]),
        usuarioFavorito: UsuariosInmueblesFavoritos.vacio(),
        solicitudAdministrador: SolicitudAdministrador.fromMap(mapData));
    }else if(tipoSesion=="Vender"){
      //print(mapData["comprobante"]);
      return InmuebleTotal(
        inmueble: Inmueble.fromMap(mapData), 
        inmuebleInternas: InmuebleInternas.fromMap(mapData),
        inmuebleComunidad: InmuebleComunidad.fromMap(mapData),
        inmueblesOtros: InmueblesOtros.fromMap(mapData),
        inmuebleComprobante: mapData["comprobante"]!=null?InmuebleComprobante.fromMap(mapData["comprobante"]):InmuebleComprobante.vacio(),
        propietario: mapData["propietario"]!=null?Usuario.fromMap(mapData["propietario"]):Usuario.vacio(),
        creador: Usuario.fromMap(mapData["creador"]),
        usuarioFavorito: UsuariosInmueblesFavoritos.vacio(),
        solicitudAdministrador: SolicitudAdministrador.vacio());
    }else if(tipoSesion=="Supervisar"){
      /*if(mapData["inmueble"]["precio"]==160000){
        print(mapData["inmueble"]["comprobante"]);
      }*/
      return InmuebleTotal(
        inmueble: Inmueble.fromMap(mapData["inmueble"]), 
        inmuebleInternas: InmuebleInternas.fromMap(mapData["inmueble"]),
        inmuebleComunidad: InmuebleComunidad.fromMap(mapData["inmueble"]),
        inmueblesOtros: InmueblesOtros.fromMap(mapData["inmueble"]),
        inmuebleComprobante:  mapData["inmueble"]["comprobante"]!=null?InmuebleComprobante.fromMap(mapData["inmueble"]["comprobante"]):InmuebleComprobante.vacio(),
        propietario: mapData["inmueble"]["propietario"]!=null?Usuario.fromMap(mapData["inmueble"]["propietario"]):Usuario.vacio(),
        creador: Usuario.fromMap(mapData["inmueble"]["creador"]),
        usuarioFavorito: UsuariosInmueblesFavoritos.vacio(),
        solicitudAdministrador: SolicitudAdministrador.fromMap(mapData));
    }
    return InmuebleTotal.vacio();
  }
  factory InmuebleTotal.vacio(){
    return InmuebleTotal(inmueble: Inmueble.vacio(), inmuebleInternas: InmuebleInternas.vacio(), 
    inmuebleComunidad: InmuebleComunidad.vacio(), inmueblesOtros: InmueblesOtros.vacio(), 
    inmuebleComprobante: InmuebleComprobante.vacio(),propietario: Usuario.vacio(),
    creador: Usuario.vacio(), usuarioFavorito: UsuariosInmueblesFavoritos.vacio(),
    solicitudAdministrador: SolicitudAdministrador.vacio());
  }
  
  factory InmuebleTotal.copiar(InmuebleTotal inmuebleTotal){
    return InmuebleTotal(inmueble: inmuebleTotal.inmueble, 
    inmuebleInternas: inmuebleTotal.inmuebleInternas, 
    inmuebleComunidad: inmuebleTotal.inmuebleComunidad, 
    inmueblesOtros: inmuebleTotal.inmueblesOtros, 
    inmuebleComprobante: inmuebleTotal.inmuebleComprobante,
    propietario: inmuebleTotal.propietario, creador: inmuebleTotal.creador, 
    usuarioFavorito: inmuebleTotal.usuarioFavorito, 
    solicitudAdministrador: inmuebleTotal.solicitudAdministrador);
  }
  factory InmuebleTotal.copyWith(InmuebleTotal i){
    return InmuebleTotal(
      inmueble: Inmueble.copyWith(i.inmueble), 
      inmuebleInternas: InmuebleInternas.copyWith(i.inmuebleInternas), 
      inmuebleComunidad: InmuebleComunidad.copyWith(i.inmuebleComunidad), 
      inmueblesOtros: InmueblesOtros.copyWith(i.inmueblesOtros), 
      inmuebleComprobante: InmuebleComprobante.copyWith(i.inmuebleComprobante),
      propietario: Usuario.copyWith(i.propietario), creador: Usuario.copyWith(i.creador), 
      usuarioFavorito: UsuariosInmueblesFavoritos.copyWith(i.usuarioFavorito), 
      solicitudAdministrador: SolicitudAdministrador.copyWith(i.solicitudAdministrador)
    );
  }
  void inmuebleTotalCopy(InmuebleTotal inmuebleTotal){
    this.inmueble=inmuebleTotal.getInmueble;
    this.inmuebleComunidad=inmuebleTotal.getInmuebleComunidad;
    this.inmuebleInternas=inmuebleTotal.getInmuebleInternas;
    this.inmueblesOtros=inmuebleTotal.getInmuebleOtros;
    this.creador=inmuebleTotal.creador;
    this.solicitudAdministrador=inmuebleTotal.getSolicitudAdministrador;
    this.usuarioFavorito=inmuebleTotal.getUsuarioFavorito;
  }
}