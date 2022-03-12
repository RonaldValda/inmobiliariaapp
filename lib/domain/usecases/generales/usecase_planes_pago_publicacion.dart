import 'package:inmobiliariaapp/data/repositories/generales/planes_pago_publicacion_repository.dart';
import 'package:inmobiliariaapp/domain/entities/planes_pago_publicacion.dart';

class UseCasePlanesPagoPublicacion{
  PlanesPagoPublicacionRepository planesPagoPublicacionRepository=PlanesPagoPublicacionRepository();
  Future<Map<String,dynamic>> obtenerPlanesPagoPublicacion(){
    return planesPagoPublicacionRepository.obtenerPlanesPagoPublicacion();
  }
  Future<Map<String,dynamic>> registrarPlanesPagoPublicacion(PlanesPagoPublicacion plan){
    return planesPagoPublicacionRepository.registrarPlanesPagoPublicacion(plan);
  }
  Future<Map<String,dynamic>> modificarPlanesPagoPublicacion(PlanesPagoPublicacion plan){
    return planesPagoPublicacionRepository.modificarPlanesPagoPublicacion(plan);
  }
  Future<Map<String,dynamic>> eliminarPlanesPagoPublicacion(String id){
    return planesPagoPublicacionRepository.eliminarPlanesPagoPublicacion(id);
  }
}