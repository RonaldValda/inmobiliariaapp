import 'package:inmobiliariaapp/data/repositories/venta/inmueble_venta_repository.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_reportado.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';

class UseCaseInmuebleVenta{
  InmuebleVentaRepository inmuebleVentaRepository=InmuebleVentaRepository();

  Future<bool> modificarEstadoInmueble(InmuebleTotal inmuebleTotal,String tipoAccion){
    return inmuebleVentaRepository.modificarEstadoInmueble(inmuebleTotal,tipoAccion);
  }
  Future<Map<String,dynamic>> registrarInmuebleQueja(InmuebleQueja inmuebleQueja){
    return inmuebleVentaRepository.registrarInmuebleQueja(inmuebleQueja);
  }
  Future<Map<String,dynamic>> obtenerNotificacionesAccionesVendedor(String idInmueble){
    return inmuebleVentaRepository.obtenerNotificacionesAccionesVendedor(idInmueble);
  }
  Future<Map<String,dynamic>> actualizarPrecioInmueble(String id,int precio){
    return inmuebleVentaRepository.actualizarPrecioInmueble(id,precio);
  }
}