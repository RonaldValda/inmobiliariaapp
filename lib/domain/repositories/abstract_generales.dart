import 'package:inmobiliariaapp/domain/entities/banco.dart';
import 'package:inmobiliariaapp/domain/entities/generales.dart';
import 'package:inmobiliariaapp/domain/entities/membresia_planes_pago.dart';
import 'package:inmobiliariaapp/domain/entities/planes_pago_publicacion.dart';
import 'package:inmobiliariaapp/domain/entities/publicidad.dart';

abstract class AbstractGeneralesRepository{
  Future<Map<String,dynamic>> obtenerDepartamentos();
  Future<Map<String,dynamic>> obtenerCiudades(String idDepartamento);
  Future<Map<String,dynamic>> obtenerGeneralesLugares();
  Future<Map<String,dynamic>> obtenerZonas(String idCiudad);
  Future<Map<String,dynamic>> registrarDepartamento(String nombreDepartamento);
  Future<bool> modificarDepartamento(String idDepartamento,String nombreDepartamento);
  Future<bool> eliminarDepartamento(String idDepartamento);
  Future<Map<String,dynamic>> registrarCiudad(String idDepartamento,String nombreCiudad);
  Future<bool> modificarCiudad(String idCiudad,String nombreCiudad);
  Future<bool> eliminarCiudad(String idCiudad);
  Future<Map<String,dynamic>> registrarZona(String idCiudad,Zona zona);
  Future<bool> modificarZona(Zona zona);
  Future<bool> eliminarZona(String idZona);
  Future<Map<String,dynamic>> obtenerVersionApp();
}
abstract class AbstractBancoRepository{
  Future<Map<String,dynamic>> obtenerCuentasBanco();
  Future<Map<String,dynamic>> registrarCuentaBanco(CuentaBanco cuentaBanco);
  Future<Map<String,dynamic>> registrarBanco(Banco banco);
  Future<Map<String,dynamic>> modificarBanco(Banco banco);
  Future<Map<String,dynamic>> eliminarBanco(String idBanco);
  Future<Map<String,dynamic>> obtenerBancos();
}
abstract class AbstractPublicidadRepository{
  Future<Map<String,dynamic>> registrarAd(String idAd,String tipoAd);
  Future<Map<String,dynamic>> eliminarAd(String idAd);
  Future<Map<String,dynamic>> obtenerAds();
  Future<Map<String,dynamic>> eliminarPublicidad(String id);
  Future<Map<String,dynamic>> modificarPublicidad(Publicidad publicidad,int mesesVigencia);
  Future<Map<String,dynamic>> registrarPublicidad(Publicidad publicidad,int mesesVigencia);
  Future<Map<String,dynamic>> obtenerPublicidades();
}
abstract class AbstractPlanesPagoPublicacionRepository{
  Future<Map<String,dynamic>> obtenerPlanesPagoPublicacion();
  Future<Map<String,dynamic>> registrarPlanesPagoPublicacion(PlanesPagoPublicacion plan);
  Future<Map<String,dynamic>> modificarPlanesPagoPublicacion(PlanesPagoPublicacion plan);
  Future<Map<String,dynamic>> eliminarPlanesPagoPublicacion(String id);
}
abstract class AbstractMembresiaPlanesPagoRepository{
  Future<Map<String,dynamic>> obtenerMembresiaPlanesPago();
  Future<Map<String,dynamic>> registrarMembresiaPlanesPago(MembresiaPlanesPago membresia);
  Future<Map<String,dynamic>> modificarMembresiaPlanesPago(MembresiaPlanesPago membresia);
}