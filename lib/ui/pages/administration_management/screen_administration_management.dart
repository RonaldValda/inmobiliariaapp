import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/f_list_tile.dart';
import 'package:inmobiliariaapp/ui/pages/administration_management/banks/screen_banks.dart';
import 'package:inmobiliariaapp/ui/pages/administration_management/banks/screen_accounts_banks.dart';
import 'package:inmobiliariaapp/ui/pages/administration_management/screen_registration_places.dart';
import 'package:inmobiliariaapp/ui/pages/planes_pago_membresia/page_membresia_planes_pago.dart';
import 'package:inmobiliariaapp/ui/pages/administration_management/plans_payment/screen_publication_plans_payment.dart';
import 'package:inmobiliariaapp/ui/pages/publicidad/page_registro_publicidad.dart';
import 'package:inmobiliariaapp/ui/pages/registro_administrador/page_registro_administradores.dart';

import '../../common/buttons.dart';
import '../../common/size_default.dart';
import '../../common/texts.dart';
class ScreenAdministrationManagement extends StatefulWidget {
  ScreenAdministrationManagement({Key? key}) : super(key: key);

  @override
  _ScreenAdministrationManagementState createState() => _ScreenAdministrationManagementState();
}

class _ScreenAdministrationManagementState extends State<ScreenAdministrationManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsDefault.colorBackgroud,
      appBar: AppBar(
        title: TextTitle(
          fontSize: SizeDefault.fSizeTitle,
          text: "Administración gerencia",
        ),
        leading: FBackButton(),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: SizeDefault.paddingHorizontalBody),
        child: ListView(
          children: [
            _wListTile(
              context:context,
              title:"Departamentos, ciudades y zonas",
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context){
                      return ScreenRegistrationPlaces();
                    }
                  )
                );
              }
            ),
            _wListTile(
              context:context,
              title:"Cuentas de banco",
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context){
                      return RegistrationAccountsBanks();
                    }
                  )
                );
              }
            ),
            _wListTile(
              context:context,
              title:"Bancos",
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context){
                      return ScreenBanks();
                    }
                  )
                );
              }
            ),
            _wListTile(
              context:context,
              title:"Planes pago publicación",
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context){
                      return ScreenPublicationPlansPayment();
                    }
                  )
                );
              }
            ),
            _wListTile(
              context:context,
              title:"Membresía planes pago",
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
              }
            ),
            _wListTile(
              context:context,
              title:"Administradores",
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
              }
            ),
            _wListTile(
              context:context,
              title:"Publicidad",
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
              }
            ),
          ],
        ),
      ),
    );
  }

  FListTileCommon _wListTile({required BuildContext context,required String title,required Function onTap}){
    return FListTileCommon(
      title: title, 
      widgetTrailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: SizeDefault.sizeIconButton,
        color: ColorsDefault.colorIcon,
      ),
      onTap: (){
        onTap();
      }
    );
  }
}