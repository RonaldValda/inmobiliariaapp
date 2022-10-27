import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/usecases/user/usecase_user.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/pages/user/login/screen_login.dart';
import 'package:inmobiliariaapp/ui/pages/perfil_usuario/page_perfil_usuario.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_user_provider.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_provider.dart';
import 'package:provider/provider.dart';
class DrawerUserInfo extends StatefulWidget {
  DrawerUserInfo({Key? key}) : super(key: key);

  @override
  _DrawerUserInfoState createState() => _DrawerUserInfoState();
}

class _DrawerUserInfoState extends State<DrawerUserInfo> {
  UseCaseUser useCaseUsuario=UseCaseUser();
  @override
  Widget build(BuildContext context) {
    final userProvider=context.watch<UserProvider>();
    final filterUserProvider=context.watch<FilterUserProvider>();
    return InkWell(
      onTap: (){
        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context){
            return PagePerfilUsuario(
            );
          }
        )
      );
      },
      child: Container(
        height: 140*SizeDefault.scaleWidth,
        padding:EdgeInsets.only(left: 10*SizeDefault.scaleWidth),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: _wMain(userProvider, filterUserProvider, context)),
            _wSubscriberInfo(userProvider),
          ],
        ),
      ),
    );
  }

  Widget _wMain(UserProvider userProvider, FilterUserProvider filterUserProvider, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _wCircleAvatar(userProvider),
            _wData(userProvider),
          ],
        ),
        _wButtonLogIn(context: context)
      ],
    );
  }

  Widget _wData(UserProvider userProvider) {
    return Container(
      height: 140*SizeDefault.scaleWidth,
      margin: EdgeInsets.only(left: 5*SizeDefault.scaleWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200*SizeDefault.scaleWidth,
            child: TextStandard(
              text: userProvider.user.namesSurnames, 
              fontSize: 13*SizeDefault.scaleWidth,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextStandard(
            text: userProvider.user.email, 
            fontSize: 12*SizeDefault.scaleWidth,
            color: ColorsDefault.colorTextInfo,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }

  Widget _wButtonLogIn({required BuildContext context}) {
    final userProvider=context.watch<UserProvider>();
    return Padding(
      padding: EdgeInsets.only(right: 10*SizeDefault.scaleHeight),
      child: InkWell(
        onTap: ()async{
          if(userProvider.sessionStarted){
            userProvider.logoutUser(context: context);
          }else{
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context){
                  return ScreenLogin();
                }
              )
            );
          }
        },
        child: Container(
          width: 35*SizeDefault.scaleWidth,
          height: 35*SizeDefault.scaleWidth,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(7)
          ),
          child: !userProvider.sessionStarted
          ?Icon(Icons.logout,color: ColorsDefault.colorIcon,size: SizeDefault.sizeIconButton,)
          :Icon(Icons.login,color: ColorsDefault.colorIcon,size: SizeDefault.sizeIconButton,)
        ),
      ),
    );
  }

  CircleAvatar _wCircleAvatar(UserProvider userProvider) {
    return userProvider.user.photoLink==""
    ? CircleAvatar(
      radius:30*SizeDefault.scaleWidth,
      backgroundColor: ColorsDefault.colorPrimary,
      child: userProvider.sessionStarted
      ?TextStandard(
        text: userProvider.user.names.substring(0,1),
        fontSize: 30*SizeDefault.scaleWidth,
        color: ColorsDefault.colorBackgroud,
      )
      :TextStandard(
        text: "",
        fontSize: 30*SizeDefault.scaleWidth,
        color: ColorsDefault.colorBackgroud,
      )
    )
    :CircleAvatar(
      radius:30*SizeDefault.scaleWidth,
      backgroundImage: CachedNetworkImageProvider(
        userProvider.user.photoLink,
        scale: 30
      ),
      //child: usuariosInfo.sesionIniciada?Text(usuariosInfo.getUsuario.nombres.toString().substring(0,1),style: TextStyle(fontSize: 40),):Text("S/R",style: TextStyle(fontSize: 40),),
    );
  }

  RotatedBox _wSubscriberInfo(UserProvider userProvider) {
    return RotatedBox(
      quarterTurns: -45,
      child: Container(
        height: 20*SizeDefault.scaleWidth,
        width: double.infinity,
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
          color:  userProvider.getSubscribed()=="Suscrito"?ColorsDefault.colorPrimary:Colors.grey.shade300
          //borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
        ),
        
        child: Center(
          child: TextStandard(
            text: userProvider.getSubscribed(), 
            fontSize: SizeDefault.fSizeStandard,
            fontWeight: FontWeight.w500,
            color: userProvider.getSubscribed()=="Suscrito"?ColorsDefault.colorBackgroud:ColorsDefault.colorTextError,
          ),
          /*child: Text(userProvider.getSubscribed(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: userProvider.getSubscribed()=="Suscrito"?
              Colors.white:Colors.white,
            ),
          ),*/
        ),
      ),
    );
  }
}