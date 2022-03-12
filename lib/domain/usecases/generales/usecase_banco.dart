import 'package:inmobiliariaapp/data/repositories/generales/banco_repository.dart';
import 'package:inmobiliariaapp/domain/entities/banco.dart';

class UseCaseBanco{
  BancoRepository bancoRepository=BancoRepository();
  Future<Map<String,dynamic>> obtenerCuentasBanco(){
    return bancoRepository.obtenerCuentasBanco();
  }
  Future<Map<String,dynamic>> registrarCuentaBanco(CuentaBanco cuentaBanco){
    return bancoRepository.registrarCuentaBanco(cuentaBanco);
  }
  Future<Map<String,dynamic>> registrarBanco(Banco banco){
    return bancoRepository.registrarBanco(banco);
  }
  Future<Map<String,dynamic>> modificarBanco(Banco banco){
    return bancoRepository.modificarBanco(banco);
  }
  Future<Map<String,dynamic>> eliminarBanco(String idBanco){
    return bancoRepository.eliminarBanco(idBanco);
  }
  Future<Map<String,dynamic>> obtenerBancos(){
    return bancoRepository.obtenerBancos();
  }
}