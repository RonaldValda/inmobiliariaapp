import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/membresia_pago.dart';
import 'package:inmobiliariaapp/domain/entities/usuario.dart';
import 'package:inmobiliariaapp/domain/entities/usuarios_inmuebles_favoritos.dart';
enum getTipoUsuario{
  administrador,
  comun,
  agente,
  superusuario
}

class UsuariosInfo with ChangeNotifier{
  Usuario usuario=Usuario.vacio();
  String tipoSesion="Comprar";
  bool sesionIniciada=false;
  List<MembresiaPago> membresiaPagos=[];
  MembresiaPago membresiaPagoActual=MembresiaPago.vacio();
  List<UsuarioInmuebleBase> usuarioInmuebleBases=[UsuarioInmuebleBase.vacio(),UsuarioInmuebleBase.vacio(),UsuarioInmuebleBase.vacio()];
  List<UsuarioInmuebleBase> get getUsuarioInmuebleBases=>this.usuarioInmuebleBases;
  List<UsuarioInmuebleBuscado> usuarioInmueblesBuscados=[];
  bool existeNotificacion=false;
  Usuario get getUsuario{
    return usuario;
  }
  void setUsuario(Usuario usuario){
    this.usuario=usuario;
    //print(this.usuario.getApellidos);
    notifyListeners();
  }
  void setUser(Usuario usuario){
    this.usuario=usuario;
    notifyListeners();
  }
  void setUsuarioInmueblesBuscados(List<UsuarioInmuebleBuscado> usuarioInmueblesBuscados){
    this.usuarioInmueblesBuscados=usuarioInmueblesBuscados;
  }
  void setUsuarioInmuebleBases(List<UsuarioInmuebleBase> usuarioInmuebleBases){
    this.usuarioInmuebleBases=usuarioInmuebleBases;
  }
  void setTipoSesion(Usuario usuario,bool estado){
    if(!estado){
      if(usuario.tipoUsuario=="Gerente"){
        tipoSesion="Observar";
      }
      else{
        tipoSesion="Comprar";
      }
    }else{
      if(usuario.tipoUsuario=="Administrador"){
        tipoSesion="Administrar";
      }else if(usuario.tipoUsuario=="Super Usuario"||usuario.tipoUsuario=="Gerente"){
        tipoSesion="Supervisar";
      }else {
        tipoSesion="Vender";
      }
    }
    notifyListeners();
  }
  void setMembresiaPagos(List<MembresiaPago> membresiaPagos){
    this.membresiaPagos=membresiaPagos;
    notifyListeners();
  }
  void setMembresiaPagoActual(MembresiaPago membresiaPago){
    this.membresiaPagoActual=membresiaPago;
    notifyListeners();
  }
  String getSuscrito(){
    String suscrito="No suscrito";
    if(membresiaPagoActual.autorizacion=="Aprobado"){
      DateTime fechaActual=DateTime.now();
      if(DateTime.parse(membresiaPagoActual.fechaFinal).difference(fechaActual).inMinutes>0){
        suscrito="Suscrito";
      }else if(fechaActual.day<=3){
          suscrito="Suscrito";
      }
    }
    return suscrito;
  }
  /*set setUsuario(Usuario user){
    this._usuario=user;
  }*/
  
}