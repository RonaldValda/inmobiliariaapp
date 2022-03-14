import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/pages/registro_ciudad/page_registro_ciudad.dart';
import 'package:inmobiliariaapp/ui/pages/planes_pago_membresia/page_membresia_planes_pago.dart';
import 'package:inmobiliariaapp/ui/pages/planes_pago_publicacion/page_planes_pago_publicacion.dart';
import 'package:inmobiliariaapp/ui/pages/publicidad/page_registro_publicidad.dart';
import 'package:inmobiliariaapp/ui/pages/registro_ads/registro_ads.dart';
import 'package:inmobiliariaapp/ui/pages/banco/registro_bancos.dart';
import 'package:inmobiliariaapp/ui/pages/registro_administrador/page_registro_administradores.dart';
class PageOperacionesGenerales extends StatefulWidget {
  PageOperacionesGenerales({Key? key}) : super(key: key);

  @override
  _PageOperacionesGeneralesState createState() => _PageOperacionesGeneralesState();
}

class _PageOperacionesGeneralesState extends State<PageOperacionesGenerales> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adm. Super Usuario"),
      ),
      body: Container(
        child: ListView(
          children: [
            ListTile(
              title:Text("Departamentos, ciudades y zonas"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context){
                      return PageRegistroCiudades(
                      );
                    }
                  )
                );
              },
            ),
            Divider(
              thickness: 2,
            ),
            ListTile(
              title:Text("Registrar cuentas banco"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context){
                      return RegistroCuentasBancos(
                      );
                    }
                  )
                );
              },
            ),
            Divider(
              thickness: 2,
            ),
            ListTile(
              title:Text("Registrar bancos"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context){
                      return PageRegistroBancos(
                      );
                    }
                  )
                );
              },
            ),
            Divider(
              thickness: 2,
            ),
            ListTile(
              title:Text("Registrar ADS"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context){
                      return RegistroAds(
                      );
                    }
                  )
                );
              },
            ),
            Divider(
              thickness: 2,
            ),
            ListTile(
              title:Text("Planes pago publicación"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context){
                      return PagePlanesPagoPublicacion(
                      );
                    }
                  )
                );
              },
            ),
            Divider(
              thickness: 2,
            ),
            ListTile(
              title:Text("Membresía planes pago"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context){
                      return PageRegistroMembresiaPlanesPago(
                      );
                    }
                  )
                );
              },
            ),
            Divider(
              thickness: 2,
            ),
            ListTile(
              title:Text("Registro de administradores"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context){
                      return PageRegistroAdministradores(
                      );
                    }
                  )
                );
              },
            ),
            Divider(
              thickness: 2,
            ),
            ListTile(
              title:Text("Registro de publicidad"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context){
                      return PageRegistroPublicidad(
                      );
                    }
                  )
                );
              },
            ),
            Divider(
              thickness: 2,
            ),
          ],
        ),
      ),
    );
  }
}