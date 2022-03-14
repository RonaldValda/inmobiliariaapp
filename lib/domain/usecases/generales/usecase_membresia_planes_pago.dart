import 'package:inmobiliariaapp/data/repositories/generales/membresia_planes_pago_repository.dart';
import 'package:inmobiliariaapp/domain/entities/membresia_planes_pago.dart';

class UseCaseMembresiaPlanesPago{
  MembresiaPlanesPagoRepository membresiaPlanesPagoRepository=MembresiaPlanesPagoRepository();
  Future<Map<String,dynamic>> obtenerMembresiaPlanesPago(){
    return membresiaPlanesPagoRepository.obtenerMembresiaPlanesPago();
  }
  
  Future<Map<String,dynamic>> registrarMembresiaPlanesPago(MembresiaPlanesPago membresia){
    return membresiaPlanesPagoRepository.registrarMembresiaPlanesPago(membresia);
  }
  Future<Map<String,dynamic>> modificarMembresiaPlanesPago(MembresiaPlanesPago membresia){
    return membresiaPlanesPagoRepository.modificarMembresiaPlanesPago(membresia);
  }
}